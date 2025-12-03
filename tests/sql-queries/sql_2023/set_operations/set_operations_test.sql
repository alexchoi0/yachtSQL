-- Set Operations - SQL:2023
-- Description: Set operations: UNION, INTERSECT, EXCEPT
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING, dept_id INT64);
DROP TABLE IF EXISTS projects;
CREATE TABLE projects (proj_id INT64, emp_id INT64, completed BOOL);
DROP TABLE IF EXISTS training;
CREATE TABLE training (training_id INT64, emp_id INT64);
INSERT INTO employees VALUES (1, 'Alice', 10), (2, 'Bob', 20);
INSERT INTO projects VALUES (101, 1, true), (102, 2, false);
INSERT INTO training VALUES (1, 1);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING, manager_id INT64);
DROP TABLE IF EXISTS managers;
CREATE TABLE managers (id INT64, name STRING);
INSERT INTO customers VALUES (1, 'Alice', NULL), (2, 'Bob', 10);
INSERT INTO managers VALUES (10, 'Manager');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS lookups;
CREATE TABLE lookups (lookup_id INT64, lookup_value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO lookups VALUES (1, NULL);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO orders VALUES (101, 1)), (103, 1), (104, 1), (105, 1);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO orders VALUES (101, 2)), (103, 2);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES (101, 1);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING);
DROP TABLE IF EXISTS current_projects;
CREATE TABLE current_projects (proj_id INT64, emp_id INT64);
DROP TABLE IF EXISTS past_projects;
CREATE TABLE past_projects (proj_id INT64, emp_id INT64);
INSERT INTO employees VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO current_projects VALUES (101, 1);
INSERT INTO past_projects VALUES (201, 2);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO orders VALUES (101, 1);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS lookups;
CREATE TABLE lookups (id INT64);
INSERT INTO data VALUES (1, 100);
INSERT INTO lookups VALUES (1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64, amount INT64);
INSERT INTO customers VALUES (1, 'Alice');
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (item_id INT64, order_id INT64, product_id INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO order_items VALUES (1, 101, 10), (2, 999, 20);
INSERT INTO orders VALUES (101, 1);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64, order_date DATE);
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES \ (101, 1, DATE '2024-01-01'), \ (102, 2, DATE '2023-06-01');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING);
DROP TABLE IF EXISTS discontinued;
CREATE TABLE discontinued (product_id INT64);
INSERT INTO products VALUES (1, 'Widget'), (2, 'Gadget'), (3, 'Doohickey');
INSERT INTO discontinued VALUES (2);

-- Tag: set_operations_set_operations_test_select_001
SELECT name FROM employees e \ WHERE EXISTS ( \ SELECT 1 FROM projects p \ WHERE p.emp_id = e.id AND p.completed = true \ ) AND NOT EXISTS ( \ SELECT 1 FROM training t WHERE t.emp_id = e.id \ );
-- Tag: set_operations_set_operations_test_select_002
SELECT name FROM customers c \ WHERE EXISTS (SELECT 1 FROM managers m WHERE m.id = c.manager_id);
-- Tag: set_operations_set_operations_test_select_003
SELECT id FROM data d \ WHERE EXISTS (SELECT lookup_value FROM lookups WHERE lookup_id = d.id);
-- Tag: set_operations_set_operations_test_select_004
SELECT name FROM customers c \ WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_005
SELECT name FROM customers c \ WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_006
SELECT name, \ CASE WHEN EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id) \ THEN 'Has Orders' \ ELSE 'No Orders' \ END as status \ FROM customers c \ ORDER BY name;
-- Tag: set_operations_set_operations_test_select_007
SELECT name FROM employees e \ WHERE EXISTS ( \ SELECT 1 FROM current_projects cp WHERE cp.emp_id = e.id \ UNION \ SELECT 1 FROM past_projects pp WHERE pp.emp_id = e.id \ ) \ ORDER BY name;
-- Tag: set_operations_set_operations_test_select_008
SELECT name FROM customers c \ WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_009
SELECT name FROM customers c \ WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_010
SELECT value FROM data d \ WHERE EXISTS (SELECT 1 FROM lookups l WHERE l.id = d.id);
-- Tag: set_operations_set_operations_test_select_011
SELECT value FROM data WHERE EXISTS (SELECT 1);
-- Tag: set_operations_set_operations_test_select_012
SELECT value FROM data WHERE NOT EXISTS (SELECT 1);
-- Tag: set_operations_set_operations_test_select_013
SELECT name FROM customers c \ WHERE EXISTS (SELECT order_id, amount FROM orders WHERE customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_014
SELECT item_id FROM order_items oi \ WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.order_id = oi.order_id);
-- Tag: set_operations_set_operations_test_select_015
SELECT name FROM customers c \ WHERE NOT EXISTS ( \ SELECT 1 FROM orders o \ WHERE o.customer_id = c.id AND o.order_date > DATE '2024-01-01' \ );
-- Tag: set_operations_set_operations_test_select_016
SELECT name FROM products p \ WHERE NOT EXISTS (SELECT 1 FROM discontinued d WHERE d.product_id = p.id) \ ORDER BY name;

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING, manager_id INT64);
DROP TABLE IF EXISTS managers;
CREATE TABLE managers (id INT64, name STRING);
INSERT INTO customers VALUES (1, 'Alice', NULL), (2, 'Bob', 10);
INSERT INTO managers VALUES (10, 'Manager');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS lookups;
CREATE TABLE lookups (lookup_id INT64, lookup_value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO lookups VALUES (1, NULL);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO orders VALUES (101, 1)), (103, 1), (104, 1), (105, 1);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO orders VALUES (101, 2)), (103, 2);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES (101, 1);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING);
DROP TABLE IF EXISTS current_projects;
CREATE TABLE current_projects (proj_id INT64, emp_id INT64);
DROP TABLE IF EXISTS past_projects;
CREATE TABLE past_projects (proj_id INT64, emp_id INT64);
INSERT INTO employees VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO current_projects VALUES (101, 1);
INSERT INTO past_projects VALUES (201, 2);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO orders VALUES (101, 1);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS lookups;
CREATE TABLE lookups (id INT64);
INSERT INTO data VALUES (1, 100);
INSERT INTO lookups VALUES (1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64, amount INT64);
INSERT INTO customers VALUES (1, 'Alice');
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (item_id INT64, order_id INT64, product_id INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO order_items VALUES (1, 101, 10), (2, 999, 20);
INSERT INTO orders VALUES (101, 1);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64, order_date DATE);
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES \ (101, 1, DATE '2024-01-01'), \ (102, 2, DATE '2023-06-01');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING);
DROP TABLE IF EXISTS discontinued;
CREATE TABLE discontinued (product_id INT64);
INSERT INTO products VALUES (1, 'Widget'), (2, 'Gadget'), (3, 'Doohickey');
INSERT INTO discontinued VALUES (2);

