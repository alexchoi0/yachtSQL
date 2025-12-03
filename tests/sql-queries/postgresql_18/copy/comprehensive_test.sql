-- ============================================================================
-- Comprehensive - PostgreSQL 18
-- ============================================================================
-- Source: tests/copy_command_comprehensive_tdd.rs
-- Description: Comprehensive test suite covering multiple SQL features
--
-- PostgreSQL: Full support
-- BigQuery: Limited or no support
-- SQL Standard: PostgreSQL 18 specific
-- ============================================================================

-- Test: Basic COPY FROM (import from CSV)
-- Expected: Import all rows from CSV file
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING, email STRING);

COPY users FROM '/path/to/users.csv';
-- File contents: 1,Alice,alice@example.com
--                2,Bob,bob@example.com
-- Result: 2 rows imported

-- Test: COPY FROM with HEADER
-- Expected: Skip first line (column headers)
DROP TABLE IF EXISTS equipment;
CREATE TABLE equipment (id INT64, name STRING, price INT64);

COPY equipment FROM '/path/to/equipment.csv' WITH (HEADER);
-- File contents: id,name,price
--                1,Widget,100
--                2,Gadget,200
-- Result: 2 data rows imported, header skipped

-- Test: COPY FROM with custom DELIMITER
-- Expected: Parse pipe-separated values
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);

COPY data FROM '/path/to/data.psv' WITH (DELIMITER '|');
-- File contents: 1|first
--                2|second
-- Result: 2 rows imported

-- Test: COPY FROM with NULL values
-- Expected: Empty fields become NULL
DROP TABLE IF EXISTS nullable;
CREATE TABLE nullable (id INT64, value INT64);

COPY nullable FROM '/path/to/nullable.csv' WITH (NULL '');
-- File contents: 1,100
--                2,
--                3,300
-- Result: Row 2 has NULL value

-- Test: COPY FROM with column list
-- Expected: Import only specified columns
DROP TABLE IF EXISTS partial;
CREATE TABLE partial (id INT64, name STRING, email STRING);

COPY partial (id, name) FROM '/path/to/partial.csv';
-- File contents: 1,Alice
--                2,Bob
-- Result: email column is NULL for all rows

-- Test: COPY TO (export to CSV)
-- Expected: Write table data to file
DROP TABLE IF EXISTS export_test;
CREATE TABLE export_test (id INT64, value STRING);
INSERT INTO export_test VALUES (1, 'first'), (2, 'second');

COPY export_test TO '/path/to/export.csv';
-- File created with: 1,first
--                     2,second

-- Test: COPY TO with HEADER
-- Expected: Include column names as first line
DROP TABLE IF EXISTS with_header;
CREATE TABLE with_header (id INT64, name STRING);
INSERT INTO with_header VALUES (1, 'test');

COPY with_header TO '/path/to/with_header.csv' WITH (HEADER);
-- File created with: id,name
--                     1,test

-- Test: COPY (query) TO file
-- Expected: Export query results
DROP TABLE IF EXISTS source;
CREATE TABLE source (id INT64, value INT64);
INSERT INTO source VALUES (1, 10), (2, 20), (3, 30);

COPY (SELECT id, value * 2 AS doubled FROM source WHERE id > 1)
TO '/path/to/query_export.csv';
-- File created with: 2,40
--                     3,60

-- Test: COPY with QUOTE option
-- Expected: Quote fields containing delimiter
DROP TABLE IF EXISTS quoted;
CREATE TABLE quoted (id INT64, text STRING);
INSERT INTO quoted VALUES (1, 'Hello, World'), (2, 'Simple');

COPY quoted TO '/path/to/quoted.csv' WITH (QUOTE '"');
-- File created with: 1,"Hello, World"
--                     2,Simple

-- Test: COPY with ESCAPE option
-- Expected: Escape special characters
DROP TABLE IF EXISTS escaped;
CREATE TABLE escaped (id INT64, text STRING);
INSERT INTO escaped VALUES (1, 'It''s working');

COPY escaped TO '/path/to/escaped.csv' WITH (ESCAPE '\\');
-- File created with: 1,It\'s working

-- Test: COPY BINARY format
-- Expected: Export/import in binary format for performance
DROP TABLE IF EXISTS binary_test;
CREATE TABLE binary_test (id INT64, value FLOAT64);
INSERT INTO binary_test VALUES (1, 3.14159), (2, 2.71828);

COPY binary_test TO '/path/to/binary.dat' WITH (FORMAT BINARY);

DROP TABLE IF EXISTS binary_import;
CREATE TABLE binary_import (id INT64, value FLOAT64);
COPY binary_import FROM '/path/to/binary.dat' WITH (FORMAT BINARY);
-- Result: Exact values preserved, no precision loss

-- Test: COPY FROM empty file
-- Expected: No rows imported, no error
DROP TABLE IF EXISTS empty_import;
CREATE TABLE empty_import (id INT64);

COPY empty_import FROM '/path/to/empty.csv';
-- Result: 0 rows imported

-- Test: COPY TO empty table
-- Expected: Creates file with header only (if WITH HEADER)
DROP TABLE IF EXISTS empty_export;
CREATE TABLE empty_export (id INT64);

COPY empty_export TO '/path/to/empty_export.csv' WITH (HEADER);
-- File created with: id
--                     (no data rows)

