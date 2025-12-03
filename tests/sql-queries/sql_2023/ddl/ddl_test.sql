-- Ddl - SQL:2023
-- Description: Data Definition Language: CREATE, ALTER, DROP operations
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS large_dataset;
CREATE TABLE large_dataset (id INT64, val FLOAT64);

-- Tag: ddl_ddl_test_select_001
SELECT \ id, \ SIN(val) as sin_val, \ COS(val) as cos_val, \ EXP(val / 10.0) as exp_val, \ LN(ABS(val) + 1.0) as ln_val, \ POWER(val, 2.0) as power_val \ FROM large_dataset \ WHERE SQRT(ABS(val)) < 5.0 \ ORDER BY id \ LIMIT 100;

DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);

-- Tag: ddl_ddl_test_select_002
SELECT BIT_XOR() FROM test;

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
ALTER TABLE users ADD COLUMN email STRING UNIQUE;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY);
ALTER TABLE test RENAME TO TEST;

-- Tag: ddl_ddl_test_select_003
SELECT * FROM TEST;
-- Tag: ddl_ddl_test_select_004
SELECT * FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (a INT64, c INT64);
ALTER TABLE test ADD COLUMN b INT64;
DROP TABLE IF EXISTS Users;
CREATE TABLE Users (ID INT64, Name STRING);
ALTER TABLE users ADD COLUMN email STRING;

-- Tag: ddl_ddl_test_select_005
SELECT * FROM test;
-- Tag: ddl_ddl_test_select_006
SELECT ID, Name, email FROM Users;

DROP TABLE IF EXISTS Users;
CREATE TABLE Users (ID INT64, Name STRING);
ALTER TABLE users ADD COLUMN email STRING;

-- Tag: ddl_ddl_test_select_007
SELECT ID, Name, email FROM Users;

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);

-- Tag: ddl_ddl_test_select_008
SELECT * FROM numbers ORDER BY value LIMIT 5 OFFSET 3;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value STRING);

-- Tag: ddl_ddl_test_select_009
SELECT * FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 NOT NULL, value STRING);

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 PRIMARY KEY, value STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 NOT NULL, value STRING);

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64 NOT NULL, value STRING);

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id INT64, username STRING);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64);

-- Tag: ddl_ddl_test_select_010
SELECT id, nonexistent_column, name FROM users;
-- Tag: ddl_ddl_test_select_011
SELECT userid FROM users;
-- Tag: ddl_ddl_test_select_012
SELECT * FROM user;

DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id INT64, username STRING);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64);

-- Tag: ddl_ddl_test_select_013
SELECT userid FROM users;
-- Tag: ddl_ddl_test_select_014
SELECT * FROM user;

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64);

-- Tag: ddl_ddl_test_select_015
SELECT * FROM user;

DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);

-- Tag: ddl_ddl_test_select_016
SELECT * FROM t LIMIT -1;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS large;
CREATE TABLE large (id INT64, value INT64);

-- Tag: ddl_ddl_test_select_017
SELECT id FROM data FETCH FIRST -1 ROWS ONLY;
-- Tag: ddl_ddl_test_select_018
SELECT id FROM data OFFSET -1 ROWS;
-- Tag: ddl_ddl_test_select_019
SELECT id FROM data FETCH FIRST 5 ONLY;
-- Tag: ddl_ddl_test_select_020
SELECT id FROM large ORDER BY id FETCH FIRST 10 ROWS ONLY;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS large;
CREATE TABLE large (id INT64, value INT64);

-- Tag: ddl_ddl_test_select_021
SELECT id FROM data OFFSET -1 ROWS;
-- Tag: ddl_ddl_test_select_022
SELECT id FROM data FETCH FIRST 5 ONLY;
-- Tag: ddl_ddl_test_select_023
SELECT id FROM large ORDER BY id FETCH FIRST 10 ROWS ONLY;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS large;
CREATE TABLE large (id INT64, value INT64);

-- Tag: ddl_ddl_test_select_024
SELECT id FROM data FETCH FIRST 5 ONLY;
-- Tag: ddl_ddl_test_select_025
SELECT id FROM large ORDER BY id FETCH FIRST 10 ROWS ONLY;

DROP TABLE IF EXISTS large;
CREATE TABLE large (id INT64, value INT64);