-- Tag: set_operations_set_operations_test_select_017
SELECT name FROM customers c \ WHERE EXISTS (SELECT 1 FROM managers m WHERE m.id = c.manager_id);
-- Tag: set_operations_set_operations_test_select_018
SELECT id FROM data d \ WHERE EXISTS (SELECT lookup_value FROM lookups WHERE lookup_id = d.id);
-- Tag: set_operations_set_operations_test_select_019
SELECT name FROM customers c \ WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_020
SELECT name FROM customers c \ WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_021
SELECT name, \ CASE WHEN EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id) \ THEN 'Has Orders' \ ELSE 'No Orders' \ END as status \ FROM customers c \ ORDER BY name;
-- Tag: set_operations_set_operations_test_select_022
SELECT name FROM employees e \ WHERE EXISTS ( \ SELECT 1 FROM current_projects cp WHERE cp.emp_id = e.id \ UNION \ SELECT 1 FROM past_projects pp WHERE pp.emp_id = e.id \ ) \ ORDER BY name;
-- Tag: set_operations_set_operations_test_select_023
SELECT name FROM customers c \ WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_024
SELECT name FROM customers c \ WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_025
SELECT value FROM data d \ WHERE EXISTS (SELECT 1 FROM lookups l WHERE l.id = d.id);
-- Tag: set_operations_set_operations_test_select_026
SELECT value FROM data WHERE EXISTS (SELECT 1);
-- Tag: set_operations_set_operations_test_select_027
SELECT value FROM data WHERE NOT EXISTS (SELECT 1);
-- Tag: set_operations_set_operations_test_select_028
SELECT name FROM customers c \ WHERE EXISTS (SELECT order_id, amount FROM orders WHERE customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_029
SELECT item_id FROM order_items oi \ WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.order_id = oi.order_id);
-- Tag: set_operations_set_operations_test_select_030
SELECT name FROM customers c \ WHERE NOT EXISTS ( \ SELECT 1 FROM orders o \ WHERE o.customer_id = c.id AND o.order_date > DATE '2024-01-01' \ );
-- Tag: set_operations_set_operations_test_select_031
SELECT name FROM products p \ WHERE NOT EXISTS (SELECT 1 FROM discontinued d WHERE d.product_id = p.id) \ ORDER BY name;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS lookups;
CREATE TABLE lookups (lookup_id INT64, lookup_value INT64);
INSERT INTO data VALUES (1, 10);
INSERT INTO lookups VALUES (1, NULL);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO orders VALUES (101, 1)), (103, 1), (104, 1), (105, 1);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO orders VALUES (101, 2)), (103, 2);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES (101, 1);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING);
DROP TABLE IF EXISTS current_projects;
CREATE TABLE current_projects (proj_id INT64, emp_id INT64);
DROP TABLE IF EXISTS past_projects;
CREATE TABLE past_projects (proj_id INT64, emp_id INT64);
INSERT INTO employees VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO current_projects VALUES (101, 1);
INSERT INTO past_projects VALUES (201, 2);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO orders VALUES (101, 1);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS lookups;
CREATE TABLE lookups (id INT64);
INSERT INTO data VALUES (1, 100);
INSERT INTO lookups VALUES (1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64, amount INT64);
INSERT INTO customers VALUES (1, 'Alice');
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (item_id INT64, order_id INT64, product_id INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO order_items VALUES (1, 101, 10), (2, 999, 20);
INSERT INTO orders VALUES (101, 1);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64, order_date DATE);
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES \ (101, 1, DATE '2024-01-01'), \ (102, 2, DATE '2023-06-01');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING);
DROP TABLE IF EXISTS discontinued;
CREATE TABLE discontinued (product_id INT64);
INSERT INTO products VALUES (1, 'Widget'), (2, 'Gadget'), (3, 'Doohickey');
INSERT INTO discontinued VALUES (2);

-- Tag: set_operations_set_operations_test_select_032
SELECT id FROM data d \ WHERE EXISTS (SELECT lookup_value FROM lookups WHERE lookup_id = d.id);
-- Tag: set_operations_set_operations_test_select_033
SELECT name FROM customers c \ WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_034
SELECT name FROM customers c \ WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_035
SELECT name, \ CASE WHEN EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id) \ THEN 'Has Orders' \ ELSE 'No Orders' \ END as status \ FROM customers c \ ORDER BY name;
-- Tag: set_operations_set_operations_test_select_036
SELECT name FROM employees e \ WHERE EXISTS ( \ SELECT 1 FROM current_projects cp WHERE cp.emp_id = e.id \ UNION \ SELECT 1 FROM past_projects pp WHERE pp.emp_id = e.id \ ) \ ORDER BY name;
-- Tag: set_operations_set_operations_test_select_037
SELECT name FROM customers c \ WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_038
SELECT name FROM customers c \ WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_039
SELECT value FROM data d \ WHERE EXISTS (SELECT 1 FROM lookups l WHERE l.id = d.id);
-- Tag: set_operations_set_operations_test_select_040
SELECT value FROM data WHERE EXISTS (SELECT 1);
-- Tag: set_operations_set_operations_test_select_041
SELECT value FROM data WHERE NOT EXISTS (SELECT 1);
-- Tag: set_operations_set_operations_test_select_042
SELECT name FROM customers c \ WHERE EXISTS (SELECT order_id, amount FROM orders WHERE customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_043
SELECT item_id FROM order_items oi \ WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.order_id = oi.order_id);
-- Tag: set_operations_set_operations_test_select_044
SELECT name FROM customers c \ WHERE NOT EXISTS ( \ SELECT 1 FROM orders o \ WHERE o.customer_id = c.id AND o.order_date > DATE '2024-01-01' \ );
-- Tag: set_operations_set_operations_test_select_045
SELECT name FROM products p \ WHERE NOT EXISTS (SELECT 1 FROM discontinued d WHERE d.product_id = p.id) \ ORDER BY name;

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO orders VALUES (101, 1)), (103, 1), (104, 1), (105, 1);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO orders VALUES (101, 2)), (103, 2);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES (101, 1);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING);
DROP TABLE IF EXISTS current_projects;
CREATE TABLE current_projects (proj_id INT64, emp_id INT64);
DROP TABLE IF EXISTS past_projects;
CREATE TABLE past_projects (proj_id INT64, emp_id INT64);
INSERT INTO employees VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO current_projects VALUES (101, 1);
INSERT INTO past_projects VALUES (201, 2);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO orders VALUES (101, 1);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS lookups;
CREATE TABLE lookups (id INT64);
INSERT INTO data VALUES (1, 100);
INSERT INTO lookups VALUES (1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64, amount INT64);
INSERT INTO customers VALUES (1, 'Alice');
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (item_id INT64, order_id INT64, product_id INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO order_items VALUES (1, 101, 10), (2, 999, 20);
INSERT INTO orders VALUES (101, 1);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64, order_date DATE);
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES \ (101, 1, DATE '2024-01-01'), \ (102, 2, DATE '2023-06-01');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING);
DROP TABLE IF EXISTS discontinued;
CREATE TABLE discontinued (product_id INT64);
INSERT INTO products VALUES (1, 'Widget'), (2, 'Gadget'), (3, 'Doohickey');
INSERT INTO discontinued VALUES (2);