-- Test: COPY large file (10,000+ rows)
-- Expected: Handle large datasets efficiently
DROP TABLE IF EXISTS large_import;
CREATE TABLE large_import (id INT64, value INT64);

COPY large_import FROM '/path/to/large_data.csv';
-- File with 10,000 rows
-- Result: All rows imported efficiently

-- ============================================================================
-- Error Conditions
-- ============================================================================

-- Test: COPY FROM file not found
-- Expected: Error indicating file doesn't exist
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);

COPY test FROM '/nonexistent/file.csv';
-- ERROR: could not open file "/nonexistent/file.csv": No such file or directory

-- Test: COPY FROM format error
-- Expected: Error on type mismatch
DROP TABLE IF EXISTS test_format;
CREATE TABLE test_format (id INT64, value INT64);

COPY test_format FROM '/path/to/malformed.csv';
-- File contents: 1,100
--                2,not_a_number
-- ERROR: invalid input syntax for type INT64: "not_a_number"

-- Test: COPY TO permission error
-- Expected: Error when cannot write file
DROP TABLE IF EXISTS test_perm;
CREATE TABLE test_perm (id INT64);
INSERT INTO test_perm VALUES (1);

COPY test_perm TO '/root/forbidden.csv';
-- ERROR: could not open file for writing: Permission denied

-- Test: COPY column count mismatch
-- Expected: Error when CSV has wrong number of columns
DROP TABLE IF EXISTS test_cols;
CREATE TABLE test_cols (id INT64, name STRING);

COPY test_cols FROM '/path/to/mismatch.csv';
-- File contents: 1,Alice,extra_column
-- ERROR: extra data after last expected column

-- Test: COPY with PRIMARY KEY violation
-- Expected: Error on duplicate key
DROP TABLE IF EXISTS test_pk;
CREATE TABLE test_pk (id INT64 PRIMARY KEY, value STRING);

COPY test_pk FROM '/path/to/duplicates.csv';
-- File contents: 1,first
--                1,duplicate
-- ERROR: duplicate key value violates unique constraint

-- Test: COPY with NOT NULL violation
-- Expected: Error on NULL in NOT NULL column
DROP TABLE IF EXISTS test_notnull;
CREATE TABLE test_notnull (id INT64 NOT NULL, value STRING);

COPY test_notnull FROM '/path/to/withnull.csv' WITH (NULL '');
-- File contents: 1,first
--                ,second
-- ERROR: null value in column "id" violates not-null constraint

-- ============================================================================
-- Advanced Options
-- ============================================================================

-- Test: COPY with FORMAT CSV
-- Expected: Explicit CSV format
COPY users FROM '/path/to/users.csv' WITH (FORMAT CSV, HEADER true, DELIMITER ',');

-- Test: COPY with FORMAT TEXT (tab-separated)
-- Expected: Tab-delimited data
COPY users FROM '/path/to/users.txt' WITH (FORMAT TEXT);

-- Test: COPY with custom NULL string
-- Expected: Treat specific string as NULL
DROP TABLE IF EXISTS custom_null;
CREATE TABLE custom_null (id INT64, value INT64);

COPY custom_null FROM '/path/to/nulls.csv' WITH (NULL 'NULL');
-- File contents: 1,100
--                2,NULL
--                3,300
-- Result: Row 2 value is NULL

-- Test: COPY with FORCE_QUOTE
-- Expected: Force quoting of specific columns
DROP TABLE IF EXISTS force_quote;
CREATE TABLE force_quote (id INT64, name STRING, email STRING);
INSERT INTO force_quote VALUES (1, 'Alice', 'alice@example.com');

COPY force_quote TO '/path/to/quoted.csv' WITH (FORCE_QUOTE (name, email));
-- File created with all name and email values quoted

-- Test: COPY with ENCODING
-- Expected: Handle different character encodings
COPY users FROM '/path/to/utf8_data.csv' WITH (ENCODING 'UTF8');

-- ============================================================================
-- Real-World Scenarios
-- ============================================================================

-- Test: ETL - Extract data to file
-- Expected: Export for external processing
DROP TABLE IF EXISTS analytics_data;
CREATE TABLE analytics_data (date DATE, revenue FLOAT64, users INT64);
INSERT INTO analytics_data VALUES ('2024-01-01', 1000.0, 100);

COPY (SELECT * FROM analytics_data WHERE date >= '2024-01-01')
TO '/exports/daily_analytics.csv' WITH (HEADER, FORMAT CSV);

-- Test: ETL - Load processed data
-- Expected: Import after external processing
DROP TABLE IF EXISTS processed_data;
CREATE TABLE processed_data (id INT64, result FLOAT64);

COPY processed_data FROM '/imports/processed.csv' WITH (HEADER, FORMAT CSV);

-- Test: Backup table data
-- Expected: Full table export for backup
DROP TABLE IF EXISTS important_data;
CREATE TABLE important_data (id INT64, data STRING);

COPY important_data TO '/backups/important_data_backup.csv' WITH (HEADER, FORMAT CSV);

-- Test: Restore from backup
-- Expected: Restore data from backup file
DROP TABLE IF EXISTS restored_data;
CREATE TABLE restored_data (id INT64, data STRING);

COPY restored_data FROM '/backups/important_data_backup.csv' WITH (HEADER, FORMAT CSV);