-- Tag: ddl_ddl_test_select_026
SELECT id FROM large ORDER BY id FETCH FIRST 10 ROWS ONLY;

DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: ddl_ddl_test_select_027
SELECT status FROM parsed_data WHERE id = 1;

DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: ddl_ddl_test_select_028
SELECT status FROM parsed_data WHERE id = 1;

DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: ddl_ddl_test_select_029
SELECT status FROM parsed_data WHERE id = 1;

DROP TABLE IF EXISTS large_data;
CREATE TABLE large_data (id INT64, email STRING);
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, message STRING);

-- Tag: ddl_ddl_test_select_030
SELECT filename, CASE WHEN filename LIKE '%.pdf' THEN 'document' WHEN filename LIKE '%.jpg' THEN 'image' WHEN filename LIKE '%.mp4' THEN 'video' ELSE 'other' END as file_type FROM files ORDER BY filename;

DROP TABLE IF EXISTS large_data;
CREATE TABLE large_data (id INT64, email STRING);
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, message STRING);

DROP TABLE IF EXISTS large_data;
CREATE TABLE large_data (id INT64, email STRING);
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, message STRING);

DROP TABLE IF EXISTS large_data;
CREATE TABLE large_data (id INT64, email STRING);
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, message STRING);

DROP TABLE IF EXISTS large_data;
CREATE TABLE large_data (id INT64, email STRING);
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, message STRING);

DROP TABLE IF EXISTS large_data;
CREATE TABLE large_data (id INT64, email STRING);
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, message STRING);

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, message STRING);

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);

-- Tag: ddl_ddl_test_select_031
SELECT id FROM data ORDER BY value * 2 LIMIT 10;
-- Tag: ddl_ddl_test_select_032
SELECT id FROM data ORDER BY value NULLS LAST LIMIT 5;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);

-- Tag: ddl_ddl_test_select_033
SELECT id FROM data ORDER BY value NULLS LAST LIMIT 5;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (data STRING);

-- Tag: ddl_ddl_test_select_034
SELECT * FROM test ORDER BY id DESC;
-- Tag: ddl_ddl_test_select_035
SELECT * FROM test t1, test t2, test t3 WHERE t1.id + t2.id + t3.id > 999999999;
-- Tag: ddl_ddl_test_select_036
SELECT * FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (data STRING);

-- Tag: ddl_ddl_test_select_037
SELECT * FROM test ORDER BY id DESC;
-- Tag: ddl_ddl_test_select_038
SELECT * FROM test t1, test t2, test t3 WHERE t1.id + t2.id + t3.id > 999999999;
-- Tag: ddl_ddl_test_select_039
SELECT * FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (data STRING);

-- Tag: ddl_ddl_test_select_040
SELECT * FROM test ORDER BY id DESC;
-- Tag: ddl_ddl_test_select_041
SELECT * FROM test t1, test t2, test t3 WHERE t1.id + t2.id + t3.id > 999999999;
-- Tag: ddl_ddl_test_select_042
SELECT * FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (data STRING);

-- Tag: ddl_ddl_test_select_043
SELECT * FROM test t1, test t2, test t3 WHERE t1.id + t2.id + t3.id > 999999999;
-- Tag: ddl_ddl_test_select_044
SELECT * FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (data STRING);

-- Tag: ddl_ddl_test_select_045
SELECT * FROM test;

DROP TABLE IF EXISTS large_strings;
CREATE TABLE large_strings (id INT64, str STRING);

-- Tag: ddl_ddl_test_select_046
SELECT \ id, \ SUBSTR(str, 1, 10) as short_str, \ POSITION('number' IN str) as pos, \ LPAD(CAST(id AS STRING), 10, '0') as padded_id, \ INITCAP(str) as proper_case \ FROM large_strings \ WHERE POSITION('5' IN str) > 0 \ ORDER BY id \ LIMIT 100;

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);

-- Tag: ddl_ddl_test_select_047
SELECT USER() IS NULL AS is_null;
-- Tag: ddl_ddl_test_select_048
SELECT VERSION() AS version, USER() AS user, DATABASE() AS db, CONNECTION_ID() AS conn;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);

-- Tag: ddl_ddl_test_select_049
SELECT VERSION() AS version, USER() AS user, DATABASE() AS db, CONNECTION_ID() AS conn;

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64 PRIMARY KEY, email STRING UNIQUE NOT NULL, age INT64 CHECK (age >= 0));