-- Tag: set_operations_set_operations_test_select_046
SELECT name FROM customers c \ WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_047
SELECT name FROM customers c \ WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_048
SELECT name, \ CASE WHEN EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id) \ THEN 'Has Orders' \ ELSE 'No Orders' \ END as status \ FROM customers c \ ORDER BY name;
-- Tag: set_operations_set_operations_test_select_049
SELECT name FROM employees e \ WHERE EXISTS ( \ SELECT 1 FROM current_projects cp WHERE cp.emp_id = e.id \ UNION \ SELECT 1 FROM past_projects pp WHERE pp.emp_id = e.id \ ) \ ORDER BY name;
-- Tag: set_operations_set_operations_test_select_050
SELECT name FROM customers c \ WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_051
SELECT name FROM customers c \ WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_052
SELECT value FROM data d \ WHERE EXISTS (SELECT 1 FROM lookups l WHERE l.id = d.id);
-- Tag: set_operations_set_operations_test_select_053
SELECT value FROM data WHERE EXISTS (SELECT 1);
-- Tag: set_operations_set_operations_test_select_054
SELECT value FROM data WHERE NOT EXISTS (SELECT 1);
-- Tag: set_operations_set_operations_test_select_055
SELECT name FROM customers c \ WHERE EXISTS (SELECT order_id, amount FROM orders WHERE customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_056
SELECT item_id FROM order_items oi \ WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.order_id = oi.order_id);
-- Tag: set_operations_set_operations_test_select_057
SELECT name FROM customers c \ WHERE NOT EXISTS ( \ SELECT 1 FROM orders o \ WHERE o.customer_id = c.id AND o.order_date > DATE '2024-01-01' \ );
-- Tag: set_operations_set_operations_test_select_058
SELECT name FROM products p \ WHERE NOT EXISTS (SELECT 1 FROM discontinued d WHERE d.product_id = p.id) \ ORDER BY name;

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO orders VALUES (101, 2)), (103, 2);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES (101, 1);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING);
DROP TABLE IF EXISTS current_projects;
CREATE TABLE current_projects (proj_id INT64, emp_id INT64);
DROP TABLE IF EXISTS past_projects;
CREATE TABLE past_projects (proj_id INT64, emp_id INT64);
INSERT INTO employees VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO current_projects VALUES (101, 1);
INSERT INTO past_projects VALUES (201, 2);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO orders VALUES (101, 1);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS lookups;
CREATE TABLE lookups (id INT64);
INSERT INTO data VALUES (1, 100);
INSERT INTO lookups VALUES (1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64, amount INT64);
INSERT INTO customers VALUES (1, 'Alice');
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (item_id INT64, order_id INT64, product_id INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO order_items VALUES (1, 101, 10), (2, 999, 20);
INSERT INTO orders VALUES (101, 1);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64, order_date DATE);
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES \ (101, 1, DATE '2024-01-01'), \ (102, 2, DATE '2023-06-01');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING);
DROP TABLE IF EXISTS discontinued;
CREATE TABLE discontinued (product_id INT64);
INSERT INTO products VALUES (1, 'Widget'), (2, 'Gadget'), (3, 'Doohickey');
INSERT INTO discontinued VALUES (2);

-- Tag: set_operations_set_operations_test_select_059
SELECT name FROM customers c \ WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_060
SELECT name, \ CASE WHEN EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id) \ THEN 'Has Orders' \ ELSE 'No Orders' \ END as status \ FROM customers c \ ORDER BY name;
-- Tag: set_operations_set_operations_test_select_061
SELECT name FROM employees e \ WHERE EXISTS ( \ SELECT 1 FROM current_projects cp WHERE cp.emp_id = e.id \ UNION \ SELECT 1 FROM past_projects pp WHERE pp.emp_id = e.id \ ) \ ORDER BY name;
-- Tag: set_operations_set_operations_test_select_062
SELECT name FROM customers c \ WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_063
SELECT name FROM customers c \ WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_064
SELECT value FROM data d \ WHERE EXISTS (SELECT 1 FROM lookups l WHERE l.id = d.id);
-- Tag: set_operations_set_operations_test_select_065
SELECT value FROM data WHERE EXISTS (SELECT 1);
-- Tag: set_operations_set_operations_test_select_066
SELECT value FROM data WHERE NOT EXISTS (SELECT 1);
-- Tag: set_operations_set_operations_test_select_067
SELECT name FROM customers c \ WHERE EXISTS (SELECT order_id, amount FROM orders WHERE customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_068
SELECT item_id FROM order_items oi \ WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.order_id = oi.order_id);
-- Tag: set_operations_set_operations_test_select_069
SELECT name FROM customers c \ WHERE NOT EXISTS ( \ SELECT 1 FROM orders o \ WHERE o.customer_id = c.id AND o.order_date > DATE '2024-01-01' \ );
-- Tag: set_operations_set_operations_test_select_070
SELECT name FROM products p \ WHERE NOT EXISTS (SELECT 1 FROM discontinued d WHERE d.product_id = p.id) \ ORDER BY name;

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES (101, 1);
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING);
DROP TABLE IF EXISTS current_projects;
CREATE TABLE current_projects (proj_id INT64, emp_id INT64);
DROP TABLE IF EXISTS past_projects;
CREATE TABLE past_projects (proj_id INT64, emp_id INT64);
INSERT INTO employees VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO current_projects VALUES (101, 1);
INSERT INTO past_projects VALUES (201, 2);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO orders VALUES (101, 1);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS lookups;
CREATE TABLE lookups (id INT64);
INSERT INTO data VALUES (1, 100);
INSERT INTO lookups VALUES (1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64, amount INT64);
INSERT INTO customers VALUES (1, 'Alice');
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (item_id INT64, order_id INT64, product_id INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO order_items VALUES (1, 101, 10), (2, 999, 20);
INSERT INTO orders VALUES (101, 1);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64, order_date DATE);
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES \ (101, 1, DATE '2024-01-01'), \ (102, 2, DATE '2023-06-01');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING);
DROP TABLE IF EXISTS discontinued;
CREATE TABLE discontinued (product_id INT64);
INSERT INTO products VALUES (1, 'Widget'), (2, 'Gadget'), (3, 'Doohickey');
INSERT INTO discontinued VALUES (2);

-- Tag: set_operations_set_operations_test_select_071
SELECT name, \ CASE WHEN EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id) \ THEN 'Has Orders' \ ELSE 'No Orders' \ END as status \ FROM customers c \ ORDER BY name;
-- Tag: set_operations_set_operations_test_select_072
SELECT name FROM employees e \ WHERE EXISTS ( \ SELECT 1 FROM current_projects cp WHERE cp.emp_id = e.id \ UNION \ SELECT 1 FROM past_projects pp WHERE pp.emp_id = e.id \ ) \ ORDER BY name;
-- Tag: set_operations_set_operations_test_select_073
SELECT name FROM customers c \ WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_074
SELECT name FROM customers c \ WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_075
SELECT value FROM data d \ WHERE EXISTS (SELECT 1 FROM lookups l WHERE l.id = d.id);
-- Tag: set_operations_set_operations_test_select_076
SELECT value FROM data WHERE EXISTS (SELECT 1);
-- Tag: set_operations_set_operations_test_select_077
SELECT value FROM data WHERE NOT EXISTS (SELECT 1);
-- Tag: set_operations_set_operations_test_select_078
SELECT name FROM customers c \ WHERE EXISTS (SELECT order_id, amount FROM orders WHERE customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_079
SELECT item_id FROM order_items oi \ WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.order_id = oi.order_id);
-- Tag: set_operations_set_operations_test_select_080
SELECT name FROM customers c \ WHERE NOT EXISTS ( \ SELECT 1 FROM orders o \ WHERE o.customer_id = c.id AND o.order_date > DATE '2024-01-01' \ );
-- Tag: set_operations_set_operations_test_select_081
SELECT name FROM products p \ WHERE NOT EXISTS (SELECT 1 FROM discontinued d WHERE d.product_id = p.id) \ ORDER BY name;

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (id INT64, name STRING);
DROP TABLE IF EXISTS current_projects;
CREATE TABLE current_projects (proj_id INT64, emp_id INT64);
DROP TABLE IF EXISTS past_projects;
CREATE TABLE past_projects (proj_id INT64, emp_id INT64);
INSERT INTO employees VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO current_projects VALUES (101, 1);
INSERT INTO past_projects VALUES (201, 2);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO orders VALUES (101, 1);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
DROP TABLE IF EXISTS lookups;
CREATE TABLE lookups (id INT64);
INSERT INTO data VALUES (1, 100);
INSERT INTO lookups VALUES (1);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100), (2, 200);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64, amount INT64);
INSERT INTO customers VALUES (1, 'Alice');
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (item_id INT64, order_id INT64, product_id INT64);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64);
INSERT INTO order_items VALUES (1, 101, 10), (2, 999, 20);
INSERT INTO orders VALUES (101, 1);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (order_id INT64, customer_id INT64, order_date DATE);
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob');
INSERT INTO orders VALUES \ (101, 1, DATE '2024-01-01'), \ (102, 2, DATE '2023-06-01');
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, name STRING);
DROP TABLE IF EXISTS discontinued;
CREATE TABLE discontinued (product_id INT64);
INSERT INTO products VALUES (1, 'Widget'), (2, 'Gadget'), (3, 'Doohickey');
INSERT INTO discontinued VALUES (2);

