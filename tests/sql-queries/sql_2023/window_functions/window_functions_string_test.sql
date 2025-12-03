-- Window Functions String - SQL:2023
-- Description: Window function operations
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, sku STRING);
INSERT INTO products VALUES (1, 'PROD-2024-001');
INSERT INTO products VALUES (2, 'ITEM-2023-042');
INSERT INTO products VALUES (3, 'PROD-2024-099');
INSERT INTO products VALUES (4, 'PROD-2023-015');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test');
INSERT INTO data VALUES (2, 'testing');
INSERT INTO data VALUES (3, 'retest');
INSERT INTO data VALUES (4, 'test123');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64, code STRING);
INSERT INTO codes VALUES (1, 'A123');
INSERT INTO codes VALUES (2, 'B456');
INSERT INTO codes VALUES (3, 'C789');
INSERT INTO codes VALUES (4, 'X000');
DROP TABLE IF EXISTS words;
CREATE TABLE words (id INT64, word STRING);
INSERT INTO words VALUES (1, 'color');
INSERT INTO words VALUES (2, 'colour');
INSERT INTO words VALUES (3, 'colouur');
INSERT INTO words VALUES (4, 'colr');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test');
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 'example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '');
INSERT INTO data VALUES (2, 'test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test.com');
INSERT INTO data VALUES (2, 'testXcom');
INSERT INTO data VALUES (3, 'test@com');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HELLO');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'abc123');
INSERT INTO data VALUES (2, 'def456');
INSERT INTO data VALUES (3, 'ghi');
INSERT INTO data VALUES (4, 'jkl789');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test');
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 'example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'foo');
INSERT INTO data VALUES (2, 'bar');
INSERT INTO data VALUES (3, 'baz');
INSERT INTO data VALUES (4, 'qux');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HELLO');
INSERT INTO data VALUES (4, 'HeLLo');
INSERT INTO data VALUES (5, 'goodbye');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64, email STRING);
INSERT INTO emails VALUES (1, 'User@Example.COM');
INSERT INTO emails VALUES (2, 'admin@SITE.ORG');
INSERT INTO emails VALUES (3, 'TEST@test.net');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC');
INSERT INTO data VALUES (2, 'abc');
INSERT INTO data VALUES (3, 'XYZ');
INSERT INTO data VALUES (4, 'xyz');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 10);
INSERT INTO numbers VALUES (2, 20);
INSERT INTO numbers VALUES (3, 10);
INSERT INTO numbers VALUES (4, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1), (2), (3), (4), (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (2, 'Bob');
INSERT INTO data VALUES (3, 'Alice');
INSERT INTO data VALUES (4, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '50%');
INSERT INTO data VALUES (2, '50percent');
INSERT INTO data VALUES (3, 'discount_50');
DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64, filename STRING);
INSERT INTO files VALUES (1, 'file_1.txt');
INSERT INTO files VALUES (2, 'file1.txt');
INSERT INTO files VALUES (3, 'filea1.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test_%_data');
INSERT INTO data VALUES (2, 'test_x_data');
INSERT INTO data VALUES (3, 'test_abc_data');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '100%');
INSERT INTO data VALUES (2, '100x');
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, department_id INT64, salary FLOAT64);
INSERT INTO employees VALUES (1, 'Alice', 1, 70000.0);
INSERT INTO employees VALUES (2, 'Bob', 1, 60000.0);
INSERT INTO employees VALUES (3, 'Charlie', 2, 80000.0);
INSERT INTO employees VALUES (4, 'David', 2, 65000.0);
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
INSERT INTO departments VALUES (1, 'Sales');
INSERT INTO departments VALUES (2, 'Engineering');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
INSERT INTO filter VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS empty_filter;
CREATE TABLE empty_filter (value INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, product_id INT64, customer_id INT64);
INSERT INTO orders VALUES (1, 100, 1);
INSERT INTO orders VALUES (2, 200, 2);
INSERT INTO orders VALUES (3, 100, 2);
DROP TABLE IF EXISTS valid_combos;
CREATE TABLE valid_combos (product_id INT64, customer_id INT64);
INSERT INTO valid_combos VALUES (100, 1);
INSERT INTO valid_combos VALUES (200, 2);
DROP TABLE IF EXISTS all_products;
CREATE TABLE all_products (id INT64, name STRING);
INSERT INTO all_products VALUES (1, 'Widget');
INSERT INTO all_products VALUES (2, 'Gadget');
INSERT INTO all_products VALUES (3, 'Gizmo');
DROP TABLE IF EXISTS sold_products;
CREATE TABLE sold_products (product_id INT64);
INSERT INTO sold_products VALUES (2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, code STRING);
INSERT INTO products VALUES (1, 'PROD-001');
INSERT INTO products VALUES (2, 'ITEM-042');
DROP TABLE IF EXISTS patterns;
CREATE TABLE patterns (id INT64, pattern STRING);
INSERT INTO patterns VALUES (1, '^PROD-');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product STRING, amount FLOAT64);
INSERT INTO sales VALUES (1, 'A', 100.0);
INSERT INTO sales VALUES (2, 'A', 200.0);
INSERT INTO sales VALUES (3, 'B', 150.0);
INSERT INTO sales VALUES (4, 'C', 100.0);
INSERT INTO sales VALUES (5, 'C', 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC123');
INSERT INTO data VALUES (2, 'XYZ');
INSERT INTO data VALUES (3, 'DEF456');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Test123');
INSERT INTO data VALUES (2, 'Hello');
INSERT INTO data VALUES (3, 'World456');
INSERT INTO data VALUES (4, 'Example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello 世界');
INSERT INTO data VALUES (2, 'Привет мир');
INSERT INTO data VALUES (3, 'مرحبا');
INSERT INTO data VALUES (4, 'Hello World');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'line1
line2');
INSERT INTO data VALUES (2, 'single line');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test!value');
INSERT INTO data VALUES (2, 'test_value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'completed');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_001
SELECT id FROM products WHERE sku ~ 'PROD-2024-[0-9]{3}' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_002
SELECT id FROM data WHERE value ~ '^test$';
-- Tag: window_functions_window_functions_string_test_select_003
SELECT id FROM codes WHERE code ~ '^[ABC][0-9]{3}$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_004
SELECT id FROM words WHERE word ~ '^colou?r$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_005
SELECT id FROM data WHERE value ~ '.*';
-- Tag: window_functions_window_functions_string_test_select_006
SELECT id FROM data WHERE value ~ '^$';
-- Tag: window_functions_window_functions_string_test_select_007
SELECT id FROM data WHERE value ~ '^test\\.com$';
-- Tag: window_functions_window_functions_string_test_select_008
SELECT id FROM data WHERE value ~ '^hello$';
-- Tag: window_functions_window_functions_string_test_select_009
SELECT id FROM data WHERE value !~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_010
SELECT id FROM data WHERE value !~ 'xyz';
-- Tag: window_functions_window_functions_string_test_select_011
SELECT COUNT(*) FROM data WHERE value ~ '^ba';
-- Tag: window_functions_window_functions_string_test_select_012
SELECT COUNT(*) FROM data WHERE value !~ '^ba';
-- Tag: window_functions_window_functions_string_test_select_013
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_014
SELECT id FROM emails WHERE email ~* '^[a-z]+@[a-z]+\.[a-z]+$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_015
SELECT id FROM data WHERE value !~* 'abc' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_016
SELECT id FROM numbers WHERE value <> 10 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_017
SELECT COUNT(*) FROM data WHERE value <> 3;
-- Tag: window_functions_window_functions_string_test_select_018
SELECT COUNT(*) FROM data WHERE value != 3;
-- Tag: window_functions_window_functions_string_test_select_019
SELECT id FROM data WHERE value <> 10;
-- Tag: window_functions_window_functions_string_test_select_020
SELECT id FROM data WHERE name <> 'Alice' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_021
SELECT id FROM data WHERE value LIKE '50!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_022
SELECT id FROM files WHERE filename LIKE 'file#_1.txt' ESCAPE '#';
-- Tag: window_functions_window_functions_string_test_select_023
SELECT id FROM data WHERE value LIKE 'test!_%!_data' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_024
SELECT id FROM data WHERE value LIKE '100\%' ESCAPE '\';
-- Tag: window_functions_window_functions_string_test_select_025
SELECT name FROM employees e WHERE e.department_id IN (SELECT id FROM departments) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_026
SELECT id FROM data WHERE value IN (SELECT value FROM filter WHERE value IS NOT NULL) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_027
SELECT id FROM data WHERE value IN (SELECT value FROM empty_filter);
-- Tag: window_functions_window_functions_string_test_select_028
SELECT id FROM orders WHERE (product_id, customer_id) IN (SELECT product_id, customer_id FROM valid_combos) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_029
SELECT id FROM all_products WHERE id NOT IN (SELECT product_id FROM sold_products) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_030
SELECT p.id FROM products p, patterns pat WHERE p.code ~ pat.pattern;
-- Tag: window_functions_window_functions_string_test_select_031
SELECT product FROM sales GROUP BY product HAVING SUM(amount) <> 200.0 ORDER BY product;
-- Tag: window_functions_window_functions_string_test_select_032
SELECT id, CASE WHEN value ~ '[0-9]' THEN 'has_digits' ELSE 'no_digits' END as category FROM data ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_033
SELECT id FROM data WHERE value ~ '^[A-Z]' AND value ~ '[0-9]' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_034
SELECT * FROM data WHERE value ~ '[a-z';
-- Tag: window_functions_window_functions_string_test_select_035
SELECT * FROM data WHERE value LIKE 'test' ESCAPE 'ab';
-- Tag: window_functions_window_functions_string_test_select_036
SELECT COUNT(*) FROM data WHERE value ~ '^value[1-3]$';
-- Tag: window_functions_window_functions_string_test_select_037
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_string_test_select_038
SELECT id FROM data WHERE value ~ 'Hello' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_039
SELECT id FROM data WHERE value ~ '\
';
-- Tag: window_functions_window_functions_string_test_select_040
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_041
SELECT id FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_042
SELECT id FROM data WHERE value LIKE 'test!!value' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_043
SELECT id FROM data WHERE status ~ '^(active|pending)$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_044
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_string_test_select_045
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_046
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_047
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_048
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_049
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_050
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_051
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_052
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_053
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_054
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_055
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_056
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_057
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_058
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test');
INSERT INTO data VALUES (2, 'testing');
INSERT INTO data VALUES (3, 'retest');
INSERT INTO data VALUES (4, 'test123');
DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64, code STRING);
INSERT INTO codes VALUES (1, 'A123');
INSERT INTO codes VALUES (2, 'B456');
INSERT INTO codes VALUES (3, 'C789');
INSERT INTO codes VALUES (4, 'X000');
DROP TABLE IF EXISTS words;
CREATE TABLE words (id INT64, word STRING);
INSERT INTO words VALUES (1, 'color');
INSERT INTO words VALUES (2, 'colour');
INSERT INTO words VALUES (3, 'colouur');
INSERT INTO words VALUES (4, 'colr');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test');
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 'example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '');
INSERT INTO data VALUES (2, 'test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test.com');
INSERT INTO data VALUES (2, 'testXcom');
INSERT INTO data VALUES (3, 'test@com');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HELLO');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'abc123');
INSERT INTO data VALUES (2, 'def456');
INSERT INTO data VALUES (3, 'ghi');
INSERT INTO data VALUES (4, 'jkl789');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test');
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 'example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'foo');
INSERT INTO data VALUES (2, 'bar');
INSERT INTO data VALUES (3, 'baz');
INSERT INTO data VALUES (4, 'qux');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HELLO');
INSERT INTO data VALUES (4, 'HeLLo');
INSERT INTO data VALUES (5, 'goodbye');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64, email STRING);
INSERT INTO emails VALUES (1, 'User@Example.COM');
INSERT INTO emails VALUES (2, 'admin@SITE.ORG');
INSERT INTO emails VALUES (3, 'TEST@test.net');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC');
INSERT INTO data VALUES (2, 'abc');
INSERT INTO data VALUES (3, 'XYZ');
INSERT INTO data VALUES (4, 'xyz');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 10);
INSERT INTO numbers VALUES (2, 20);
INSERT INTO numbers VALUES (3, 10);
INSERT INTO numbers VALUES (4, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1), (2), (3), (4), (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (2, 'Bob');
INSERT INTO data VALUES (3, 'Alice');
INSERT INTO data VALUES (4, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '50%');
INSERT INTO data VALUES (2, '50percent');
INSERT INTO data VALUES (3, 'discount_50');
DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64, filename STRING);
INSERT INTO files VALUES (1, 'file_1.txt');
INSERT INTO files VALUES (2, 'file1.txt');
INSERT INTO files VALUES (3, 'filea1.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test_%_data');
INSERT INTO data VALUES (2, 'test_x_data');
INSERT INTO data VALUES (3, 'test_abc_data');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '100%');
INSERT INTO data VALUES (2, '100x');
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, department_id INT64, salary FLOAT64);
INSERT INTO employees VALUES (1, 'Alice', 1, 70000.0);
INSERT INTO employees VALUES (2, 'Bob', 1, 60000.0);
INSERT INTO employees VALUES (3, 'Charlie', 2, 80000.0);
INSERT INTO employees VALUES (4, 'David', 2, 65000.0);
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
INSERT INTO departments VALUES (1, 'Sales');
INSERT INTO departments VALUES (2, 'Engineering');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
INSERT INTO filter VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS empty_filter;
CREATE TABLE empty_filter (value INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, product_id INT64, customer_id INT64);
INSERT INTO orders VALUES (1, 100, 1);
INSERT INTO orders VALUES (2, 200, 2);
INSERT INTO orders VALUES (3, 100, 2);
DROP TABLE IF EXISTS valid_combos;
CREATE TABLE valid_combos (product_id INT64, customer_id INT64);
INSERT INTO valid_combos VALUES (100, 1);
INSERT INTO valid_combos VALUES (200, 2);
DROP TABLE IF EXISTS all_products;
CREATE TABLE all_products (id INT64, name STRING);
INSERT INTO all_products VALUES (1, 'Widget');
INSERT INTO all_products VALUES (2, 'Gadget');
INSERT INTO all_products VALUES (3, 'Gizmo');
DROP TABLE IF EXISTS sold_products;
CREATE TABLE sold_products (product_id INT64);
INSERT INTO sold_products VALUES (2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, code STRING);
INSERT INTO products VALUES (1, 'PROD-001');
INSERT INTO products VALUES (2, 'ITEM-042');
DROP TABLE IF EXISTS patterns;
CREATE TABLE patterns (id INT64, pattern STRING);
INSERT INTO patterns VALUES (1, '^PROD-');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product STRING, amount FLOAT64);
INSERT INTO sales VALUES (1, 'A', 100.0);
INSERT INTO sales VALUES (2, 'A', 200.0);
INSERT INTO sales VALUES (3, 'B', 150.0);
INSERT INTO sales VALUES (4, 'C', 100.0);
INSERT INTO sales VALUES (5, 'C', 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC123');
INSERT INTO data VALUES (2, 'XYZ');
INSERT INTO data VALUES (3, 'DEF456');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Test123');
INSERT INTO data VALUES (2, 'Hello');
INSERT INTO data VALUES (3, 'World456');
INSERT INTO data VALUES (4, 'Example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello 世界');
INSERT INTO data VALUES (2, 'Привет мир');
INSERT INTO data VALUES (3, 'مرحبا');
INSERT INTO data VALUES (4, 'Hello World');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'line1
line2');
INSERT INTO data VALUES (2, 'single line');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test!value');
INSERT INTO data VALUES (2, 'test_value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'completed');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_059
SELECT id FROM data WHERE value ~ '^test$';
-- Tag: window_functions_window_functions_string_test_select_060
SELECT id FROM codes WHERE code ~ '^[ABC][0-9]{3}$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_061
SELECT id FROM words WHERE word ~ '^colou?r$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_062
SELECT id FROM data WHERE value ~ '.*';
-- Tag: window_functions_window_functions_string_test_select_063
SELECT id FROM data WHERE value ~ '^$';
-- Tag: window_functions_window_functions_string_test_select_064
SELECT id FROM data WHERE value ~ '^test\\.com$';
-- Tag: window_functions_window_functions_string_test_select_065
SELECT id FROM data WHERE value ~ '^hello$';
-- Tag: window_functions_window_functions_string_test_select_066
SELECT id FROM data WHERE value !~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_067
SELECT id FROM data WHERE value !~ 'xyz';
-- Tag: window_functions_window_functions_string_test_select_068
SELECT COUNT(*) FROM data WHERE value ~ '^ba';
-- Tag: window_functions_window_functions_string_test_select_069
SELECT COUNT(*) FROM data WHERE value !~ '^ba';
-- Tag: window_functions_window_functions_string_test_select_070
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_071
SELECT id FROM emails WHERE email ~* '^[a-z]+@[a-z]+\.[a-z]+$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_072
SELECT id FROM data WHERE value !~* 'abc' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_073
SELECT id FROM numbers WHERE value <> 10 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_074
SELECT COUNT(*) FROM data WHERE value <> 3;
-- Tag: window_functions_window_functions_string_test_select_075
SELECT COUNT(*) FROM data WHERE value != 3;
-- Tag: window_functions_window_functions_string_test_select_076
SELECT id FROM data WHERE value <> 10;
-- Tag: window_functions_window_functions_string_test_select_077
SELECT id FROM data WHERE name <> 'Alice' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_078
SELECT id FROM data WHERE value LIKE '50!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_079
SELECT id FROM files WHERE filename LIKE 'file#_1.txt' ESCAPE '#';
-- Tag: window_functions_window_functions_string_test_select_080
SELECT id FROM data WHERE value LIKE 'test!_%!_data' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_081
SELECT id FROM data WHERE value LIKE '100\%' ESCAPE '\';
-- Tag: window_functions_window_functions_string_test_select_082
SELECT name FROM employees e WHERE e.department_id IN (SELECT id FROM departments) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_083
SELECT id FROM data WHERE value IN (SELECT value FROM filter WHERE value IS NOT NULL) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_084
SELECT id FROM data WHERE value IN (SELECT value FROM empty_filter);
-- Tag: window_functions_window_functions_string_test_select_085
SELECT id FROM orders WHERE (product_id, customer_id) IN (SELECT product_id, customer_id FROM valid_combos) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_086
SELECT id FROM all_products WHERE id NOT IN (SELECT product_id FROM sold_products) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_087
SELECT p.id FROM products p, patterns pat WHERE p.code ~ pat.pattern;
-- Tag: window_functions_window_functions_string_test_select_088
SELECT product FROM sales GROUP BY product HAVING SUM(amount) <> 200.0 ORDER BY product;
-- Tag: window_functions_window_functions_string_test_select_089
SELECT id, CASE WHEN value ~ '[0-9]' THEN 'has_digits' ELSE 'no_digits' END as category FROM data ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_090
SELECT id FROM data WHERE value ~ '^[A-Z]' AND value ~ '[0-9]' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_091
SELECT * FROM data WHERE value ~ '[a-z';
-- Tag: window_functions_window_functions_string_test_select_092
SELECT * FROM data WHERE value LIKE 'test' ESCAPE 'ab';
-- Tag: window_functions_window_functions_string_test_select_093
SELECT COUNT(*) FROM data WHERE value ~ '^value[1-3]$';
-- Tag: window_functions_window_functions_string_test_select_094
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_string_test_select_095
SELECT id FROM data WHERE value ~ 'Hello' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_096
SELECT id FROM data WHERE value ~ '\
';
-- Tag: window_functions_window_functions_string_test_select_097
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_098
SELECT id FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_099
SELECT id FROM data WHERE value LIKE 'test!!value' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_100
SELECT id FROM data WHERE status ~ '^(active|pending)$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_101
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_string_test_select_102
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_103
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_104
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_105
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_106
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_107
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_108
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_109
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_110
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_111
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_112
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_113
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_114
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_115
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS codes;
CREATE TABLE codes (id INT64, code STRING);
INSERT INTO codes VALUES (1, 'A123');
INSERT INTO codes VALUES (2, 'B456');
INSERT INTO codes VALUES (3, 'C789');
INSERT INTO codes VALUES (4, 'X000');
DROP TABLE IF EXISTS words;
CREATE TABLE words (id INT64, word STRING);
INSERT INTO words VALUES (1, 'color');
INSERT INTO words VALUES (2, 'colour');
INSERT INTO words VALUES (3, 'colouur');
INSERT INTO words VALUES (4, 'colr');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test');
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 'example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '');
INSERT INTO data VALUES (2, 'test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test.com');
INSERT INTO data VALUES (2, 'testXcom');
INSERT INTO data VALUES (3, 'test@com');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HELLO');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'abc123');
INSERT INTO data VALUES (2, 'def456');
INSERT INTO data VALUES (3, 'ghi');
INSERT INTO data VALUES (4, 'jkl789');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test');
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 'example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'foo');
INSERT INTO data VALUES (2, 'bar');
INSERT INTO data VALUES (3, 'baz');
INSERT INTO data VALUES (4, 'qux');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HELLO');
INSERT INTO data VALUES (4, 'HeLLo');
INSERT INTO data VALUES (5, 'goodbye');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64, email STRING);
INSERT INTO emails VALUES (1, 'User@Example.COM');
INSERT INTO emails VALUES (2, 'admin@SITE.ORG');
INSERT INTO emails VALUES (3, 'TEST@test.net');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC');
INSERT INTO data VALUES (2, 'abc');
INSERT INTO data VALUES (3, 'XYZ');
INSERT INTO data VALUES (4, 'xyz');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 10);
INSERT INTO numbers VALUES (2, 20);
INSERT INTO numbers VALUES (3, 10);
INSERT INTO numbers VALUES (4, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1), (2), (3), (4), (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (2, 'Bob');
INSERT INTO data VALUES (3, 'Alice');
INSERT INTO data VALUES (4, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '50%');
INSERT INTO data VALUES (2, '50percent');
INSERT INTO data VALUES (3, 'discount_50');
DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64, filename STRING);
INSERT INTO files VALUES (1, 'file_1.txt');
INSERT INTO files VALUES (2, 'file1.txt');
INSERT INTO files VALUES (3, 'filea1.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test_%_data');
INSERT INTO data VALUES (2, 'test_x_data');
INSERT INTO data VALUES (3, 'test_abc_data');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '100%');
INSERT INTO data VALUES (2, '100x');
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, department_id INT64, salary FLOAT64);
INSERT INTO employees VALUES (1, 'Alice', 1, 70000.0);
INSERT INTO employees VALUES (2, 'Bob', 1, 60000.0);
INSERT INTO employees VALUES (3, 'Charlie', 2, 80000.0);
INSERT INTO employees VALUES (4, 'David', 2, 65000.0);
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
INSERT INTO departments VALUES (1, 'Sales');
INSERT INTO departments VALUES (2, 'Engineering');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
INSERT INTO filter VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS empty_filter;
CREATE TABLE empty_filter (value INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, product_id INT64, customer_id INT64);
INSERT INTO orders VALUES (1, 100, 1);
INSERT INTO orders VALUES (2, 200, 2);
INSERT INTO orders VALUES (3, 100, 2);
DROP TABLE IF EXISTS valid_combos;
CREATE TABLE valid_combos (product_id INT64, customer_id INT64);
INSERT INTO valid_combos VALUES (100, 1);
INSERT INTO valid_combos VALUES (200, 2);
DROP TABLE IF EXISTS all_products;
CREATE TABLE all_products (id INT64, name STRING);
INSERT INTO all_products VALUES (1, 'Widget');
INSERT INTO all_products VALUES (2, 'Gadget');
INSERT INTO all_products VALUES (3, 'Gizmo');
DROP TABLE IF EXISTS sold_products;
CREATE TABLE sold_products (product_id INT64);
INSERT INTO sold_products VALUES (2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, code STRING);
INSERT INTO products VALUES (1, 'PROD-001');
INSERT INTO products VALUES (2, 'ITEM-042');
DROP TABLE IF EXISTS patterns;
CREATE TABLE patterns (id INT64, pattern STRING);
INSERT INTO patterns VALUES (1, '^PROD-');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product STRING, amount FLOAT64);
INSERT INTO sales VALUES (1, 'A', 100.0);
INSERT INTO sales VALUES (2, 'A', 200.0);
INSERT INTO sales VALUES (3, 'B', 150.0);
INSERT INTO sales VALUES (4, 'C', 100.0);
INSERT INTO sales VALUES (5, 'C', 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC123');
INSERT INTO data VALUES (2, 'XYZ');
INSERT INTO data VALUES (3, 'DEF456');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Test123');
INSERT INTO data VALUES (2, 'Hello');
INSERT INTO data VALUES (3, 'World456');
INSERT INTO data VALUES (4, 'Example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello 世界');
INSERT INTO data VALUES (2, 'Привет мир');
INSERT INTO data VALUES (3, 'مرحبا');
INSERT INTO data VALUES (4, 'Hello World');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'line1
line2');
INSERT INTO data VALUES (2, 'single line');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test!value');
INSERT INTO data VALUES (2, 'test_value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'completed');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_116
SELECT id FROM codes WHERE code ~ '^[ABC][0-9]{3}$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_117
SELECT id FROM words WHERE word ~ '^colou?r$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_118
SELECT id FROM data WHERE value ~ '.*';
-- Tag: window_functions_window_functions_string_test_select_119
SELECT id FROM data WHERE value ~ '^$';
-- Tag: window_functions_window_functions_string_test_select_120
SELECT id FROM data WHERE value ~ '^test\\.com$';
-- Tag: window_functions_window_functions_string_test_select_121
SELECT id FROM data WHERE value ~ '^hello$';
-- Tag: window_functions_window_functions_string_test_select_122
SELECT id FROM data WHERE value !~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_123
SELECT id FROM data WHERE value !~ 'xyz';
-- Tag: window_functions_window_functions_string_test_select_124
SELECT COUNT(*) FROM data WHERE value ~ '^ba';
-- Tag: window_functions_window_functions_string_test_select_125
SELECT COUNT(*) FROM data WHERE value !~ '^ba';
-- Tag: window_functions_window_functions_string_test_select_126
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_127
SELECT id FROM emails WHERE email ~* '^[a-z]+@[a-z]+\.[a-z]+$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_128
SELECT id FROM data WHERE value !~* 'abc' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_129
SELECT id FROM numbers WHERE value <> 10 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_130
SELECT COUNT(*) FROM data WHERE value <> 3;
-- Tag: window_functions_window_functions_string_test_select_131
SELECT COUNT(*) FROM data WHERE value != 3;
-- Tag: window_functions_window_functions_string_test_select_132
SELECT id FROM data WHERE value <> 10;
-- Tag: window_functions_window_functions_string_test_select_133
SELECT id FROM data WHERE name <> 'Alice' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_134
SELECT id FROM data WHERE value LIKE '50!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_135
SELECT id FROM files WHERE filename LIKE 'file#_1.txt' ESCAPE '#';
-- Tag: window_functions_window_functions_string_test_select_136
SELECT id FROM data WHERE value LIKE 'test!_%!_data' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_137
SELECT id FROM data WHERE value LIKE '100\%' ESCAPE '\';
-- Tag: window_functions_window_functions_string_test_select_138
SELECT name FROM employees e WHERE e.department_id IN (SELECT id FROM departments) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_139
SELECT id FROM data WHERE value IN (SELECT value FROM filter WHERE value IS NOT NULL) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_140
SELECT id FROM data WHERE value IN (SELECT value FROM empty_filter);
-- Tag: window_functions_window_functions_string_test_select_141
SELECT id FROM orders WHERE (product_id, customer_id) IN (SELECT product_id, customer_id FROM valid_combos) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_142
SELECT id FROM all_products WHERE id NOT IN (SELECT product_id FROM sold_products) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_143
SELECT p.id FROM products p, patterns pat WHERE p.code ~ pat.pattern;
-- Tag: window_functions_window_functions_string_test_select_144
SELECT product FROM sales GROUP BY product HAVING SUM(amount) <> 200.0 ORDER BY product;
-- Tag: window_functions_window_functions_string_test_select_145
SELECT id, CASE WHEN value ~ '[0-9]' THEN 'has_digits' ELSE 'no_digits' END as category FROM data ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_146
SELECT id FROM data WHERE value ~ '^[A-Z]' AND value ~ '[0-9]' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_147
SELECT * FROM data WHERE value ~ '[a-z';
-- Tag: window_functions_window_functions_string_test_select_148
SELECT * FROM data WHERE value LIKE 'test' ESCAPE 'ab';
-- Tag: window_functions_window_functions_string_test_select_149
SELECT COUNT(*) FROM data WHERE value ~ '^value[1-3]$';
-- Tag: window_functions_window_functions_string_test_select_150
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_string_test_select_151
SELECT id FROM data WHERE value ~ 'Hello' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_152
SELECT id FROM data WHERE value ~ '\
';
-- Tag: window_functions_window_functions_string_test_select_153
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_154
SELECT id FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_155
SELECT id FROM data WHERE value LIKE 'test!!value' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_156
SELECT id FROM data WHERE status ~ '^(active|pending)$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_157
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_string_test_select_158
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_159
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_160
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_161
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_162
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_163
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_164
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_165
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_166
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_167
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_168
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_169
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_170
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_171
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS words;
CREATE TABLE words (id INT64, word STRING);
INSERT INTO words VALUES (1, 'color');
INSERT INTO words VALUES (2, 'colour');
INSERT INTO words VALUES (3, 'colouur');
INSERT INTO words VALUES (4, 'colr');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test');
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 'example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '');
INSERT INTO data VALUES (2, 'test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test.com');
INSERT INTO data VALUES (2, 'testXcom');
INSERT INTO data VALUES (3, 'test@com');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HELLO');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'abc123');
INSERT INTO data VALUES (2, 'def456');
INSERT INTO data VALUES (3, 'ghi');
INSERT INTO data VALUES (4, 'jkl789');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test');
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 'example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'foo');
INSERT INTO data VALUES (2, 'bar');
INSERT INTO data VALUES (3, 'baz');
INSERT INTO data VALUES (4, 'qux');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HELLO');
INSERT INTO data VALUES (4, 'HeLLo');
INSERT INTO data VALUES (5, 'goodbye');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64, email STRING);
INSERT INTO emails VALUES (1, 'User@Example.COM');
INSERT INTO emails VALUES (2, 'admin@SITE.ORG');
INSERT INTO emails VALUES (3, 'TEST@test.net');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC');
INSERT INTO data VALUES (2, 'abc');
INSERT INTO data VALUES (3, 'XYZ');
INSERT INTO data VALUES (4, 'xyz');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 10);
INSERT INTO numbers VALUES (2, 20);
INSERT INTO numbers VALUES (3, 10);
INSERT INTO numbers VALUES (4, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1), (2), (3), (4), (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (2, 'Bob');
INSERT INTO data VALUES (3, 'Alice');
INSERT INTO data VALUES (4, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '50%');
INSERT INTO data VALUES (2, '50percent');
INSERT INTO data VALUES (3, 'discount_50');
DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64, filename STRING);
INSERT INTO files VALUES (1, 'file_1.txt');
INSERT INTO files VALUES (2, 'file1.txt');
INSERT INTO files VALUES (3, 'filea1.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test_%_data');
INSERT INTO data VALUES (2, 'test_x_data');
INSERT INTO data VALUES (3, 'test_abc_data');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '100%');
INSERT INTO data VALUES (2, '100x');
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, department_id INT64, salary FLOAT64);
INSERT INTO employees VALUES (1, 'Alice', 1, 70000.0);
INSERT INTO employees VALUES (2, 'Bob', 1, 60000.0);
INSERT INTO employees VALUES (3, 'Charlie', 2, 80000.0);
INSERT INTO employees VALUES (4, 'David', 2, 65000.0);
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
INSERT INTO departments VALUES (1, 'Sales');
INSERT INTO departments VALUES (2, 'Engineering');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
INSERT INTO filter VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS empty_filter;
CREATE TABLE empty_filter (value INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, product_id INT64, customer_id INT64);
INSERT INTO orders VALUES (1, 100, 1);
INSERT INTO orders VALUES (2, 200, 2);
INSERT INTO orders VALUES (3, 100, 2);
DROP TABLE IF EXISTS valid_combos;
CREATE TABLE valid_combos (product_id INT64, customer_id INT64);
INSERT INTO valid_combos VALUES (100, 1);
INSERT INTO valid_combos VALUES (200, 2);
DROP TABLE IF EXISTS all_products;
CREATE TABLE all_products (id INT64, name STRING);
INSERT INTO all_products VALUES (1, 'Widget');
INSERT INTO all_products VALUES (2, 'Gadget');
INSERT INTO all_products VALUES (3, 'Gizmo');
DROP TABLE IF EXISTS sold_products;
CREATE TABLE sold_products (product_id INT64);
INSERT INTO sold_products VALUES (2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, code STRING);
INSERT INTO products VALUES (1, 'PROD-001');
INSERT INTO products VALUES (2, 'ITEM-042');
DROP TABLE IF EXISTS patterns;
CREATE TABLE patterns (id INT64, pattern STRING);
INSERT INTO patterns VALUES (1, '^PROD-');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product STRING, amount FLOAT64);
INSERT INTO sales VALUES (1, 'A', 100.0);
INSERT INTO sales VALUES (2, 'A', 200.0);
INSERT INTO sales VALUES (3, 'B', 150.0);
INSERT INTO sales VALUES (4, 'C', 100.0);
INSERT INTO sales VALUES (5, 'C', 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC123');
INSERT INTO data VALUES (2, 'XYZ');
INSERT INTO data VALUES (3, 'DEF456');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Test123');
INSERT INTO data VALUES (2, 'Hello');
INSERT INTO data VALUES (3, 'World456');
INSERT INTO data VALUES (4, 'Example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello 世界');
INSERT INTO data VALUES (2, 'Привет мир');
INSERT INTO data VALUES (3, 'مرحبا');
INSERT INTO data VALUES (4, 'Hello World');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'line1
line2');
INSERT INTO data VALUES (2, 'single line');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test!value');
INSERT INTO data VALUES (2, 'test_value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'completed');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_172
SELECT id FROM words WHERE word ~ '^colou?r$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_173
SELECT id FROM data WHERE value ~ '.*';
-- Tag: window_functions_window_functions_string_test_select_174
SELECT id FROM data WHERE value ~ '^$';
-- Tag: window_functions_window_functions_string_test_select_175
SELECT id FROM data WHERE value ~ '^test\\.com$';
-- Tag: window_functions_window_functions_string_test_select_176
SELECT id FROM data WHERE value ~ '^hello$';
-- Tag: window_functions_window_functions_string_test_select_177
SELECT id FROM data WHERE value !~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_178
SELECT id FROM data WHERE value !~ 'xyz';
-- Tag: window_functions_window_functions_string_test_select_179
SELECT COUNT(*) FROM data WHERE value ~ '^ba';
-- Tag: window_functions_window_functions_string_test_select_180
SELECT COUNT(*) FROM data WHERE value !~ '^ba';
-- Tag: window_functions_window_functions_string_test_select_181
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_182
SELECT id FROM emails WHERE email ~* '^[a-z]+@[a-z]+\.[a-z]+$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_183
SELECT id FROM data WHERE value !~* 'abc' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_184
SELECT id FROM numbers WHERE value <> 10 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_185
SELECT COUNT(*) FROM data WHERE value <> 3;
-- Tag: window_functions_window_functions_string_test_select_186
SELECT COUNT(*) FROM data WHERE value != 3;
-- Tag: window_functions_window_functions_string_test_select_187
SELECT id FROM data WHERE value <> 10;
-- Tag: window_functions_window_functions_string_test_select_188
SELECT id FROM data WHERE name <> 'Alice' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_189
SELECT id FROM data WHERE value LIKE '50!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_190
SELECT id FROM files WHERE filename LIKE 'file#_1.txt' ESCAPE '#';
-- Tag: window_functions_window_functions_string_test_select_191
SELECT id FROM data WHERE value LIKE 'test!_%!_data' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_192
SELECT id FROM data WHERE value LIKE '100\%' ESCAPE '\';
-- Tag: window_functions_window_functions_string_test_select_193
SELECT name FROM employees e WHERE e.department_id IN (SELECT id FROM departments) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_194
SELECT id FROM data WHERE value IN (SELECT value FROM filter WHERE value IS NOT NULL) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_195
SELECT id FROM data WHERE value IN (SELECT value FROM empty_filter);
-- Tag: window_functions_window_functions_string_test_select_196
SELECT id FROM orders WHERE (product_id, customer_id) IN (SELECT product_id, customer_id FROM valid_combos) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_197
SELECT id FROM all_products WHERE id NOT IN (SELECT product_id FROM sold_products) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_198
SELECT p.id FROM products p, patterns pat WHERE p.code ~ pat.pattern;
-- Tag: window_functions_window_functions_string_test_select_199
SELECT product FROM sales GROUP BY product HAVING SUM(amount) <> 200.0 ORDER BY product;
-- Tag: window_functions_window_functions_string_test_select_200
SELECT id, CASE WHEN value ~ '[0-9]' THEN 'has_digits' ELSE 'no_digits' END as category FROM data ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_201
SELECT id FROM data WHERE value ~ '^[A-Z]' AND value ~ '[0-9]' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_202
SELECT * FROM data WHERE value ~ '[a-z';
-- Tag: window_functions_window_functions_string_test_select_203
SELECT * FROM data WHERE value LIKE 'test' ESCAPE 'ab';
-- Tag: window_functions_window_functions_string_test_select_204
SELECT COUNT(*) FROM data WHERE value ~ '^value[1-3]$';
-- Tag: window_functions_window_functions_string_test_select_205
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_string_test_select_206
SELECT id FROM data WHERE value ~ 'Hello' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_207
SELECT id FROM data WHERE value ~ '\
';
-- Tag: window_functions_window_functions_string_test_select_208
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_209
SELECT id FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_210
SELECT id FROM data WHERE value LIKE 'test!!value' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_211
SELECT id FROM data WHERE status ~ '^(active|pending)$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_212
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_string_test_select_213
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_214
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_215
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_216
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_217
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_218
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_219
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_220
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_221
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_222
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_223
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_224
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_225
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_226
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test');
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 'example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '');
INSERT INTO data VALUES (2, 'test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test.com');
INSERT INTO data VALUES (2, 'testXcom');
INSERT INTO data VALUES (3, 'test@com');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HELLO');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'abc123');
INSERT INTO data VALUES (2, 'def456');
INSERT INTO data VALUES (3, 'ghi');
INSERT INTO data VALUES (4, 'jkl789');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test');
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 'example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'foo');
INSERT INTO data VALUES (2, 'bar');
INSERT INTO data VALUES (3, 'baz');
INSERT INTO data VALUES (4, 'qux');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HELLO');
INSERT INTO data VALUES (4, 'HeLLo');
INSERT INTO data VALUES (5, 'goodbye');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64, email STRING);
INSERT INTO emails VALUES (1, 'User@Example.COM');
INSERT INTO emails VALUES (2, 'admin@SITE.ORG');
INSERT INTO emails VALUES (3, 'TEST@test.net');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC');
INSERT INTO data VALUES (2, 'abc');
INSERT INTO data VALUES (3, 'XYZ');
INSERT INTO data VALUES (4, 'xyz');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 10);
INSERT INTO numbers VALUES (2, 20);
INSERT INTO numbers VALUES (3, 10);
INSERT INTO numbers VALUES (4, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1), (2), (3), (4), (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (2, 'Bob');
INSERT INTO data VALUES (3, 'Alice');
INSERT INTO data VALUES (4, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '50%');
INSERT INTO data VALUES (2, '50percent');
INSERT INTO data VALUES (3, 'discount_50');
DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64, filename STRING);
INSERT INTO files VALUES (1, 'file_1.txt');
INSERT INTO files VALUES (2, 'file1.txt');
INSERT INTO files VALUES (3, 'filea1.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test_%_data');
INSERT INTO data VALUES (2, 'test_x_data');
INSERT INTO data VALUES (3, 'test_abc_data');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '100%');
INSERT INTO data VALUES (2, '100x');
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, department_id INT64, salary FLOAT64);
INSERT INTO employees VALUES (1, 'Alice', 1, 70000.0);
INSERT INTO employees VALUES (2, 'Bob', 1, 60000.0);
INSERT INTO employees VALUES (3, 'Charlie', 2, 80000.0);
INSERT INTO employees VALUES (4, 'David', 2, 65000.0);
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
INSERT INTO departments VALUES (1, 'Sales');
INSERT INTO departments VALUES (2, 'Engineering');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
INSERT INTO filter VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS empty_filter;
CREATE TABLE empty_filter (value INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, product_id INT64, customer_id INT64);
INSERT INTO orders VALUES (1, 100, 1);
INSERT INTO orders VALUES (2, 200, 2);
INSERT INTO orders VALUES (3, 100, 2);
DROP TABLE IF EXISTS valid_combos;
CREATE TABLE valid_combos (product_id INT64, customer_id INT64);
INSERT INTO valid_combos VALUES (100, 1);
INSERT INTO valid_combos VALUES (200, 2);
DROP TABLE IF EXISTS all_products;
CREATE TABLE all_products (id INT64, name STRING);
INSERT INTO all_products VALUES (1, 'Widget');
INSERT INTO all_products VALUES (2, 'Gadget');
INSERT INTO all_products VALUES (3, 'Gizmo');
DROP TABLE IF EXISTS sold_products;
CREATE TABLE sold_products (product_id INT64);
INSERT INTO sold_products VALUES (2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, code STRING);
INSERT INTO products VALUES (1, 'PROD-001');
INSERT INTO products VALUES (2, 'ITEM-042');
DROP TABLE IF EXISTS patterns;
CREATE TABLE patterns (id INT64, pattern STRING);
INSERT INTO patterns VALUES (1, '^PROD-');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product STRING, amount FLOAT64);
INSERT INTO sales VALUES (1, 'A', 100.0);
INSERT INTO sales VALUES (2, 'A', 200.0);
INSERT INTO sales VALUES (3, 'B', 150.0);
INSERT INTO sales VALUES (4, 'C', 100.0);
INSERT INTO sales VALUES (5, 'C', 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC123');
INSERT INTO data VALUES (2, 'XYZ');
INSERT INTO data VALUES (3, 'DEF456');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Test123');
INSERT INTO data VALUES (2, 'Hello');
INSERT INTO data VALUES (3, 'World456');
INSERT INTO data VALUES (4, 'Example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello 世界');
INSERT INTO data VALUES (2, 'Привет мир');
INSERT INTO data VALUES (3, 'مرحبا');
INSERT INTO data VALUES (4, 'Hello World');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'line1
line2');
INSERT INTO data VALUES (2, 'single line');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test!value');
INSERT INTO data VALUES (2, 'test_value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'completed');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_227
SELECT id FROM data WHERE value ~ '.*';
-- Tag: window_functions_window_functions_string_test_select_228
SELECT id FROM data WHERE value ~ '^$';
-- Tag: window_functions_window_functions_string_test_select_229
SELECT id FROM data WHERE value ~ '^test\\.com$';
-- Tag: window_functions_window_functions_string_test_select_230
SELECT id FROM data WHERE value ~ '^hello$';
-- Tag: window_functions_window_functions_string_test_select_231
SELECT id FROM data WHERE value !~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_232
SELECT id FROM data WHERE value !~ 'xyz';
-- Tag: window_functions_window_functions_string_test_select_233
SELECT COUNT(*) FROM data WHERE value ~ '^ba';
-- Tag: window_functions_window_functions_string_test_select_234
SELECT COUNT(*) FROM data WHERE value !~ '^ba';
-- Tag: window_functions_window_functions_string_test_select_235
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_236
SELECT id FROM emails WHERE email ~* '^[a-z]+@[a-z]+\.[a-z]+$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_237
SELECT id FROM data WHERE value !~* 'abc' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_238
SELECT id FROM numbers WHERE value <> 10 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_239
SELECT COUNT(*) FROM data WHERE value <> 3;
-- Tag: window_functions_window_functions_string_test_select_240
SELECT COUNT(*) FROM data WHERE value != 3;
-- Tag: window_functions_window_functions_string_test_select_241
SELECT id FROM data WHERE value <> 10;
-- Tag: window_functions_window_functions_string_test_select_242
SELECT id FROM data WHERE name <> 'Alice' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_243
SELECT id FROM data WHERE value LIKE '50!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_244
SELECT id FROM files WHERE filename LIKE 'file#_1.txt' ESCAPE '#';
-- Tag: window_functions_window_functions_string_test_select_245
SELECT id FROM data WHERE value LIKE 'test!_%!_data' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_246
SELECT id FROM data WHERE value LIKE '100\%' ESCAPE '\';
-- Tag: window_functions_window_functions_string_test_select_247
SELECT name FROM employees e WHERE e.department_id IN (SELECT id FROM departments) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_248
SELECT id FROM data WHERE value IN (SELECT value FROM filter WHERE value IS NOT NULL) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_249
SELECT id FROM data WHERE value IN (SELECT value FROM empty_filter);
-- Tag: window_functions_window_functions_string_test_select_250
SELECT id FROM orders WHERE (product_id, customer_id) IN (SELECT product_id, customer_id FROM valid_combos) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_251
SELECT id FROM all_products WHERE id NOT IN (SELECT product_id FROM sold_products) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_252
SELECT p.id FROM products p, patterns pat WHERE p.code ~ pat.pattern;
-- Tag: window_functions_window_functions_string_test_select_253
SELECT product FROM sales GROUP BY product HAVING SUM(amount) <> 200.0 ORDER BY product;
-- Tag: window_functions_window_functions_string_test_select_254
SELECT id, CASE WHEN value ~ '[0-9]' THEN 'has_digits' ELSE 'no_digits' END as category FROM data ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_255
SELECT id FROM data WHERE value ~ '^[A-Z]' AND value ~ '[0-9]' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_256
SELECT * FROM data WHERE value ~ '[a-z';
-- Tag: window_functions_window_functions_string_test_select_257
SELECT * FROM data WHERE value LIKE 'test' ESCAPE 'ab';
-- Tag: window_functions_window_functions_string_test_select_258
SELECT COUNT(*) FROM data WHERE value ~ '^value[1-3]$';
-- Tag: window_functions_window_functions_string_test_select_259
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_string_test_select_260
SELECT id FROM data WHERE value ~ 'Hello' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_261
SELECT id FROM data WHERE value ~ '\
';
-- Tag: window_functions_window_functions_string_test_select_262
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_263
SELECT id FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_264
SELECT id FROM data WHERE value LIKE 'test!!value' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_265
SELECT id FROM data WHERE status ~ '^(active|pending)$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_266
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_string_test_select_267
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_268
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_269
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_270
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_271
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_272
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_273
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_274
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_275
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_276
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_277
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_278
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_279
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_280
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '');
INSERT INTO data VALUES (2, 'test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test.com');
INSERT INTO data VALUES (2, 'testXcom');
INSERT INTO data VALUES (3, 'test@com');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HELLO');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'abc123');
INSERT INTO data VALUES (2, 'def456');
INSERT INTO data VALUES (3, 'ghi');
INSERT INTO data VALUES (4, 'jkl789');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test');
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 'example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'foo');
INSERT INTO data VALUES (2, 'bar');
INSERT INTO data VALUES (3, 'baz');
INSERT INTO data VALUES (4, 'qux');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HELLO');
INSERT INTO data VALUES (4, 'HeLLo');
INSERT INTO data VALUES (5, 'goodbye');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64, email STRING);
INSERT INTO emails VALUES (1, 'User@Example.COM');
INSERT INTO emails VALUES (2, 'admin@SITE.ORG');
INSERT INTO emails VALUES (3, 'TEST@test.net');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC');
INSERT INTO data VALUES (2, 'abc');
INSERT INTO data VALUES (3, 'XYZ');
INSERT INTO data VALUES (4, 'xyz');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 10);
INSERT INTO numbers VALUES (2, 20);
INSERT INTO numbers VALUES (3, 10);
INSERT INTO numbers VALUES (4, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1), (2), (3), (4), (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (2, 'Bob');
INSERT INTO data VALUES (3, 'Alice');
INSERT INTO data VALUES (4, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '50%');
INSERT INTO data VALUES (2, '50percent');
INSERT INTO data VALUES (3, 'discount_50');
DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64, filename STRING);
INSERT INTO files VALUES (1, 'file_1.txt');
INSERT INTO files VALUES (2, 'file1.txt');
INSERT INTO files VALUES (3, 'filea1.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test_%_data');
INSERT INTO data VALUES (2, 'test_x_data');
INSERT INTO data VALUES (3, 'test_abc_data');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '100%');
INSERT INTO data VALUES (2, '100x');
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, department_id INT64, salary FLOAT64);
INSERT INTO employees VALUES (1, 'Alice', 1, 70000.0);
INSERT INTO employees VALUES (2, 'Bob', 1, 60000.0);
INSERT INTO employees VALUES (3, 'Charlie', 2, 80000.0);
INSERT INTO employees VALUES (4, 'David', 2, 65000.0);
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
INSERT INTO departments VALUES (1, 'Sales');
INSERT INTO departments VALUES (2, 'Engineering');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
INSERT INTO filter VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS empty_filter;
CREATE TABLE empty_filter (value INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, product_id INT64, customer_id INT64);
INSERT INTO orders VALUES (1, 100, 1);
INSERT INTO orders VALUES (2, 200, 2);
INSERT INTO orders VALUES (3, 100, 2);
DROP TABLE IF EXISTS valid_combos;
CREATE TABLE valid_combos (product_id INT64, customer_id INT64);
INSERT INTO valid_combos VALUES (100, 1);
INSERT INTO valid_combos VALUES (200, 2);
DROP TABLE IF EXISTS all_products;
CREATE TABLE all_products (id INT64, name STRING);
INSERT INTO all_products VALUES (1, 'Widget');
INSERT INTO all_products VALUES (2, 'Gadget');
INSERT INTO all_products VALUES (3, 'Gizmo');
DROP TABLE IF EXISTS sold_products;
CREATE TABLE sold_products (product_id INT64);
INSERT INTO sold_products VALUES (2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, code STRING);
INSERT INTO products VALUES (1, 'PROD-001');
INSERT INTO products VALUES (2, 'ITEM-042');
DROP TABLE IF EXISTS patterns;
CREATE TABLE patterns (id INT64, pattern STRING);
INSERT INTO patterns VALUES (1, '^PROD-');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product STRING, amount FLOAT64);
INSERT INTO sales VALUES (1, 'A', 100.0);
INSERT INTO sales VALUES (2, 'A', 200.0);
INSERT INTO sales VALUES (3, 'B', 150.0);
INSERT INTO sales VALUES (4, 'C', 100.0);
INSERT INTO sales VALUES (5, 'C', 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC123');
INSERT INTO data VALUES (2, 'XYZ');
INSERT INTO data VALUES (3, 'DEF456');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Test123');
INSERT INTO data VALUES (2, 'Hello');
INSERT INTO data VALUES (3, 'World456');
INSERT INTO data VALUES (4, 'Example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello 世界');
INSERT INTO data VALUES (2, 'Привет мир');
INSERT INTO data VALUES (3, 'مرحبا');
INSERT INTO data VALUES (4, 'Hello World');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'line1
line2');
INSERT INTO data VALUES (2, 'single line');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test!value');
INSERT INTO data VALUES (2, 'test_value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'completed');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_281
SELECT id FROM data WHERE value ~ '^$';
-- Tag: window_functions_window_functions_string_test_select_282
SELECT id FROM data WHERE value ~ '^test\\.com$';
-- Tag: window_functions_window_functions_string_test_select_283
SELECT id FROM data WHERE value ~ '^hello$';
-- Tag: window_functions_window_functions_string_test_select_284
SELECT id FROM data WHERE value !~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_285
SELECT id FROM data WHERE value !~ 'xyz';
-- Tag: window_functions_window_functions_string_test_select_286
SELECT COUNT(*) FROM data WHERE value ~ '^ba';
-- Tag: window_functions_window_functions_string_test_select_287
SELECT COUNT(*) FROM data WHERE value !~ '^ba';
-- Tag: window_functions_window_functions_string_test_select_288
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_289
SELECT id FROM emails WHERE email ~* '^[a-z]+@[a-z]+\.[a-z]+$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_290
SELECT id FROM data WHERE value !~* 'abc' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_291
SELECT id FROM numbers WHERE value <> 10 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_292
SELECT COUNT(*) FROM data WHERE value <> 3;
-- Tag: window_functions_window_functions_string_test_select_293
SELECT COUNT(*) FROM data WHERE value != 3;
-- Tag: window_functions_window_functions_string_test_select_294
SELECT id FROM data WHERE value <> 10;
-- Tag: window_functions_window_functions_string_test_select_295
SELECT id FROM data WHERE name <> 'Alice' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_296
SELECT id FROM data WHERE value LIKE '50!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_297
SELECT id FROM files WHERE filename LIKE 'file#_1.txt' ESCAPE '#';
-- Tag: window_functions_window_functions_string_test_select_298
SELECT id FROM data WHERE value LIKE 'test!_%!_data' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_299
SELECT id FROM data WHERE value LIKE '100\%' ESCAPE '\';
-- Tag: window_functions_window_functions_string_test_select_300
SELECT name FROM employees e WHERE e.department_id IN (SELECT id FROM departments) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_301
SELECT id FROM data WHERE value IN (SELECT value FROM filter WHERE value IS NOT NULL) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_302
SELECT id FROM data WHERE value IN (SELECT value FROM empty_filter);
-- Tag: window_functions_window_functions_string_test_select_303
SELECT id FROM orders WHERE (product_id, customer_id) IN (SELECT product_id, customer_id FROM valid_combos) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_304
SELECT id FROM all_products WHERE id NOT IN (SELECT product_id FROM sold_products) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_305
SELECT p.id FROM products p, patterns pat WHERE p.code ~ pat.pattern;
-- Tag: window_functions_window_functions_string_test_select_306
SELECT product FROM sales GROUP BY product HAVING SUM(amount) <> 200.0 ORDER BY product;
-- Tag: window_functions_window_functions_string_test_select_307
SELECT id, CASE WHEN value ~ '[0-9]' THEN 'has_digits' ELSE 'no_digits' END as category FROM data ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_308
SELECT id FROM data WHERE value ~ '^[A-Z]' AND value ~ '[0-9]' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_309
SELECT * FROM data WHERE value ~ '[a-z';
-- Tag: window_functions_window_functions_string_test_select_310
SELECT * FROM data WHERE value LIKE 'test' ESCAPE 'ab';
-- Tag: window_functions_window_functions_string_test_select_311
SELECT COUNT(*) FROM data WHERE value ~ '^value[1-3]$';
-- Tag: window_functions_window_functions_string_test_select_312
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_string_test_select_313
SELECT id FROM data WHERE value ~ 'Hello' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_314
SELECT id FROM data WHERE value ~ '\
';
-- Tag: window_functions_window_functions_string_test_select_315
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_316
SELECT id FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_317
SELECT id FROM data WHERE value LIKE 'test!!value' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_318
SELECT id FROM data WHERE status ~ '^(active|pending)$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_319
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_string_test_select_320
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_321
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_322
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_323
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_324
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_325
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_326
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_327
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_328
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_329
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_330
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_331
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_332
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_333
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test.com');
INSERT INTO data VALUES (2, 'testXcom');
INSERT INTO data VALUES (3, 'test@com');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HELLO');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'abc123');
INSERT INTO data VALUES (2, 'def456');
INSERT INTO data VALUES (3, 'ghi');
INSERT INTO data VALUES (4, 'jkl789');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test');
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 'example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'foo');
INSERT INTO data VALUES (2, 'bar');
INSERT INTO data VALUES (3, 'baz');
INSERT INTO data VALUES (4, 'qux');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HELLO');
INSERT INTO data VALUES (4, 'HeLLo');
INSERT INTO data VALUES (5, 'goodbye');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64, email STRING);
INSERT INTO emails VALUES (1, 'User@Example.COM');
INSERT INTO emails VALUES (2, 'admin@SITE.ORG');
INSERT INTO emails VALUES (3, 'TEST@test.net');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC');
INSERT INTO data VALUES (2, 'abc');
INSERT INTO data VALUES (3, 'XYZ');
INSERT INTO data VALUES (4, 'xyz');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 10);
INSERT INTO numbers VALUES (2, 20);
INSERT INTO numbers VALUES (3, 10);
INSERT INTO numbers VALUES (4, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1), (2), (3), (4), (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (2, 'Bob');
INSERT INTO data VALUES (3, 'Alice');
INSERT INTO data VALUES (4, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '50%');
INSERT INTO data VALUES (2, '50percent');
INSERT INTO data VALUES (3, 'discount_50');
DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64, filename STRING);
INSERT INTO files VALUES (1, 'file_1.txt');
INSERT INTO files VALUES (2, 'file1.txt');
INSERT INTO files VALUES (3, 'filea1.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test_%_data');
INSERT INTO data VALUES (2, 'test_x_data');
INSERT INTO data VALUES (3, 'test_abc_data');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '100%');
INSERT INTO data VALUES (2, '100x');
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, department_id INT64, salary FLOAT64);
INSERT INTO employees VALUES (1, 'Alice', 1, 70000.0);
INSERT INTO employees VALUES (2, 'Bob', 1, 60000.0);
INSERT INTO employees VALUES (3, 'Charlie', 2, 80000.0);
INSERT INTO employees VALUES (4, 'David', 2, 65000.0);
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
INSERT INTO departments VALUES (1, 'Sales');
INSERT INTO departments VALUES (2, 'Engineering');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
INSERT INTO filter VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS empty_filter;
CREATE TABLE empty_filter (value INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, product_id INT64, customer_id INT64);
INSERT INTO orders VALUES (1, 100, 1);
INSERT INTO orders VALUES (2, 200, 2);
INSERT INTO orders VALUES (3, 100, 2);
DROP TABLE IF EXISTS valid_combos;
CREATE TABLE valid_combos (product_id INT64, customer_id INT64);
INSERT INTO valid_combos VALUES (100, 1);
INSERT INTO valid_combos VALUES (200, 2);
DROP TABLE IF EXISTS all_products;
CREATE TABLE all_products (id INT64, name STRING);
INSERT INTO all_products VALUES (1, 'Widget');
INSERT INTO all_products VALUES (2, 'Gadget');
INSERT INTO all_products VALUES (3, 'Gizmo');
DROP TABLE IF EXISTS sold_products;
CREATE TABLE sold_products (product_id INT64);
INSERT INTO sold_products VALUES (2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, code STRING);
INSERT INTO products VALUES (1, 'PROD-001');
INSERT INTO products VALUES (2, 'ITEM-042');
DROP TABLE IF EXISTS patterns;
CREATE TABLE patterns (id INT64, pattern STRING);
INSERT INTO patterns VALUES (1, '^PROD-');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product STRING, amount FLOAT64);
INSERT INTO sales VALUES (1, 'A', 100.0);
INSERT INTO sales VALUES (2, 'A', 200.0);
INSERT INTO sales VALUES (3, 'B', 150.0);
INSERT INTO sales VALUES (4, 'C', 100.0);
INSERT INTO sales VALUES (5, 'C', 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC123');
INSERT INTO data VALUES (2, 'XYZ');
INSERT INTO data VALUES (3, 'DEF456');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Test123');
INSERT INTO data VALUES (2, 'Hello');
INSERT INTO data VALUES (3, 'World456');
INSERT INTO data VALUES (4, 'Example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello 世界');
INSERT INTO data VALUES (2, 'Привет мир');
INSERT INTO data VALUES (3, 'مرحبا');
INSERT INTO data VALUES (4, 'Hello World');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'line1
line2');
INSERT INTO data VALUES (2, 'single line');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test!value');
INSERT INTO data VALUES (2, 'test_value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'completed');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_334
SELECT id FROM data WHERE value ~ '^test\\.com$';
-- Tag: window_functions_window_functions_string_test_select_335
SELECT id FROM data WHERE value ~ '^hello$';
-- Tag: window_functions_window_functions_string_test_select_336
SELECT id FROM data WHERE value !~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_337
SELECT id FROM data WHERE value !~ 'xyz';
-- Tag: window_functions_window_functions_string_test_select_338
SELECT COUNT(*) FROM data WHERE value ~ '^ba';
-- Tag: window_functions_window_functions_string_test_select_339
SELECT COUNT(*) FROM data WHERE value !~ '^ba';
-- Tag: window_functions_window_functions_string_test_select_340
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_341
SELECT id FROM emails WHERE email ~* '^[a-z]+@[a-z]+\.[a-z]+$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_342
SELECT id FROM data WHERE value !~* 'abc' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_343
SELECT id FROM numbers WHERE value <> 10 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_344
SELECT COUNT(*) FROM data WHERE value <> 3;
-- Tag: window_functions_window_functions_string_test_select_345
SELECT COUNT(*) FROM data WHERE value != 3;
-- Tag: window_functions_window_functions_string_test_select_346
SELECT id FROM data WHERE value <> 10;
-- Tag: window_functions_window_functions_string_test_select_347
SELECT id FROM data WHERE name <> 'Alice' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_348
SELECT id FROM data WHERE value LIKE '50!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_349
SELECT id FROM files WHERE filename LIKE 'file#_1.txt' ESCAPE '#';
-- Tag: window_functions_window_functions_string_test_select_350
SELECT id FROM data WHERE value LIKE 'test!_%!_data' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_351
SELECT id FROM data WHERE value LIKE '100\%' ESCAPE '\';
-- Tag: window_functions_window_functions_string_test_select_352
SELECT name FROM employees e WHERE e.department_id IN (SELECT id FROM departments) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_353
SELECT id FROM data WHERE value IN (SELECT value FROM filter WHERE value IS NOT NULL) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_354
SELECT id FROM data WHERE value IN (SELECT value FROM empty_filter);
-- Tag: window_functions_window_functions_string_test_select_355
SELECT id FROM orders WHERE (product_id, customer_id) IN (SELECT product_id, customer_id FROM valid_combos) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_356
SELECT id FROM all_products WHERE id NOT IN (SELECT product_id FROM sold_products) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_357
SELECT p.id FROM products p, patterns pat WHERE p.code ~ pat.pattern;
-- Tag: window_functions_window_functions_string_test_select_358
SELECT product FROM sales GROUP BY product HAVING SUM(amount) <> 200.0 ORDER BY product;
-- Tag: window_functions_window_functions_string_test_select_359
SELECT id, CASE WHEN value ~ '[0-9]' THEN 'has_digits' ELSE 'no_digits' END as category FROM data ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_360
SELECT id FROM data WHERE value ~ '^[A-Z]' AND value ~ '[0-9]' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_361
SELECT * FROM data WHERE value ~ '[a-z';
-- Tag: window_functions_window_functions_string_test_select_362
SELECT * FROM data WHERE value LIKE 'test' ESCAPE 'ab';
-- Tag: window_functions_window_functions_string_test_select_363
SELECT COUNT(*) FROM data WHERE value ~ '^value[1-3]$';
-- Tag: window_functions_window_functions_string_test_select_364
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_string_test_select_365
SELECT id FROM data WHERE value ~ 'Hello' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_366
SELECT id FROM data WHERE value ~ '\
';
-- Tag: window_functions_window_functions_string_test_select_367
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_368
SELECT id FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_369
SELECT id FROM data WHERE value LIKE 'test!!value' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_370
SELECT id FROM data WHERE status ~ '^(active|pending)$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_371
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_string_test_select_372
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_373
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_374
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_375
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_376
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_377
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_378
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_379
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_380
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_381
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_382
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_383
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_384
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_385
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HELLO');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'abc123');
INSERT INTO data VALUES (2, 'def456');
INSERT INTO data VALUES (3, 'ghi');
INSERT INTO data VALUES (4, 'jkl789');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test');
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 'example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'foo');
INSERT INTO data VALUES (2, 'bar');
INSERT INTO data VALUES (3, 'baz');
INSERT INTO data VALUES (4, 'qux');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HELLO');
INSERT INTO data VALUES (4, 'HeLLo');
INSERT INTO data VALUES (5, 'goodbye');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64, email STRING);
INSERT INTO emails VALUES (1, 'User@Example.COM');
INSERT INTO emails VALUES (2, 'admin@SITE.ORG');
INSERT INTO emails VALUES (3, 'TEST@test.net');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC');
INSERT INTO data VALUES (2, 'abc');
INSERT INTO data VALUES (3, 'XYZ');
INSERT INTO data VALUES (4, 'xyz');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 10);
INSERT INTO numbers VALUES (2, 20);
INSERT INTO numbers VALUES (3, 10);
INSERT INTO numbers VALUES (4, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1), (2), (3), (4), (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (2, 'Bob');
INSERT INTO data VALUES (3, 'Alice');
INSERT INTO data VALUES (4, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '50%');
INSERT INTO data VALUES (2, '50percent');
INSERT INTO data VALUES (3, 'discount_50');
DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64, filename STRING);
INSERT INTO files VALUES (1, 'file_1.txt');
INSERT INTO files VALUES (2, 'file1.txt');
INSERT INTO files VALUES (3, 'filea1.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test_%_data');
INSERT INTO data VALUES (2, 'test_x_data');
INSERT INTO data VALUES (3, 'test_abc_data');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '100%');
INSERT INTO data VALUES (2, '100x');
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, department_id INT64, salary FLOAT64);
INSERT INTO employees VALUES (1, 'Alice', 1, 70000.0);
INSERT INTO employees VALUES (2, 'Bob', 1, 60000.0);
INSERT INTO employees VALUES (3, 'Charlie', 2, 80000.0);
INSERT INTO employees VALUES (4, 'David', 2, 65000.0);
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
INSERT INTO departments VALUES (1, 'Sales');
INSERT INTO departments VALUES (2, 'Engineering');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
INSERT INTO filter VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS empty_filter;
CREATE TABLE empty_filter (value INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, product_id INT64, customer_id INT64);
INSERT INTO orders VALUES (1, 100, 1);
INSERT INTO orders VALUES (2, 200, 2);
INSERT INTO orders VALUES (3, 100, 2);
DROP TABLE IF EXISTS valid_combos;
CREATE TABLE valid_combos (product_id INT64, customer_id INT64);
INSERT INTO valid_combos VALUES (100, 1);
INSERT INTO valid_combos VALUES (200, 2);
DROP TABLE IF EXISTS all_products;
CREATE TABLE all_products (id INT64, name STRING);
INSERT INTO all_products VALUES (1, 'Widget');
INSERT INTO all_products VALUES (2, 'Gadget');
INSERT INTO all_products VALUES (3, 'Gizmo');
DROP TABLE IF EXISTS sold_products;
CREATE TABLE sold_products (product_id INT64);
INSERT INTO sold_products VALUES (2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, code STRING);
INSERT INTO products VALUES (1, 'PROD-001');
INSERT INTO products VALUES (2, 'ITEM-042');
DROP TABLE IF EXISTS patterns;
CREATE TABLE patterns (id INT64, pattern STRING);
INSERT INTO patterns VALUES (1, '^PROD-');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product STRING, amount FLOAT64);
INSERT INTO sales VALUES (1, 'A', 100.0);
INSERT INTO sales VALUES (2, 'A', 200.0);
INSERT INTO sales VALUES (3, 'B', 150.0);
INSERT INTO sales VALUES (4, 'C', 100.0);
INSERT INTO sales VALUES (5, 'C', 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC123');
INSERT INTO data VALUES (2, 'XYZ');
INSERT INTO data VALUES (3, 'DEF456');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Test123');
INSERT INTO data VALUES (2, 'Hello');
INSERT INTO data VALUES (3, 'World456');
INSERT INTO data VALUES (4, 'Example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello 世界');
INSERT INTO data VALUES (2, 'Привет мир');
INSERT INTO data VALUES (3, 'مرحبا');
INSERT INTO data VALUES (4, 'Hello World');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'line1
line2');
INSERT INTO data VALUES (2, 'single line');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test!value');
INSERT INTO data VALUES (2, 'test_value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'completed');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_386
SELECT id FROM data WHERE value ~ '^hello$';
-- Tag: window_functions_window_functions_string_test_select_387
SELECT id FROM data WHERE value !~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_388
SELECT id FROM data WHERE value !~ 'xyz';
-- Tag: window_functions_window_functions_string_test_select_389
SELECT COUNT(*) FROM data WHERE value ~ '^ba';
-- Tag: window_functions_window_functions_string_test_select_390
SELECT COUNT(*) FROM data WHERE value !~ '^ba';
-- Tag: window_functions_window_functions_string_test_select_391
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_392
SELECT id FROM emails WHERE email ~* '^[a-z]+@[a-z]+\.[a-z]+$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_393
SELECT id FROM data WHERE value !~* 'abc' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_394
SELECT id FROM numbers WHERE value <> 10 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_395
SELECT COUNT(*) FROM data WHERE value <> 3;
-- Tag: window_functions_window_functions_string_test_select_396
SELECT COUNT(*) FROM data WHERE value != 3;
-- Tag: window_functions_window_functions_string_test_select_397
SELECT id FROM data WHERE value <> 10;
-- Tag: window_functions_window_functions_string_test_select_398
SELECT id FROM data WHERE name <> 'Alice' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_399
SELECT id FROM data WHERE value LIKE '50!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_400
SELECT id FROM files WHERE filename LIKE 'file#_1.txt' ESCAPE '#';
-- Tag: window_functions_window_functions_string_test_select_401
SELECT id FROM data WHERE value LIKE 'test!_%!_data' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_402
SELECT id FROM data WHERE value LIKE '100\%' ESCAPE '\';
-- Tag: window_functions_window_functions_string_test_select_403
SELECT name FROM employees e WHERE e.department_id IN (SELECT id FROM departments) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_404
SELECT id FROM data WHERE value IN (SELECT value FROM filter WHERE value IS NOT NULL) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_405
SELECT id FROM data WHERE value IN (SELECT value FROM empty_filter);
-- Tag: window_functions_window_functions_string_test_select_406
SELECT id FROM orders WHERE (product_id, customer_id) IN (SELECT product_id, customer_id FROM valid_combos) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_407
SELECT id FROM all_products WHERE id NOT IN (SELECT product_id FROM sold_products) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_408
SELECT p.id FROM products p, patterns pat WHERE p.code ~ pat.pattern;
-- Tag: window_functions_window_functions_string_test_select_409
SELECT product FROM sales GROUP BY product HAVING SUM(amount) <> 200.0 ORDER BY product;
-- Tag: window_functions_window_functions_string_test_select_410
SELECT id, CASE WHEN value ~ '[0-9]' THEN 'has_digits' ELSE 'no_digits' END as category FROM data ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_411
SELECT id FROM data WHERE value ~ '^[A-Z]' AND value ~ '[0-9]' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_412
SELECT * FROM data WHERE value ~ '[a-z';
-- Tag: window_functions_window_functions_string_test_select_413
SELECT * FROM data WHERE value LIKE 'test' ESCAPE 'ab';
-- Tag: window_functions_window_functions_string_test_select_414
SELECT COUNT(*) FROM data WHERE value ~ '^value[1-3]$';
-- Tag: window_functions_window_functions_string_test_select_415
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_string_test_select_416
SELECT id FROM data WHERE value ~ 'Hello' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_417
SELECT id FROM data WHERE value ~ '\
';
-- Tag: window_functions_window_functions_string_test_select_418
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_419
SELECT id FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_420
SELECT id FROM data WHERE value LIKE 'test!!value' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_421
SELECT id FROM data WHERE status ~ '^(active|pending)$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_422
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_string_test_select_423
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_424
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_425
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_426
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_427
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_428
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_429
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_430
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_431
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_432
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_433
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_434
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_435
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_436
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'abc123');
INSERT INTO data VALUES (2, 'def456');
INSERT INTO data VALUES (3, 'ghi');
INSERT INTO data VALUES (4, 'jkl789');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test');
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 'example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'foo');
INSERT INTO data VALUES (2, 'bar');
INSERT INTO data VALUES (3, 'baz');
INSERT INTO data VALUES (4, 'qux');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HELLO');
INSERT INTO data VALUES (4, 'HeLLo');
INSERT INTO data VALUES (5, 'goodbye');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64, email STRING);
INSERT INTO emails VALUES (1, 'User@Example.COM');
INSERT INTO emails VALUES (2, 'admin@SITE.ORG');
INSERT INTO emails VALUES (3, 'TEST@test.net');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC');
INSERT INTO data VALUES (2, 'abc');
INSERT INTO data VALUES (3, 'XYZ');
INSERT INTO data VALUES (4, 'xyz');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 10);
INSERT INTO numbers VALUES (2, 20);
INSERT INTO numbers VALUES (3, 10);
INSERT INTO numbers VALUES (4, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1), (2), (3), (4), (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (2, 'Bob');
INSERT INTO data VALUES (3, 'Alice');
INSERT INTO data VALUES (4, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '50%');
INSERT INTO data VALUES (2, '50percent');
INSERT INTO data VALUES (3, 'discount_50');
DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64, filename STRING);
INSERT INTO files VALUES (1, 'file_1.txt');
INSERT INTO files VALUES (2, 'file1.txt');
INSERT INTO files VALUES (3, 'filea1.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test_%_data');
INSERT INTO data VALUES (2, 'test_x_data');
INSERT INTO data VALUES (3, 'test_abc_data');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '100%');
INSERT INTO data VALUES (2, '100x');
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, department_id INT64, salary FLOAT64);
INSERT INTO employees VALUES (1, 'Alice', 1, 70000.0);
INSERT INTO employees VALUES (2, 'Bob', 1, 60000.0);
INSERT INTO employees VALUES (3, 'Charlie', 2, 80000.0);
INSERT INTO employees VALUES (4, 'David', 2, 65000.0);
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
INSERT INTO departments VALUES (1, 'Sales');
INSERT INTO departments VALUES (2, 'Engineering');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
INSERT INTO filter VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS empty_filter;
CREATE TABLE empty_filter (value INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, product_id INT64, customer_id INT64);
INSERT INTO orders VALUES (1, 100, 1);
INSERT INTO orders VALUES (2, 200, 2);
INSERT INTO orders VALUES (3, 100, 2);
DROP TABLE IF EXISTS valid_combos;
CREATE TABLE valid_combos (product_id INT64, customer_id INT64);
INSERT INTO valid_combos VALUES (100, 1);
INSERT INTO valid_combos VALUES (200, 2);
DROP TABLE IF EXISTS all_products;
CREATE TABLE all_products (id INT64, name STRING);
INSERT INTO all_products VALUES (1, 'Widget');
INSERT INTO all_products VALUES (2, 'Gadget');
INSERT INTO all_products VALUES (3, 'Gizmo');
DROP TABLE IF EXISTS sold_products;
CREATE TABLE sold_products (product_id INT64);
INSERT INTO sold_products VALUES (2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, code STRING);
INSERT INTO products VALUES (1, 'PROD-001');
INSERT INTO products VALUES (2, 'ITEM-042');
DROP TABLE IF EXISTS patterns;
CREATE TABLE patterns (id INT64, pattern STRING);
INSERT INTO patterns VALUES (1, '^PROD-');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product STRING, amount FLOAT64);
INSERT INTO sales VALUES (1, 'A', 100.0);
INSERT INTO sales VALUES (2, 'A', 200.0);
INSERT INTO sales VALUES (3, 'B', 150.0);
INSERT INTO sales VALUES (4, 'C', 100.0);
INSERT INTO sales VALUES (5, 'C', 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC123');
INSERT INTO data VALUES (2, 'XYZ');
INSERT INTO data VALUES (3, 'DEF456');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Test123');
INSERT INTO data VALUES (2, 'Hello');
INSERT INTO data VALUES (3, 'World456');
INSERT INTO data VALUES (4, 'Example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello 世界');
INSERT INTO data VALUES (2, 'Привет мир');
INSERT INTO data VALUES (3, 'مرحبا');
INSERT INTO data VALUES (4, 'Hello World');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'line1
line2');
INSERT INTO data VALUES (2, 'single line');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test!value');
INSERT INTO data VALUES (2, 'test_value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'completed');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_437
SELECT id FROM data WHERE value !~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_438
SELECT id FROM data WHERE value !~ 'xyz';
-- Tag: window_functions_window_functions_string_test_select_439
SELECT COUNT(*) FROM data WHERE value ~ '^ba';
-- Tag: window_functions_window_functions_string_test_select_440
SELECT COUNT(*) FROM data WHERE value !~ '^ba';
-- Tag: window_functions_window_functions_string_test_select_441
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_442
SELECT id FROM emails WHERE email ~* '^[a-z]+@[a-z]+\.[a-z]+$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_443
SELECT id FROM data WHERE value !~* 'abc' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_444
SELECT id FROM numbers WHERE value <> 10 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_445
SELECT COUNT(*) FROM data WHERE value <> 3;
-- Tag: window_functions_window_functions_string_test_select_446
SELECT COUNT(*) FROM data WHERE value != 3;
-- Tag: window_functions_window_functions_string_test_select_447
SELECT id FROM data WHERE value <> 10;
-- Tag: window_functions_window_functions_string_test_select_448
SELECT id FROM data WHERE name <> 'Alice' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_449
SELECT id FROM data WHERE value LIKE '50!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_450
SELECT id FROM files WHERE filename LIKE 'file#_1.txt' ESCAPE '#';
-- Tag: window_functions_window_functions_string_test_select_451
SELECT id FROM data WHERE value LIKE 'test!_%!_data' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_452
SELECT id FROM data WHERE value LIKE '100\%' ESCAPE '\';
-- Tag: window_functions_window_functions_string_test_select_453
SELECT name FROM employees e WHERE e.department_id IN (SELECT id FROM departments) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_454
SELECT id FROM data WHERE value IN (SELECT value FROM filter WHERE value IS NOT NULL) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_455
SELECT id FROM data WHERE value IN (SELECT value FROM empty_filter);
-- Tag: window_functions_window_functions_string_test_select_456
SELECT id FROM orders WHERE (product_id, customer_id) IN (SELECT product_id, customer_id FROM valid_combos) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_457
SELECT id FROM all_products WHERE id NOT IN (SELECT product_id FROM sold_products) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_458
SELECT p.id FROM products p, patterns pat WHERE p.code ~ pat.pattern;
-- Tag: window_functions_window_functions_string_test_select_459
SELECT product FROM sales GROUP BY product HAVING SUM(amount) <> 200.0 ORDER BY product;
-- Tag: window_functions_window_functions_string_test_select_460
SELECT id, CASE WHEN value ~ '[0-9]' THEN 'has_digits' ELSE 'no_digits' END as category FROM data ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_461
SELECT id FROM data WHERE value ~ '^[A-Z]' AND value ~ '[0-9]' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_462
SELECT * FROM data WHERE value ~ '[a-z';
-- Tag: window_functions_window_functions_string_test_select_463
SELECT * FROM data WHERE value LIKE 'test' ESCAPE 'ab';
-- Tag: window_functions_window_functions_string_test_select_464
SELECT COUNT(*) FROM data WHERE value ~ '^value[1-3]$';
-- Tag: window_functions_window_functions_string_test_select_465
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_string_test_select_466
SELECT id FROM data WHERE value ~ 'Hello' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_467
SELECT id FROM data WHERE value ~ '\
';
-- Tag: window_functions_window_functions_string_test_select_468
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_469
SELECT id FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_470
SELECT id FROM data WHERE value LIKE 'test!!value' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_471
SELECT id FROM data WHERE status ~ '^(active|pending)$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_472
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_string_test_select_473
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_474
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_475
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_476
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_477
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_478
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_479
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_480
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_481
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_482
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_483
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_484
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_485
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_486
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test');
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 'example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'foo');
INSERT INTO data VALUES (2, 'bar');
INSERT INTO data VALUES (3, 'baz');
INSERT INTO data VALUES (4, 'qux');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HELLO');
INSERT INTO data VALUES (4, 'HeLLo');
INSERT INTO data VALUES (5, 'goodbye');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64, email STRING);
INSERT INTO emails VALUES (1, 'User@Example.COM');
INSERT INTO emails VALUES (2, 'admin@SITE.ORG');
INSERT INTO emails VALUES (3, 'TEST@test.net');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC');
INSERT INTO data VALUES (2, 'abc');
INSERT INTO data VALUES (3, 'XYZ');
INSERT INTO data VALUES (4, 'xyz');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 10);
INSERT INTO numbers VALUES (2, 20);
INSERT INTO numbers VALUES (3, 10);
INSERT INTO numbers VALUES (4, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1), (2), (3), (4), (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (2, 'Bob');
INSERT INTO data VALUES (3, 'Alice');
INSERT INTO data VALUES (4, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '50%');
INSERT INTO data VALUES (2, '50percent');
INSERT INTO data VALUES (3, 'discount_50');
DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64, filename STRING);
INSERT INTO files VALUES (1, 'file_1.txt');
INSERT INTO files VALUES (2, 'file1.txt');
INSERT INTO files VALUES (3, 'filea1.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test_%_data');
INSERT INTO data VALUES (2, 'test_x_data');
INSERT INTO data VALUES (3, 'test_abc_data');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '100%');
INSERT INTO data VALUES (2, '100x');
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, department_id INT64, salary FLOAT64);
INSERT INTO employees VALUES (1, 'Alice', 1, 70000.0);
INSERT INTO employees VALUES (2, 'Bob', 1, 60000.0);
INSERT INTO employees VALUES (3, 'Charlie', 2, 80000.0);
INSERT INTO employees VALUES (4, 'David', 2, 65000.0);
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
INSERT INTO departments VALUES (1, 'Sales');
INSERT INTO departments VALUES (2, 'Engineering');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
INSERT INTO filter VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS empty_filter;
CREATE TABLE empty_filter (value INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, product_id INT64, customer_id INT64);
INSERT INTO orders VALUES (1, 100, 1);
INSERT INTO orders VALUES (2, 200, 2);
INSERT INTO orders VALUES (3, 100, 2);
DROP TABLE IF EXISTS valid_combos;
CREATE TABLE valid_combos (product_id INT64, customer_id INT64);
INSERT INTO valid_combos VALUES (100, 1);
INSERT INTO valid_combos VALUES (200, 2);
DROP TABLE IF EXISTS all_products;
CREATE TABLE all_products (id INT64, name STRING);
INSERT INTO all_products VALUES (1, 'Widget');
INSERT INTO all_products VALUES (2, 'Gadget');
INSERT INTO all_products VALUES (3, 'Gizmo');
DROP TABLE IF EXISTS sold_products;
CREATE TABLE sold_products (product_id INT64);
INSERT INTO sold_products VALUES (2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, code STRING);
INSERT INTO products VALUES (1, 'PROD-001');
INSERT INTO products VALUES (2, 'ITEM-042');
DROP TABLE IF EXISTS patterns;
CREATE TABLE patterns (id INT64, pattern STRING);
INSERT INTO patterns VALUES (1, '^PROD-');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product STRING, amount FLOAT64);
INSERT INTO sales VALUES (1, 'A', 100.0);
INSERT INTO sales VALUES (2, 'A', 200.0);
INSERT INTO sales VALUES (3, 'B', 150.0);
INSERT INTO sales VALUES (4, 'C', 100.0);
INSERT INTO sales VALUES (5, 'C', 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC123');
INSERT INTO data VALUES (2, 'XYZ');
INSERT INTO data VALUES (3, 'DEF456');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Test123');
INSERT INTO data VALUES (2, 'Hello');
INSERT INTO data VALUES (3, 'World456');
INSERT INTO data VALUES (4, 'Example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello 世界');
INSERT INTO data VALUES (2, 'Привет мир');
INSERT INTO data VALUES (3, 'مرحبا');
INSERT INTO data VALUES (4, 'Hello World');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'line1
line2');
INSERT INTO data VALUES (2, 'single line');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test!value');
INSERT INTO data VALUES (2, 'test_value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'completed');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_487
SELECT id FROM data WHERE value !~ 'xyz';
-- Tag: window_functions_window_functions_string_test_select_488
SELECT COUNT(*) FROM data WHERE value ~ '^ba';
-- Tag: window_functions_window_functions_string_test_select_489
SELECT COUNT(*) FROM data WHERE value !~ '^ba';
-- Tag: window_functions_window_functions_string_test_select_490
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_491
SELECT id FROM emails WHERE email ~* '^[a-z]+@[a-z]+\.[a-z]+$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_492
SELECT id FROM data WHERE value !~* 'abc' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_493
SELECT id FROM numbers WHERE value <> 10 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_494
SELECT COUNT(*) FROM data WHERE value <> 3;
-- Tag: window_functions_window_functions_string_test_select_495
SELECT COUNT(*) FROM data WHERE value != 3;
-- Tag: window_functions_window_functions_string_test_select_496
SELECT id FROM data WHERE value <> 10;
-- Tag: window_functions_window_functions_string_test_select_497
SELECT id FROM data WHERE name <> 'Alice' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_498
SELECT id FROM data WHERE value LIKE '50!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_499
SELECT id FROM files WHERE filename LIKE 'file#_1.txt' ESCAPE '#';
-- Tag: window_functions_window_functions_string_test_select_500
SELECT id FROM data WHERE value LIKE 'test!_%!_data' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_501
SELECT id FROM data WHERE value LIKE '100\%' ESCAPE '\';
-- Tag: window_functions_window_functions_string_test_select_502
SELECT name FROM employees e WHERE e.department_id IN (SELECT id FROM departments) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_503
SELECT id FROM data WHERE value IN (SELECT value FROM filter WHERE value IS NOT NULL) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_504
SELECT id FROM data WHERE value IN (SELECT value FROM empty_filter);
-- Tag: window_functions_window_functions_string_test_select_505
SELECT id FROM orders WHERE (product_id, customer_id) IN (SELECT product_id, customer_id FROM valid_combos) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_506
SELECT id FROM all_products WHERE id NOT IN (SELECT product_id FROM sold_products) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_507
SELECT p.id FROM products p, patterns pat WHERE p.code ~ pat.pattern;
-- Tag: window_functions_window_functions_string_test_select_508
SELECT product FROM sales GROUP BY product HAVING SUM(amount) <> 200.0 ORDER BY product;
-- Tag: window_functions_window_functions_string_test_select_509
SELECT id, CASE WHEN value ~ '[0-9]' THEN 'has_digits' ELSE 'no_digits' END as category FROM data ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_510
SELECT id FROM data WHERE value ~ '^[A-Z]' AND value ~ '[0-9]' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_511
SELECT * FROM data WHERE value ~ '[a-z';
-- Tag: window_functions_window_functions_string_test_select_512
SELECT * FROM data WHERE value LIKE 'test' ESCAPE 'ab';
-- Tag: window_functions_window_functions_string_test_select_513
SELECT COUNT(*) FROM data WHERE value ~ '^value[1-3]$';
-- Tag: window_functions_window_functions_string_test_select_514
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_string_test_select_515
SELECT id FROM data WHERE value ~ 'Hello' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_516
SELECT id FROM data WHERE value ~ '\
';
-- Tag: window_functions_window_functions_string_test_select_517
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_518
SELECT id FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_519
SELECT id FROM data WHERE value LIKE 'test!!value' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_520
SELECT id FROM data WHERE status ~ '^(active|pending)$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_521
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_string_test_select_522
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_523
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_524
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_525
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_526
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_527
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_528
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_529
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_530
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_531
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_532
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_533
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_534
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_535
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'foo');
INSERT INTO data VALUES (2, 'bar');
INSERT INTO data VALUES (3, 'baz');
INSERT INTO data VALUES (4, 'qux');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HELLO');
INSERT INTO data VALUES (4, 'HeLLo');
INSERT INTO data VALUES (5, 'goodbye');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64, email STRING);
INSERT INTO emails VALUES (1, 'User@Example.COM');
INSERT INTO emails VALUES (2, 'admin@SITE.ORG');
INSERT INTO emails VALUES (3, 'TEST@test.net');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC');
INSERT INTO data VALUES (2, 'abc');
INSERT INTO data VALUES (3, 'XYZ');
INSERT INTO data VALUES (4, 'xyz');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 10);
INSERT INTO numbers VALUES (2, 20);
INSERT INTO numbers VALUES (3, 10);
INSERT INTO numbers VALUES (4, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1), (2), (3), (4), (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (2, 'Bob');
INSERT INTO data VALUES (3, 'Alice');
INSERT INTO data VALUES (4, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '50%');
INSERT INTO data VALUES (2, '50percent');
INSERT INTO data VALUES (3, 'discount_50');
DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64, filename STRING);
INSERT INTO files VALUES (1, 'file_1.txt');
INSERT INTO files VALUES (2, 'file1.txt');
INSERT INTO files VALUES (3, 'filea1.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test_%_data');
INSERT INTO data VALUES (2, 'test_x_data');
INSERT INTO data VALUES (3, 'test_abc_data');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '100%');
INSERT INTO data VALUES (2, '100x');
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, department_id INT64, salary FLOAT64);
INSERT INTO employees VALUES (1, 'Alice', 1, 70000.0);
INSERT INTO employees VALUES (2, 'Bob', 1, 60000.0);
INSERT INTO employees VALUES (3, 'Charlie', 2, 80000.0);
INSERT INTO employees VALUES (4, 'David', 2, 65000.0);
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
INSERT INTO departments VALUES (1, 'Sales');
INSERT INTO departments VALUES (2, 'Engineering');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
INSERT INTO filter VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS empty_filter;
CREATE TABLE empty_filter (value INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, product_id INT64, customer_id INT64);
INSERT INTO orders VALUES (1, 100, 1);
INSERT INTO orders VALUES (2, 200, 2);
INSERT INTO orders VALUES (3, 100, 2);
DROP TABLE IF EXISTS valid_combos;
CREATE TABLE valid_combos (product_id INT64, customer_id INT64);
INSERT INTO valid_combos VALUES (100, 1);
INSERT INTO valid_combos VALUES (200, 2);
DROP TABLE IF EXISTS all_products;
CREATE TABLE all_products (id INT64, name STRING);
INSERT INTO all_products VALUES (1, 'Widget');
INSERT INTO all_products VALUES (2, 'Gadget');
INSERT INTO all_products VALUES (3, 'Gizmo');
DROP TABLE IF EXISTS sold_products;
CREATE TABLE sold_products (product_id INT64);
INSERT INTO sold_products VALUES (2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, code STRING);
INSERT INTO products VALUES (1, 'PROD-001');
INSERT INTO products VALUES (2, 'ITEM-042');
DROP TABLE IF EXISTS patterns;
CREATE TABLE patterns (id INT64, pattern STRING);
INSERT INTO patterns VALUES (1, '^PROD-');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product STRING, amount FLOAT64);
INSERT INTO sales VALUES (1, 'A', 100.0);
INSERT INTO sales VALUES (2, 'A', 200.0);
INSERT INTO sales VALUES (3, 'B', 150.0);
INSERT INTO sales VALUES (4, 'C', 100.0);
INSERT INTO sales VALUES (5, 'C', 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC123');
INSERT INTO data VALUES (2, 'XYZ');
INSERT INTO data VALUES (3, 'DEF456');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Test123');
INSERT INTO data VALUES (2, 'Hello');
INSERT INTO data VALUES (3, 'World456');
INSERT INTO data VALUES (4, 'Example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello 世界');
INSERT INTO data VALUES (2, 'Привет мир');
INSERT INTO data VALUES (3, 'مرحبا');
INSERT INTO data VALUES (4, 'Hello World');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'line1
line2');
INSERT INTO data VALUES (2, 'single line');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test!value');
INSERT INTO data VALUES (2, 'test_value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'completed');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_536
SELECT COUNT(*) FROM data WHERE value ~ '^ba';
-- Tag: window_functions_window_functions_string_test_select_537
SELECT COUNT(*) FROM data WHERE value !~ '^ba';
-- Tag: window_functions_window_functions_string_test_select_538
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_539
SELECT id FROM emails WHERE email ~* '^[a-z]+@[a-z]+\.[a-z]+$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_540
SELECT id FROM data WHERE value !~* 'abc' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_541
SELECT id FROM numbers WHERE value <> 10 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_542
SELECT COUNT(*) FROM data WHERE value <> 3;
-- Tag: window_functions_window_functions_string_test_select_543
SELECT COUNT(*) FROM data WHERE value != 3;
-- Tag: window_functions_window_functions_string_test_select_544
SELECT id FROM data WHERE value <> 10;
-- Tag: window_functions_window_functions_string_test_select_545
SELECT id FROM data WHERE name <> 'Alice' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_546
SELECT id FROM data WHERE value LIKE '50!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_547
SELECT id FROM files WHERE filename LIKE 'file#_1.txt' ESCAPE '#';
-- Tag: window_functions_window_functions_string_test_select_548
SELECT id FROM data WHERE value LIKE 'test!_%!_data' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_549
SELECT id FROM data WHERE value LIKE '100\%' ESCAPE '\';
-- Tag: window_functions_window_functions_string_test_select_550
SELECT name FROM employees e WHERE e.department_id IN (SELECT id FROM departments) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_551
SELECT id FROM data WHERE value IN (SELECT value FROM filter WHERE value IS NOT NULL) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_552
SELECT id FROM data WHERE value IN (SELECT value FROM empty_filter);
-- Tag: window_functions_window_functions_string_test_select_553
SELECT id FROM orders WHERE (product_id, customer_id) IN (SELECT product_id, customer_id FROM valid_combos) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_554
SELECT id FROM all_products WHERE id NOT IN (SELECT product_id FROM sold_products) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_555
SELECT p.id FROM products p, patterns pat WHERE p.code ~ pat.pattern;
-- Tag: window_functions_window_functions_string_test_select_556
SELECT product FROM sales GROUP BY product HAVING SUM(amount) <> 200.0 ORDER BY product;
-- Tag: window_functions_window_functions_string_test_select_557
SELECT id, CASE WHEN value ~ '[0-9]' THEN 'has_digits' ELSE 'no_digits' END as category FROM data ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_558
SELECT id FROM data WHERE value ~ '^[A-Z]' AND value ~ '[0-9]' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_559
SELECT * FROM data WHERE value ~ '[a-z';
-- Tag: window_functions_window_functions_string_test_select_560
SELECT * FROM data WHERE value LIKE 'test' ESCAPE 'ab';
-- Tag: window_functions_window_functions_string_test_select_561
SELECT COUNT(*) FROM data WHERE value ~ '^value[1-3]$';
-- Tag: window_functions_window_functions_string_test_select_562
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_string_test_select_563
SELECT id FROM data WHERE value ~ 'Hello' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_564
SELECT id FROM data WHERE value ~ '\
';
-- Tag: window_functions_window_functions_string_test_select_565
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_566
SELECT id FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_567
SELECT id FROM data WHERE value LIKE 'test!!value' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_568
SELECT id FROM data WHERE status ~ '^(active|pending)$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_569
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_string_test_select_570
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_571
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_572
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_573
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_574
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_575
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_576
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_577
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_578
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_579
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_580
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_581
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_582
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_583
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HELLO');
INSERT INTO data VALUES (4, 'HeLLo');
INSERT INTO data VALUES (5, 'goodbye');
DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64, email STRING);
INSERT INTO emails VALUES (1, 'User@Example.COM');
INSERT INTO emails VALUES (2, 'admin@SITE.ORG');
INSERT INTO emails VALUES (3, 'TEST@test.net');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC');
INSERT INTO data VALUES (2, 'abc');
INSERT INTO data VALUES (3, 'XYZ');
INSERT INTO data VALUES (4, 'xyz');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 10);
INSERT INTO numbers VALUES (2, 20);
INSERT INTO numbers VALUES (3, 10);
INSERT INTO numbers VALUES (4, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1), (2), (3), (4), (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (2, 'Bob');
INSERT INTO data VALUES (3, 'Alice');
INSERT INTO data VALUES (4, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '50%');
INSERT INTO data VALUES (2, '50percent');
INSERT INTO data VALUES (3, 'discount_50');
DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64, filename STRING);
INSERT INTO files VALUES (1, 'file_1.txt');
INSERT INTO files VALUES (2, 'file1.txt');
INSERT INTO files VALUES (3, 'filea1.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test_%_data');
INSERT INTO data VALUES (2, 'test_x_data');
INSERT INTO data VALUES (3, 'test_abc_data');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '100%');
INSERT INTO data VALUES (2, '100x');
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, department_id INT64, salary FLOAT64);
INSERT INTO employees VALUES (1, 'Alice', 1, 70000.0);
INSERT INTO employees VALUES (2, 'Bob', 1, 60000.0);
INSERT INTO employees VALUES (3, 'Charlie', 2, 80000.0);
INSERT INTO employees VALUES (4, 'David', 2, 65000.0);
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
INSERT INTO departments VALUES (1, 'Sales');
INSERT INTO departments VALUES (2, 'Engineering');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
INSERT INTO filter VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS empty_filter;
CREATE TABLE empty_filter (value INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, product_id INT64, customer_id INT64);
INSERT INTO orders VALUES (1, 100, 1);
INSERT INTO orders VALUES (2, 200, 2);
INSERT INTO orders VALUES (3, 100, 2);
DROP TABLE IF EXISTS valid_combos;
CREATE TABLE valid_combos (product_id INT64, customer_id INT64);
INSERT INTO valid_combos VALUES (100, 1);
INSERT INTO valid_combos VALUES (200, 2);
DROP TABLE IF EXISTS all_products;
CREATE TABLE all_products (id INT64, name STRING);
INSERT INTO all_products VALUES (1, 'Widget');
INSERT INTO all_products VALUES (2, 'Gadget');
INSERT INTO all_products VALUES (3, 'Gizmo');
DROP TABLE IF EXISTS sold_products;
CREATE TABLE sold_products (product_id INT64);
INSERT INTO sold_products VALUES (2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, code STRING);
INSERT INTO products VALUES (1, 'PROD-001');
INSERT INTO products VALUES (2, 'ITEM-042');
DROP TABLE IF EXISTS patterns;
CREATE TABLE patterns (id INT64, pattern STRING);
INSERT INTO patterns VALUES (1, '^PROD-');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product STRING, amount FLOAT64);
INSERT INTO sales VALUES (1, 'A', 100.0);
INSERT INTO sales VALUES (2, 'A', 200.0);
INSERT INTO sales VALUES (3, 'B', 150.0);
INSERT INTO sales VALUES (4, 'C', 100.0);
INSERT INTO sales VALUES (5, 'C', 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC123');
INSERT INTO data VALUES (2, 'XYZ');
INSERT INTO data VALUES (3, 'DEF456');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Test123');
INSERT INTO data VALUES (2, 'Hello');
INSERT INTO data VALUES (3, 'World456');
INSERT INTO data VALUES (4, 'Example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello 世界');
INSERT INTO data VALUES (2, 'Привет мир');
INSERT INTO data VALUES (3, 'مرحبا');
INSERT INTO data VALUES (4, 'Hello World');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'line1
line2');
INSERT INTO data VALUES (2, 'single line');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test!value');
INSERT INTO data VALUES (2, 'test_value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'completed');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_584
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_585
SELECT id FROM emails WHERE email ~* '^[a-z]+@[a-z]+\.[a-z]+$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_586
SELECT id FROM data WHERE value !~* 'abc' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_587
SELECT id FROM numbers WHERE value <> 10 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_588
SELECT COUNT(*) FROM data WHERE value <> 3;
-- Tag: window_functions_window_functions_string_test_select_589
SELECT COUNT(*) FROM data WHERE value != 3;
-- Tag: window_functions_window_functions_string_test_select_590
SELECT id FROM data WHERE value <> 10;
-- Tag: window_functions_window_functions_string_test_select_591
SELECT id FROM data WHERE name <> 'Alice' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_592
SELECT id FROM data WHERE value LIKE '50!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_593
SELECT id FROM files WHERE filename LIKE 'file#_1.txt' ESCAPE '#';
-- Tag: window_functions_window_functions_string_test_select_594
SELECT id FROM data WHERE value LIKE 'test!_%!_data' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_595
SELECT id FROM data WHERE value LIKE '100\%' ESCAPE '\';
-- Tag: window_functions_window_functions_string_test_select_596
SELECT name FROM employees e WHERE e.department_id IN (SELECT id FROM departments) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_597
SELECT id FROM data WHERE value IN (SELECT value FROM filter WHERE value IS NOT NULL) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_598
SELECT id FROM data WHERE value IN (SELECT value FROM empty_filter);
-- Tag: window_functions_window_functions_string_test_select_599
SELECT id FROM orders WHERE (product_id, customer_id) IN (SELECT product_id, customer_id FROM valid_combos) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_600
SELECT id FROM all_products WHERE id NOT IN (SELECT product_id FROM sold_products) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_601
SELECT p.id FROM products p, patterns pat WHERE p.code ~ pat.pattern;
-- Tag: window_functions_window_functions_string_test_select_602
SELECT product FROM sales GROUP BY product HAVING SUM(amount) <> 200.0 ORDER BY product;
-- Tag: window_functions_window_functions_string_test_select_603
SELECT id, CASE WHEN value ~ '[0-9]' THEN 'has_digits' ELSE 'no_digits' END as category FROM data ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_604
SELECT id FROM data WHERE value ~ '^[A-Z]' AND value ~ '[0-9]' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_605
SELECT * FROM data WHERE value ~ '[a-z';
-- Tag: window_functions_window_functions_string_test_select_606
SELECT * FROM data WHERE value LIKE 'test' ESCAPE 'ab';
-- Tag: window_functions_window_functions_string_test_select_607
SELECT COUNT(*) FROM data WHERE value ~ '^value[1-3]$';
-- Tag: window_functions_window_functions_string_test_select_608
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_string_test_select_609
SELECT id FROM data WHERE value ~ 'Hello' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_610
SELECT id FROM data WHERE value ~ '\
';
-- Tag: window_functions_window_functions_string_test_select_611
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_612
SELECT id FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_613
SELECT id FROM data WHERE value LIKE 'test!!value' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_614
SELECT id FROM data WHERE status ~ '^(active|pending)$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_615
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_string_test_select_616
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_617
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_618
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_619
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_620
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_621
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_622
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_623
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_624
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_625
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_626
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_627
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_628
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_629
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS emails;
CREATE TABLE emails (id INT64, email STRING);
INSERT INTO emails VALUES (1, 'User@Example.COM');
INSERT INTO emails VALUES (2, 'admin@SITE.ORG');
INSERT INTO emails VALUES (3, 'TEST@test.net');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC');
INSERT INTO data VALUES (2, 'abc');
INSERT INTO data VALUES (3, 'XYZ');
INSERT INTO data VALUES (4, 'xyz');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 10);
INSERT INTO numbers VALUES (2, 20);
INSERT INTO numbers VALUES (3, 10);
INSERT INTO numbers VALUES (4, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1), (2), (3), (4), (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (2, 'Bob');
INSERT INTO data VALUES (3, 'Alice');
INSERT INTO data VALUES (4, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '50%');
INSERT INTO data VALUES (2, '50percent');
INSERT INTO data VALUES (3, 'discount_50');
DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64, filename STRING);
INSERT INTO files VALUES (1, 'file_1.txt');
INSERT INTO files VALUES (2, 'file1.txt');
INSERT INTO files VALUES (3, 'filea1.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test_%_data');
INSERT INTO data VALUES (2, 'test_x_data');
INSERT INTO data VALUES (3, 'test_abc_data');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '100%');
INSERT INTO data VALUES (2, '100x');
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, department_id INT64, salary FLOAT64);
INSERT INTO employees VALUES (1, 'Alice', 1, 70000.0);
INSERT INTO employees VALUES (2, 'Bob', 1, 60000.0);
INSERT INTO employees VALUES (3, 'Charlie', 2, 80000.0);
INSERT INTO employees VALUES (4, 'David', 2, 65000.0);
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
INSERT INTO departments VALUES (1, 'Sales');
INSERT INTO departments VALUES (2, 'Engineering');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
INSERT INTO filter VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS empty_filter;
CREATE TABLE empty_filter (value INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, product_id INT64, customer_id INT64);
INSERT INTO orders VALUES (1, 100, 1);
INSERT INTO orders VALUES (2, 200, 2);
INSERT INTO orders VALUES (3, 100, 2);
DROP TABLE IF EXISTS valid_combos;
CREATE TABLE valid_combos (product_id INT64, customer_id INT64);
INSERT INTO valid_combos VALUES (100, 1);
INSERT INTO valid_combos VALUES (200, 2);
DROP TABLE IF EXISTS all_products;
CREATE TABLE all_products (id INT64, name STRING);
INSERT INTO all_products VALUES (1, 'Widget');
INSERT INTO all_products VALUES (2, 'Gadget');
INSERT INTO all_products VALUES (3, 'Gizmo');
DROP TABLE IF EXISTS sold_products;
CREATE TABLE sold_products (product_id INT64);
INSERT INTO sold_products VALUES (2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, code STRING);
INSERT INTO products VALUES (1, 'PROD-001');
INSERT INTO products VALUES (2, 'ITEM-042');
DROP TABLE IF EXISTS patterns;
CREATE TABLE patterns (id INT64, pattern STRING);
INSERT INTO patterns VALUES (1, '^PROD-');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product STRING, amount FLOAT64);
INSERT INTO sales VALUES (1, 'A', 100.0);
INSERT INTO sales VALUES (2, 'A', 200.0);
INSERT INTO sales VALUES (3, 'B', 150.0);
INSERT INTO sales VALUES (4, 'C', 100.0);
INSERT INTO sales VALUES (5, 'C', 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC123');
INSERT INTO data VALUES (2, 'XYZ');
INSERT INTO data VALUES (3, 'DEF456');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Test123');
INSERT INTO data VALUES (2, 'Hello');
INSERT INTO data VALUES (3, 'World456');
INSERT INTO data VALUES (4, 'Example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello 世界');
INSERT INTO data VALUES (2, 'Привет мир');
INSERT INTO data VALUES (3, 'مرحبا');
INSERT INTO data VALUES (4, 'Hello World');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'line1
line2');
INSERT INTO data VALUES (2, 'single line');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test!value');
INSERT INTO data VALUES (2, 'test_value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'completed');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_630
SELECT id FROM emails WHERE email ~* '^[a-z]+@[a-z]+\.[a-z]+$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_631
SELECT id FROM data WHERE value !~* 'abc' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_632
SELECT id FROM numbers WHERE value <> 10 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_633
SELECT COUNT(*) FROM data WHERE value <> 3;
-- Tag: window_functions_window_functions_string_test_select_634
SELECT COUNT(*) FROM data WHERE value != 3;
-- Tag: window_functions_window_functions_string_test_select_635
SELECT id FROM data WHERE value <> 10;
-- Tag: window_functions_window_functions_string_test_select_636
SELECT id FROM data WHERE name <> 'Alice' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_637
SELECT id FROM data WHERE value LIKE '50!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_638
SELECT id FROM files WHERE filename LIKE 'file#_1.txt' ESCAPE '#';
-- Tag: window_functions_window_functions_string_test_select_639
SELECT id FROM data WHERE value LIKE 'test!_%!_data' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_640
SELECT id FROM data WHERE value LIKE '100\%' ESCAPE '\';
-- Tag: window_functions_window_functions_string_test_select_641
SELECT name FROM employees e WHERE e.department_id IN (SELECT id FROM departments) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_642
SELECT id FROM data WHERE value IN (SELECT value FROM filter WHERE value IS NOT NULL) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_643
SELECT id FROM data WHERE value IN (SELECT value FROM empty_filter);
-- Tag: window_functions_window_functions_string_test_select_644
SELECT id FROM orders WHERE (product_id, customer_id) IN (SELECT product_id, customer_id FROM valid_combos) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_645
SELECT id FROM all_products WHERE id NOT IN (SELECT product_id FROM sold_products) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_646
SELECT p.id FROM products p, patterns pat WHERE p.code ~ pat.pattern;
-- Tag: window_functions_window_functions_string_test_select_647
SELECT product FROM sales GROUP BY product HAVING SUM(amount) <> 200.0 ORDER BY product;
-- Tag: window_functions_window_functions_string_test_select_648
SELECT id, CASE WHEN value ~ '[0-9]' THEN 'has_digits' ELSE 'no_digits' END as category FROM data ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_649
SELECT id FROM data WHERE value ~ '^[A-Z]' AND value ~ '[0-9]' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_650
SELECT * FROM data WHERE value ~ '[a-z';
-- Tag: window_functions_window_functions_string_test_select_651
SELECT * FROM data WHERE value LIKE 'test' ESCAPE 'ab';
-- Tag: window_functions_window_functions_string_test_select_652
SELECT COUNT(*) FROM data WHERE value ~ '^value[1-3]$';
-- Tag: window_functions_window_functions_string_test_select_653
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_string_test_select_654
SELECT id FROM data WHERE value ~ 'Hello' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_655
SELECT id FROM data WHERE value ~ '\
';
-- Tag: window_functions_window_functions_string_test_select_656
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_657
SELECT id FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_658
SELECT id FROM data WHERE value LIKE 'test!!value' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_659
SELECT id FROM data WHERE status ~ '^(active|pending)$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_660
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_string_test_select_661
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_662
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_663
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_664
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_665
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_666
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_667
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_668
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_669
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_670
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_671
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_672
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_673
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_674
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC');
INSERT INTO data VALUES (2, 'abc');
INSERT INTO data VALUES (3, 'XYZ');
INSERT INTO data VALUES (4, 'xyz');
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 10);
INSERT INTO numbers VALUES (2, 20);
INSERT INTO numbers VALUES (3, 10);
INSERT INTO numbers VALUES (4, 30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (1), (2), (3), (4), (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, NULL);
INSERT INTO data VALUES (3, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, name STRING);
INSERT INTO data VALUES (1, 'Alice');
INSERT INTO data VALUES (2, 'Bob');
INSERT INTO data VALUES (3, 'Alice');
INSERT INTO data VALUES (4, 'Charlie');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '50%');
INSERT INTO data VALUES (2, '50percent');
INSERT INTO data VALUES (3, 'discount_50');
DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64, filename STRING);
INSERT INTO files VALUES (1, 'file_1.txt');
INSERT INTO files VALUES (2, 'file1.txt');
INSERT INTO files VALUES (3, 'filea1.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test_%_data');
INSERT INTO data VALUES (2, 'test_x_data');
INSERT INTO data VALUES (3, 'test_abc_data');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '100%');
INSERT INTO data VALUES (2, '100x');
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, department_id INT64, salary FLOAT64);
INSERT INTO employees VALUES (1, 'Alice', 1, 70000.0);
INSERT INTO employees VALUES (2, 'Bob', 1, 60000.0);
INSERT INTO employees VALUES (3, 'Charlie', 2, 80000.0);
INSERT INTO employees VALUES (4, 'David', 2, 65000.0);
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
INSERT INTO departments VALUES (1, 'Sales');
INSERT INTO departments VALUES (2, 'Engineering');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
INSERT INTO filter VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS empty_filter;
CREATE TABLE empty_filter (value INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, product_id INT64, customer_id INT64);
INSERT INTO orders VALUES (1, 100, 1);
INSERT INTO orders VALUES (2, 200, 2);
INSERT INTO orders VALUES (3, 100, 2);
DROP TABLE IF EXISTS valid_combos;
CREATE TABLE valid_combos (product_id INT64, customer_id INT64);
INSERT INTO valid_combos VALUES (100, 1);
INSERT INTO valid_combos VALUES (200, 2);
DROP TABLE IF EXISTS all_products;
CREATE TABLE all_products (id INT64, name STRING);
INSERT INTO all_products VALUES (1, 'Widget');
INSERT INTO all_products VALUES (2, 'Gadget');
INSERT INTO all_products VALUES (3, 'Gizmo');
DROP TABLE IF EXISTS sold_products;
CREATE TABLE sold_products (product_id INT64);
INSERT INTO sold_products VALUES (2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, code STRING);
INSERT INTO products VALUES (1, 'PROD-001');
INSERT INTO products VALUES (2, 'ITEM-042');
DROP TABLE IF EXISTS patterns;
CREATE TABLE patterns (id INT64, pattern STRING);
INSERT INTO patterns VALUES (1, '^PROD-');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product STRING, amount FLOAT64);
INSERT INTO sales VALUES (1, 'A', 100.0);
INSERT INTO sales VALUES (2, 'A', 200.0);
INSERT INTO sales VALUES (3, 'B', 150.0);
INSERT INTO sales VALUES (4, 'C', 100.0);
INSERT INTO sales VALUES (5, 'C', 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC123');
INSERT INTO data VALUES (2, 'XYZ');
INSERT INTO data VALUES (3, 'DEF456');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Test123');
INSERT INTO data VALUES (2, 'Hello');
INSERT INTO data VALUES (3, 'World456');
INSERT INTO data VALUES (4, 'Example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello 世界');
INSERT INTO data VALUES (2, 'Привет мир');
INSERT INTO data VALUES (3, 'مرحبا');
INSERT INTO data VALUES (4, 'Hello World');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'line1
line2');
INSERT INTO data VALUES (2, 'single line');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test!value');
INSERT INTO data VALUES (2, 'test_value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'completed');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_675
SELECT id FROM data WHERE value !~* 'abc' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_676
SELECT id FROM numbers WHERE value <> 10 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_677
SELECT COUNT(*) FROM data WHERE value <> 3;
-- Tag: window_functions_window_functions_string_test_select_678
SELECT COUNT(*) FROM data WHERE value != 3;
-- Tag: window_functions_window_functions_string_test_select_679
SELECT id FROM data WHERE value <> 10;
-- Tag: window_functions_window_functions_string_test_select_680
SELECT id FROM data WHERE name <> 'Alice' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_681
SELECT id FROM data WHERE value LIKE '50!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_682
SELECT id FROM files WHERE filename LIKE 'file#_1.txt' ESCAPE '#';
-- Tag: window_functions_window_functions_string_test_select_683
SELECT id FROM data WHERE value LIKE 'test!_%!_data' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_684
SELECT id FROM data WHERE value LIKE '100\%' ESCAPE '\';
-- Tag: window_functions_window_functions_string_test_select_685
SELECT name FROM employees e WHERE e.department_id IN (SELECT id FROM departments) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_686
SELECT id FROM data WHERE value IN (SELECT value FROM filter WHERE value IS NOT NULL) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_687
SELECT id FROM data WHERE value IN (SELECT value FROM empty_filter);
-- Tag: window_functions_window_functions_string_test_select_688
SELECT id FROM orders WHERE (product_id, customer_id) IN (SELECT product_id, customer_id FROM valid_combos) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_689
SELECT id FROM all_products WHERE id NOT IN (SELECT product_id FROM sold_products) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_690
SELECT p.id FROM products p, patterns pat WHERE p.code ~ pat.pattern;
-- Tag: window_functions_window_functions_string_test_select_691
SELECT product FROM sales GROUP BY product HAVING SUM(amount) <> 200.0 ORDER BY product;
-- Tag: window_functions_window_functions_string_test_select_692
SELECT id, CASE WHEN value ~ '[0-9]' THEN 'has_digits' ELSE 'no_digits' END as category FROM data ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_693
SELECT id FROM data WHERE value ~ '^[A-Z]' AND value ~ '[0-9]' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_694
SELECT * FROM data WHERE value ~ '[a-z';
-- Tag: window_functions_window_functions_string_test_select_695
SELECT * FROM data WHERE value LIKE 'test' ESCAPE 'ab';
-- Tag: window_functions_window_functions_string_test_select_696
SELECT COUNT(*) FROM data WHERE value ~ '^value[1-3]$';
-- Tag: window_functions_window_functions_string_test_select_697
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_string_test_select_698
SELECT id FROM data WHERE value ~ 'Hello' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_699
SELECT id FROM data WHERE value ~ '\
';
-- Tag: window_functions_window_functions_string_test_select_700
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_701
SELECT id FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_702
SELECT id FROM data WHERE value LIKE 'test!!value' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_703
SELECT id FROM data WHERE status ~ '^(active|pending)$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_704
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_string_test_select_705
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_706
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_707
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_708
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_709
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_710
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_711
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_712
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_713
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_714
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_715
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_716
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_717
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_718
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '50%');
INSERT INTO data VALUES (2, '50percent');
INSERT INTO data VALUES (3, 'discount_50');
DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64, filename STRING);
INSERT INTO files VALUES (1, 'file_1.txt');
INSERT INTO files VALUES (2, 'file1.txt');
INSERT INTO files VALUES (3, 'filea1.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test_%_data');
INSERT INTO data VALUES (2, 'test_x_data');
INSERT INTO data VALUES (3, 'test_abc_data');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '100%');
INSERT INTO data VALUES (2, '100x');
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, department_id INT64, salary FLOAT64);
INSERT INTO employees VALUES (1, 'Alice', 1, 70000.0);
INSERT INTO employees VALUES (2, 'Bob', 1, 60000.0);
INSERT INTO employees VALUES (3, 'Charlie', 2, 80000.0);
INSERT INTO employees VALUES (4, 'David', 2, 65000.0);
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
INSERT INTO departments VALUES (1, 'Sales');
INSERT INTO departments VALUES (2, 'Engineering');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
INSERT INTO filter VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS empty_filter;
CREATE TABLE empty_filter (value INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, product_id INT64, customer_id INT64);
INSERT INTO orders VALUES (1, 100, 1);
INSERT INTO orders VALUES (2, 200, 2);
INSERT INTO orders VALUES (3, 100, 2);
DROP TABLE IF EXISTS valid_combos;
CREATE TABLE valid_combos (product_id INT64, customer_id INT64);
INSERT INTO valid_combos VALUES (100, 1);
INSERT INTO valid_combos VALUES (200, 2);
DROP TABLE IF EXISTS all_products;
CREATE TABLE all_products (id INT64, name STRING);
INSERT INTO all_products VALUES (1, 'Widget');
INSERT INTO all_products VALUES (2, 'Gadget');
INSERT INTO all_products VALUES (3, 'Gizmo');
DROP TABLE IF EXISTS sold_products;
CREATE TABLE sold_products (product_id INT64);
INSERT INTO sold_products VALUES (2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, code STRING);
INSERT INTO products VALUES (1, 'PROD-001');
INSERT INTO products VALUES (2, 'ITEM-042');
DROP TABLE IF EXISTS patterns;
CREATE TABLE patterns (id INT64, pattern STRING);
INSERT INTO patterns VALUES (1, '^PROD-');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product STRING, amount FLOAT64);
INSERT INTO sales VALUES (1, 'A', 100.0);
INSERT INTO sales VALUES (2, 'A', 200.0);
INSERT INTO sales VALUES (3, 'B', 150.0);
INSERT INTO sales VALUES (4, 'C', 100.0);
INSERT INTO sales VALUES (5, 'C', 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC123');
INSERT INTO data VALUES (2, 'XYZ');
INSERT INTO data VALUES (3, 'DEF456');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Test123');
INSERT INTO data VALUES (2, 'Hello');
INSERT INTO data VALUES (3, 'World456');
INSERT INTO data VALUES (4, 'Example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello 世界');
INSERT INTO data VALUES (2, 'Привет мир');
INSERT INTO data VALUES (3, 'مرحبا');
INSERT INTO data VALUES (4, 'Hello World');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'line1
line2');
INSERT INTO data VALUES (2, 'single line');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test!value');
INSERT INTO data VALUES (2, 'test_value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'completed');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_719
SELECT id FROM data WHERE value LIKE '50!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_720
SELECT id FROM files WHERE filename LIKE 'file#_1.txt' ESCAPE '#';
-- Tag: window_functions_window_functions_string_test_select_721
SELECT id FROM data WHERE value LIKE 'test!_%!_data' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_722
SELECT id FROM data WHERE value LIKE '100\%' ESCAPE '\';
-- Tag: window_functions_window_functions_string_test_select_723
SELECT name FROM employees e WHERE e.department_id IN (SELECT id FROM departments) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_724
SELECT id FROM data WHERE value IN (SELECT value FROM filter WHERE value IS NOT NULL) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_725
SELECT id FROM data WHERE value IN (SELECT value FROM empty_filter);
-- Tag: window_functions_window_functions_string_test_select_726
SELECT id FROM orders WHERE (product_id, customer_id) IN (SELECT product_id, customer_id FROM valid_combos) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_727
SELECT id FROM all_products WHERE id NOT IN (SELECT product_id FROM sold_products) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_728
SELECT p.id FROM products p, patterns pat WHERE p.code ~ pat.pattern;
-- Tag: window_functions_window_functions_string_test_select_729
SELECT product FROM sales GROUP BY product HAVING SUM(amount) <> 200.0 ORDER BY product;
-- Tag: window_functions_window_functions_string_test_select_730
SELECT id, CASE WHEN value ~ '[0-9]' THEN 'has_digits' ELSE 'no_digits' END as category FROM data ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_731
SELECT id FROM data WHERE value ~ '^[A-Z]' AND value ~ '[0-9]' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_732
SELECT * FROM data WHERE value ~ '[a-z';
-- Tag: window_functions_window_functions_string_test_select_733
SELECT * FROM data WHERE value LIKE 'test' ESCAPE 'ab';
-- Tag: window_functions_window_functions_string_test_select_734
SELECT COUNT(*) FROM data WHERE value ~ '^value[1-3]$';
-- Tag: window_functions_window_functions_string_test_select_735
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_string_test_select_736
SELECT id FROM data WHERE value ~ 'Hello' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_737
SELECT id FROM data WHERE value ~ '\
';
-- Tag: window_functions_window_functions_string_test_select_738
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_739
SELECT id FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_740
SELECT id FROM data WHERE value LIKE 'test!!value' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_741
SELECT id FROM data WHERE status ~ '^(active|pending)$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_742
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_string_test_select_743
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_744
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_745
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_746
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_747
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_748
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_749
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_750
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_751
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_752
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_753
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_754
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_755
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_756
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS files;
CREATE TABLE files (id INT64, filename STRING);
INSERT INTO files VALUES (1, 'file_1.txt');
INSERT INTO files VALUES (2, 'file1.txt');
INSERT INTO files VALUES (3, 'filea1.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test_%_data');
INSERT INTO data VALUES (2, 'test_x_data');
INSERT INTO data VALUES (3, 'test_abc_data');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '100%');
INSERT INTO data VALUES (2, '100x');
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, department_id INT64, salary FLOAT64);
INSERT INTO employees VALUES (1, 'Alice', 1, 70000.0);
INSERT INTO employees VALUES (2, 'Bob', 1, 60000.0);
INSERT INTO employees VALUES (3, 'Charlie', 2, 80000.0);
INSERT INTO employees VALUES (4, 'David', 2, 65000.0);
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
INSERT INTO departments VALUES (1, 'Sales');
INSERT INTO departments VALUES (2, 'Engineering');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
INSERT INTO filter VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS empty_filter;
CREATE TABLE empty_filter (value INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, product_id INT64, customer_id INT64);
INSERT INTO orders VALUES (1, 100, 1);
INSERT INTO orders VALUES (2, 200, 2);
INSERT INTO orders VALUES (3, 100, 2);
DROP TABLE IF EXISTS valid_combos;
CREATE TABLE valid_combos (product_id INT64, customer_id INT64);
INSERT INTO valid_combos VALUES (100, 1);
INSERT INTO valid_combos VALUES (200, 2);
DROP TABLE IF EXISTS all_products;
CREATE TABLE all_products (id INT64, name STRING);
INSERT INTO all_products VALUES (1, 'Widget');
INSERT INTO all_products VALUES (2, 'Gadget');
INSERT INTO all_products VALUES (3, 'Gizmo');
DROP TABLE IF EXISTS sold_products;
CREATE TABLE sold_products (product_id INT64);
INSERT INTO sold_products VALUES (2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, code STRING);
INSERT INTO products VALUES (1, 'PROD-001');
INSERT INTO products VALUES (2, 'ITEM-042');
DROP TABLE IF EXISTS patterns;
CREATE TABLE patterns (id INT64, pattern STRING);
INSERT INTO patterns VALUES (1, '^PROD-');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product STRING, amount FLOAT64);
INSERT INTO sales VALUES (1, 'A', 100.0);
INSERT INTO sales VALUES (2, 'A', 200.0);
INSERT INTO sales VALUES (3, 'B', 150.0);
INSERT INTO sales VALUES (4, 'C', 100.0);
INSERT INTO sales VALUES (5, 'C', 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC123');
INSERT INTO data VALUES (2, 'XYZ');
INSERT INTO data VALUES (3, 'DEF456');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Test123');
INSERT INTO data VALUES (2, 'Hello');
INSERT INTO data VALUES (3, 'World456');
INSERT INTO data VALUES (4, 'Example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello 世界');
INSERT INTO data VALUES (2, 'Привет мир');
INSERT INTO data VALUES (3, 'مرحبا');
INSERT INTO data VALUES (4, 'Hello World');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'line1
line2');
INSERT INTO data VALUES (2, 'single line');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test!value');
INSERT INTO data VALUES (2, 'test_value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'completed');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_757
SELECT id FROM files WHERE filename LIKE 'file#_1.txt' ESCAPE '#';
-- Tag: window_functions_window_functions_string_test_select_758
SELECT id FROM data WHERE value LIKE 'test!_%!_data' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_759
SELECT id FROM data WHERE value LIKE '100\%' ESCAPE '\';
-- Tag: window_functions_window_functions_string_test_select_760
SELECT name FROM employees e WHERE e.department_id IN (SELECT id FROM departments) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_761
SELECT id FROM data WHERE value IN (SELECT value FROM filter WHERE value IS NOT NULL) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_762
SELECT id FROM data WHERE value IN (SELECT value FROM empty_filter);
-- Tag: window_functions_window_functions_string_test_select_763
SELECT id FROM orders WHERE (product_id, customer_id) IN (SELECT product_id, customer_id FROM valid_combos) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_764
SELECT id FROM all_products WHERE id NOT IN (SELECT product_id FROM sold_products) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_765
SELECT p.id FROM products p, patterns pat WHERE p.code ~ pat.pattern;
-- Tag: window_functions_window_functions_string_test_select_766
SELECT product FROM sales GROUP BY product HAVING SUM(amount) <> 200.0 ORDER BY product;
-- Tag: window_functions_window_functions_string_test_select_767
SELECT id, CASE WHEN value ~ '[0-9]' THEN 'has_digits' ELSE 'no_digits' END as category FROM data ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_768
SELECT id FROM data WHERE value ~ '^[A-Z]' AND value ~ '[0-9]' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_769
SELECT * FROM data WHERE value ~ '[a-z';
-- Tag: window_functions_window_functions_string_test_select_770
SELECT * FROM data WHERE value LIKE 'test' ESCAPE 'ab';
-- Tag: window_functions_window_functions_string_test_select_771
SELECT COUNT(*) FROM data WHERE value ~ '^value[1-3]$';
-- Tag: window_functions_window_functions_string_test_select_772
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_string_test_select_773
SELECT id FROM data WHERE value ~ 'Hello' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_774
SELECT id FROM data WHERE value ~ '\
';
-- Tag: window_functions_window_functions_string_test_select_775
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_776
SELECT id FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_777
SELECT id FROM data WHERE value LIKE 'test!!value' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_778
SELECT id FROM data WHERE status ~ '^(active|pending)$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_779
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_string_test_select_780
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_781
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_782
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_783
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_784
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_785
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_786
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_787
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_788
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_789
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_790
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_791
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_792
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_793
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test_%_data');
INSERT INTO data VALUES (2, 'test_x_data');
INSERT INTO data VALUES (3, 'test_abc_data');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '100%');
INSERT INTO data VALUES (2, '100x');
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, department_id INT64, salary FLOAT64);
INSERT INTO employees VALUES (1, 'Alice', 1, 70000.0);
INSERT INTO employees VALUES (2, 'Bob', 1, 60000.0);
INSERT INTO employees VALUES (3, 'Charlie', 2, 80000.0);
INSERT INTO employees VALUES (4, 'David', 2, 65000.0);
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
INSERT INTO departments VALUES (1, 'Sales');
INSERT INTO departments VALUES (2, 'Engineering');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
INSERT INTO filter VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS empty_filter;
CREATE TABLE empty_filter (value INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, product_id INT64, customer_id INT64);
INSERT INTO orders VALUES (1, 100, 1);
INSERT INTO orders VALUES (2, 200, 2);
INSERT INTO orders VALUES (3, 100, 2);
DROP TABLE IF EXISTS valid_combos;
CREATE TABLE valid_combos (product_id INT64, customer_id INT64);
INSERT INTO valid_combos VALUES (100, 1);
INSERT INTO valid_combos VALUES (200, 2);
DROP TABLE IF EXISTS all_products;
CREATE TABLE all_products (id INT64, name STRING);
INSERT INTO all_products VALUES (1, 'Widget');
INSERT INTO all_products VALUES (2, 'Gadget');
INSERT INTO all_products VALUES (3, 'Gizmo');
DROP TABLE IF EXISTS sold_products;
CREATE TABLE sold_products (product_id INT64);
INSERT INTO sold_products VALUES (2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, code STRING);
INSERT INTO products VALUES (1, 'PROD-001');
INSERT INTO products VALUES (2, 'ITEM-042');
DROP TABLE IF EXISTS patterns;
CREATE TABLE patterns (id INT64, pattern STRING);
INSERT INTO patterns VALUES (1, '^PROD-');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product STRING, amount FLOAT64);
INSERT INTO sales VALUES (1, 'A', 100.0);
INSERT INTO sales VALUES (2, 'A', 200.0);
INSERT INTO sales VALUES (3, 'B', 150.0);
INSERT INTO sales VALUES (4, 'C', 100.0);
INSERT INTO sales VALUES (5, 'C', 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC123');
INSERT INTO data VALUES (2, 'XYZ');
INSERT INTO data VALUES (3, 'DEF456');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Test123');
INSERT INTO data VALUES (2, 'Hello');
INSERT INTO data VALUES (3, 'World456');
INSERT INTO data VALUES (4, 'Example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello 世界');
INSERT INTO data VALUES (2, 'Привет мир');
INSERT INTO data VALUES (3, 'مرحبا');
INSERT INTO data VALUES (4, 'Hello World');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'line1
line2');
INSERT INTO data VALUES (2, 'single line');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test!value');
INSERT INTO data VALUES (2, 'test_value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'completed');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_794
SELECT id FROM data WHERE value LIKE 'test!_%!_data' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_795
SELECT id FROM data WHERE value LIKE '100\%' ESCAPE '\';
-- Tag: window_functions_window_functions_string_test_select_796
SELECT name FROM employees e WHERE e.department_id IN (SELECT id FROM departments) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_797
SELECT id FROM data WHERE value IN (SELECT value FROM filter WHERE value IS NOT NULL) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_798
SELECT id FROM data WHERE value IN (SELECT value FROM empty_filter);
-- Tag: window_functions_window_functions_string_test_select_799
SELECT id FROM orders WHERE (product_id, customer_id) IN (SELECT product_id, customer_id FROM valid_combos) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_800
SELECT id FROM all_products WHERE id NOT IN (SELECT product_id FROM sold_products) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_801
SELECT p.id FROM products p, patterns pat WHERE p.code ~ pat.pattern;
-- Tag: window_functions_window_functions_string_test_select_802
SELECT product FROM sales GROUP BY product HAVING SUM(amount) <> 200.0 ORDER BY product;
-- Tag: window_functions_window_functions_string_test_select_803
SELECT id, CASE WHEN value ~ '[0-9]' THEN 'has_digits' ELSE 'no_digits' END as category FROM data ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_804
SELECT id FROM data WHERE value ~ '^[A-Z]' AND value ~ '[0-9]' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_805
SELECT * FROM data WHERE value ~ '[a-z';
-- Tag: window_functions_window_functions_string_test_select_806
SELECT * FROM data WHERE value LIKE 'test' ESCAPE 'ab';
-- Tag: window_functions_window_functions_string_test_select_807
SELECT COUNT(*) FROM data WHERE value ~ '^value[1-3]$';
-- Tag: window_functions_window_functions_string_test_select_808
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_string_test_select_809
SELECT id FROM data WHERE value ~ 'Hello' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_810
SELECT id FROM data WHERE value ~ '\
';
-- Tag: window_functions_window_functions_string_test_select_811
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_812
SELECT id FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_813
SELECT id FROM data WHERE value LIKE 'test!!value' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_814
SELECT id FROM data WHERE status ~ '^(active|pending)$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_815
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_string_test_select_816
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_817
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_818
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_819
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_820
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_821
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_822
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_823
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_824
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_825
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_826
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_827
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_828
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_829
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '100%');
INSERT INTO data VALUES (2, '100x');
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, department_id INT64, salary FLOAT64);
INSERT INTO employees VALUES (1, 'Alice', 1, 70000.0);
INSERT INTO employees VALUES (2, 'Bob', 1, 60000.0);
INSERT INTO employees VALUES (3, 'Charlie', 2, 80000.0);
INSERT INTO employees VALUES (4, 'David', 2, 65000.0);
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (id INT64, name STRING);
INSERT INTO departments VALUES (1, 'Sales');
INSERT INTO departments VALUES (2, 'Engineering');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
INSERT INTO filter VALUES (30);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
DROP TABLE IF EXISTS empty_filter;
CREATE TABLE empty_filter (value INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, product_id INT64, customer_id INT64);
INSERT INTO orders VALUES (1, 100, 1);
INSERT INTO orders VALUES (2, 200, 2);
INSERT INTO orders VALUES (3, 100, 2);
DROP TABLE IF EXISTS valid_combos;
CREATE TABLE valid_combos (product_id INT64, customer_id INT64);
INSERT INTO valid_combos VALUES (100, 1);
INSERT INTO valid_combos VALUES (200, 2);
DROP TABLE IF EXISTS all_products;
CREATE TABLE all_products (id INT64, name STRING);
INSERT INTO all_products VALUES (1, 'Widget');
INSERT INTO all_products VALUES (2, 'Gadget');
INSERT INTO all_products VALUES (3, 'Gizmo');
DROP TABLE IF EXISTS sold_products;
CREATE TABLE sold_products (product_id INT64);
INSERT INTO sold_products VALUES (2);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, code STRING);
INSERT INTO products VALUES (1, 'PROD-001');
INSERT INTO products VALUES (2, 'ITEM-042');
DROP TABLE IF EXISTS patterns;
CREATE TABLE patterns (id INT64, pattern STRING);
INSERT INTO patterns VALUES (1, '^PROD-');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product STRING, amount FLOAT64);
INSERT INTO sales VALUES (1, 'A', 100.0);
INSERT INTO sales VALUES (2, 'A', 200.0);
INSERT INTO sales VALUES (3, 'B', 150.0);
INSERT INTO sales VALUES (4, 'C', 100.0);
INSERT INTO sales VALUES (5, 'C', 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC123');
INSERT INTO data VALUES (2, 'XYZ');
INSERT INTO data VALUES (3, 'DEF456');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Test123');
INSERT INTO data VALUES (2, 'Hello');
INSERT INTO data VALUES (3, 'World456');
INSERT INTO data VALUES (4, 'Example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello 世界');
INSERT INTO data VALUES (2, 'Привет мир');
INSERT INTO data VALUES (3, 'مرحبا');
INSERT INTO data VALUES (4, 'Hello World');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'line1
line2');
INSERT INTO data VALUES (2, 'single line');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test!value');
INSERT INTO data VALUES (2, 'test_value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'completed');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_830
SELECT id FROM data WHERE value LIKE '100\%' ESCAPE '\';
-- Tag: window_functions_window_functions_string_test_select_831
SELECT name FROM employees e WHERE e.department_id IN (SELECT id FROM departments) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_832
SELECT id FROM data WHERE value IN (SELECT value FROM filter WHERE value IS NOT NULL) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_833
SELECT id FROM data WHERE value IN (SELECT value FROM empty_filter);
-- Tag: window_functions_window_functions_string_test_select_834
SELECT id FROM orders WHERE (product_id, customer_id) IN (SELECT product_id, customer_id FROM valid_combos) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_835
SELECT id FROM all_products WHERE id NOT IN (SELECT product_id FROM sold_products) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_836
SELECT p.id FROM products p, patterns pat WHERE p.code ~ pat.pattern;
-- Tag: window_functions_window_functions_string_test_select_837
SELECT product FROM sales GROUP BY product HAVING SUM(amount) <> 200.0 ORDER BY product;
-- Tag: window_functions_window_functions_string_test_select_838
SELECT id, CASE WHEN value ~ '[0-9]' THEN 'has_digits' ELSE 'no_digits' END as category FROM data ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_839
SELECT id FROM data WHERE value ~ '^[A-Z]' AND value ~ '[0-9]' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_840
SELECT * FROM data WHERE value ~ '[a-z';
-- Tag: window_functions_window_functions_string_test_select_841
SELECT * FROM data WHERE value LIKE 'test' ESCAPE 'ab';
-- Tag: window_functions_window_functions_string_test_select_842
SELECT COUNT(*) FROM data WHERE value ~ '^value[1-3]$';
-- Tag: window_functions_window_functions_string_test_select_843
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_string_test_select_844
SELECT id FROM data WHERE value ~ 'Hello' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_845
SELECT id FROM data WHERE value ~ '\
';
-- Tag: window_functions_window_functions_string_test_select_846
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_847
SELECT id FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_848
SELECT id FROM data WHERE value LIKE 'test!!value' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_849
SELECT id FROM data WHERE status ~ '^(active|pending)$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_850
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_string_test_select_851
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_852
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_853
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_854
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_855
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_856
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_857
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_858
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_859
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_860
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_861
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_862
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_863
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_864
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, code STRING);
INSERT INTO products VALUES (1, 'PROD-001');
INSERT INTO products VALUES (2, 'ITEM-042');
DROP TABLE IF EXISTS patterns;
CREATE TABLE patterns (id INT64, pattern STRING);
INSERT INTO patterns VALUES (1, '^PROD-');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, product STRING, amount FLOAT64);
INSERT INTO sales VALUES (1, 'A', 100.0);
INSERT INTO sales VALUES (2, 'A', 200.0);
INSERT INTO sales VALUES (3, 'B', 150.0);
INSERT INTO sales VALUES (4, 'C', 100.0);
INSERT INTO sales VALUES (5, 'C', 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC123');
INSERT INTO data VALUES (2, 'XYZ');
INSERT INTO data VALUES (3, 'DEF456');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Test123');
INSERT INTO data VALUES (2, 'Hello');
INSERT INTO data VALUES (3, 'World456');
INSERT INTO data VALUES (4, 'Example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello 世界');
INSERT INTO data VALUES (2, 'Привет мир');
INSERT INTO data VALUES (3, 'مرحبا');
INSERT INTO data VALUES (4, 'Hello World');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'line1
line2');
INSERT INTO data VALUES (2, 'single line');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test!value');
INSERT INTO data VALUES (2, 'test_value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'completed');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_865
SELECT p.id FROM products p, patterns pat WHERE p.code ~ pat.pattern;
-- Tag: window_functions_window_functions_string_test_select_866
SELECT product FROM sales GROUP BY product HAVING SUM(amount) <> 200.0 ORDER BY product;
-- Tag: window_functions_window_functions_string_test_select_867
SELECT id, CASE WHEN value ~ '[0-9]' THEN 'has_digits' ELSE 'no_digits' END as category FROM data ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_868
SELECT id FROM data WHERE value ~ '^[A-Z]' AND value ~ '[0-9]' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_869
SELECT * FROM data WHERE value ~ '[a-z';
-- Tag: window_functions_window_functions_string_test_select_870
SELECT * FROM data WHERE value LIKE 'test' ESCAPE 'ab';
-- Tag: window_functions_window_functions_string_test_select_871
SELECT COUNT(*) FROM data WHERE value ~ '^value[1-3]$';
-- Tag: window_functions_window_functions_string_test_select_872
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_string_test_select_873
SELECT id FROM data WHERE value ~ 'Hello' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_874
SELECT id FROM data WHERE value ~ '\
';
-- Tag: window_functions_window_functions_string_test_select_875
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_876
SELECT id FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_877
SELECT id FROM data WHERE value LIKE 'test!!value' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_878
SELECT id FROM data WHERE status ~ '^(active|pending)$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_879
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_string_test_select_880
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_881
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_882
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_883
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_884
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_885
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_886
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_887
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_888
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_889
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_890
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_891
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_892
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_893
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'ABC123');
INSERT INTO data VALUES (2, 'XYZ');
INSERT INTO data VALUES (3, 'DEF456');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Test123');
INSERT INTO data VALUES (2, 'Hello');
INSERT INTO data VALUES (3, 'World456');
INSERT INTO data VALUES (4, 'Example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello 世界');
INSERT INTO data VALUES (2, 'Привет мир');
INSERT INTO data VALUES (3, 'مرحبا');
INSERT INTO data VALUES (4, 'Hello World');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'line1
line2');
INSERT INTO data VALUES (2, 'single line');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test!value');
INSERT INTO data VALUES (2, 'test_value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'completed');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_894
SELECT id, CASE WHEN value ~ '[0-9]' THEN 'has_digits' ELSE 'no_digits' END as category FROM data ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_895
SELECT id FROM data WHERE value ~ '^[A-Z]' AND value ~ '[0-9]' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_896
SELECT * FROM data WHERE value ~ '[a-z';
-- Tag: window_functions_window_functions_string_test_select_897
SELECT * FROM data WHERE value LIKE 'test' ESCAPE 'ab';
-- Tag: window_functions_window_functions_string_test_select_898
SELECT COUNT(*) FROM data WHERE value ~ '^value[1-3]$';
-- Tag: window_functions_window_functions_string_test_select_899
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_string_test_select_900
SELECT id FROM data WHERE value ~ 'Hello' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_901
SELECT id FROM data WHERE value ~ '\
';
-- Tag: window_functions_window_functions_string_test_select_902
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_903
SELECT id FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_904
SELECT id FROM data WHERE value LIKE 'test!!value' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_905
SELECT id FROM data WHERE status ~ '^(active|pending)$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_906
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_string_test_select_907
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_908
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_909
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_910
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_911
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_912
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_913
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_914
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_915
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_916
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_917
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_918
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_919
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_920
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Test123');
INSERT INTO data VALUES (2, 'Hello');
INSERT INTO data VALUES (3, 'World456');
INSERT INTO data VALUES (4, 'Example');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello 世界');
INSERT INTO data VALUES (2, 'Привет мир');
INSERT INTO data VALUES (3, 'مرحبا');
INSERT INTO data VALUES (4, 'Hello World');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'line1
line2');
INSERT INTO data VALUES (2, 'single line');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test!value');
INSERT INTO data VALUES (2, 'test_value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'completed');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_921
SELECT id FROM data WHERE value ~ '^[A-Z]' AND value ~ '[0-9]' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_922
SELECT * FROM data WHERE value ~ '[a-z';
-- Tag: window_functions_window_functions_string_test_select_923
SELECT * FROM data WHERE value LIKE 'test' ESCAPE 'ab';
-- Tag: window_functions_window_functions_string_test_select_924
SELECT COUNT(*) FROM data WHERE value ~ '^value[1-3]$';
-- Tag: window_functions_window_functions_string_test_select_925
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_string_test_select_926
SELECT id FROM data WHERE value ~ 'Hello' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_927
SELECT id FROM data WHERE value ~ '\
';
-- Tag: window_functions_window_functions_string_test_select_928
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_929
SELECT id FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_930
SELECT id FROM data WHERE value LIKE 'test!!value' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_931
SELECT id FROM data WHERE status ~ '^(active|pending)$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_932
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_string_test_select_933
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_934
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_935
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_936
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_937
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_938
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_939
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_940
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_941
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_942
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_943
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_944
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_945
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_946
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('test');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello 世界');
INSERT INTO data VALUES (2, 'Привет мир');
INSERT INTO data VALUES (3, 'مرحبا');
INSERT INTO data VALUES (4, 'Hello World');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'line1
line2');
INSERT INTO data VALUES (2, 'single line');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test!value');
INSERT INTO data VALUES (2, 'test_value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'completed');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_947
SELECT * FROM data WHERE value ~ '[a-z';
-- Tag: window_functions_window_functions_string_test_select_948
SELECT * FROM data WHERE value LIKE 'test' ESCAPE 'ab';
-- Tag: window_functions_window_functions_string_test_select_949
SELECT COUNT(*) FROM data WHERE value ~ '^value[1-3]$';
-- Tag: window_functions_window_functions_string_test_select_950
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_string_test_select_951
SELECT id FROM data WHERE value ~ 'Hello' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_952
SELECT id FROM data WHERE value ~ '\
';
-- Tag: window_functions_window_functions_string_test_select_953
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_954
SELECT id FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_955
SELECT id FROM data WHERE value LIKE 'test!!value' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_956
SELECT id FROM data WHERE status ~ '^(active|pending)$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_957
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_string_test_select_958
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_959
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_960
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_961
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_962
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_963
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_964
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_965
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_966
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_967
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_968
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_969
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_970
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_971
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello 世界');
INSERT INTO data VALUES (2, 'Привет мир');
INSERT INTO data VALUES (3, 'مرحبا');
INSERT INTO data VALUES (4, 'Hello World');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'line1
line2');
INSERT INTO data VALUES (2, 'single line');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test!value');
INSERT INTO data VALUES (2, 'test_value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'completed');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_972
SELECT * FROM data WHERE value LIKE 'test' ESCAPE 'ab';
-- Tag: window_functions_window_functions_string_test_select_973
SELECT COUNT(*) FROM data WHERE value ~ '^value[1-3]$';
-- Tag: window_functions_window_functions_string_test_select_974
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_string_test_select_975
SELECT id FROM data WHERE value ~ 'Hello' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_976
SELECT id FROM data WHERE value ~ '\
';
-- Tag: window_functions_window_functions_string_test_select_977
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_978
SELECT id FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_979
SELECT id FROM data WHERE value LIKE 'test!!value' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_980
SELECT id FROM data WHERE status ~ '^(active|pending)$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_981
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_string_test_select_982
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_983
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_984
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_985
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_986
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_987
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_988
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_989
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_990
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_991
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_992
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_993
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_994
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_995
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello 世界');
INSERT INTO data VALUES (2, 'Привет мир');
INSERT INTO data VALUES (3, 'مرحبا');
INSERT INTO data VALUES (4, 'Hello World');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'line1
line2');
INSERT INTO data VALUES (2, 'single line');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test!value');
INSERT INTO data VALUES (2, 'test_value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'completed');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_996
SELECT COUNT(*) FROM data WHERE value ~ '^value[1-3]$';
-- Tag: window_functions_window_functions_string_test_select_997
SELECT COUNT(*) FROM data WHERE id IN (SELECT id FROM filter);
-- Tag: window_functions_window_functions_string_test_select_998
SELECT id FROM data WHERE value ~ 'Hello' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_999
SELECT id FROM data WHERE value ~ '\
';
-- Tag: window_functions_window_functions_string_test_select_1000
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_1001
SELECT id FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_1002
SELECT id FROM data WHERE value LIKE 'test!!value' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_1003
SELECT id FROM data WHERE status ~ '^(active|pending)$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1004
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_string_test_select_1005
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1006
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_1007
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1008
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1009
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_1010
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1011
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_1012
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_1013
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_1014
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1015
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1016
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_1017
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_1018
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'Hello 世界');
INSERT INTO data VALUES (2, 'Привет мир');
INSERT INTO data VALUES (3, 'مرحبا');
INSERT INTO data VALUES (4, 'Hello World');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'line1
line2');
INSERT INTO data VALUES (2, 'single line');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test!value');
INSERT INTO data VALUES (2, 'test_value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'completed');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_1019
SELECT id FROM data WHERE value ~ 'Hello' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1020
SELECT id FROM data WHERE value ~ '\
';
-- Tag: window_functions_window_functions_string_test_select_1021
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_1022
SELECT id FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_1023
SELECT id FROM data WHERE value LIKE 'test!!value' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_1024
SELECT id FROM data WHERE status ~ '^(active|pending)$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1025
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_string_test_select_1026
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1027
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_1028
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1029
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1030
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_1031
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1032
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_1033
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_1034
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_1035
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1036
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1037
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_1038
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_1039
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'line1
line2');
INSERT INTO data VALUES (2, 'single line');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value INT64);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
INSERT INTO filter VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test!value');
INSERT INTO data VALUES (2, 'test_value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'completed');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_1040
SELECT id FROM data WHERE value ~ '\
';
-- Tag: window_functions_window_functions_string_test_select_1041
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_1042
SELECT id FROM data WHERE value IN (SELECT value FROM filter);
-- Tag: window_functions_window_functions_string_test_select_1043
SELECT id FROM data WHERE value LIKE 'test!!value' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_1044
SELECT id FROM data WHERE status ~ '^(active|pending)$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1045
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_string_test_select_1046
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1047
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_1048
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1049
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1050
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_1051
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1052
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_1053
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_1054
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_1055
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1056
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1057
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_1058
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_1059
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test!value');
INSERT INTO data VALUES (2, 'test_value');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, status STRING);
INSERT INTO data VALUES (1, 'active');
INSERT INTO data VALUES (2, 'pending');
INSERT INTO data VALUES (3, 'inactive');
INSERT INTO data VALUES (4, 'completed');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_1060
SELECT id FROM data WHERE value LIKE 'test!!value' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_1061
SELECT id FROM data WHERE status ~ '^(active|pending)$' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1062
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_string_test_select_1063
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1064
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_1065
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1066
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1067
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_1068
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1069
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_1070
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_1071
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_1072
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1073
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1074
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_1075
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_1076
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (2, 'short');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1.5);
INSERT INTO data VALUES (2, 2.5);
INSERT INTO data VALUES (3, 1.5);
INSERT INTO data VALUES (4, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_1077
SELECT id FROM data WHERE value ~ '^a+$';
-- Tag: window_functions_window_functions_string_test_select_1078
SELECT id FROM data WHERE value <> 1.5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1079
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_1080
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1081
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1082
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_1083
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1084
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_1085
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_1086
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_1087
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1088
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1089
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_1090
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_1091
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test123');
INSERT INTO data VALUES (2, 'test');
INSERT INTO data VALUES (3, '123');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS multipliers;
CREATE TABLE multipliers (mult INT64);
INSERT INTO multipliers VALUES (5);
INSERT INTO multipliers VALUES (10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_1092
SELECT id FROM data WHERE value ~ 'test(?=[0-9])';
-- Tag: window_functions_window_functions_string_test_select_1093
SELECT id FROM data WHERE value IN (SELECT mult * 2 FROM multipliers) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1094
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1095
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_1096
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1097
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_1098
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_1099
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_1100
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1101
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1102
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_1103
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_1104
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'the cat');
INSERT INTO data VALUES (2, 'category');
INSERT INTO data VALUES (3, 'cat');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_1105
SELECT id FROM data WHERE value ~ '\bcat\b' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1106
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_1107
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1108
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_1109
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_1110
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_1111
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1112
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1113
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_1114
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_1115
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'test%');
INSERT INTO data VALUES (2, 'test_');
INSERT INTO data VALUES (3, 'testx');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO data VALUES (2, 20);
INSERT INTO data VALUES (3, 30);
DROP TABLE IF EXISTS filter;
CREATE TABLE filter (value FLOAT64);
INSERT INTO filter VALUES (10.0);
INSERT INTO filter VALUES (20.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_1116
SELECT id FROM data WHERE value LIKE 'test!%' ESCAPE '!';
-- Tag: window_functions_window_functions_string_test_select_1117
SELECT id FROM data WHERE value NOT IN (SELECT value FROM filter) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1118
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_1119
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_1120
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_1121
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1122
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1123
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_1124
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_1125
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'HELLO');
INSERT INTO data VALUES (2, 'hello');
INSERT INTO data VALUES (3, 'HeLLo');
INSERT INTO data VALUES (4, 'Straße');
INSERT INTO data VALUES (5, 'STRASSE');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING, flag BOOL);
INSERT INTO data VALUES (1, 'test123', false);
INSERT INTO data VALUES (2, 'hello', false);
INSERT INTO data VALUES (3, 'world456', false);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'keep_this');
INSERT INTO data VALUES (2, 'DELETE_ME');
INSERT INTO data VALUES (3, 'also_keep');
INSERT INTO data VALUES (4, 'DELETE_THIS');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING, active BOOL);
INSERT INTO products VALUES (1, 'Widget', false);
INSERT INTO products VALUES (2, 'Gadget', false);
INSERT INTO products VALUES (3, 'Gizmo', false);
DROP TABLE IF EXISTS active_list;
CREATE TABLE active_list (product_id INT64);
INSERT INTO active_list VALUES (1);
INSERT INTO active_list VALUES (3);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, 'file_01.txt');
INSERT INTO data VALUES (2, 'file_02.txt');
INSERT INTO data VALUES (3, 'fileX01.txt');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 123);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, manager_id INT64);
INSERT INTO employees VALUES (1, 'Alice', NULL);
INSERT INTO employees VALUES (2, 'Bob', 1);
INSERT INTO employees VALUES (3, 'Charlie', 1);
INSERT INTO employees VALUES (4, 'David', 2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '<tag>content</tag>');
INSERT INTO data VALUES (2, '<a><b></b></a>');
INSERT INTO data VALUES (3, 'no tags here');

