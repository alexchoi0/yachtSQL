-- Ranking Functions - SQL:2023
-- Description: Ranking window functions
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS crew_members;
CREATE TABLE crew_members (
    id INT64,
    name STRING,
    fleet STRING,
    salary INT64
);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    id INT64,
    region STRING,
    product STRING,
    amount INT64,
    sale_date DATE
);

DROP TABLE IF EXISTS scores;
CREATE TABLE scores (
    id INT64,
    student STRING,
    subject STRING,
    score INT64
);

-- ----------------------------------------------------------------------------
-- ROW_NUMBER() - Sequential Row Numbering
-- ----------------------------------------------------------------------------

-- ROW_NUMBER() basic - assigns unique sequential number to each row
-- SQL:2023 Part 2, Section 7.14
INSERT INTO crew_members VALUES
    (1, 'Alice', 'Sales', 50000),
    (2, 'Bob', 'Sales', 60000),
    (3, 'Charlie', 'Sales', 55000);

-- Tag: window_functions_ranking_functions_test_select_001
SELECT
    name,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) as rank
FROM crew_members
ORDER BY rank;

-- ROW_NUMBER() with PARTITION BY - restart numbering for each partition
DELETE FROM crew_members;
INSERT INTO crew_members VALUES
    (1, 'Alice', 'Sales', 50000),
    (2, 'Bob', 'Sales', 60000),
    (3, 'Charlie', 'Engineering', 70000),
    (4, 'David', 'Engineering', 65000);

-- Tag: window_functions_ranking_functions_test_select_002
SELECT
    name,
    fleet,
    salary,
    ROW_NUMBER() OVER (PARTITION BY fleet ORDER BY salary DESC) as dept_rank
FROM crew_members
ORDER BY fleet, dept_rank;

-- ROW_NUMBER() with ties - assigns different numbers even for equal values
DELETE FROM crew_members;
INSERT INTO crew_members VALUES
    (1, 'Alice', 'Sales', 50000),
    (2, 'Bob', 'Sales', 50000),
    (3, 'Charlie', 'Sales', 50000);

-- Tag: window_functions_ranking_functions_test_select_003
SELECT
    name,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary) as row_num
FROM crew_members;

-- ROW_NUMBER() without ORDER BY - arbitrary but deterministic order
DELETE FROM crew_members;
INSERT INTO crew_members VALUES
    (1, 'Alice', 'Sales', 50000),
    (2, 'Bob', 'Sales', 60000),
    (3, 'Charlie', 'Sales', 55000);

-- Tag: window_functions_ranking_functions_test_select_004
SELECT
    name,
    salary,
    ROW_NUMBER() OVER () as row_num
FROM crew_members;

-- ROW_NUMBER() with complex ORDER BY
-- Tag: window_functions_ranking_functions_test_select_005
SELECT
    name,
    fleet,
    salary,
    ROW_NUMBER() OVER (ORDER BY fleet, salary DESC) as row_num
FROM crew_members;
-- Orders by fleet first, then by salary within fleet

-- ----------------------------------------------------------------------------
-- RANK() - Ranking with Gaps
-- ----------------------------------------------------------------------------

-- RANK() basic - same values get same rank, with gaps after ties
-- SQL:2023 Part 2, Section 7.14
DELETE FROM scores;
INSERT INTO scores VALUES
    (1, 'Alice', 'Math', 100),
    (2, 'Bob', 'Math', 90),
    (3, 'Charlie', 'Math', 90),
    (4, 'David', 'Math', 80);

-- Tag: window_functions_ranking_functions_test_select_006
SELECT
    student,
    score,
    RANK() OVER (ORDER BY score DESC) as rank
FROM scores
ORDER BY rank;

-- RANK() vs ROW_NUMBER() comparison
-- Tag: window_functions_ranking_functions_test_select_007
SELECT
    student,
    score,
    ROW_NUMBER() OVER (ORDER BY score DESC) as row_num,
    RANK() OVER (ORDER BY score DESC) as rank