-- Tag: set_operations_set_operations_test_select_082
SELECT name FROM employees e \ WHERE EXISTS ( \ SELECT 1 FROM current_projects cp WHERE cp.emp_id = e.id \ UNION \ SELECT 1 FROM past_projects pp WHERE pp.emp_id = e.id \ ) \ ORDER BY name;
-- Tag: set_operations_set_operations_test_select_083
SELECT name FROM customers c \ WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_084
SELECT name FROM customers c \ WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_085
SELECT value FROM data d \ WHERE EXISTS (SELECT 1 FROM lookups l WHERE l.id = d.id);
-- Tag: set_operations_set_operations_test_select_086
SELECT value FROM data WHERE EXISTS (SELECT 1);
-- Tag: set_operations_set_operations_test_select_087
SELECT value FROM data WHERE NOT EXISTS (SELECT 1);
-- Tag: set_operations_set_operations_test_select_088
SELECT name FROM customers c \ WHERE EXISTS (SELECT order_id, amount FROM orders WHERE customer_id = c.id);
-- Tag: set_operations_set_operations_test_select_089
SELECT item_id FROM order_items oi \ WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.order_id = oi.order_id);
-- Tag: set_operations_set_operations_test_select_090
SELECT name FROM customers c \ WHERE NOT EXISTS ( \ SELECT 1 FROM orders o \ WHERE o.customer_id = c.id AND o.order_date > DATE '2024-01-01' \ );
-- Tag: set_operations_set_operations_test_select_091
SELECT name FROM products p \ WHERE NOT EXISTS (SELECT 1 FROM discontinued d WHERE d.product_id = p.id) \ ORDER BY name;

DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
INSERT INTO t1 VALUES (1), (2), (3);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t2 VALUES (4), (5), (6);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
INSERT INTO t1 VALUES (1), (2);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t2 VALUES (3), (4);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
INSERT INTO t1 VALUES (1), (NULL);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t2 VALUES (NULL), (2);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
INSERT INTO t1 VALUES (NULL), (NULL), (1);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t2 VALUES (NULL), (1);

-- Tag: set_operations_set_operations_test_select_092
SELECT val FROM t1 UNION ALL SELECT val FROM t2 ORDER BY val LIMIT 3;
-- Tag: set_operations_set_operations_test_select_093
SELECT val FROM t1 UNION ALL SELECT val FROM t2 ORDER BY val OFFSET 2;
-- Tag: set_operations_set_operations_test_select_094
SELECT val FROM t1 UNION ALL SELECT val FROM t2;
-- Tag: set_operations_set_operations_test_select_095
SELECT val FROM t1 UNION SELECT val FROM t2;

DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
INSERT INTO t1 VALUES (1), (2);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t2 VALUES (3), (4);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
INSERT INTO t1 VALUES (1), (NULL);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t2 VALUES (NULL), (2);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
INSERT INTO t1 VALUES (NULL), (NULL), (1);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t2 VALUES (NULL), (1);

-- Tag: set_operations_set_operations_test_select_096
SELECT val FROM t1 UNION ALL SELECT val FROM t2 ORDER BY val OFFSET 2;
-- Tag: set_operations_set_operations_test_select_097
SELECT val FROM t1 UNION ALL SELECT val FROM t2;
-- Tag: set_operations_set_operations_test_select_098
SELECT val FROM t1 UNION SELECT val FROM t2;

DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
INSERT INTO t1 VALUES (1), (NULL);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t2 VALUES (NULL), (2);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
INSERT INTO t1 VALUES (NULL), (NULL), (1);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t2 VALUES (NULL), (1);

-- Tag: set_operations_set_operations_test_select_099
SELECT val FROM t1 UNION ALL SELECT val FROM t2;
-- Tag: set_operations_set_operations_test_select_100
SELECT val FROM t1 UNION SELECT val FROM t2;

DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (val INT64);
INSERT INTO t1 VALUES (NULL), (NULL), (1);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (val INT64);
INSERT INTO t2 VALUES (NULL), (1);

-- Tag: set_operations_set_operations_test_select_101
SELECT val FROM t1 UNION SELECT val FROM t2;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, NULL), (3, 20), (4, NULL), (5, 5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, NULL), (3, 20), (4, NULL), (5, 5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (NULL), (20), (5);
DROP TABLE IF EXISTS products;
CREATE TABLE products (name STRING, price FLOAT64, tax_rate FLOAT64);
INSERT INTO products VALUES ('A', 100, 0.1), ('B', 80, 0.15), ('C', 110, 0.05);
DROP TABLE IF EXISTS tasks;
CREATE TABLE tasks (id INT64, priority STRING);
INSERT INTO tasks VALUES (1, 'low'), (2, 'high'), (3, 'medium'), (4, 'high');
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64, c INT64);
INSERT INTO data VALUES (3, 1, 100), (1, 2, 200), (2, 3, 150);
DROP TABLE IF EXISTS names;
CREATE TABLE names (name STRING);
INSERT INTO names VALUES ('alice'), ('Bob'), ('CHARLIE'), ('david');
DROP TABLE IF EXISTS empty1;
CREATE TABLE empty1 (n INT64);
DROP TABLE IF EXISTS empty2;
CREATE TABLE empty2 (n INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value INT64);
INSERT INTO nulls VALUES (NULL), (NULL), (NULL);
DROP TABLE IF EXISTS same;
CREATE TABLE same (id INT64, value INT64);
INSERT INTO same VALUES (1, 10), (2, 10), (3, 10);