-- Tag: window_functions_window_functions_string_test_select_1126
SELECT id FROM data WHERE value ~* '^hello$' ORDER BY id;
UPDATE data SET flag = true WHERE value ~ '[0-9]';
-- Tag: window_functions_window_functions_string_test_select_1127
SELECT id FROM data WHERE flag = true ORDER BY id;
DELETE FROM data WHERE value ~ '^DELETE_';
-- Tag: window_functions_window_functions_string_test_select_1128
SELECT id FROM data ORDER BY id;
UPDATE products SET active = true WHERE id IN (SELECT product_id FROM active_list);
-- Tag: window_functions_window_functions_string_test_select_1129
SELECT id FROM products WHERE active = true ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1130
SELECT id FROM data WHERE value LIKE 'file!___.txt' ESCAPE '!' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1131
SELECT * FROM data WHERE value ~ '123';
-- Tag: window_functions_window_functions_string_test_select_1132
SELECT name FROM employees WHERE id IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL) ORDER BY name;
-- Tag: window_functions_window_functions_string_test_select_1133
SELECT id FROM data WHERE value ~ '<.*>' ORDER BY id;

DROP TABLE IF EXISTS words;
CREATE TABLE words (id INT64, word STRING);
INSERT INTO words VALUES (1, 'apple'), (2, 'application'), (3, 'banana'), (4, 'apply');
DROP TABLE IF EXISTS words;
CREATE TABLE words (id INT64, word STRING);
INSERT INTO words VALUES (1, 'Apple'), (2, 'BANANA'), (3, 'cherry'), (4, 'APPLication');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 0), (2, 10);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 0), (2, 10);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64, c INT64);
INSERT INTO test VALUES (1, 10, 20, 30), (2, 5, 15, 25);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
INSERT INTO test VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, active BOOL);
INSERT INTO test VALUES (1, true), (2, false);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a BOOL, b BOOL, c BOOL);
INSERT INTO test VALUES (1, true, false, true), (2, false, true, false), (3, true, true, true);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product_id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0), (1, 200.0), (2, 50.0), (2, 60.0);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, order_id INT64);
INSERT INTO orders VALUES (1, 101), (1, 102), (2, 201), (3, 301), (3, 302), (3, 303);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, status STRING);
INSERT INTO test VALUES (1, 'active');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, country STRING, active BOOL);
INSERT INTO users VALUES (1, 25, 'US', true), (2, 17, 'UK', true), (3, 30, 'US', false), (4, 40, 'UK', true);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (emp_id INT64, dept_id INT64);
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (dept_id INT64, active BOOL);
INSERT INTO employees VALUES (1, 10), (2, 20), (3, 30);
INSERT INTO departments VALUES (10, true), (20, false), (30, true);
DROP TABLE IF EXISTS logic;
CREATE TABLE logic (id INT64, a BOOL, b BOOL, expected STRING);
INSERT INTO logic VALUES
(1, TRUE, TRUE, 'TRUE'),
(2, TRUE, FALSE, 'FALSE'),
(3, TRUE, NULL, 'NULL'),
(4, FALSE, TRUE, 'FALSE'),
(5, FALSE, FALSE, 'FALSE'),
(6, FALSE, NULL, 'FALSE'),
(7, NULL, TRUE, 'NULL'),
(8, NULL, FALSE, 'FALSE'),
(9, NULL, NULL, 'NULL');
DROP TABLE IF EXISTS logic;
CREATE TABLE logic (id INT64, a BOOL, b BOOL);
INSERT INTO logic VALUES
(1, TRUE, TRUE),
(2, TRUE, FALSE),
(3, TRUE, NULL),
(4, FALSE, TRUE),
(5, FALSE, FALSE),
(6, FALSE, NULL),
(7, NULL, TRUE),
(8, NULL, FALSE),
(9, NULL, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val INT64);
INSERT INTO test VALUES (1, 10), (2, NULL), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a BOOL, b BOOL);
INSERT INTO test VALUES
(1, TRUE, TRUE),   -- (TRUE OR NULL) AND TRUE = TRUE AND TRUE = TRUE
(2, TRUE, FALSE),  -- (TRUE OR NULL) AND FALSE = TRUE AND FALSE = FALSE
(3, FALSE, TRUE),  -- (FALSE OR NULL) AND TRUE = NULL AND TRUE = NULL
(4, FALSE, FALSE)  -- (FALSE OR NULL) AND FALSE = NULL AND FALSE = FALSE;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, text STRING);
INSERT INTO test VALUES
(1, 'test123'),
(2, 'hello'),
(3, 'test456'),
(4, 'world789');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val INT64, default_val INT64);
INSERT INTO test VALUES
(1, 10, 5),
(2, NULL, 5),
(3, 20, 5);
DROP TABLE IF EXISTS large_test;
CREATE TABLE large_test (id INT64, active BOOL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val BOOL);
INSERT INTO test VALUES (1, TRUE), (2, FALSE);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, flag BOOL);
INSERT INTO test VALUES (1, TRUE), (2, FALSE), (3, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, active BOOL, dept STRING);
INSERT INTO test VALUES
(1, TRUE, 'Sales'),
(2, FALSE, 'Sales'),
(3, NULL, 'Sales'),
(4, TRUE, 'HR');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 20), (2, 30, 20), (3, 20, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 20), (2, 30, 20), (3, 20, 20);
DROP TABLE IF EXISTS state;
CREATE TABLE state (id INT64, active BOOL);
INSERT INTO state VALUES (1, TRUE), (2, FALSE);
INSERT INTO state VALUES (3, FALSE), (4, TRUE);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, active BOOL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val BOOL);
INSERT INTO test VALUES (1, NULL), (2, NULL), (3, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val BOOL);
INSERT INTO test VALUES (1, TRUE), (2, TRUE), (3, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64, is_refund BOOL);
INSERT INTO sales VALUES
(1, 100.0, FALSE),
(2, 50.0, TRUE),
(3, 200.0, FALSE),
(4, 30.0, TRUE);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, active BOOL);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, active BOOL);
INSERT INTO t1 VALUES (1, TRUE), (2, FALSE);
INSERT INTO t2 VALUES (3, TRUE), (4, FALSE);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, is_cancelled BOOL, amount FLOAT64);
INSERT INTO orders VALUES
(1, FALSE, 100.0),
(2, TRUE, 50.0),
(3, FALSE, 200.0),
(4, TRUE, 30.0);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, active BOOL, last_login TIMESTAMP);
INSERT INTO users VALUES
(1, TRUE, CURRENT_TIMESTAMP),
(2, FALSE, CURRENT_TIMESTAMP);
DROP TABLE IF EXISTS temp_data;
CREATE TABLE temp_data (id INT64, keep BOOL);
INSERT INTO temp_data VALUES
(1, TRUE),
(2, FALSE),
(3, TRUE),
(4, FALSE);