FROM scores
ORDER BY score DESC;
-- ROW_NUMBER: 1,2,3,4 (unique)
-- RANK: 1,2,2,4 (ties get same rank, gap follows)

-- RANK() with PARTITION BY
DELETE FROM scores;
INSERT INTO scores VALUES
    (1, 'Alice', 'Math', 90),
    (2, 'Bob', 'Math', 85),
    (3, 'Charlie', 'Science', 95),
    (4, 'David', 'Science', 95);

-- Tag: window_functions_ranking_functions_test_select_008
SELECT
    student,
    subject,
    score,
    RANK() OVER (PARTITION BY subject ORDER BY score DESC) as rank
FROM scores
ORDER BY subject, rank;
-- Each subject has independent ranking

-- RANK() with all tied values
DELETE FROM scores;
INSERT INTO scores VALUES
    (1, 'Alice', 'Math', 100),
    (2, 'Bob', 'Math', 100),
    (3, 'Charlie', 'Math', 100);

-- Tag: window_functions_ranking_functions_test_select_009
SELECT
    student,
    score,
    RANK() OVER (ORDER BY score DESC) as rank
FROM scores;

-- RANK() with no ties
DELETE FROM scores;
INSERT INTO scores VALUES
    (1, 'Alice', 'Math', 100),
    (2, 'Bob', 'Math', 90),
    (3, 'Charlie', 'Math', 80);

-- Tag: window_functions_ranking_functions_test_select_010
SELECT
    student,
    score,
    RANK() OVER (ORDER BY score DESC) as rank
FROM scores;

-- ----------------------------------------------------------------------------
-- DENSE_RANK() - Ranking without Gaps
-- ----------------------------------------------------------------------------

-- DENSE_RANK() basic - no gaps after ties
-- SQL:2023 Part 2, Section 7.14
DELETE FROM scores;
INSERT INTO scores VALUES
    (1, 'Alice', 'Math', 100),
    (2, 'Bob', 'Math', 90),
    (3, 'Charlie', 'Math', 90),
    (4, 'David', 'Math', 80);

-- Tag: window_functions_ranking_functions_test_select_011
SELECT
    student,
    score,
    DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank
FROM scores
ORDER BY dense_rank;

-- Comparison: ROW_NUMBER, RANK, DENSE_RANK
-- Tag: window_functions_ranking_functions_test_select_012
SELECT
    student,
    score,
    ROW_NUMBER() OVER (ORDER BY score DESC) as row_num,
    RANK() OVER (ORDER BY score DESC) as rank,
    DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank
FROM scores
ORDER BY score DESC;
-- ROW_NUMBER: 1,2,3,4 (unique)
-- RANK: 1,2,2,4 (gap after tie)
-- DENSE_RANK: 1,2,2,3 (no gap)

-- DENSE_RANK() with PARTITION BY
DELETE FROM scores;
INSERT INTO scores VALUES
    (1, 'Alice', 'Math', 100),
    (2, 'Bob', 'Math', 90),
    (3, 'Charlie', 'Math', 90),
    (4, 'David', 'Science', 95),
    (5, 'Eve', 'Science', 85);

-- Tag: window_functions_ranking_functions_test_select_013
SELECT
    student,
    subject,
    score,
    DENSE_RANK() OVER (PARTITION BY subject ORDER BY score DESC) as rank
FROM scores
ORDER BY subject, rank;
-- Independent dense ranking within each subject

-- DENSE_RANK() with multiple ties
DELETE FROM scores;
INSERT INTO scores VALUES
    (1, 'A', 'Math', 100),
    (2, 'B', 'Math', 100),
    (3, 'C', 'Math', 90),
    (4, 'D', 'Math', 90),
    (5, 'E', 'Math', 90),
    (6, 'F', 'Math', 80);

-- Tag: window_functions_ranking_functions_test_select_014
SELECT
    student,
    score,
    DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank
FROM scores;

-- ----------------------------------------------------------------------------
-- PERCENT_RANK() - Relative Rank as Percentage
-- ----------------------------------------------------------------------------