-- Tag: set_operations_set_operations_test_select_102
SELECT value FROM data ORDER BY value NULLS FIRST;
-- Tag: set_operations_set_operations_test_select_103
SELECT value FROM data ORDER BY value NULLS LAST;
-- Tag: set_operations_set_operations_test_select_104
SELECT value FROM data ORDER BY value DESC NULLS FIRST;
-- Tag: set_operations_set_operations_test_select_105
SELECT name, price * (1 + tax_rate) as total FROM products ORDER BY price * (1 + tax_rate);
-- Tag: set_operations_set_operations_test_select_106
SELECT id FROM tasks ORDER BY CASE priority WHEN 'high' THEN 1 WHEN 'medium' THEN 2 WHEN 'low' THEN 3 END, id;
-- Tag: set_operations_set_operations_test_select_107
SELECT a, b, c FROM data ORDER BY 1, 3;
-- Tag: set_operations_set_operations_test_select_108
SELECT name FROM names ORDER BY name COLLATE NOCASE;
-- Tag: set_operations_set_operations_test_select_109
SELECT n FROM empty1 UNION ALL SELECT n FROM empty2;
-- Tag: set_operations_set_operations_test_select_110
SELECT DISTINCT value FROM nulls;
-- Tag: set_operations_set_operations_test_select_111
SELECT id FROM same ORDER BY value, id DESC;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 10), (2, NULL), (3, 20), (4, NULL), (5, 5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (NULL), (20), (5);
DROP TABLE IF EXISTS products;
CREATE TABLE products (name STRING, price FLOAT64, tax_rate FLOAT64);
INSERT INTO products VALUES ('A', 100, 0.1), ('B', 80, 0.15), ('C', 110, 0.05);
DROP TABLE IF EXISTS tasks;
CREATE TABLE tasks (id INT64, priority STRING);
INSERT INTO tasks VALUES (1, 'low'), (2, 'high'), (3, 'medium'), (4, 'high');
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64, c INT64);
INSERT INTO data VALUES (3, 1, 100), (1, 2, 200), (2, 3, 150);
DROP TABLE IF EXISTS names;
CREATE TABLE names (name STRING);
INSERT INTO names VALUES ('alice'), ('Bob'), ('CHARLIE'), ('david');
DROP TABLE IF EXISTS empty1;
CREATE TABLE empty1 (n INT64);
DROP TABLE IF EXISTS empty2;
CREATE TABLE empty2 (n INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value INT64);
INSERT INTO nulls VALUES (NULL), (NULL), (NULL);
DROP TABLE IF EXISTS same;
CREATE TABLE same (id INT64, value INT64);
INSERT INTO same VALUES (1, 10), (2, 10), (3, 10);

-- Tag: set_operations_set_operations_test_select_112
SELECT value FROM data ORDER BY value NULLS LAST;
-- Tag: set_operations_set_operations_test_select_113
SELECT value FROM data ORDER BY value DESC NULLS FIRST;
-- Tag: set_operations_set_operations_test_select_114
SELECT name, price * (1 + tax_rate) as total FROM products ORDER BY price * (1 + tax_rate);
-- Tag: set_operations_set_operations_test_select_115
SELECT id FROM tasks ORDER BY CASE priority WHEN 'high' THEN 1 WHEN 'medium' THEN 2 WHEN 'low' THEN 3 END, id;
-- Tag: set_operations_set_operations_test_select_116
SELECT a, b, c FROM data ORDER BY 1, 3;
-- Tag: set_operations_set_operations_test_select_117
SELECT name FROM names ORDER BY name COLLATE NOCASE;
-- Tag: set_operations_set_operations_test_select_118
SELECT n FROM empty1 UNION ALL SELECT n FROM empty2;
-- Tag: set_operations_set_operations_test_select_119
SELECT DISTINCT value FROM nulls;
-- Tag: set_operations_set_operations_test_select_120
SELECT id FROM same ORDER BY value, id DESC;

DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (10), (NULL), (20), (5);
DROP TABLE IF EXISTS products;
CREATE TABLE products (name STRING, price FLOAT64, tax_rate FLOAT64);
INSERT INTO products VALUES ('A', 100, 0.1), ('B', 80, 0.15), ('C', 110, 0.05);
DROP TABLE IF EXISTS tasks;
CREATE TABLE tasks (id INT64, priority STRING);
INSERT INTO tasks VALUES (1, 'low'), (2, 'high'), (3, 'medium'), (4, 'high');
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64, c INT64);
INSERT INTO data VALUES (3, 1, 100), (1, 2, 200), (2, 3, 150);
DROP TABLE IF EXISTS names;
CREATE TABLE names (name STRING);
INSERT INTO names VALUES ('alice'), ('Bob'), ('CHARLIE'), ('david');
DROP TABLE IF EXISTS empty1;
CREATE TABLE empty1 (n INT64);
DROP TABLE IF EXISTS empty2;
CREATE TABLE empty2 (n INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value INT64);
INSERT INTO nulls VALUES (NULL), (NULL), (NULL);
DROP TABLE IF EXISTS same;
CREATE TABLE same (id INT64, value INT64);
INSERT INTO same VALUES (1, 10), (2, 10), (3, 10);

-- Tag: set_operations_set_operations_test_select_121
SELECT value FROM data ORDER BY value DESC NULLS FIRST;
-- Tag: set_operations_set_operations_test_select_122
SELECT name, price * (1 + tax_rate) as total FROM products ORDER BY price * (1 + tax_rate);
-- Tag: set_operations_set_operations_test_select_123
SELECT id FROM tasks ORDER BY CASE priority WHEN 'high' THEN 1 WHEN 'medium' THEN 2 WHEN 'low' THEN 3 END, id;
-- Tag: set_operations_set_operations_test_select_124
SELECT a, b, c FROM data ORDER BY 1, 3;
-- Tag: set_operations_set_operations_test_select_125
SELECT name FROM names ORDER BY name COLLATE NOCASE;
-- Tag: set_operations_set_operations_test_select_126
SELECT n FROM empty1 UNION ALL SELECT n FROM empty2;
-- Tag: set_operations_set_operations_test_select_127
SELECT DISTINCT value FROM nulls;
-- Tag: set_operations_set_operations_test_select_128
SELECT id FROM same ORDER BY value, id DESC;

DROP TABLE IF EXISTS products;
CREATE TABLE products (name STRING, price FLOAT64, tax_rate FLOAT64);
INSERT INTO products VALUES ('A', 100, 0.1), ('B', 80, 0.15), ('C', 110, 0.05);
DROP TABLE IF EXISTS tasks;
CREATE TABLE tasks (id INT64, priority STRING);
INSERT INTO tasks VALUES (1, 'low'), (2, 'high'), (3, 'medium'), (4, 'high');
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64, c INT64);
INSERT INTO data VALUES (3, 1, 100), (1, 2, 200), (2, 3, 150);
DROP TABLE IF EXISTS names;
CREATE TABLE names (name STRING);
INSERT INTO names VALUES ('alice'), ('Bob'), ('CHARLIE'), ('david');
DROP TABLE IF EXISTS empty1;
CREATE TABLE empty1 (n INT64);
DROP TABLE IF EXISTS empty2;
CREATE TABLE empty2 (n INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value INT64);
INSERT INTO nulls VALUES (NULL), (NULL), (NULL);
DROP TABLE IF EXISTS same;
CREATE TABLE same (id INT64, value INT64);
INSERT INTO same VALUES (1, 10), (2, 10), (3, 10);