-- Tag: window_functions_window_functions_string_test_select_1134
SELECT id FROM words WHERE word NOT LIKE 'app%' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1135
SELECT id FROM words WHERE word NOT ILIKE 'app%' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1136
SELECT id FROM test WHERE value > 5 AND (100 / value) > 5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1137
SELECT id FROM test WHERE value = 0 OR (100 / value) > 5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1138
SELECT id FROM test WHERE NOT (CASE WHEN value > 15 THEN true ELSE false END) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1139
SELECT id, CASE WHEN NOT (value > 15) THEN 'low' ELSE 'high' END as category FROM test ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1140
SELECT id FROM test WHERE NOT ((a > 5 AND b > 15) OR c > 35) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1141
SELECT id FROM test WHERE NOT (name < 'Charlie') ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1142
SELECT id FROM test WHERE NOT NOT NOT active ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1143
SELECT id FROM test WHERE NOT a AND NOT b AND NOT c ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1144
SELECT product_id FROM sales GROUP BY product_id HAVING NOT (SUM(amount) > 200) ORDER BY product_id;
-- Tag: window_functions_window_functions_string_test_select_1145
SELECT customer_id FROM orders GROUP BY customer_id HAVING NOT (COUNT(*) > 2) ORDER BY customer_id;
-- Tag: window_functions_window_functions_string_test_select_1146
SELECT id FROM test WHERE NOT value;
-- Tag: window_functions_window_functions_string_test_select_1147
SELECT id FROM test WHERE NOT status;
-- Tag: window_functions_window_functions_string_test_select_1148
SELECT id FROM users WHERE NOT (age < 18 OR country = 'US' OR NOT active) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1149
SELECT e.emp_id FROM employees e JOIN departments d ON e.dept_id = d.dept_id WHERE NOT d.active ORDER BY e.emp_id;
-- Tag: window_functions_window_functions_string_test_select_1150
SELECT id FROM logic WHERE a AND b;
-- Tag: window_functions_window_functions_string_test_select_1151
SELECT id FROM logic WHERE a OR b ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1152
SELECT id FROM test WHERE (val + 5) > 20 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1153
SELECT id FROM test WHERE (a OR NULL) AND b ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1154
SELECT id FROM test WHERE NOT REGEXP_CONTAINS(text, r'test') ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1155
SELECT id FROM test WHERE NOT (COALESCE(val, default_val) > 15) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1156
SELECT COUNT(*) as cnt FROM large_test WHERE NOT active;
-- Tag: window_functions_window_functions_string_test_select_1157
SELECT id FROM test WHERE NOT NOT NOT NOT NOT val ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1158
SELECT id, NOT flag as inverted FROM test ORDER BY inverted NULLS LAST;
-- Tag: window_functions_window_functions_string_test_select_1159
SELECT dept, COUNT(*) as cnt FROM test WHERE NOT active GROUP BY dept;
-- Tag: window_functions_window_functions_string_test_select_1160
SELECT id FROM test WHERE NOT (a > b) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1161
SELECT id FROM test WHERE a <= b ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1162
SELECT id FROM test WHERE NOT (a < b) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1163
SELECT id FROM test WHERE a >= b ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1164
SELECT COUNT(*) as cnt FROM state WHERE NOT active;
-- Tag: window_functions_window_functions_string_test_select_1165
SELECT COUNT(*) as cnt FROM state WHERE NOT active;
-- Tag: window_functions_window_functions_string_test_select_1166
SELECT id FROM test WHERE NOT active;
-- Tag: window_functions_window_functions_string_test_select_1167
SELECT id FROM test WHERE NOT val;
-- Tag: window_functions_window_functions_string_test_select_1168
SELECT id FROM test WHERE NOT val;
-- Tag: window_functions_window_functions_string_test_select_1169
SELECT id, ROW_NUMBER() OVER (ORDER BY amount DESC) as rn
FROM sales
WHERE NOT is_refund
ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1170
SELECT id FROM t1 WHERE NOT active
UNION
-- Tag: window_functions_window_functions_string_test_select_1171
SELECT id FROM t2 WHERE NOT active
ORDER BY id;
WITH active_orders AS (
-- Tag: window_functions_window_functions_string_test_select_1172
SELECT order_id, amount FROM orders WHERE NOT is_cancelled
)
-- Tag: window_functions_window_functions_string_test_select_1173
SELECT SUM(amount) as total FROM active_orders;
UPDATE users SET active = TRUE WHERE NOT active;
-- Tag: window_functions_window_functions_string_test_select_1174
SELECT COUNT(*) as cnt FROM users WHERE active;
DELETE FROM temp_data WHERE NOT keep;
-- Tag: window_functions_window_functions_string_test_select_1175
SELECT COUNT(*) as cnt FROM temp_data;