-- PERCENT_RANK() basic - (rank - 1) / (total rows - 1)
-- SQL:2023 Part 2, Section 7.14
-- Returns value between 0 and 1
DELETE FROM scores;
INSERT INTO scores VALUES
    (1, 'Alice', 'Math', 100),
    (2, 'Bob', 'Math', 90),
    (3, 'Charlie', 'Math', 80),
    (4, 'David', 'Math', 70);

-- Tag: window_functions_ranking_functions_test_select_015
SELECT
    student,
    score,
    PERCENT_RANK() OVER (ORDER BY score DESC) as percent_rank
FROM scores
ORDER BY score DESC;
-- Formula: (RANK() - 1) / (COUNT(*) - 1)

-- PERCENT_RANK() with ties
DELETE FROM scores;
INSERT INTO scores VALUES
    (1, 'Alice', 'Math', 100),
    (2, 'Bob', 'Math', 90),
    (3, 'Charlie', 'Math', 90),
    (4, 'David', 'Math', 80);

-- Tag: window_functions_ranking_functions_test_select_016
SELECT
    student,
    score,
    RANK() OVER (ORDER BY score DESC) as rank,
    PERCENT_RANK() OVER (ORDER BY score DESC) as percent_rank
FROM scores
ORDER BY score DESC;
-- Alice: rank=1, percent_rank=0.0
-- Bob: rank=2, percent_rank=0.333
-- Charlie: rank=2, percent_rank=0.333
-- David: rank=4, percent_rank=1.0

-- PERCENT_RANK() with PARTITION BY
-- Tag: window_functions_ranking_functions_test_select_017
SELECT
    student,
    subject,
    score,
    PERCENT_RANK() OVER (PARTITION BY subject ORDER BY score DESC) as percent_rank
FROM scores
ORDER BY subject, score DESC;

-- PERCENT_RANK() with single row - returns 0.0
DELETE FROM scores;
INSERT INTO scores VALUES (1, 'Alice', 'Math', 100);
-- Tag: window_functions_ranking_functions_test_select_018
SELECT
    student,
    score,
    PERCENT_RANK() OVER (ORDER BY score) as percent_rank
FROM scores;

-- ----------------------------------------------------------------------------
-- CUME_DIST() - Cumulative Distribution
-- ----------------------------------------------------------------------------

-- CUME_DIST() basic - number of rows <= current / total rows
-- SQL:2023 Part 2, Section 7.14
-- Returns value between 1/n and 1
DELETE FROM scores;
INSERT INTO scores VALUES
    (1, 'Alice', 'Math', 100),
    (2, 'Bob', 'Math', 90),
    (3, 'Charlie', 'Math', 80),
    (4, 'David', 'Math', 70);

-- Tag: window_functions_ranking_functions_test_select_019
SELECT
    student,
    score,
    CUME_DIST() OVER (ORDER BY score DESC) as cume_dist
FROM scores
ORDER BY score DESC;
-- Formula: (number of rows with score <= current) / (total rows)

-- CUME_DIST() with ties
DELETE FROM scores;
INSERT INTO scores VALUES
    (1, 'Alice', 'Math', 100),
    (2, 'Bob', 'Math', 90),
    (3, 'Charlie', 'Math', 90),
    (4, 'David', 'Math', 80);

-- Tag: window_functions_ranking_functions_test_select_020
SELECT
    student,
    score,
    CUME_DIST() OVER (ORDER BY score DESC) as cume_dist
FROM scores
ORDER BY score DESC;
-- Alice: 0.25 (1/4)
-- Bob: 0.75 (3/4, includes both 90s)
-- Charlie: 0.75 (3/4, includes both 90s)
-- David: 1.0 (4/4)

-- CUME_DIST() vs PERCENT_RANK() comparison
-- Tag: window_functions_ranking_functions_test_select_021
SELECT
    student,
    score,
    PERCENT_RANK() OVER (ORDER BY score DESC) as percent_rank,
    CUME_DIST() OVER (ORDER BY score DESC) as cume_dist