-- Tag: set_operations_set_operations_test_select_129
SELECT name, price * (1 + tax_rate) as total FROM products ORDER BY price * (1 + tax_rate);
-- Tag: set_operations_set_operations_test_select_130
SELECT id FROM tasks ORDER BY CASE priority WHEN 'high' THEN 1 WHEN 'medium' THEN 2 WHEN 'low' THEN 3 END, id;
-- Tag: set_operations_set_operations_test_select_131
SELECT a, b, c FROM data ORDER BY 1, 3;
-- Tag: set_operations_set_operations_test_select_132
SELECT name FROM names ORDER BY name COLLATE NOCASE;
-- Tag: set_operations_set_operations_test_select_133
SELECT n FROM empty1 UNION ALL SELECT n FROM empty2;
-- Tag: set_operations_set_operations_test_select_134
SELECT DISTINCT value FROM nulls;
-- Tag: set_operations_set_operations_test_select_135
SELECT id FROM same ORDER BY value, id DESC;

DROP TABLE IF EXISTS tasks;
CREATE TABLE tasks (id INT64, priority STRING);
INSERT INTO tasks VALUES (1, 'low'), (2, 'high'), (3, 'medium'), (4, 'high');
DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64, c INT64);
INSERT INTO data VALUES (3, 1, 100), (1, 2, 200), (2, 3, 150);
DROP TABLE IF EXISTS names;
CREATE TABLE names (name STRING);
INSERT INTO names VALUES ('alice'), ('Bob'), ('CHARLIE'), ('david');
DROP TABLE IF EXISTS empty1;
CREATE TABLE empty1 (n INT64);
DROP TABLE IF EXISTS empty2;
CREATE TABLE empty2 (n INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value INT64);
INSERT INTO nulls VALUES (NULL), (NULL), (NULL);
DROP TABLE IF EXISTS same;
CREATE TABLE same (id INT64, value INT64);
INSERT INTO same VALUES (1, 10), (2, 10), (3, 10);

-- Tag: set_operations_set_operations_test_select_136
SELECT id FROM tasks ORDER BY CASE priority WHEN 'high' THEN 1 WHEN 'medium' THEN 2 WHEN 'low' THEN 3 END, id;
-- Tag: set_operations_set_operations_test_select_137
SELECT a, b, c FROM data ORDER BY 1, 3;
-- Tag: set_operations_set_operations_test_select_138
SELECT name FROM names ORDER BY name COLLATE NOCASE;
-- Tag: set_operations_set_operations_test_select_139
SELECT n FROM empty1 UNION ALL SELECT n FROM empty2;
-- Tag: set_operations_set_operations_test_select_140
SELECT DISTINCT value FROM nulls;
-- Tag: set_operations_set_operations_test_select_141
SELECT id FROM same ORDER BY value, id DESC;

DROP TABLE IF EXISTS data;
CREATE TABLE data (a INT64, b INT64, c INT64);
INSERT INTO data VALUES (3, 1, 100), (1, 2, 200), (2, 3, 150);
DROP TABLE IF EXISTS names;
CREATE TABLE names (name STRING);
INSERT INTO names VALUES ('alice'), ('Bob'), ('CHARLIE'), ('david');
DROP TABLE IF EXISTS empty1;
CREATE TABLE empty1 (n INT64);
DROP TABLE IF EXISTS empty2;
CREATE TABLE empty2 (n INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value INT64);
INSERT INTO nulls VALUES (NULL), (NULL), (NULL);
DROP TABLE IF EXISTS same;
CREATE TABLE same (id INT64, value INT64);
INSERT INTO same VALUES (1, 10), (2, 10), (3, 10);

-- Tag: set_operations_set_operations_test_select_142
SELECT a, b, c FROM data ORDER BY 1, 3;
-- Tag: set_operations_set_operations_test_select_143
SELECT name FROM names ORDER BY name COLLATE NOCASE;
-- Tag: set_operations_set_operations_test_select_144
SELECT n FROM empty1 UNION ALL SELECT n FROM empty2;
-- Tag: set_operations_set_operations_test_select_145
SELECT DISTINCT value FROM nulls;
-- Tag: set_operations_set_operations_test_select_146
SELECT id FROM same ORDER BY value, id DESC;

DROP TABLE IF EXISTS names;
CREATE TABLE names (name STRING);
INSERT INTO names VALUES ('alice'), ('Bob'), ('CHARLIE'), ('david');
DROP TABLE IF EXISTS empty1;
CREATE TABLE empty1 (n INT64);
DROP TABLE IF EXISTS empty2;
CREATE TABLE empty2 (n INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value INT64);
INSERT INTO nulls VALUES (NULL), (NULL), (NULL);
DROP TABLE IF EXISTS same;
CREATE TABLE same (id INT64, value INT64);
INSERT INTO same VALUES (1, 10), (2, 10), (3, 10);

-- Tag: set_operations_set_operations_test_select_147
SELECT name FROM names ORDER BY name COLLATE NOCASE;
-- Tag: set_operations_set_operations_test_select_148
SELECT n FROM empty1 UNION ALL SELECT n FROM empty2;
-- Tag: set_operations_set_operations_test_select_149
SELECT DISTINCT value FROM nulls;
-- Tag: set_operations_set_operations_test_select_150
SELECT id FROM same ORDER BY value, id DESC;

DROP TABLE IF EXISTS empty1;
CREATE TABLE empty1 (n INT64);
DROP TABLE IF EXISTS empty2;
CREATE TABLE empty2 (n INT64);
DROP TABLE IF EXISTS nulls;
CREATE TABLE nulls (value INT64);
INSERT INTO nulls VALUES (NULL), (NULL), (NULL);
DROP TABLE IF EXISTS same;
CREATE TABLE same (id INT64, value INT64);
INSERT INTO same VALUES (1, 10), (2, 10), (3, 10);