DROP TABLE IF EXISTS words;
CREATE TABLE words (id INT64, word STRING);
INSERT INTO words VALUES (1, 'Apple'), (2, 'BANANA'), (3, 'cherry'), (4, 'APPLication');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 0), (2, 10);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 0), (2, 10);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10), (2, 20), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64, c INT64);
INSERT INTO test VALUES (1, 10, 20, 30), (2, 5, 15, 25);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, name STRING);
INSERT INTO test VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, active BOOL);
INSERT INTO test VALUES (1, true), (2, false);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a BOOL, b BOOL, c BOOL);
INSERT INTO test VALUES (1, true, false, true), (2, false, true, false), (3, true, true, true);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product_id INT64, amount FLOAT64);
INSERT INTO sales VALUES (1, 100.0), (1, 200.0), (2, 50.0), (2, 60.0);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (customer_id INT64, order_id INT64);
INSERT INTO orders VALUES (1, 101), (1, 102), (2, 201), (3, 301), (3, 302), (3, 303);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
INSERT INTO test VALUES (1, 10);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, status STRING);
INSERT INTO test VALUES (1, 'active');
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, country STRING, active BOOL);
INSERT INTO users VALUES (1, 25, 'US', true), (2, 17, 'UK', true), (3, 30, 'US', false), (4, 40, 'UK', true);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (emp_id INT64, dept_id INT64);
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (dept_id INT64, active BOOL);
INSERT INTO employees VALUES (1, 10), (2, 20), (3, 30);
INSERT INTO departments VALUES (10, true), (20, false), (30, true);
DROP TABLE IF EXISTS logic;
CREATE TABLE logic (id INT64, a BOOL, b BOOL, expected STRING);
INSERT INTO logic VALUES
(1, TRUE, TRUE, 'TRUE'),
(2, TRUE, FALSE, 'FALSE'),
(3, TRUE, NULL, 'NULL'),
(4, FALSE, TRUE, 'FALSE'),
(5, FALSE, FALSE, 'FALSE'),
(6, FALSE, NULL, 'FALSE'),
(7, NULL, TRUE, 'NULL'),
(8, NULL, FALSE, 'FALSE'),
(9, NULL, NULL, 'NULL');
DROP TABLE IF EXISTS logic;
CREATE TABLE logic (id INT64, a BOOL, b BOOL);
INSERT INTO logic VALUES
(1, TRUE, TRUE),
(2, TRUE, FALSE),
(3, TRUE, NULL),
(4, FALSE, TRUE),
(5, FALSE, FALSE),
(6, FALSE, NULL),
(7, NULL, TRUE),
(8, NULL, FALSE),
(9, NULL, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val INT64);
INSERT INTO test VALUES (1, 10), (2, NULL), (3, 30);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a BOOL, b BOOL);
INSERT INTO test VALUES
(1, TRUE, TRUE),   -- (TRUE OR NULL) AND TRUE = TRUE AND TRUE = TRUE
(2, TRUE, FALSE),  -- (TRUE OR NULL) AND FALSE = TRUE AND FALSE = FALSE
(3, FALSE, TRUE),  -- (FALSE OR NULL) AND TRUE = NULL AND TRUE = NULL
(4, FALSE, FALSE)  -- (FALSE OR NULL) AND FALSE = NULL AND FALSE = FALSE;
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, text STRING);
INSERT INTO test VALUES
(1, 'test123'),
(2, 'hello'),
(3, 'test456'),
(4, 'world789');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val INT64, default_val INT64);
INSERT INTO test VALUES
(1, 10, 5),
(2, NULL, 5),
(3, 20, 5);
DROP TABLE IF EXISTS large_test;
CREATE TABLE large_test (id INT64, active BOOL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val BOOL);
INSERT INTO test VALUES (1, TRUE), (2, FALSE);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, flag BOOL);
INSERT INTO test VALUES (1, TRUE), (2, FALSE), (3, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, active BOOL, dept STRING);
INSERT INTO test VALUES
(1, TRUE, 'Sales'),
(2, FALSE, 'Sales'),
(3, NULL, 'Sales'),
(4, TRUE, 'HR');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 20), (2, 30, 20), (3, 20, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 20), (2, 30, 20), (3, 20, 20);
DROP TABLE IF EXISTS state;
CREATE TABLE state (id INT64, active BOOL);
INSERT INTO state VALUES (1, TRUE), (2, FALSE);
INSERT INTO state VALUES (3, FALSE), (4, TRUE);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, active BOOL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val BOOL);
INSERT INTO test VALUES (1, NULL), (2, NULL), (3, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val BOOL);
INSERT INTO test VALUES (1, TRUE), (2, TRUE), (3, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64, is_refund BOOL);
INSERT INTO sales VALUES
(1, 100.0, FALSE),
(2, 50.0, TRUE),
(3, 200.0, FALSE),
(4, 30.0, TRUE);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, active BOOL);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, active BOOL);
INSERT INTO t1 VALUES (1, TRUE), (2, FALSE);
INSERT INTO t2 VALUES (3, TRUE), (4, FALSE);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, is_cancelled BOOL, amount FLOAT64);
INSERT INTO orders VALUES
(1, FALSE, 100.0),
(2, TRUE, 50.0),
(3, FALSE, 200.0),
(4, TRUE, 30.0);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, active BOOL, last_login TIMESTAMP);
INSERT INTO users VALUES
(1, TRUE, CURRENT_TIMESTAMP),
(2, FALSE, CURRENT_TIMESTAMP);
DROP TABLE IF EXISTS temp_data;
CREATE TABLE temp_data (id INT64, keep BOOL);
INSERT INTO temp_data VALUES
(1, TRUE),
(2, FALSE),
(3, TRUE),
(4, FALSE);