FROM scores
ORDER BY score DESC;

-- CUME_DIST() with PARTITION BY
-- Tag: window_functions_ranking_functions_test_select_022
SELECT
    student,
    subject,
    score,
    CUME_DIST() OVER (PARTITION BY subject ORDER BY score DESC) as cume_dist
FROM scores
ORDER BY subject, score DESC;

-- ----------------------------------------------------------------------------
-- NTILE(n) - Divide Rows into Buckets
-- ----------------------------------------------------------------------------

-- NTILE(4) - divide into quartiles
-- SQL:2023 Part 2, Section 7.14
DELETE FROM crew_members;
INSERT INTO crew_members VALUES
    (1, 'A', 'Sales', 50000),
    (2, 'B', 'Sales', 55000),
    (3, 'C', 'Sales', 60000),
    (4, 'D', 'Sales', 65000),
    (5, 'E', 'Sales', 70000),
    (6, 'F', 'Sales', 75000),
    (7, 'G', 'Sales', 80000),
    (8, 'H', 'Sales', 85000);

-- Tag: window_functions_ranking_functions_test_select_023
SELECT
    name,
    salary,
    NTILE(4) OVER (ORDER BY salary) as quartile
FROM crew_members
ORDER BY salary;

-- NTILE(3) - divide into thirds with uneven distribution
DELETE FROM crew_members;
INSERT INTO crew_members VALUES
    (1, 'A', 'Sales', 50000),
    (2, 'B', 'Sales', 60000),
    (3, 'C', 'Sales', 70000),
    (4, 'D', 'Sales', 80000),
    (5, 'E', 'Sales', 90000);

-- Tag: window_functions_ranking_functions_test_select_024
SELECT
    name,
    salary,
    NTILE(3) OVER (ORDER BY salary) as tercile
FROM crew_members
ORDER BY salary;

-- NTILE(n) where n > row count
DELETE FROM crew_members;
INSERT INTO crew_members VALUES
    (1, 'A', 'Sales', 50000),
    (2, 'B', 'Sales', 60000);

-- Tag: window_functions_ranking_functions_test_select_025
SELECT
    name,
    salary,
    NTILE(5) OVER (ORDER BY salary) as bucket
FROM crew_members;

-- NTILE with PARTITION BY
DELETE FROM crew_members;
INSERT INTO crew_members VALUES
    (1, 'A', 'Sales', 50000),
    (2, 'B', 'Sales', 60000),
    (3, 'C', 'Sales', 70000),
    (4, 'D', 'Engineering', 80000),
    (5, 'E', 'Engineering', 90000),
    (6, 'F', 'Engineering', 100000);

-- Tag: window_functions_ranking_functions_test_select_026
SELECT
    name,
    fleet,
    salary,
    NTILE(2) OVER (PARTITION BY fleet ORDER BY salary) as half
FROM crew_members
ORDER BY fleet, salary;
-- Each fleet independently divided into halves

-- NTILE for percentile groups
-- Tag: window_functions_ranking_functions_test_select_027
SELECT
    name,
    salary,
    NTILE(100) OVER (ORDER BY salary) as percentile
FROM crew_members;
-- Divide into 100 buckets (percentiles)

-- NTILE(1) - all rows in one bucket
-- Tag: window_functions_ranking_functions_test_select_028
SELECT
    name,
    salary,
    NTILE(1) OVER (ORDER BY salary) as single_bucket
FROM crew_members;
-- All rows get bucket=1

-- ----------------------------------------------------------------------------
-- Complex Ranking Scenarios
-- ----------------------------------------------------------------------------

-- Multiple ranking functions together
DELETE FROM scores;
INSERT INTO scores VALUES
    (1, 'Alice', 'Math', 100),
    (2, 'Bob', 'Math', 90),
    (3, 'Charlie', 'Math', 90),
    (4, 'David', 'Math', 80),
    (5, 'Eve', 'Math', 80),
    (6, 'Frank', 'Math', 70);