-- Tag: set_operations_set_operations_test_select_151
SELECT n FROM empty1 UNION ALL SELECT n FROM empty2;
-- Tag: set_operations_set_operations_test_select_152
SELECT DISTINCT value FROM nulls;
-- Tag: set_operations_set_operations_test_select_153
SELECT id FROM same ORDER BY value, id DESC;

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);
DROP TABLE IF EXISTS multi_col;
CREATE TABLE multi_col (a INT64, b INT64);
INSERT INTO multi_col VALUES (10, 20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);
DROP TABLE IF EXISTS multi_col;
CREATE TABLE multi_col (a INT64, b INT64);
INSERT INTO multi_col VALUES (10, 20);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (100);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (text STRING);
INSERT INTO strings VALUES ('hello');
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO customers VALUES (2, 'Bob');
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, product_id INT64);
INSERT INTO orders VALUES (1, 1, 100);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, category STRING);
INSERT INTO products VALUES (100, 'Electronics');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, price FLOAT64);
INSERT INTO items VALUES (1, 50.0);
INSERT INTO items VALUES (2, 100.0);
DROP TABLE IF EXISTS set_a;
CREATE TABLE set_a (val FLOAT64);
INSERT INTO set_a VALUES (40.0);
INSERT INTO set_a VALUES (60.0);
DROP TABLE IF EXISTS set_b;
CREATE TABLE set_b (val FLOAT64);
INSERT INTO set_b VALUES (120.0);
DROP TABLE IF EXISTS active_users;
CREATE TABLE active_users (id INT64);
INSERT INTO active_users VALUES (1);
DROP TABLE IF EXISTS premium_users;
CREATE TABLE premium_users (id INT64);
INSERT INTO premium_users VALUES (2);
DROP TABLE IF EXISTS all_users;
CREATE TABLE all_users (id INT64, name STRING);
INSERT INTO all_users VALUES (1, 'Alice');
INSERT INTO all_users VALUES (2, 'Bob');
INSERT INTO all_users VALUES (3, 'Charlie');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64);
INSERT INTO items VALUES (1);
DROP TABLE IF EXISTS large_set;
CREATE TABLE large_set (val INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (0);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS thresholds;
CREATE TABLE thresholds (threshold INT64);
INSERT INTO thresholds VALUES (0);

-- Tag: set_operations_set_operations_test_select_154
SELECT id FROM data WHERE value > ANY (SELECT a, b FROM multi_col);
-- Tag: set_operations_set_operations_test_select_155
SELECT id FROM data WHERE value > ALL (SELECT a, b FROM multi_col);
-- Tag: set_operations_set_operations_test_select_156
SELECT value FROM numbers WHERE value > ANY (SELECT text FROM strings);
-- Tag: set_operations_set_operations_test_select_157
SELECT name FROM customers c \ WHERE EXISTS (\ SELECT 1 FROM orders o \ WHERE o.customer_id = c.id \ AND EXISTS (\ SELECT 1 FROM products p \ WHERE p.id = o.product_id \ AND p.category = 'Electronics'\ )\ );
-- Tag: set_operations_set_operations_test_select_158
SELECT id FROM items \ WHERE price > ANY (SELECT val FROM set_a) \ AND price < ALL (SELECT val FROM set_b);
-- Tag: set_operations_set_operations_test_select_159
SELECT name FROM all_users \ WHERE id IN (\ SELECT id FROM active_users \ UNION \ SELECT id FROM premium_users\ );
-- Tag: set_operations_set_operations_test_select_160
SELECT id FROM items WHERE EXISTS (SELECT 1 FROM large_set WHERE val > 0);
-- Tag: set_operations_set_operations_test_select_161
SELECT value FROM numbers WHERE value >= ALL (SELECT threshold FROM thresholds);

DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 100);
DROP TABLE IF EXISTS multi_col;
CREATE TABLE multi_col (a INT64, b INT64);
INSERT INTO multi_col VALUES (10, 20);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (100);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (text STRING);
INSERT INTO strings VALUES ('hello');
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO customers VALUES (2, 'Bob');
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, product_id INT64);
INSERT INTO orders VALUES (1, 1, 100);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, category STRING);
INSERT INTO products VALUES (100, 'Electronics');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, price FLOAT64);
INSERT INTO items VALUES (1, 50.0);
INSERT INTO items VALUES (2, 100.0);
DROP TABLE IF EXISTS set_a;
CREATE TABLE set_a (val FLOAT64);
INSERT INTO set_a VALUES (40.0);
INSERT INTO set_a VALUES (60.0);
DROP TABLE IF EXISTS set_b;
CREATE TABLE set_b (val FLOAT64);
INSERT INTO set_b VALUES (120.0);
DROP TABLE IF EXISTS active_users;
CREATE TABLE active_users (id INT64);
INSERT INTO active_users VALUES (1);
DROP TABLE IF EXISTS premium_users;
CREATE TABLE premium_users (id INT64);
INSERT INTO premium_users VALUES (2);
DROP TABLE IF EXISTS all_users;
CREATE TABLE all_users (id INT64, name STRING);
INSERT INTO all_users VALUES (1, 'Alice');
INSERT INTO all_users VALUES (2, 'Bob');
INSERT INTO all_users VALUES (3, 'Charlie');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64);
INSERT INTO items VALUES (1);
DROP TABLE IF EXISTS large_set;
CREATE TABLE large_set (val INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (0);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS thresholds;
CREATE TABLE thresholds (threshold INT64);
INSERT INTO thresholds VALUES (0);

-- Tag: set_operations_set_operations_test_select_162
SELECT id FROM data WHERE value > ALL (SELECT a, b FROM multi_col);
-- Tag: set_operations_set_operations_test_select_163
SELECT value FROM numbers WHERE value > ANY (SELECT text FROM strings);
-- Tag: set_operations_set_operations_test_select_164
SELECT name FROM customers c \ WHERE EXISTS (\ SELECT 1 FROM orders o \ WHERE o.customer_id = c.id \ AND EXISTS (\ SELECT 1 FROM products p \ WHERE p.id = o.product_id \ AND p.category = 'Electronics'\ )\ );
-- Tag: set_operations_set_operations_test_select_165
SELECT id FROM items \ WHERE price > ANY (SELECT val FROM set_a) \ AND price < ALL (SELECT val FROM set_b);
-- Tag: set_operations_set_operations_test_select_166
SELECT name FROM all_users \ WHERE id IN (\ SELECT id FROM active_users \ UNION \ SELECT id FROM premium_users\ );
-- Tag: set_operations_set_operations_test_select_167
SELECT id FROM items WHERE EXISTS (SELECT 1 FROM large_set WHERE val > 0);
-- Tag: set_operations_set_operations_test_select_168
SELECT value FROM numbers WHERE value >= ALL (SELECT threshold FROM thresholds);

DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (100);
DROP TABLE IF EXISTS strings;
CREATE TABLE strings (text STRING);
INSERT INTO strings VALUES ('hello');
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO customers VALUES (2, 'Bob');
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, product_id INT64);
INSERT INTO orders VALUES (1, 1, 100);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, category STRING);
INSERT INTO products VALUES (100, 'Electronics');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, price FLOAT64);
INSERT INTO items VALUES (1, 50.0);
INSERT INTO items VALUES (2, 100.0);
DROP TABLE IF EXISTS set_a;
CREATE TABLE set_a (val FLOAT64);
INSERT INTO set_a VALUES (40.0);
INSERT INTO set_a VALUES (60.0);
DROP TABLE IF EXISTS set_b;
CREATE TABLE set_b (val FLOAT64);
INSERT INTO set_b VALUES (120.0);
DROP TABLE IF EXISTS active_users;
CREATE TABLE active_users (id INT64);
INSERT INTO active_users VALUES (1);
DROP TABLE IF EXISTS premium_users;
CREATE TABLE premium_users (id INT64);
INSERT INTO premium_users VALUES (2);
DROP TABLE IF EXISTS all_users;
CREATE TABLE all_users (id INT64, name STRING);
INSERT INTO all_users VALUES (1, 'Alice');
INSERT INTO all_users VALUES (2, 'Bob');
INSERT INTO all_users VALUES (3, 'Charlie');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64);
INSERT INTO items VALUES (1);
DROP TABLE IF EXISTS large_set;
CREATE TABLE large_set (val INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (0);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS thresholds;
CREATE TABLE thresholds (threshold INT64);
INSERT INTO thresholds VALUES (0);

-- Tag: set_operations_set_operations_test_select_169
SELECT value FROM numbers WHERE value > ANY (SELECT text FROM strings);
-- Tag: set_operations_set_operations_test_select_170
SELECT name FROM customers c \ WHERE EXISTS (\ SELECT 1 FROM orders o \ WHERE o.customer_id = c.id \ AND EXISTS (\ SELECT 1 FROM products p \ WHERE p.id = o.product_id \ AND p.category = 'Electronics'\ )\ );
-- Tag: set_operations_set_operations_test_select_171
SELECT id FROM items \ WHERE price > ANY (SELECT val FROM set_a) \ AND price < ALL (SELECT val FROM set_b);
-- Tag: set_operations_set_operations_test_select_172
SELECT name FROM all_users \ WHERE id IN (\ SELECT id FROM active_users \ UNION \ SELECT id FROM premium_users\ );
-- Tag: set_operations_set_operations_test_select_173
SELECT id FROM items WHERE EXISTS (SELECT 1 FROM large_set WHERE val > 0);
-- Tag: set_operations_set_operations_test_select_174
SELECT value FROM numbers WHERE value >= ALL (SELECT threshold FROM thresholds);

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (id INT64, name STRING);
INSERT INTO customers VALUES (1, 'Alice');
INSERT INTO customers VALUES (2, 'Bob');
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, customer_id INT64, product_id INT64);
INSERT INTO orders VALUES (1, 1, 100);
DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, category STRING);
INSERT INTO products VALUES (100, 'Electronics');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, price FLOAT64);
INSERT INTO items VALUES (1, 50.0);
INSERT INTO items VALUES (2, 100.0);
DROP TABLE IF EXISTS set_a;
CREATE TABLE set_a (val FLOAT64);
INSERT INTO set_a VALUES (40.0);
INSERT INTO set_a VALUES (60.0);
DROP TABLE IF EXISTS set_b;
CREATE TABLE set_b (val FLOAT64);
INSERT INTO set_b VALUES (120.0);
DROP TABLE IF EXISTS active_users;
CREATE TABLE active_users (id INT64);
INSERT INTO active_users VALUES (1);
DROP TABLE IF EXISTS premium_users;
CREATE TABLE premium_users (id INT64);
INSERT INTO premium_users VALUES (2);
DROP TABLE IF EXISTS all_users;
CREATE TABLE all_users (id INT64, name STRING);
INSERT INTO all_users VALUES (1, 'Alice');
INSERT INTO all_users VALUES (2, 'Bob');
INSERT INTO all_users VALUES (3, 'Charlie');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64);
INSERT INTO items VALUES (1);
DROP TABLE IF EXISTS large_set;
CREATE TABLE large_set (val INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (0);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS thresholds;
CREATE TABLE thresholds (threshold INT64);
INSERT INTO thresholds VALUES (0);

-- Tag: set_operations_set_operations_test_select_175
SELECT name FROM customers c \ WHERE EXISTS (\ SELECT 1 FROM orders o \ WHERE o.customer_id = c.id \ AND EXISTS (\ SELECT 1 FROM products p \ WHERE p.id = o.product_id \ AND p.category = 'Electronics'\ )\ );
-- Tag: set_operations_set_operations_test_select_176
SELECT id FROM items \ WHERE price > ANY (SELECT val FROM set_a) \ AND price < ALL (SELECT val FROM set_b);
-- Tag: set_operations_set_operations_test_select_177
SELECT name FROM all_users \ WHERE id IN (\ SELECT id FROM active_users \ UNION \ SELECT id FROM premium_users\ );
-- Tag: set_operations_set_operations_test_select_178
SELECT id FROM items WHERE EXISTS (SELECT 1 FROM large_set WHERE val > 0);
-- Tag: set_operations_set_operations_test_select_179
SELECT value FROM numbers WHERE value >= ALL (SELECT threshold FROM thresholds);

DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, price FLOAT64);
INSERT INTO items VALUES (1, 50.0);
INSERT INTO items VALUES (2, 100.0);
DROP TABLE IF EXISTS set_a;
CREATE TABLE set_a (val FLOAT64);
INSERT INTO set_a VALUES (40.0);
INSERT INTO set_a VALUES (60.0);
DROP TABLE IF EXISTS set_b;
CREATE TABLE set_b (val FLOAT64);
INSERT INTO set_b VALUES (120.0);
DROP TABLE IF EXISTS active_users;
CREATE TABLE active_users (id INT64);
INSERT INTO active_users VALUES (1);
DROP TABLE IF EXISTS premium_users;
CREATE TABLE premium_users (id INT64);
INSERT INTO premium_users VALUES (2);
DROP TABLE IF EXISTS all_users;
CREATE TABLE all_users (id INT64, name STRING);
INSERT INTO all_users VALUES (1, 'Alice');
INSERT INTO all_users VALUES (2, 'Bob');
INSERT INTO all_users VALUES (3, 'Charlie');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64);
INSERT INTO items VALUES (1);
DROP TABLE IF EXISTS large_set;
CREATE TABLE large_set (val INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (0);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS thresholds;
CREATE TABLE thresholds (threshold INT64);
INSERT INTO thresholds VALUES (0);

-- Tag: set_operations_set_operations_test_select_180
SELECT id FROM items \ WHERE price > ANY (SELECT val FROM set_a) \ AND price < ALL (SELECT val FROM set_b);
-- Tag: set_operations_set_operations_test_select_181
SELECT name FROM all_users \ WHERE id IN (\ SELECT id FROM active_users \ UNION \ SELECT id FROM premium_users\ );
-- Tag: set_operations_set_operations_test_select_182
SELECT id FROM items WHERE EXISTS (SELECT 1 FROM large_set WHERE val > 0);
-- Tag: set_operations_set_operations_test_select_183
SELECT value FROM numbers WHERE value >= ALL (SELECT threshold FROM thresholds);

DROP TABLE IF EXISTS active_users;
CREATE TABLE active_users (id INT64);
INSERT INTO active_users VALUES (1);
DROP TABLE IF EXISTS premium_users;
CREATE TABLE premium_users (id INT64);
INSERT INTO premium_users VALUES (2);
DROP TABLE IF EXISTS all_users;
CREATE TABLE all_users (id INT64, name STRING);
INSERT INTO all_users VALUES (1, 'Alice');
INSERT INTO all_users VALUES (2, 'Bob');
INSERT INTO all_users VALUES (3, 'Charlie');
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64);
INSERT INTO items VALUES (1);
DROP TABLE IF EXISTS large_set;
CREATE TABLE large_set (val INT64);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (value INT64);
INSERT INTO numbers VALUES (0);
INSERT INTO numbers VALUES (5);
INSERT INTO numbers VALUES (10);
DROP TABLE IF EXISTS thresholds;
CREATE TABLE thresholds (threshold INT64);
INSERT INTO thresholds VALUES (0);