-- Tag: window_functions_window_functions_string_test_select_1176
SELECT id FROM words WHERE word NOT ILIKE 'app%' ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1177
SELECT id FROM test WHERE value > 5 AND (100 / value) > 5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1178
SELECT id FROM test WHERE value = 0 OR (100 / value) > 5 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1179
SELECT id FROM test WHERE NOT (CASE WHEN value > 15 THEN true ELSE false END) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1180
SELECT id, CASE WHEN NOT (value > 15) THEN 'low' ELSE 'high' END as category FROM test ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1181
SELECT id FROM test WHERE NOT ((a > 5 AND b > 15) OR c > 35) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1182
SELECT id FROM test WHERE NOT (name < 'Charlie') ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1183
SELECT id FROM test WHERE NOT NOT NOT active ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1184
SELECT id FROM test WHERE NOT a AND NOT b AND NOT c ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1185
SELECT product_id FROM sales GROUP BY product_id HAVING NOT (SUM(amount) > 200) ORDER BY product_id;
-- Tag: window_functions_window_functions_string_test_select_1186
SELECT customer_id FROM orders GROUP BY customer_id HAVING NOT (COUNT(*) > 2) ORDER BY customer_id;
-- Tag: window_functions_window_functions_string_test_select_1187
SELECT id FROM test WHERE NOT value;
-- Tag: window_functions_window_functions_string_test_select_1188
SELECT id FROM test WHERE NOT status;
-- Tag: window_functions_window_functions_string_test_select_1189
SELECT id FROM users WHERE NOT (age < 18 OR country = 'US' OR NOT active) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1190
SELECT e.emp_id FROM employees e JOIN departments d ON e.dept_id = d.dept_id WHERE NOT d.active ORDER BY e.emp_id;
-- Tag: window_functions_window_functions_string_test_select_1191
SELECT id FROM logic WHERE a AND b;
-- Tag: window_functions_window_functions_string_test_select_1192
SELECT id FROM logic WHERE a OR b ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1193
SELECT id FROM test WHERE (val + 5) > 20 ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1194
SELECT id FROM test WHERE (a OR NULL) AND b ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1195
SELECT id FROM test WHERE NOT REGEXP_CONTAINS(text, r'test') ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1196
SELECT id FROM test WHERE NOT (COALESCE(val, default_val) > 15) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1197
SELECT COUNT(*) as cnt FROM large_test WHERE NOT active;
-- Tag: window_functions_window_functions_string_test_select_1198
SELECT id FROM test WHERE NOT NOT NOT NOT NOT val ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1199
SELECT id, NOT flag as inverted FROM test ORDER BY inverted NULLS LAST;
-- Tag: window_functions_window_functions_string_test_select_1200
SELECT dept, COUNT(*) as cnt FROM test WHERE NOT active GROUP BY dept;
-- Tag: window_functions_window_functions_string_test_select_1201
SELECT id FROM test WHERE NOT (a > b) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1202
SELECT id FROM test WHERE a <= b ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1203
SELECT id FROM test WHERE NOT (a < b) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1204
SELECT id FROM test WHERE a >= b ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1205
SELECT COUNT(*) as cnt FROM state WHERE NOT active;
-- Tag: window_functions_window_functions_string_test_select_1206
SELECT COUNT(*) as cnt FROM state WHERE NOT active;
-- Tag: window_functions_window_functions_string_test_select_1207
SELECT id FROM test WHERE NOT active;
-- Tag: window_functions_window_functions_string_test_select_1208
SELECT id FROM test WHERE NOT val;
-- Tag: window_functions_window_functions_string_test_select_1209
SELECT id FROM test WHERE NOT val;
-- Tag: window_functions_window_functions_string_test_select_1210
SELECT id, ROW_NUMBER() OVER (ORDER BY amount DESC) as rn
FROM sales
WHERE NOT is_refund
ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1211
SELECT id FROM t1 WHERE NOT active
UNION
-- Tag: window_functions_window_functions_string_test_select_1212
SELECT id FROM t2 WHERE NOT active
ORDER BY id;
WITH active_orders AS (
-- Tag: window_functions_window_functions_string_test_select_1213
SELECT order_id, amount FROM orders WHERE NOT is_cancelled
)
-- Tag: window_functions_window_functions_string_test_select_1214
SELECT SUM(amount) as total FROM active_orders;
UPDATE users SET active = TRUE WHERE NOT active;
-- Tag: window_functions_window_functions_string_test_select_1215
SELECT COUNT(*) as cnt FROM users WHERE active;
DELETE FROM temp_data WHERE NOT keep;
-- Tag: window_functions_window_functions_string_test_select_1216
SELECT COUNT(*) as cnt FROM temp_data;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, text STRING);
INSERT INTO test VALUES
(1, 'test123'),
(2, 'hello'),
(3, 'test456'),
(4, 'world789');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val INT64, default_val INT64);
INSERT INTO test VALUES
(1, 10, 5),
(2, NULL, 5),
(3, 20, 5);
DROP TABLE IF EXISTS large_test;
CREATE TABLE large_test (id INT64, active BOOL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val BOOL);
INSERT INTO test VALUES (1, TRUE), (2, FALSE);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, flag BOOL);
INSERT INTO test VALUES (1, TRUE), (2, FALSE), (3, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, active BOOL, dept STRING);
INSERT INTO test VALUES
(1, TRUE, 'Sales'),
(2, FALSE, 'Sales'),
(3, NULL, 'Sales'),
(4, TRUE, 'HR');
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 20), (2, 30, 20), (3, 20, 20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, a INT64, b INT64);
INSERT INTO test VALUES (1, 10, 20), (2, 30, 20), (3, 20, 20);
DROP TABLE IF EXISTS state;
CREATE TABLE state (id INT64, active BOOL);
INSERT INTO state VALUES (1, TRUE), (2, FALSE);
INSERT INTO state VALUES (3, FALSE), (4, TRUE);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, active BOOL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val BOOL);
INSERT INTO test VALUES (1, NULL), (2, NULL), (3, NULL);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, val BOOL);
INSERT INTO test VALUES (1, TRUE), (2, TRUE), (3, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount FLOAT64, is_refund BOOL);
INSERT INTO sales VALUES
(1, 100.0, FALSE),
(2, 50.0, TRUE),
(3, 200.0, FALSE),
(4, 30.0, TRUE);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT64, active BOOL);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (id INT64, active BOOL);
INSERT INTO t1 VALUES (1, TRUE), (2, FALSE);
INSERT INTO t2 VALUES (3, TRUE), (4, FALSE);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, is_cancelled BOOL, amount FLOAT64);
INSERT INTO orders VALUES
(1, FALSE, 100.0),
(2, TRUE, 50.0),
(3, FALSE, 200.0),
(4, TRUE, 30.0);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, active BOOL, last_login TIMESTAMP);
INSERT INTO users VALUES
(1, TRUE, CURRENT_TIMESTAMP),
(2, FALSE, CURRENT_TIMESTAMP);
DROP TABLE IF EXISTS temp_data;
CREATE TABLE temp_data (id INT64, keep BOOL);
INSERT INTO temp_data VALUES
(1, TRUE),
(2, FALSE),
(3, TRUE),
(4, FALSE);