-- Tag: window_functions_ranking_functions_test_select_029
SELECT
    student,
    score,
    ROW_NUMBER() OVER (ORDER BY score DESC) as row_num,
    RANK() OVER (ORDER BY score DESC) as rank,
    DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank,
    PERCENT_RANK() OVER (ORDER BY score DESC) as percent_rank,
    CUME_DIST() OVER (ORDER BY score DESC) as cume_dist,
    NTILE(3) OVER (ORDER BY score DESC) as tercile
FROM scores
ORDER BY score DESC;
-- Shows all ranking functions side by side

-- Ranking with multiple ORDER BY columns
-- Tag: window_functions_ranking_functions_test_select_030
SELECT
    name,
    fleet,
    salary,
    RANK() OVER (ORDER BY fleet, salary DESC) as rank
FROM crew_members;
-- Ranks first by fleet, then by salary within each fleet

-- Ranking with DESC and ASC mixed
-- Tag: window_functions_ranking_functions_test_select_031
SELECT
    name,
    salary,
    RANK() OVER (ORDER BY salary DESC, name ASC) as rank
FROM crew_members;
-- Primary sort descending, secondary ascending

-- Top N per partition using ROW_NUMBER
-- Tag: window_functions_ranking_functions_test_select_001
SELECT *
FROM (
-- Tag: window_functions_ranking_functions_test_select_032
    SELECT
        name,
        fleet,
        salary,
        ROW_NUMBER() OVER (PARTITION BY fleet ORDER BY salary DESC) as rank
    FROM crew_members
) ranked
WHERE rank <= 3;
-- Get top 3 salaries per fleet

-- Ranking gaps analysis
-- Tag: window_functions_ranking_functions_test_select_033
SELECT
    student,
    score,
    RANK() OVER (ORDER BY score DESC) as rank,
    DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank,
    RANK() OVER (ORDER BY score DESC) - DENSE_RANK() OVER (ORDER BY score DESC) as gap
FROM scores;
-- Shows where RANK has gaps compared to DENSE_RANK

-- ----------------------------------------------------------------------------
-- Edge Cases
-- ----------------------------------------------------------------------------

-- Empty table
DELETE FROM scores;
-- Tag: window_functions_ranking_functions_test_select_034
SELECT
    student,
    score,
    RANK() OVER (ORDER BY score) as rank
FROM scores;

-- Single row
INSERT INTO scores VALUES (1, 'Alice', 'Math', 100);
-- Tag: window_functions_ranking_functions_test_select_035
SELECT
    student,
    score,
    ROW_NUMBER() OVER (ORDER BY score) as row_num,
    RANK() OVER (ORDER BY score) as rank,
    DENSE_RANK() OVER (ORDER BY score) as dense_rank,
    PERCENT_RANK() OVER (ORDER BY score) as percent_rank,
    CUME_DIST() OVER (ORDER BY score) as cume_dist
FROM scores;

-- All rows identical
DELETE FROM scores;
INSERT INTO scores VALUES
    (1, 'A', 'Math', 100),
    (2, 'B', 'Math', 100),
    (3, 'C', 'Math', 100);

-- Tag: window_functions_ranking_functions_test_select_036
SELECT
    student,
    score,
    RANK() OVER (ORDER BY score) as rank,
    DENSE_RANK() OVER (ORDER BY score) as dense_rank
FROM scores;
-- All get rank=1, dense_rank=1

-- NULL values in ORDER BY
DELETE FROM scores;
INSERT INTO scores VALUES
    (1, 'Alice', 'Math', 100),
    (2, 'Bob', 'Math', NULL),
    (3, 'Charlie', 'Math', 90);

-- Tag: window_functions_ranking_functions_test_select_037
SELECT
    student,
    score,
    RANK() OVER (ORDER BY score DESC NULLS LAST) as rank
FROM scores;
-- NULLs sorted last: Alice=1, Charlie=2, Bob=3

-- ----------------------------------------------------------------------------
-- Cleanup
-- ----------------------------------------------------------------------------