-- Tag: set_operations_set_operations_test_select_184
SELECT name FROM all_users \ WHERE id IN (\ SELECT id FROM active_users \ UNION \ SELECT id FROM premium_users\ );
-- Tag: set_operations_set_operations_test_select_185
SELECT id FROM items WHERE EXISTS (SELECT 1 FROM large_set WHERE val > 0);
-- Tag: set_operations_set_operations_test_select_186
SELECT value FROM numbers WHERE value >= ALL (SELECT threshold FROM thresholds);

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

-- Tag: set_operations_set_operations_test_select_187
SELECT val FROM t1 UNION SELECT val FROM t2;
-- Tag: set_operations_set_operations_test_select_188
SELECT val FROM t1 INTERSECT SELECT val FROM t2;
-- Tag: set_operations_set_operations_test_select_189
SELECT val FROM data WHERE val > ALL (SELECT val FROM empty);
-- Tag: set_operations_set_operations_test_select_190
SELECT val FROM data WHERE val > ANY (SELECT val FROM empty);

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

-- Tag: set_operations_set_operations_test_select_191
SELECT val FROM t1 INTERSECT SELECT val FROM t2;
-- Tag: set_operations_set_operations_test_select_192
SELECT val FROM data WHERE val > ALL (SELECT val FROM empty);
-- Tag: set_operations_set_operations_test_select_193
SELECT val FROM data WHERE val > ANY (SELECT val FROM empty);