-- Tag: window_functions_window_functions_string_test_select_1217
SELECT id FROM test WHERE NOT REGEXP_CONTAINS(text, r'test') ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1218
SELECT id FROM test WHERE NOT (COALESCE(val, default_val) > 15) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1219
SELECT COUNT(*) as cnt FROM large_test WHERE NOT active;
-- Tag: window_functions_window_functions_string_test_select_1220
SELECT id FROM test WHERE NOT NOT NOT NOT NOT val ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1221
SELECT id, NOT flag as inverted FROM test ORDER BY inverted NULLS LAST;
-- Tag: window_functions_window_functions_string_test_select_1222
SELECT dept, COUNT(*) as cnt FROM test WHERE NOT active GROUP BY dept;
-- Tag: window_functions_window_functions_string_test_select_1223
SELECT id FROM test WHERE NOT (a > b) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1224
SELECT id FROM test WHERE a <= b ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1225
SELECT id FROM test WHERE NOT (a < b) ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1226
SELECT id FROM test WHERE a >= b ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1227
SELECT COUNT(*) as cnt FROM state WHERE NOT active;
-- Tag: window_functions_window_functions_string_test_select_1228
SELECT COUNT(*) as cnt FROM state WHERE NOT active;
-- Tag: window_functions_window_functions_string_test_select_1229
SELECT id FROM test WHERE NOT active;
-- Tag: window_functions_window_functions_string_test_select_1230
SELECT id FROM test WHERE NOT val;
-- Tag: window_functions_window_functions_string_test_select_1231
SELECT id FROM test WHERE NOT val;
-- Tag: window_functions_window_functions_string_test_select_1232
SELECT id, ROW_NUMBER() OVER (ORDER BY amount DESC) as rn
FROM sales
WHERE NOT is_refund
ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1233
SELECT id FROM t1 WHERE NOT active
UNION
-- Tag: window_functions_window_functions_string_test_select_1234
SELECT id FROM t2 WHERE NOT active
ORDER BY id;
WITH active_orders AS (
-- Tag: window_functions_window_functions_string_test_select_1235
SELECT order_id, amount FROM orders WHERE NOT is_cancelled
)
-- Tag: window_functions_window_functions_string_test_select_1236
SELECT SUM(amount) as total FROM active_orders;
UPDATE users SET active = TRUE WHERE NOT active;
-- Tag: window_functions_window_functions_string_test_select_1237
SELECT COUNT(*) as cnt FROM users WHERE active;
DELETE FROM temp_data WHERE NOT keep;
-- Tag: window_functions_window_functions_string_test_select_1238
SELECT COUNT(*) as cnt FROM temp_data;

DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, name STRING);
DROP TABLE IF EXISTS config;
CREATE TABLE config (prefix STRING);
INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO config VALUES ('User: ');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS messages;
CREATE TABLE messages (text STRING);
INSERT INTO data VALUES (1), (2);
INSERT INTO messages VALUES ('Hello World');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, price FLOAT64, in_stock BOOL);
DROP TABLE IF EXISTS thresholds;
CREATE TABLE thresholds (min_price FLOAT64);
INSERT INTO products VALUES
(1, 50.0, true),
(2, 150.0, true),
(3, 75.0, false);
INSERT INTO thresholds VALUES (100.0);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, value INT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (special_value INT64);
INSERT INTO items VALUES (1, 10), (2, 20), (3, 30);
INSERT INTO config VALUES (20);
DROP TABLE IF EXISTS values;
CREATE TABLE values (id INT64, num INT64);
DROP TABLE IF EXISTS range;
CREATE TABLE range (min INT64, max INT64);
INSERT INTO values VALUES (1, 5), (2, 15), (3, 25);
INSERT INTO range VALUES (10, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
INSERT INTO data VALUES (1), (2), (3);
DROP TABLE IF EXISTS categories;
CREATE TABLE categories (id INT64, name STRING);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, cat_id INT64, price FLOAT64);
INSERT INTO categories VALUES (1, 'Electronics'), (2, 'Clothing');
INSERT INTO items VALUES
(1, 1, 100.0),
(2, 1, 200.0),
(3, 2, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS set1;
CREATE TABLE set1 (value INT64);
DROP TABLE IF EXISTS set2;
CREATE TABLE set2 (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO set1 VALUES (42);
INSERT INTO set2 VALUES (99);
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (id INT64, name STRING);
DROP TABLE IF EXISTS stores;
CREATE TABLE stores (id INT64, region_id INT64, name STRING);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (store_id INT64, amount FLOAT64);
INSERT INTO regions VALUES (1, 'North'), (2, 'South');
INSERT INTO stores VALUES (1, 1, 'Store A'), (2, 1, 'Store B'), (3, 2, 'Store C');
INSERT INTO sales VALUES
(1, 100.0),
(1, 150.0),
(2, 200.0),
(3, 300.0);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, name STRING);
INSERT INTO events VALUES (1, 'Event A'), (2, 'Event B');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (divisor INT64);
INSERT INTO data VALUES (1), (2);
INSERT INTO config VALUES (0);
DROP TABLE IF EXISTS measurements;
CREATE TABLE measurements (id INT64, value FLOAT64);
DROP TABLE IF EXISTS calibration;
CREATE TABLE calibration (offset FLOAT64, scale FLOAT64);
INSERT INTO measurements VALUES (1, 10.0), (2, 20.0);
INSERT INTO calibration VALUES (5.0, 2.0);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
DROP TABLE IF EXISTS config;
CREATE TABLE config (divisor INT64);
INSERT INTO numbers VALUES (1, 17), (2, 23);
INSERT INTO config VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO nulls VALUES (NULL), (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value FLOAT64);
INSERT INTO data VALUES (1);
INSERT INTO nulls VALUES (NULL), (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value INT64);
INSERT INTO data VALUES (1);
INSERT INTO nulls VALUES (NULL), (NULL);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (product STRING, amount FLOAT64);
DROP TABLE IF EXISTS targets;
CREATE TABLE targets (target FLOAT64);
INSERT INTO sales VALUES
('A', 100.0),
('A', 150.0),
('B', 200.0);
INSERT INTO targets VALUES (120.0);

-- Tag: window_functions_window_functions_string_test_select_1239
SELECT id, CONCAT((SELECT prefix FROM config), name) as formatted_name
FROM users
ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1240
SELECT id,
(SELECT UPPER(text) FROM messages) as upper_msg,
(SELECT LOWER(text) FROM messages) as lower_msg
FROM data
ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1241
SELECT id, price
FROM products
WHERE in_stock = true AND price > (SELECT min_price FROM thresholds)
ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1242
SELECT id
FROM items
WHERE value < 15 OR value = (SELECT special_value FROM config)
ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1243
SELECT id
FROM values
WHERE num BETWEEN (SELECT min FROM range) AND (SELECT max FROM range)
ORDER BY id;
WITH stats AS (
-- Tag: window_functions_window_functions_string_test_select_1244
SELECT AVG(id) as avg_id FROM data
)
-- Tag: window_functions_window_functions_string_test_select_1245
SELECT id, (SELECT avg_id FROM stats) as average
FROM data
ORDER BY id;
WITH category_data AS (
-- Tag: window_functions_window_functions_string_test_select_1246
SELECT id, name FROM categories
)
-- Tag: window_functions_window_functions_string_test_select_1247
SELECT c.name,
(SELECT MAX(price) FROM items WHERE cat_id = c.id) as max_price
FROM category_data c
ORDER BY c.name;
-- Tag: window_functions_window_functions_string_test_select_1248
SELECT id,
(SELECT value FROM set1
UNION
-- Tag: window_functions_window_functions_string_test_select_1249
SELECT value FROM set2
ORDER BY value
LIMIT 1) as min_value
FROM data;
-- Tag: window_functions_window_functions_string_test_select_1250
SELECT r.name,
(SELECT SUM(amount)
FROM sales s
WHERE s.store_id IN (SELECT id FROM stores WHERE region_id = r.id)) as region_total
FROM regions r
ORDER BY r.name;
-- Tag: window_functions_window_functions_string_test_select_1251
SELECT id, name, (SELECT CURRENT_DATE()) as today
FROM events
ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1252
SELECT id, 100 / (SELECT divisor FROM config) as result
FROM data
ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1253
SELECT id,
value,
(value + (SELECT offset FROM calibration)) * (SELECT scale FROM calibration) as calibrated
FROM measurements
ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1254
SELECT id, value, value % (SELECT divisor FROM config) as remainder
FROM numbers
ORDER BY id;
-- Tag: window_functions_window_functions_string_test_select_1255
SELECT id, (SELECT SUM(value) FROM nulls) as sum_nulls FROM data;
-- Tag: window_functions_window_functions_string_test_select_1256
SELECT id, (SELECT AVG(value) FROM nulls) as avg_nulls FROM data;
-- Tag: window_functions_window_functions_string_test_select_1257
SELECT id,
(SELECT MIN(value) FROM nulls) as min_val,
(SELECT MAX(value) FROM nulls) as max_val
FROM data;
-- Tag: window_functions_window_functions_string_test_select_1258
SELECT product,
SUM(amount) as total,
SUM(amount) - (SELECT target FROM targets) as over_under
FROM sales
GROUP BY product
ORDER BY product;

DROP TABLE IF EXISTS text;
CREATE TABLE text (val STRING);
INSERT INTO text VALUES ('hello world');
INSERT INTO text VALUES ('goodbye');
DROP TABLE IF EXISTS text;
CREATE TABLE text (val STRING);
INSERT INTO text VALUES ('Hello World');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('ab');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('hello');
INSERT INTO test VALUES ('');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('42');
DROP TABLE IF EXISTS products;
CREATE TABLE products ( category STRING, name STRING, price NUMERIC(10, 2) );
INSERT INTO products VALUES ('Electronics', 'Phone', 699.99);
INSERT INTO products VALUES ('Electronics', 'Tablet', 499.99);
INSERT INTO products VALUES ('Books', 'Novel', 19.99);
DROP TABLE IF EXISTS stock_prices;
CREATE TABLE stock_prices ( symbol STRING, price NUMERIC(10, 2) );
INSERT INTO stock_prices VALUES ('AAPL', 150.00);
INSERT INTO stock_prices VALUES ('AAPL', 155.00);
INSERT INTO stock_prices VALUES ('AAPL', 145.00);
INSERT INTO stock_prices VALUES ('GOOG', 2800.00);
INSERT INTO stock_prices VALUES ('GOOG', 2850.00);
DROP TABLE IF EXISTS test;
CREATE TABLE test (val NUMERIC(5, 2));
INSERT INTO test VALUES (12345.67);
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('not a number');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (val INT64);
INSERT INTO test VALUES (1);

-- Tag: window_functions_window_functions_string_test_select_1259
SELECT val, POSITION('world' IN val) AS pos FROM text;
-- Tag: window_functions_window_functions_string_test_select_1260
SELECT LEFT(val, 5) AS left_part FROM text;
-- Tag: window_functions_window_functions_string_test_select_1261
SELECT REPEAT(val, 3) AS repeated FROM test;
-- Tag: window_functions_window_functions_string_test_select_1262
SELECT val, REVERSE(val) AS rev FROM test;
-- Tag: window_functions_window_functions_string_test_select_1263
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_string_test_select_1264
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_string_test_select_1265
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_string_test_select_1266
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_string_test_select_1267
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_string_test_select_1268
SELECT val FROM test WHERE SUM(val) > 5;

DROP TABLE IF EXISTS text;
CREATE TABLE text (val STRING);
INSERT INTO text VALUES ('Hello World');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('ab');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('hello');
INSERT INTO test VALUES ('');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('42');
DROP TABLE IF EXISTS products;
CREATE TABLE products ( category STRING, name STRING, price NUMERIC(10, 2) );
INSERT INTO products VALUES ('Electronics', 'Phone', 699.99);
INSERT INTO products VALUES ('Electronics', 'Tablet', 499.99);
INSERT INTO products VALUES ('Books', 'Novel', 19.99);
DROP TABLE IF EXISTS stock_prices;
CREATE TABLE stock_prices ( symbol STRING, price NUMERIC(10, 2) );
INSERT INTO stock_prices VALUES ('AAPL', 150.00);
INSERT INTO stock_prices VALUES ('AAPL', 155.00);
INSERT INTO stock_prices VALUES ('AAPL', 145.00);
INSERT INTO stock_prices VALUES ('GOOG', 2800.00);
INSERT INTO stock_prices VALUES ('GOOG', 2850.00);
DROP TABLE IF EXISTS test;
CREATE TABLE test (val NUMERIC(5, 2));
INSERT INTO test VALUES (12345.67);
DROP TABLE IF EXISTS test;
CREATE TABLE test (val STRING);
INSERT INTO test VALUES ('not a number');
DROP TABLE IF EXISTS test;
CREATE TABLE test (val INT64);
INSERT INTO test VALUES (1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (val INT64);
INSERT INTO test VALUES (1);

-- Tag: window_functions_window_functions_string_test_select_1269
SELECT LEFT(val, 5) AS left_part FROM text;
-- Tag: window_functions_window_functions_string_test_select_1270
SELECT REPEAT(val, 3) AS repeated FROM test;
-- Tag: window_functions_window_functions_string_test_select_1271
SELECT val, REVERSE(val) AS rev FROM test;
-- Tag: window_functions_window_functions_string_test_select_1272
SELECT LPAD(val, 5, '0') AS padded FROM test;
-- Tag: window_functions_window_functions_string_test_select_1273
SELECT category, name, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS rank
FROM products;
-- Tag: window_functions_window_functions_string_test_select_1274
SELECT symbol,
AVG(price) AS avg_price,
STDDEV(price) AS volatility
FROM stock_prices
GROUP BY symbol;
-- Tag: window_functions_window_functions_string_test_select_1275
SELECT CAST(val AS NUMERIC) FROM test;
-- Tag: window_functions_window_functions_string_test_select_1276
SELECT RANK() FROM test;
-- Tag: window_functions_window_functions_string_test_select_1277
SELECT val FROM test WHERE SUM(val) > 5;

DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
INSERT INTO data VALUES (3);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (1);
INSERT INTO data VALUES (NULL);
INSERT INTO data VALUES (2);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, amount INT64);
INSERT INTO sales VALUES ('East', 100);
INSERT INTO sales VALUES (NULL, 50);
INSERT INTO sales VALUES ('East', 200);
INSERT INTO sales VALUES (NULL, 75);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (NULL);
INSERT INTO t2 VALUES (2);
INSERT INTO t2 VALUES (NULL);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (NULL);
INSERT INTO t2 VALUES (1);
INSERT INTO t2 VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (val INT64);
INSERT INTO data VALUES (5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (val INT64);
DROP TABLE IF EXISTS empty;
CREATE TABLE empty (val INT64);
INSERT INTO data VALUES (5);

-- Tag: window_functions_window_functions_string_test_select_1278
SELECT CONCAT('Hello', NULL, 'World') as result;
-- Tag: window_functions_window_functions_string_test_select_1279
SELECT ((NULL + 5) * 2) - 3 as result;
-- Tag: window_functions_window_functions_string_test_select_1280
SELECT COALESCE(NULL, NULL, 42, 50) as result;
-- Tag: window_functions_window_functions_string_test_select_1281
SELECT COALESCE(NULL, NULL, NULL) as result;
-- Tag: window_functions_window_functions_string_test_select_1282
SELECT NULLIF(5, 5) as result;
-- Tag: window_functions_window_functions_string_test_select_1283
SELECT NULLIF(5, 10) as result;
-- Tag: window_functions_window_functions_string_test_select_1284
SELECT NULLIF(NULL, 5) as result;
-- Tag: window_functions_window_functions_string_test_select_1285
SELECT IFNULL(NULL, 42) as result;
-- Tag: window_functions_window_functions_string_test_select_1286
SELECT IFNULL(10, 42) as result;
-- Tag: window_functions_window_functions_string_test_select_1287
SELECT val FROM data ORDER BY val;
-- Tag: window_functions_window_functions_string_test_select_1288
SELECT region, amount,
SUM(amount) OVER (PARTITION BY region) as partition_sum
FROM sales
ORDER BY region, amount;
-- Tag: window_functions_window_functions_string_test_select_1289
SELECT val FROM t1 UNION SELECT val FROM t2;
-- Tag: window_functions_window_functions_string_test_select_1290
SELECT val FROM t1 INTERSECT SELECT val FROM t2;
-- Tag: window_functions_window_functions_string_test_select_1291
SELECT val FROM data WHERE val > ALL (SELECT val FROM empty);
-- Tag: window_functions_window_functions_string_test_select_1292
SELECT val FROM data WHERE val > ANY (SELECT val FROM empty);

