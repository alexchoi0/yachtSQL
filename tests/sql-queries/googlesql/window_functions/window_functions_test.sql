-- ============================================================================
-- Window Functions - GoogleSQL/BigQuery
-- ============================================================================
-- Source: Migrated from conditional_expressions_extreme_edge_cases_tdd.rs, data_types.rs, int64_overflow_comprehensive_tdd.rs, json_extreme_edge_cases_tdd.rs, type_casting_edge_cases_tdd.rs
-- Description: Window function operations
--
-- PostgreSQL: Limited or no support
-- BigQuery: Full support
-- SQL Standard: GoogleSQL/BigQuery specific
-- ============================================================================

DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, score INT64);
INSERT INTO t VALUES (1, 95);
INSERT INTO t VALUES (2, 75);
INSERT INTO t VALUES (3, 55);
INSERT INTO t VALUES (4, 35);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL);
INSERT INTO t VALUES (1, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'active');
INSERT INTO t VALUES (2, 'inactive');
INSERT INTO t VALUES (3, 'pending');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, grade STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64, b INT64);
INSERT INTO t VALUES (1, 10, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, x INT64, y INT64);
INSERT INTO t VALUES (1, 10, 20);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64, b INT64, c INT64);
INSERT INTO t VALUES (1, 10, 20, 30);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 3);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, score INT64);
INSERT INTO t VALUES (1, 95);
INSERT INTO t VALUES (2, 75);
INSERT INTO t VALUES (3, 55);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, active BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
INSERT INTO t VALUES (4, 'D');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, code STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'Z');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
INSERT INTO t VALUES (2, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT CASE WHEN val > 5 THEN 'high' ELSE 'low' END as category FROM t;
SELECT id, CASE
WHEN score >= 90 THEN 'A'
WHEN score >= 70 THEN 'B'
WHEN score >= 50 THEN 'C'
ELSE 'F'
END as grade FROM t ORDER BY id;
SELECT CASE WHEN val > 100 THEN 'big' END as size FROM t;
SELECT CASE WHEN NULL THEN 'yes' ELSE 'no' END as result FROM t;
SELECT CASE
WHEN a > 5 THEN 'first'
WHEN a > 8 THEN 'second'
ELSE 'none'
END as result FROM t;
SELECT CASE
WHEN a THEN 'a'
WHEN b THEN 'b'
ELSE 'none'
END as result FROM t;
SELECT id, CASE status
WHEN 'active' THEN 1
WHEN 'inactive' THEN 0
ELSE -1
END as status_code FROM t ORDER BY id;
SELECT CASE val
WHEN NULL THEN 'match'
ELSE 'no match'
END as result FROM t;
SELECT id, CASE grade
WHEN 'A' THEN 'Excellent'
WHEN 'B' THEN 'Good'
WHEN 'C' THEN 'Average'
ELSE 'Poor'
END as description FROM t ORDER BY id;
SELECT CASE val WHEN 10 THEN 'ten' ELSE 'other' END as r1 FROM t;
SELECT CASE WHEN val = 10 THEN 'ten' ELSE 'other' END as r2 FROM t;
SELECT CASE
WHEN a > 5 THEN
CASE WHEN b > 3 THEN 'both high' ELSE 'a high only' END
ELSE 'a low'
END as result FROM t;
SELECT CASE
WHEN (CASE WHEN x > 5 THEN y ELSE 0 END) > 15 THEN 'yes'
ELSE 'no'
END as result FROM t;
SELECT CASE
WHEN a > 5 THEN
CASE WHEN b > 15 THEN
CASE WHEN c > 25 THEN 'all high' ELSE 'c low' END
ELSE 'b low' END
ELSE 'a low'
END as result FROM t;
SELECT CASE WHEN flag THEN 10 ELSE 3.14 END as val FROM t ORDER BY id;
SELECT CASE WHEN flag THEN 'text' ELSE 42 END as val FROM t;
SELECT CASE WHEN flag THEN NULL ELSE NULL END as val FROM t;
SELECT id, IF(val > 5, 'high', 'low') as category FROM t ORDER BY id;
SELECT IF(NULL, 'yes', 'no') as result FROM t;
SELECT id, IF(flag, NULL, 'no') as val FROM t ORDER BY id;
SELECT id, IF(score >= 90, 'A', IF(score >= 70, 'B', 'C')) as grade FROM t ORDER BY id;
SELECT IF(val > 5, 'yes', 'no') as r1 FROM t;
SELECT CASE WHEN val > 5 THEN 'yes' ELSE 'no' END as r2 FROM t;
SELECT id, IIF(active, 'yes', 'no') as status FROM t ORDER BY id;
SELECT IF(val > 5, 'high', 'low') as r1 FROM t;
SELECT IIF(val > 5, 'high', 'low') as r2 FROM t;
SELECT id, DECODE(status, 'A', 'Active', 'B', 'Busy', 'C', 'Complete', 'Unknown') as desc FROM t ORDER BY id;
SELECT id, DECODE(code, 'A', 'Found') as result FROM t ORDER BY id;
SELECT id, DECODE(val, NULL, 'was null', 10, 'was ten', 'other') as desc FROM t ORDER BY id;
SELECT DECODE(val, NULL, 'match', 'no match') as r1 FROM t;
SELECT CASE val WHEN NULL THEN 'match' ELSE 'no match' END as r2 FROM t;
SELECT DECODE(val, 10, 'first', 10, 'second', 'other') as result FROM t;
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_case_when_multiple_conditions
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:44
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, score INT64);
INSERT INTO t VALUES (1, 95);
INSERT INTO t VALUES (2, 75);
INSERT INTO t VALUES (3, 55);
INSERT INTO t VALUES (4, 35);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL);
INSERT INTO t VALUES (1, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'active');
INSERT INTO t VALUES (2, 'inactive');
INSERT INTO t VALUES (3, 'pending');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, grade STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64, b INT64);
INSERT INTO t VALUES (1, 10, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, x INT64, y INT64);
INSERT INTO t VALUES (1, 10, 20);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64, b INT64, c INT64);
INSERT INTO t VALUES (1, 10, 20, 30);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 3);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, score INT64);
INSERT INTO t VALUES (1, 95);
INSERT INTO t VALUES (2, 75);
INSERT INTO t VALUES (3, 55);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, active BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
INSERT INTO t VALUES (4, 'D');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, code STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'Z');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
INSERT INTO t VALUES (2, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT id, CASE
WHEN score >= 90 THEN 'A'
WHEN score >= 70 THEN 'B'
WHEN score >= 50 THEN 'C'
ELSE 'F'
END as grade FROM t ORDER BY id;
SELECT CASE WHEN val > 100 THEN 'big' END as size FROM t;
SELECT CASE WHEN NULL THEN 'yes' ELSE 'no' END as result FROM t;
SELECT CASE
WHEN a > 5 THEN 'first'
WHEN a > 8 THEN 'second'
ELSE 'none'
END as result FROM t;
SELECT CASE
WHEN a THEN 'a'
WHEN b THEN 'b'
ELSE 'none'
END as result FROM t;
SELECT id, CASE status
WHEN 'active' THEN 1
WHEN 'inactive' THEN 0
ELSE -1
END as status_code FROM t ORDER BY id;
SELECT CASE val
WHEN NULL THEN 'match'
ELSE 'no match'
END as result FROM t;
SELECT id, CASE grade
WHEN 'A' THEN 'Excellent'
WHEN 'B' THEN 'Good'
WHEN 'C' THEN 'Average'
ELSE 'Poor'
END as description FROM t ORDER BY id;
SELECT CASE val WHEN 10 THEN 'ten' ELSE 'other' END as r1 FROM t;
SELECT CASE WHEN val = 10 THEN 'ten' ELSE 'other' END as r2 FROM t;
SELECT CASE
WHEN a > 5 THEN
CASE WHEN b > 3 THEN 'both high' ELSE 'a high only' END
ELSE 'a low'
END as result FROM t;
SELECT CASE
WHEN (CASE WHEN x > 5 THEN y ELSE 0 END) > 15 THEN 'yes'
ELSE 'no'
END as result FROM t;
SELECT CASE
WHEN a > 5 THEN
CASE WHEN b > 15 THEN
CASE WHEN c > 25 THEN 'all high' ELSE 'c low' END
ELSE 'b low' END
ELSE 'a low'
END as result FROM t;
SELECT CASE WHEN flag THEN 10 ELSE 3.14 END as val FROM t ORDER BY id;
SELECT CASE WHEN flag THEN 'text' ELSE 42 END as val FROM t;
SELECT CASE WHEN flag THEN NULL ELSE NULL END as val FROM t;
SELECT id, IF(val > 5, 'high', 'low') as category FROM t ORDER BY id;
SELECT IF(NULL, 'yes', 'no') as result FROM t;
SELECT id, IF(flag, NULL, 'no') as val FROM t ORDER BY id;
SELECT id, IF(score >= 90, 'A', IF(score >= 70, 'B', 'C')) as grade FROM t ORDER BY id;
SELECT IF(val > 5, 'yes', 'no') as r1 FROM t;
SELECT CASE WHEN val > 5 THEN 'yes' ELSE 'no' END as r2 FROM t;
SELECT id, IIF(active, 'yes', 'no') as status FROM t ORDER BY id;
SELECT IF(val > 5, 'high', 'low') as r1 FROM t;
SELECT IIF(val > 5, 'high', 'low') as r2 FROM t;
SELECT id, DECODE(status, 'A', 'Active', 'B', 'Busy', 'C', 'Complete', 'Unknown') as desc FROM t ORDER BY id;
SELECT id, DECODE(code, 'A', 'Found') as result FROM t ORDER BY id;
SELECT id, DECODE(val, NULL, 'was null', 10, 'was ten', 'other') as desc FROM t ORDER BY id;
SELECT DECODE(val, NULL, 'match', 'no match') as r1 FROM t;
SELECT CASE val WHEN NULL THEN 'match' ELSE 'no match' END as r2 FROM t;
SELECT DECODE(val, 10, 'first', 10, 'second', 'other') as result FROM t;
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_case_when_no_else_returns_null
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:91
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL);
INSERT INTO t VALUES (1, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'active');
INSERT INTO t VALUES (2, 'inactive');
INSERT INTO t VALUES (3, 'pending');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, grade STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64, b INT64);
INSERT INTO t VALUES (1, 10, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, x INT64, y INT64);
INSERT INTO t VALUES (1, 10, 20);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64, b INT64, c INT64);
INSERT INTO t VALUES (1, 10, 20, 30);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 3);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, score INT64);
INSERT INTO t VALUES (1, 95);
INSERT INTO t VALUES (2, 75);
INSERT INTO t VALUES (3, 55);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, active BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
INSERT INTO t VALUES (4, 'D');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, code STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'Z');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
INSERT INTO t VALUES (2, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT CASE WHEN val > 100 THEN 'big' END as size FROM t;
SELECT CASE WHEN NULL THEN 'yes' ELSE 'no' END as result FROM t;
SELECT CASE
WHEN a > 5 THEN 'first'
WHEN a > 8 THEN 'second'
ELSE 'none'
END as result FROM t;
SELECT CASE
WHEN a THEN 'a'
WHEN b THEN 'b'
ELSE 'none'
END as result FROM t;
SELECT id, CASE status
WHEN 'active' THEN 1
WHEN 'inactive' THEN 0
ELSE -1
END as status_code FROM t ORDER BY id;
SELECT CASE val
WHEN NULL THEN 'match'
ELSE 'no match'
END as result FROM t;
SELECT id, CASE grade
WHEN 'A' THEN 'Excellent'
WHEN 'B' THEN 'Good'
WHEN 'C' THEN 'Average'
ELSE 'Poor'
END as description FROM t ORDER BY id;
SELECT CASE val WHEN 10 THEN 'ten' ELSE 'other' END as r1 FROM t;
SELECT CASE WHEN val = 10 THEN 'ten' ELSE 'other' END as r2 FROM t;
SELECT CASE
WHEN a > 5 THEN
CASE WHEN b > 3 THEN 'both high' ELSE 'a high only' END
ELSE 'a low'
END as result FROM t;
SELECT CASE
WHEN (CASE WHEN x > 5 THEN y ELSE 0 END) > 15 THEN 'yes'
ELSE 'no'
END as result FROM t;
SELECT CASE
WHEN a > 5 THEN
CASE WHEN b > 15 THEN
CASE WHEN c > 25 THEN 'all high' ELSE 'c low' END
ELSE 'b low' END
ELSE 'a low'
END as result FROM t;
SELECT CASE WHEN flag THEN 10 ELSE 3.14 END as val FROM t ORDER BY id;
SELECT CASE WHEN flag THEN 'text' ELSE 42 END as val FROM t;
SELECT CASE WHEN flag THEN NULL ELSE NULL END as val FROM t;
SELECT id, IF(val > 5, 'high', 'low') as category FROM t ORDER BY id;
SELECT IF(NULL, 'yes', 'no') as result FROM t;
SELECT id, IF(flag, NULL, 'no') as val FROM t ORDER BY id;
SELECT id, IF(score >= 90, 'A', IF(score >= 70, 'B', 'C')) as grade FROM t ORDER BY id;
SELECT IF(val > 5, 'yes', 'no') as r1 FROM t;
SELECT CASE WHEN val > 5 THEN 'yes' ELSE 'no' END as r2 FROM t;
SELECT id, IIF(active, 'yes', 'no') as status FROM t ORDER BY id;
SELECT IF(val > 5, 'high', 'low') as r1 FROM t;
SELECT IIF(val > 5, 'high', 'low') as r2 FROM t;
SELECT id, DECODE(status, 'A', 'Active', 'B', 'Busy', 'C', 'Complete', 'Unknown') as desc FROM t ORDER BY id;
SELECT id, DECODE(code, 'A', 'Found') as result FROM t ORDER BY id;
SELECT id, DECODE(val, NULL, 'was null', 10, 'was ten', 'other') as desc FROM t ORDER BY id;
SELECT DECODE(val, NULL, 'match', 'no match') as r1 FROM t;
SELECT CASE val WHEN NULL THEN 'match' ELSE 'no match' END as r2 FROM t;
SELECT DECODE(val, 10, 'first', 10, 'second', 'other') as result FROM t;
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_case_when_null_condition
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:115
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL);
INSERT INTO t VALUES (1, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'active');
INSERT INTO t VALUES (2, 'inactive');
INSERT INTO t VALUES (3, 'pending');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, grade STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64, b INT64);
INSERT INTO t VALUES (1, 10, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, x INT64, y INT64);
INSERT INTO t VALUES (1, 10, 20);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64, b INT64, c INT64);
INSERT INTO t VALUES (1, 10, 20, 30);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 3);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, score INT64);
INSERT INTO t VALUES (1, 95);
INSERT INTO t VALUES (2, 75);
INSERT INTO t VALUES (3, 55);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, active BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
INSERT INTO t VALUES (4, 'D');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, code STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'Z');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
INSERT INTO t VALUES (2, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT CASE WHEN NULL THEN 'yes' ELSE 'no' END as result FROM t;
SELECT CASE
WHEN a > 5 THEN 'first'
WHEN a > 8 THEN 'second'
ELSE 'none'
END as result FROM t;
SELECT CASE
WHEN a THEN 'a'
WHEN b THEN 'b'
ELSE 'none'
END as result FROM t;
SELECT id, CASE status
WHEN 'active' THEN 1
WHEN 'inactive' THEN 0
ELSE -1
END as status_code FROM t ORDER BY id;
SELECT CASE val
WHEN NULL THEN 'match'
ELSE 'no match'
END as result FROM t;
SELECT id, CASE grade
WHEN 'A' THEN 'Excellent'
WHEN 'B' THEN 'Good'
WHEN 'C' THEN 'Average'
ELSE 'Poor'
END as description FROM t ORDER BY id;
SELECT CASE val WHEN 10 THEN 'ten' ELSE 'other' END as r1 FROM t;
SELECT CASE WHEN val = 10 THEN 'ten' ELSE 'other' END as r2 FROM t;
SELECT CASE
WHEN a > 5 THEN
CASE WHEN b > 3 THEN 'both high' ELSE 'a high only' END
ELSE 'a low'
END as result FROM t;
SELECT CASE
WHEN (CASE WHEN x > 5 THEN y ELSE 0 END) > 15 THEN 'yes'
ELSE 'no'
END as result FROM t;
SELECT CASE
WHEN a > 5 THEN
CASE WHEN b > 15 THEN
CASE WHEN c > 25 THEN 'all high' ELSE 'c low' END
ELSE 'b low' END
ELSE 'a low'
END as result FROM t;
SELECT CASE WHEN flag THEN 10 ELSE 3.14 END as val FROM t ORDER BY id;
SELECT CASE WHEN flag THEN 'text' ELSE 42 END as val FROM t;
SELECT CASE WHEN flag THEN NULL ELSE NULL END as val FROM t;
SELECT id, IF(val > 5, 'high', 'low') as category FROM t ORDER BY id;
SELECT IF(NULL, 'yes', 'no') as result FROM t;
SELECT id, IF(flag, NULL, 'no') as val FROM t ORDER BY id;
SELECT id, IF(score >= 90, 'A', IF(score >= 70, 'B', 'C')) as grade FROM t ORDER BY id;
SELECT IF(val > 5, 'yes', 'no') as r1 FROM t;
SELECT CASE WHEN val > 5 THEN 'yes' ELSE 'no' END as r2 FROM t;
SELECT id, IIF(active, 'yes', 'no') as status FROM t ORDER BY id;
SELECT IF(val > 5, 'high', 'low') as r1 FROM t;
SELECT IIF(val > 5, 'high', 'low') as r2 FROM t;
SELECT id, DECODE(status, 'A', 'Active', 'B', 'Busy', 'C', 'Complete', 'Unknown') as desc FROM t ORDER BY id;
SELECT id, DECODE(code, 'A', 'Found') as result FROM t ORDER BY id;
SELECT id, DECODE(val, NULL, 'was null', 10, 'was ten', 'other') as desc FROM t ORDER BY id;
SELECT DECODE(val, NULL, 'match', 'no match') as r1 FROM t;
SELECT CASE val WHEN NULL THEN 'match' ELSE 'no match' END as r2 FROM t;
SELECT DECODE(val, 10, 'first', 10, 'second', 'other') as result FROM t;
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_case_when_evaluates_first_true
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:133
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL);
INSERT INTO t VALUES (1, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'active');
INSERT INTO t VALUES (2, 'inactive');
INSERT INTO t VALUES (3, 'pending');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, grade STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64, b INT64);
INSERT INTO t VALUES (1, 10, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, x INT64, y INT64);
INSERT INTO t VALUES (1, 10, 20);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64, b INT64, c INT64);
INSERT INTO t VALUES (1, 10, 20, 30);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 3);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, score INT64);
INSERT INTO t VALUES (1, 95);
INSERT INTO t VALUES (2, 75);
INSERT INTO t VALUES (3, 55);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, active BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
INSERT INTO t VALUES (4, 'D');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, code STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'Z');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
INSERT INTO t VALUES (2, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT CASE
WHEN a > 5 THEN 'first'
WHEN a > 8 THEN 'second'
ELSE 'none'
END as result FROM t;
SELECT CASE
WHEN a THEN 'a'
WHEN b THEN 'b'
ELSE 'none'
END as result FROM t;
SELECT id, CASE status
WHEN 'active' THEN 1
WHEN 'inactive' THEN 0
ELSE -1
END as status_code FROM t ORDER BY id;
SELECT CASE val
WHEN NULL THEN 'match'
ELSE 'no match'
END as result FROM t;
SELECT id, CASE grade
WHEN 'A' THEN 'Excellent'
WHEN 'B' THEN 'Good'
WHEN 'C' THEN 'Average'
ELSE 'Poor'
END as description FROM t ORDER BY id;
SELECT CASE val WHEN 10 THEN 'ten' ELSE 'other' END as r1 FROM t;
SELECT CASE WHEN val = 10 THEN 'ten' ELSE 'other' END as r2 FROM t;
SELECT CASE
WHEN a > 5 THEN
CASE WHEN b > 3 THEN 'both high' ELSE 'a high only' END
ELSE 'a low'
END as result FROM t;
SELECT CASE
WHEN (CASE WHEN x > 5 THEN y ELSE 0 END) > 15 THEN 'yes'
ELSE 'no'
END as result FROM t;
SELECT CASE
WHEN a > 5 THEN
CASE WHEN b > 15 THEN
CASE WHEN c > 25 THEN 'all high' ELSE 'c low' END
ELSE 'b low' END
ELSE 'a low'
END as result FROM t;
SELECT CASE WHEN flag THEN 10 ELSE 3.14 END as val FROM t ORDER BY id;
SELECT CASE WHEN flag THEN 'text' ELSE 42 END as val FROM t;
SELECT CASE WHEN flag THEN NULL ELSE NULL END as val FROM t;
SELECT id, IF(val > 5, 'high', 'low') as category FROM t ORDER BY id;
SELECT IF(NULL, 'yes', 'no') as result FROM t;
SELECT id, IF(flag, NULL, 'no') as val FROM t ORDER BY id;
SELECT id, IF(score >= 90, 'A', IF(score >= 70, 'B', 'C')) as grade FROM t ORDER BY id;
SELECT IF(val > 5, 'yes', 'no') as r1 FROM t;
SELECT CASE WHEN val > 5 THEN 'yes' ELSE 'no' END as r2 FROM t;
SELECT id, IIF(active, 'yes', 'no') as status FROM t ORDER BY id;
SELECT IF(val > 5, 'high', 'low') as r1 FROM t;
SELECT IIF(val > 5, 'high', 'low') as r2 FROM t;
SELECT id, DECODE(status, 'A', 'Active', 'B', 'Busy', 'C', 'Complete', 'Unknown') as desc FROM t ORDER BY id;
SELECT id, DECODE(code, 'A', 'Found') as result FROM t ORDER BY id;
SELECT id, DECODE(val, NULL, 'was null', 10, 'was ten', 'other') as desc FROM t ORDER BY id;
SELECT DECODE(val, NULL, 'match', 'no match') as r1 FROM t;
SELECT CASE val WHEN NULL THEN 'match' ELSE 'no match' END as r2 FROM t;
SELECT DECODE(val, 10, 'first', 10, 'second', 'other') as result FROM t;
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_case_when_all_null_conditions
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:164
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a BOOL, b BOOL);
INSERT INTO t VALUES (1, NULL, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'active');
INSERT INTO t VALUES (2, 'inactive');
INSERT INTO t VALUES (3, 'pending');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, grade STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64, b INT64);
INSERT INTO t VALUES (1, 10, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, x INT64, y INT64);
INSERT INTO t VALUES (1, 10, 20);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64, b INT64, c INT64);
INSERT INTO t VALUES (1, 10, 20, 30);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 3);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, score INT64);
INSERT INTO t VALUES (1, 95);
INSERT INTO t VALUES (2, 75);
INSERT INTO t VALUES (3, 55);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, active BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
INSERT INTO t VALUES (4, 'D');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, code STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'Z');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
INSERT INTO t VALUES (2, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT CASE
WHEN a THEN 'a'
WHEN b THEN 'b'
ELSE 'none'
END as result FROM t;
SELECT id, CASE status
WHEN 'active' THEN 1
WHEN 'inactive' THEN 0
ELSE -1
END as status_code FROM t ORDER BY id;
SELECT CASE val
WHEN NULL THEN 'match'
ELSE 'no match'
END as result FROM t;
SELECT id, CASE grade
WHEN 'A' THEN 'Excellent'
WHEN 'B' THEN 'Good'
WHEN 'C' THEN 'Average'
ELSE 'Poor'
END as description FROM t ORDER BY id;
SELECT CASE val WHEN 10 THEN 'ten' ELSE 'other' END as r1 FROM t;
SELECT CASE WHEN val = 10 THEN 'ten' ELSE 'other' END as r2 FROM t;
SELECT CASE
WHEN a > 5 THEN
CASE WHEN b > 3 THEN 'both high' ELSE 'a high only' END
ELSE 'a low'
END as result FROM t;
SELECT CASE
WHEN (CASE WHEN x > 5 THEN y ELSE 0 END) > 15 THEN 'yes'
ELSE 'no'
END as result FROM t;
SELECT CASE
WHEN a > 5 THEN
CASE WHEN b > 15 THEN
CASE WHEN c > 25 THEN 'all high' ELSE 'c low' END
ELSE 'b low' END
ELSE 'a low'
END as result FROM t;
SELECT CASE WHEN flag THEN 10 ELSE 3.14 END as val FROM t ORDER BY id;
SELECT CASE WHEN flag THEN 'text' ELSE 42 END as val FROM t;
SELECT CASE WHEN flag THEN NULL ELSE NULL END as val FROM t;
SELECT id, IF(val > 5, 'high', 'low') as category FROM t ORDER BY id;
SELECT IF(NULL, 'yes', 'no') as result FROM t;
SELECT id, IF(flag, NULL, 'no') as val FROM t ORDER BY id;
SELECT id, IF(score >= 90, 'A', IF(score >= 70, 'B', 'C')) as grade FROM t ORDER BY id;
SELECT IF(val > 5, 'yes', 'no') as r1 FROM t;
SELECT CASE WHEN val > 5 THEN 'yes' ELSE 'no' END as r2 FROM t;
SELECT id, IIF(active, 'yes', 'no') as status FROM t ORDER BY id;
SELECT IF(val > 5, 'high', 'low') as r1 FROM t;
SELECT IIF(val > 5, 'high', 'low') as r2 FROM t;
SELECT id, DECODE(status, 'A', 'Active', 'B', 'Busy', 'C', 'Complete', 'Unknown') as desc FROM t ORDER BY id;
SELECT id, DECODE(code, 'A', 'Found') as result FROM t ORDER BY id;
SELECT id, DECODE(val, NULL, 'was null', 10, 'was ten', 'other') as desc FROM t ORDER BY id;
SELECT DECODE(val, NULL, 'match', 'no match') as r1 FROM t;
SELECT CASE val WHEN NULL THEN 'match' ELSE 'no match' END as r2 FROM t;
SELECT DECODE(val, 10, 'first', 10, 'second', 'other') as result FROM t;
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_case_simple_form_basic
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:196
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'active');
INSERT INTO t VALUES (2, 'inactive');
INSERT INTO t VALUES (3, 'pending');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, grade STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64, b INT64);
INSERT INTO t VALUES (1, 10, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, x INT64, y INT64);
INSERT INTO t VALUES (1, 10, 20);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64, b INT64, c INT64);
INSERT INTO t VALUES (1, 10, 20, 30);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 3);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, score INT64);
INSERT INTO t VALUES (1, 95);
INSERT INTO t VALUES (2, 75);
INSERT INTO t VALUES (3, 55);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, active BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
INSERT INTO t VALUES (4, 'D');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, code STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'Z');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
INSERT INTO t VALUES (2, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT id, CASE status
WHEN 'active' THEN 1
WHEN 'inactive' THEN 0
ELSE -1
END as status_code FROM t ORDER BY id;
SELECT CASE val
WHEN NULL THEN 'match'
ELSE 'no match'
END as result FROM t;
SELECT id, CASE grade
WHEN 'A' THEN 'Excellent'
WHEN 'B' THEN 'Good'
WHEN 'C' THEN 'Average'
ELSE 'Poor'
END as description FROM t ORDER BY id;
SELECT CASE val WHEN 10 THEN 'ten' ELSE 'other' END as r1 FROM t;
SELECT CASE WHEN val = 10 THEN 'ten' ELSE 'other' END as r2 FROM t;
SELECT CASE
WHEN a > 5 THEN
CASE WHEN b > 3 THEN 'both high' ELSE 'a high only' END
ELSE 'a low'
END as result FROM t;
SELECT CASE
WHEN (CASE WHEN x > 5 THEN y ELSE 0 END) > 15 THEN 'yes'
ELSE 'no'
END as result FROM t;
SELECT CASE
WHEN a > 5 THEN
CASE WHEN b > 15 THEN
CASE WHEN c > 25 THEN 'all high' ELSE 'c low' END
ELSE 'b low' END
ELSE 'a low'
END as result FROM t;
SELECT CASE WHEN flag THEN 10 ELSE 3.14 END as val FROM t ORDER BY id;
SELECT CASE WHEN flag THEN 'text' ELSE 42 END as val FROM t;
SELECT CASE WHEN flag THEN NULL ELSE NULL END as val FROM t;
SELECT id, IF(val > 5, 'high', 'low') as category FROM t ORDER BY id;
SELECT IF(NULL, 'yes', 'no') as result FROM t;
SELECT id, IF(flag, NULL, 'no') as val FROM t ORDER BY id;
SELECT id, IF(score >= 90, 'A', IF(score >= 70, 'B', 'C')) as grade FROM t ORDER BY id;
SELECT IF(val > 5, 'yes', 'no') as r1 FROM t;
SELECT CASE WHEN val > 5 THEN 'yes' ELSE 'no' END as r2 FROM t;
SELECT id, IIF(active, 'yes', 'no') as status FROM t ORDER BY id;
SELECT IF(val > 5, 'high', 'low') as r1 FROM t;
SELECT IIF(val > 5, 'high', 'low') as r2 FROM t;
SELECT id, DECODE(status, 'A', 'Active', 'B', 'Busy', 'C', 'Complete', 'Unknown') as desc FROM t ORDER BY id;
SELECT id, DECODE(code, 'A', 'Found') as result FROM t ORDER BY id;
SELECT id, DECODE(val, NULL, 'was null', 10, 'was ten', 'other') as desc FROM t ORDER BY id;
SELECT DECODE(val, NULL, 'match', 'no match') as r1 FROM t;
SELECT CASE val WHEN NULL THEN 'match' ELSE 'no match' END as r2 FROM t;
SELECT DECODE(val, 10, 'first', 10, 'second', 'other') as result FROM t;
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_case_simple_form_null_match
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:238
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, grade STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64, b INT64);
INSERT INTO t VALUES (1, 10, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, x INT64, y INT64);
INSERT INTO t VALUES (1, 10, 20);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64, b INT64, c INT64);
INSERT INTO t VALUES (1, 10, 20, 30);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 3);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, score INT64);
INSERT INTO t VALUES (1, 95);
INSERT INTO t VALUES (2, 75);
INSERT INTO t VALUES (3, 55);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, active BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
INSERT INTO t VALUES (4, 'D');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, code STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'Z');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
INSERT INTO t VALUES (2, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT CASE val
WHEN NULL THEN 'match'
ELSE 'no match'
END as result FROM t;
SELECT id, CASE grade
WHEN 'A' THEN 'Excellent'
WHEN 'B' THEN 'Good'
WHEN 'C' THEN 'Average'
ELSE 'Poor'
END as description FROM t ORDER BY id;
SELECT CASE val WHEN 10 THEN 'ten' ELSE 'other' END as r1 FROM t;
SELECT CASE WHEN val = 10 THEN 'ten' ELSE 'other' END as r2 FROM t;
SELECT CASE
WHEN a > 5 THEN
CASE WHEN b > 3 THEN 'both high' ELSE 'a high only' END
ELSE 'a low'
END as result FROM t;
SELECT CASE
WHEN (CASE WHEN x > 5 THEN y ELSE 0 END) > 15 THEN 'yes'
ELSE 'no'
END as result FROM t;
SELECT CASE
WHEN a > 5 THEN
CASE WHEN b > 15 THEN
CASE WHEN c > 25 THEN 'all high' ELSE 'c low' END
ELSE 'b low' END
ELSE 'a low'
END as result FROM t;
SELECT CASE WHEN flag THEN 10 ELSE 3.14 END as val FROM t ORDER BY id;
SELECT CASE WHEN flag THEN 'text' ELSE 42 END as val FROM t;
SELECT CASE WHEN flag THEN NULL ELSE NULL END as val FROM t;
SELECT id, IF(val > 5, 'high', 'low') as category FROM t ORDER BY id;
SELECT IF(NULL, 'yes', 'no') as result FROM t;
SELECT id, IF(flag, NULL, 'no') as val FROM t ORDER BY id;
SELECT id, IF(score >= 90, 'A', IF(score >= 70, 'B', 'C')) as grade FROM t ORDER BY id;
SELECT IF(val > 5, 'yes', 'no') as r1 FROM t;
SELECT CASE WHEN val > 5 THEN 'yes' ELSE 'no' END as r2 FROM t;
SELECT id, IIF(active, 'yes', 'no') as status FROM t ORDER BY id;
SELECT IF(val > 5, 'high', 'low') as r1 FROM t;
SELECT IIF(val > 5, 'high', 'low') as r2 FROM t;
SELECT id, DECODE(status, 'A', 'Active', 'B', 'Busy', 'C', 'Complete', 'Unknown') as desc FROM t ORDER BY id;
SELECT id, DECODE(code, 'A', 'Found') as result FROM t ORDER BY id;
SELECT id, DECODE(val, NULL, 'was null', 10, 'was ten', 'other') as desc FROM t ORDER BY id;
SELECT DECODE(val, NULL, 'match', 'no match') as r1 FROM t;
SELECT CASE val WHEN NULL THEN 'match' ELSE 'no match' END as r2 FROM t;
SELECT DECODE(val, 10, 'first', 10, 'second', 'other') as result FROM t;
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_case_simple_form_multiple_when
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:268
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, grade STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64, b INT64);
INSERT INTO t VALUES (1, 10, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, x INT64, y INT64);
INSERT INTO t VALUES (1, 10, 20);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64, b INT64, c INT64);
INSERT INTO t VALUES (1, 10, 20, 30);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 3);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, score INT64);
INSERT INTO t VALUES (1, 95);
INSERT INTO t VALUES (2, 75);
INSERT INTO t VALUES (3, 55);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, active BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
INSERT INTO t VALUES (4, 'D');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, code STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'Z');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
INSERT INTO t VALUES (2, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT id, CASE grade
WHEN 'A' THEN 'Excellent'
WHEN 'B' THEN 'Good'
WHEN 'C' THEN 'Average'
ELSE 'Poor'
END as description FROM t ORDER BY id;
SELECT CASE val WHEN 10 THEN 'ten' ELSE 'other' END as r1 FROM t;
SELECT CASE WHEN val = 10 THEN 'ten' ELSE 'other' END as r2 FROM t;
SELECT CASE
WHEN a > 5 THEN
CASE WHEN b > 3 THEN 'both high' ELSE 'a high only' END
ELSE 'a low'
END as result FROM t;
SELECT CASE
WHEN (CASE WHEN x > 5 THEN y ELSE 0 END) > 15 THEN 'yes'
ELSE 'no'
END as result FROM t;
SELECT CASE
WHEN a > 5 THEN
CASE WHEN b > 15 THEN
CASE WHEN c > 25 THEN 'all high' ELSE 'c low' END
ELSE 'b low' END
ELSE 'a low'
END as result FROM t;
SELECT CASE WHEN flag THEN 10 ELSE 3.14 END as val FROM t ORDER BY id;
SELECT CASE WHEN flag THEN 'text' ELSE 42 END as val FROM t;
SELECT CASE WHEN flag THEN NULL ELSE NULL END as val FROM t;
SELECT id, IF(val > 5, 'high', 'low') as category FROM t ORDER BY id;
SELECT IF(NULL, 'yes', 'no') as result FROM t;
SELECT id, IF(flag, NULL, 'no') as val FROM t ORDER BY id;
SELECT id, IF(score >= 90, 'A', IF(score >= 70, 'B', 'C')) as grade FROM t ORDER BY id;
SELECT IF(val > 5, 'yes', 'no') as r1 FROM t;
SELECT CASE WHEN val > 5 THEN 'yes' ELSE 'no' END as r2 FROM t;
SELECT id, IIF(active, 'yes', 'no') as status FROM t ORDER BY id;
SELECT IF(val > 5, 'high', 'low') as r1 FROM t;
SELECT IIF(val > 5, 'high', 'low') as r2 FROM t;
SELECT id, DECODE(status, 'A', 'Active', 'B', 'Busy', 'C', 'Complete', 'Unknown') as desc FROM t ORDER BY id;
SELECT id, DECODE(code, 'A', 'Found') as result FROM t ORDER BY id;
SELECT id, DECODE(val, NULL, 'was null', 10, 'was ten', 'other') as desc FROM t ORDER BY id;
SELECT DECODE(val, NULL, 'match', 'no match') as r1 FROM t;
SELECT CASE val WHEN NULL THEN 'match' ELSE 'no match' END as r2 FROM t;
SELECT DECODE(val, 10, 'first', 10, 'second', 'other') as result FROM t;
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_case_simple_vs_searched_form
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:305
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64, b INT64);
INSERT INTO t VALUES (1, 10, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, x INT64, y INT64);
INSERT INTO t VALUES (1, 10, 20);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64, b INT64, c INT64);
INSERT INTO t VALUES (1, 10, 20, 30);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 3);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, score INT64);
INSERT INTO t VALUES (1, 95);
INSERT INTO t VALUES (2, 75);
INSERT INTO t VALUES (3, 55);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, active BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
INSERT INTO t VALUES (4, 'D');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, code STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'Z');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
INSERT INTO t VALUES (2, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT CASE val WHEN 10 THEN 'ten' ELSE 'other' END as r1 FROM t;
SELECT CASE WHEN val = 10 THEN 'ten' ELSE 'other' END as r2 FROM t;
SELECT CASE
WHEN a > 5 THEN
CASE WHEN b > 3 THEN 'both high' ELSE 'a high only' END
ELSE 'a low'
END as result FROM t;
SELECT CASE
WHEN (CASE WHEN x > 5 THEN y ELSE 0 END) > 15 THEN 'yes'
ELSE 'no'
END as result FROM t;
SELECT CASE
WHEN a > 5 THEN
CASE WHEN b > 15 THEN
CASE WHEN c > 25 THEN 'all high' ELSE 'c low' END
ELSE 'b low' END
ELSE 'a low'
END as result FROM t;
SELECT CASE WHEN flag THEN 10 ELSE 3.14 END as val FROM t ORDER BY id;
SELECT CASE WHEN flag THEN 'text' ELSE 42 END as val FROM t;
SELECT CASE WHEN flag THEN NULL ELSE NULL END as val FROM t;
SELECT id, IF(val > 5, 'high', 'low') as category FROM t ORDER BY id;
SELECT IF(NULL, 'yes', 'no') as result FROM t;
SELECT id, IF(flag, NULL, 'no') as val FROM t ORDER BY id;
SELECT id, IF(score >= 90, 'A', IF(score >= 70, 'B', 'C')) as grade FROM t ORDER BY id;
SELECT IF(val > 5, 'yes', 'no') as r1 FROM t;
SELECT CASE WHEN val > 5 THEN 'yes' ELSE 'no' END as r2 FROM t;
SELECT id, IIF(active, 'yes', 'no') as status FROM t ORDER BY id;
SELECT IF(val > 5, 'high', 'low') as r1 FROM t;
SELECT IIF(val > 5, 'high', 'low') as r2 FROM t;
SELECT id, DECODE(status, 'A', 'Active', 'B', 'Busy', 'C', 'Complete', 'Unknown') as desc FROM t ORDER BY id;
SELECT id, DECODE(code, 'A', 'Found') as result FROM t ORDER BY id;
SELECT id, DECODE(val, NULL, 'was null', 10, 'was ten', 'other') as desc FROM t ORDER BY id;
SELECT DECODE(val, NULL, 'match', 'no match') as r1 FROM t;
SELECT CASE val WHEN NULL THEN 'match' ELSE 'no match' END as r2 FROM t;
SELECT DECODE(val, 10, 'first', 10, 'second', 'other') as result FROM t;
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_nested_case_in_then
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:337
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64, b INT64);
INSERT INTO t VALUES (1, 10, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, x INT64, y INT64);
INSERT INTO t VALUES (1, 10, 20);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64, b INT64, c INT64);
INSERT INTO t VALUES (1, 10, 20, 30);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 3);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, score INT64);
INSERT INTO t VALUES (1, 95);
INSERT INTO t VALUES (2, 75);
INSERT INTO t VALUES (3, 55);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, active BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
INSERT INTO t VALUES (4, 'D');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, code STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'Z');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
INSERT INTO t VALUES (2, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT CASE
WHEN a > 5 THEN
CASE WHEN b > 3 THEN 'both high' ELSE 'a high only' END
ELSE 'a low'
END as result FROM t;
SELECT CASE
WHEN (CASE WHEN x > 5 THEN y ELSE 0 END) > 15 THEN 'yes'
ELSE 'no'
END as result FROM t;
SELECT CASE
WHEN a > 5 THEN
CASE WHEN b > 15 THEN
CASE WHEN c > 25 THEN 'all high' ELSE 'c low' END
ELSE 'b low' END
ELSE 'a low'
END as result FROM t;
SELECT CASE WHEN flag THEN 10 ELSE 3.14 END as val FROM t ORDER BY id;
SELECT CASE WHEN flag THEN 'text' ELSE 42 END as val FROM t;
SELECT CASE WHEN flag THEN NULL ELSE NULL END as val FROM t;
SELECT id, IF(val > 5, 'high', 'low') as category FROM t ORDER BY id;
SELECT IF(NULL, 'yes', 'no') as result FROM t;
SELECT id, IF(flag, NULL, 'no') as val FROM t ORDER BY id;
SELECT id, IF(score >= 90, 'A', IF(score >= 70, 'B', 'C')) as grade FROM t ORDER BY id;
SELECT IF(val > 5, 'yes', 'no') as r1 FROM t;
SELECT CASE WHEN val > 5 THEN 'yes' ELSE 'no' END as r2 FROM t;
SELECT id, IIF(active, 'yes', 'no') as status FROM t ORDER BY id;
SELECT IF(val > 5, 'high', 'low') as r1 FROM t;
SELECT IIF(val > 5, 'high', 'low') as r2 FROM t;
SELECT id, DECODE(status, 'A', 'Active', 'B', 'Busy', 'C', 'Complete', 'Unknown') as desc FROM t ORDER BY id;
SELECT id, DECODE(code, 'A', 'Found') as result FROM t ORDER BY id;
SELECT id, DECODE(val, NULL, 'was null', 10, 'was ten', 'other') as desc FROM t ORDER BY id;
SELECT DECODE(val, NULL, 'match', 'no match') as r1 FROM t;
SELECT CASE val WHEN NULL THEN 'match' ELSE 'no match' END as r2 FROM t;
SELECT DECODE(val, 10, 'first', 10, 'second', 'other') as result FROM t;
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_nested_case_in_when_condition
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:365
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, x INT64, y INT64);
INSERT INTO t VALUES (1, 10, 20);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64, b INT64, c INT64);
INSERT INTO t VALUES (1, 10, 20, 30);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 3);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, score INT64);
INSERT INTO t VALUES (1, 95);
INSERT INTO t VALUES (2, 75);
INSERT INTO t VALUES (3, 55);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, active BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
INSERT INTO t VALUES (4, 'D');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, code STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'Z');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
INSERT INTO t VALUES (2, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT CASE
WHEN (CASE WHEN x > 5 THEN y ELSE 0 END) > 15 THEN 'yes'
ELSE 'no'
END as result FROM t;
SELECT CASE
WHEN a > 5 THEN
CASE WHEN b > 15 THEN
CASE WHEN c > 25 THEN 'all high' ELSE 'c low' END
ELSE 'b low' END
ELSE 'a low'
END as result FROM t;
SELECT CASE WHEN flag THEN 10 ELSE 3.14 END as val FROM t ORDER BY id;
SELECT CASE WHEN flag THEN 'text' ELSE 42 END as val FROM t;
SELECT CASE WHEN flag THEN NULL ELSE NULL END as val FROM t;
SELECT id, IF(val > 5, 'high', 'low') as category FROM t ORDER BY id;
SELECT IF(NULL, 'yes', 'no') as result FROM t;
SELECT id, IF(flag, NULL, 'no') as val FROM t ORDER BY id;
SELECT id, IF(score >= 90, 'A', IF(score >= 70, 'B', 'C')) as grade FROM t ORDER BY id;
SELECT IF(val > 5, 'yes', 'no') as r1 FROM t;
SELECT CASE WHEN val > 5 THEN 'yes' ELSE 'no' END as r2 FROM t;
SELECT id, IIF(active, 'yes', 'no') as status FROM t ORDER BY id;
SELECT IF(val > 5, 'high', 'low') as r1 FROM t;
SELECT IIF(val > 5, 'high', 'low') as r2 FROM t;
SELECT id, DECODE(status, 'A', 'Active', 'B', 'Busy', 'C', 'Complete', 'Unknown') as desc FROM t ORDER BY id;
SELECT id, DECODE(code, 'A', 'Found') as result FROM t ORDER BY id;
SELECT id, DECODE(val, NULL, 'was null', 10, 'was ten', 'other') as desc FROM t ORDER BY id;
SELECT DECODE(val, NULL, 'match', 'no match') as r1 FROM t;
SELECT CASE val WHEN NULL THEN 'match' ELSE 'no match' END as r2 FROM t;
SELECT DECODE(val, 10, 'first', 10, 'second', 'other') as result FROM t;
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_deeply_nested_case
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:393
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, a INT64, b INT64, c INT64);
INSERT INTO t VALUES (1, 10, 20, 30);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 3);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, score INT64);
INSERT INTO t VALUES (1, 95);
INSERT INTO t VALUES (2, 75);
INSERT INTO t VALUES (3, 55);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, active BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
INSERT INTO t VALUES (4, 'D');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, code STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'Z');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
INSERT INTO t VALUES (2, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT CASE
WHEN a > 5 THEN
CASE WHEN b > 15 THEN
CASE WHEN c > 25 THEN 'all high' ELSE 'c low' END
ELSE 'b low' END
ELSE 'a low'
END as result FROM t;
SELECT CASE WHEN flag THEN 10 ELSE 3.14 END as val FROM t ORDER BY id;
SELECT CASE WHEN flag THEN 'text' ELSE 42 END as val FROM t;
SELECT CASE WHEN flag THEN NULL ELSE NULL END as val FROM t;
SELECT id, IF(val > 5, 'high', 'low') as category FROM t ORDER BY id;
SELECT IF(NULL, 'yes', 'no') as result FROM t;
SELECT id, IF(flag, NULL, 'no') as val FROM t ORDER BY id;
SELECT id, IF(score >= 90, 'A', IF(score >= 70, 'B', 'C')) as grade FROM t ORDER BY id;
SELECT IF(val > 5, 'yes', 'no') as r1 FROM t;
SELECT CASE WHEN val > 5 THEN 'yes' ELSE 'no' END as r2 FROM t;
SELECT id, IIF(active, 'yes', 'no') as status FROM t ORDER BY id;
SELECT IF(val > 5, 'high', 'low') as r1 FROM t;
SELECT IIF(val > 5, 'high', 'low') as r2 FROM t;
SELECT id, DECODE(status, 'A', 'Active', 'B', 'Busy', 'C', 'Complete', 'Unknown') as desc FROM t ORDER BY id;
SELECT id, DECODE(code, 'A', 'Found') as result FROM t ORDER BY id;
SELECT id, DECODE(val, NULL, 'was null', 10, 'was ten', 'other') as desc FROM t ORDER BY id;
SELECT DECODE(val, NULL, 'match', 'no match') as r1 FROM t;
SELECT CASE val WHEN NULL THEN 'match' ELSE 'no match' END as r2 FROM t;
SELECT DECODE(val, 10, 'first', 10, 'second', 'other') as result FROM t;
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_case_type_coercion_int_to_float
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:427
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 3);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, score INT64);
INSERT INTO t VALUES (1, 95);
INSERT INTO t VALUES (2, 75);
INSERT INTO t VALUES (3, 55);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, active BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
INSERT INTO t VALUES (4, 'D');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, code STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'Z');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
INSERT INTO t VALUES (2, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT CASE WHEN flag THEN 10 ELSE 3.14 END as val FROM t ORDER BY id;
SELECT CASE WHEN flag THEN 'text' ELSE 42 END as val FROM t;
SELECT CASE WHEN flag THEN NULL ELSE NULL END as val FROM t;
SELECT id, IF(val > 5, 'high', 'low') as category FROM t ORDER BY id;
SELECT IF(NULL, 'yes', 'no') as result FROM t;
SELECT id, IF(flag, NULL, 'no') as val FROM t ORDER BY id;
SELECT id, IF(score >= 90, 'A', IF(score >= 70, 'B', 'C')) as grade FROM t ORDER BY id;
SELECT IF(val > 5, 'yes', 'no') as r1 FROM t;
SELECT CASE WHEN val > 5 THEN 'yes' ELSE 'no' END as r2 FROM t;
SELECT id, IIF(active, 'yes', 'no') as status FROM t ORDER BY id;
SELECT IF(val > 5, 'high', 'low') as r1 FROM t;
SELECT IIF(val > 5, 'high', 'low') as r2 FROM t;
SELECT id, DECODE(status, 'A', 'Active', 'B', 'Busy', 'C', 'Complete', 'Unknown') as desc FROM t ORDER BY id;
SELECT id, DECODE(code, 'A', 'Found') as result FROM t ORDER BY id;
SELECT id, DECODE(val, NULL, 'was null', 10, 'was ten', 'other') as desc FROM t ORDER BY id;
SELECT DECODE(val, NULL, 'match', 'no match') as r1 FROM t;
SELECT CASE val WHEN NULL THEN 'match' ELSE 'no match' END as r2 FROM t;
SELECT DECODE(val, 10, 'first', 10, 'second', 'other') as result FROM t;
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_case_incompatible_types_error
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:454
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 3);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, score INT64);
INSERT INTO t VALUES (1, 95);
INSERT INTO t VALUES (2, 75);
INSERT INTO t VALUES (3, 55);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, active BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
INSERT INTO t VALUES (4, 'D');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, code STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'Z');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
INSERT INTO t VALUES (2, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT CASE WHEN flag THEN 'text' ELSE 42 END as val FROM t;
SELECT CASE WHEN flag THEN NULL ELSE NULL END as val FROM t;
SELECT id, IF(val > 5, 'high', 'low') as category FROM t ORDER BY id;
SELECT IF(NULL, 'yes', 'no') as result FROM t;
SELECT id, IF(flag, NULL, 'no') as val FROM t ORDER BY id;
SELECT id, IF(score >= 90, 'A', IF(score >= 70, 'B', 'C')) as grade FROM t ORDER BY id;
SELECT IF(val > 5, 'yes', 'no') as r1 FROM t;
SELECT CASE WHEN val > 5 THEN 'yes' ELSE 'no' END as r2 FROM t;
SELECT id, IIF(active, 'yes', 'no') as status FROM t ORDER BY id;
SELECT IF(val > 5, 'high', 'low') as r1 FROM t;
SELECT IIF(val > 5, 'high', 'low') as r2 FROM t;
SELECT id, DECODE(status, 'A', 'Active', 'B', 'Busy', 'C', 'Complete', 'Unknown') as desc FROM t ORDER BY id;
SELECT id, DECODE(code, 'A', 'Found') as result FROM t ORDER BY id;
SELECT id, DECODE(val, NULL, 'was null', 10, 'was ten', 'other') as desc FROM t ORDER BY id;
SELECT DECODE(val, NULL, 'match', 'no match') as r1 FROM t;
SELECT CASE val WHEN NULL THEN 'match' ELSE 'no match' END as r2 FROM t;
SELECT DECODE(val, 10, 'first', 10, 'second', 'other') as result FROM t;
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_case_all_branches_null
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:478
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 3);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, score INT64);
INSERT INTO t VALUES (1, 95);
INSERT INTO t VALUES (2, 75);
INSERT INTO t VALUES (3, 55);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, active BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
INSERT INTO t VALUES (4, 'D');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, code STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'Z');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
INSERT INTO t VALUES (2, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT CASE WHEN flag THEN NULL ELSE NULL END as val FROM t;
SELECT id, IF(val > 5, 'high', 'low') as category FROM t ORDER BY id;
SELECT IF(NULL, 'yes', 'no') as result FROM t;
SELECT id, IF(flag, NULL, 'no') as val FROM t ORDER BY id;
SELECT id, IF(score >= 90, 'A', IF(score >= 70, 'B', 'C')) as grade FROM t ORDER BY id;
SELECT IF(val > 5, 'yes', 'no') as r1 FROM t;
SELECT CASE WHEN val > 5 THEN 'yes' ELSE 'no' END as r2 FROM t;
SELECT id, IIF(active, 'yes', 'no') as status FROM t ORDER BY id;
SELECT IF(val > 5, 'high', 'low') as r1 FROM t;
SELECT IIF(val > 5, 'high', 'low') as r2 FROM t;
SELECT id, DECODE(status, 'A', 'Active', 'B', 'Busy', 'C', 'Complete', 'Unknown') as desc FROM t ORDER BY id;
SELECT id, DECODE(code, 'A', 'Found') as result FROM t ORDER BY id;
SELECT id, DECODE(val, NULL, 'was null', 10, 'was ten', 'other') as desc FROM t ORDER BY id;
SELECT DECODE(val, NULL, 'match', 'no match') as r1 FROM t;
SELECT CASE val WHEN NULL THEN 'match' ELSE 'no match' END as r2 FROM t;
SELECT DECODE(val, 10, 'first', 10, 'second', 'other') as result FROM t;
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_if_function_basic
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:508
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 3);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, score INT64);
INSERT INTO t VALUES (1, 95);
INSERT INTO t VALUES (2, 75);
INSERT INTO t VALUES (3, 55);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, active BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
INSERT INTO t VALUES (4, 'D');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, code STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'Z');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
INSERT INTO t VALUES (2, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT id, IF(val > 5, 'high', 'low') as category FROM t ORDER BY id;
SELECT IF(NULL, 'yes', 'no') as result FROM t;
SELECT id, IF(flag, NULL, 'no') as val FROM t ORDER BY id;
SELECT id, IF(score >= 90, 'A', IF(score >= 70, 'B', 'C')) as grade FROM t ORDER BY id;
SELECT IF(val > 5, 'yes', 'no') as r1 FROM t;
SELECT CASE WHEN val > 5 THEN 'yes' ELSE 'no' END as r2 FROM t;
SELECT id, IIF(active, 'yes', 'no') as status FROM t ORDER BY id;
SELECT IF(val > 5, 'high', 'low') as r1 FROM t;
SELECT IIF(val > 5, 'high', 'low') as r2 FROM t;
SELECT id, DECODE(status, 'A', 'Active', 'B', 'Busy', 'C', 'Complete', 'Unknown') as desc FROM t ORDER BY id;
SELECT id, DECODE(code, 'A', 'Found') as result FROM t ORDER BY id;
SELECT id, DECODE(val, NULL, 'was null', 10, 'was ten', 'other') as desc FROM t ORDER BY id;
SELECT DECODE(val, NULL, 'match', 'no match') as r1 FROM t;
SELECT CASE val WHEN NULL THEN 'match' ELSE 'no match' END as r2 FROM t;
SELECT DECODE(val, 10, 'first', 10, 'second', 'other') as result FROM t;
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_if_function_null_condition
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:534
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64);
INSERT INTO t VALUES (1);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, score INT64);
INSERT INTO t VALUES (1, 95);
INSERT INTO t VALUES (2, 75);
INSERT INTO t VALUES (3, 55);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, active BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
INSERT INTO t VALUES (4, 'D');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, code STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'Z');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
INSERT INTO t VALUES (2, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT IF(NULL, 'yes', 'no') as result FROM t;
SELECT id, IF(flag, NULL, 'no') as val FROM t ORDER BY id;
SELECT id, IF(score >= 90, 'A', IF(score >= 70, 'B', 'C')) as grade FROM t ORDER BY id;
SELECT IF(val > 5, 'yes', 'no') as r1 FROM t;
SELECT CASE WHEN val > 5 THEN 'yes' ELSE 'no' END as r2 FROM t;
SELECT id, IIF(active, 'yes', 'no') as status FROM t ORDER BY id;
SELECT IF(val > 5, 'high', 'low') as r1 FROM t;
SELECT IIF(val > 5, 'high', 'low') as r2 FROM t;
SELECT id, DECODE(status, 'A', 'Active', 'B', 'Busy', 'C', 'Complete', 'Unknown') as desc FROM t ORDER BY id;
SELECT id, DECODE(code, 'A', 'Found') as result FROM t ORDER BY id;
SELECT id, DECODE(val, NULL, 'was null', 10, 'was ten', 'other') as desc FROM t ORDER BY id;
SELECT DECODE(val, NULL, 'match', 'no match') as r1 FROM t;
SELECT CASE val WHEN NULL THEN 'match' ELSE 'no match' END as r2 FROM t;
SELECT DECODE(val, 10, 'first', 10, 'second', 'other') as result FROM t;
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_if_function_null_results
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:552
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, flag BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, score INT64);
INSERT INTO t VALUES (1, 95);
INSERT INTO t VALUES (2, 75);
INSERT INTO t VALUES (3, 55);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, active BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
INSERT INTO t VALUES (4, 'D');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, code STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'Z');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
INSERT INTO t VALUES (2, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT id, IF(flag, NULL, 'no') as val FROM t ORDER BY id;
SELECT id, IF(score >= 90, 'A', IF(score >= 70, 'B', 'C')) as grade FROM t ORDER BY id;
SELECT IF(val > 5, 'yes', 'no') as r1 FROM t;
SELECT CASE WHEN val > 5 THEN 'yes' ELSE 'no' END as r2 FROM t;
SELECT id, IIF(active, 'yes', 'no') as status FROM t ORDER BY id;
SELECT IF(val > 5, 'high', 'low') as r1 FROM t;
SELECT IIF(val > 5, 'high', 'low') as r2 FROM t;
SELECT id, DECODE(status, 'A', 'Active', 'B', 'Busy', 'C', 'Complete', 'Unknown') as desc FROM t ORDER BY id;
SELECT id, DECODE(code, 'A', 'Found') as result FROM t ORDER BY id;
SELECT id, DECODE(val, NULL, 'was null', 10, 'was ten', 'other') as desc FROM t ORDER BY id;
SELECT DECODE(val, NULL, 'match', 'no match') as r1 FROM t;
SELECT CASE val WHEN NULL THEN 'match' ELSE 'no match' END as r2 FROM t;
SELECT DECODE(val, 10, 'first', 10, 'second', 'other') as result FROM t;
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_if_function_nested
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:577
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, score INT64);
INSERT INTO t VALUES (1, 95);
INSERT INTO t VALUES (2, 75);
INSERT INTO t VALUES (3, 55);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, active BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
INSERT INTO t VALUES (4, 'D');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, code STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'Z');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
INSERT INTO t VALUES (2, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT id, IF(score >= 90, 'A', IF(score >= 70, 'B', 'C')) as grade FROM t ORDER BY id;
SELECT IF(val > 5, 'yes', 'no') as r1 FROM t;
SELECT CASE WHEN val > 5 THEN 'yes' ELSE 'no' END as r2 FROM t;
SELECT id, IIF(active, 'yes', 'no') as status FROM t ORDER BY id;
SELECT IF(val > 5, 'high', 'low') as r1 FROM t;
SELECT IIF(val > 5, 'high', 'low') as r2 FROM t;
SELECT id, DECODE(status, 'A', 'Active', 'B', 'Busy', 'C', 'Complete', 'Unknown') as desc FROM t ORDER BY id;
SELECT id, DECODE(code, 'A', 'Found') as result FROM t ORDER BY id;
SELECT id, DECODE(val, NULL, 'was null', 10, 'was ten', 'other') as desc FROM t ORDER BY id;
SELECT DECODE(val, NULL, 'match', 'no match') as r1 FROM t;
SELECT CASE val WHEN NULL THEN 'match' ELSE 'no match' END as r2 FROM t;
SELECT DECODE(val, 10, 'first', 10, 'second', 'other') as result FROM t;
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_if_vs_case_when_equivalence
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:608
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, active BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
INSERT INTO t VALUES (4, 'D');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, code STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'Z');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
INSERT INTO t VALUES (2, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT IF(val > 5, 'yes', 'no') as r1 FROM t;
SELECT CASE WHEN val > 5 THEN 'yes' ELSE 'no' END as r2 FROM t;
SELECT id, IIF(active, 'yes', 'no') as status FROM t ORDER BY id;
SELECT IF(val > 5, 'high', 'low') as r1 FROM t;
SELECT IIF(val > 5, 'high', 'low') as r2 FROM t;
SELECT id, DECODE(status, 'A', 'Active', 'B', 'Busy', 'C', 'Complete', 'Unknown') as desc FROM t ORDER BY id;
SELECT id, DECODE(code, 'A', 'Found') as result FROM t ORDER BY id;
SELECT id, DECODE(val, NULL, 'was null', 10, 'was ten', 'other') as desc FROM t ORDER BY id;
SELECT DECODE(val, NULL, 'match', 'no match') as r1 FROM t;
SELECT CASE val WHEN NULL THEN 'match' ELSE 'no match' END as r2 FROM t;
SELECT DECODE(val, 10, 'first', 10, 'second', 'other') as result FROM t;
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_iif_function_basic
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:640
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, active BOOL);
INSERT INTO t VALUES (1, TRUE);
INSERT INTO t VALUES (2, FALSE);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
INSERT INTO t VALUES (4, 'D');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, code STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'Z');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
INSERT INTO t VALUES (2, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT id, IIF(active, 'yes', 'no') as status FROM t ORDER BY id;
SELECT IF(val > 5, 'high', 'low') as r1 FROM t;
SELECT IIF(val > 5, 'high', 'low') as r2 FROM t;
SELECT id, DECODE(status, 'A', 'Active', 'B', 'Busy', 'C', 'Complete', 'Unknown') as desc FROM t ORDER BY id;
SELECT id, DECODE(code, 'A', 'Found') as result FROM t ORDER BY id;
SELECT id, DECODE(val, NULL, 'was null', 10, 'was ten', 'other') as desc FROM t ORDER BY id;
SELECT DECODE(val, NULL, 'match', 'no match') as r1 FROM t;
SELECT CASE val WHEN NULL THEN 'match' ELSE 'no match' END as r2 FROM t;
SELECT DECODE(val, 10, 'first', 10, 'second', 'other') as result FROM t;
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_iif_vs_if_equivalence
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:668
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
INSERT INTO t VALUES (4, 'D');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, code STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'Z');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
INSERT INTO t VALUES (2, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT IF(val > 5, 'high', 'low') as r1 FROM t;
SELECT IIF(val > 5, 'high', 'low') as r2 FROM t;
SELECT id, DECODE(status, 'A', 'Active', 'B', 'Busy', 'C', 'Complete', 'Unknown') as desc FROM t ORDER BY id;
SELECT id, DECODE(code, 'A', 'Found') as result FROM t ORDER BY id;
SELECT id, DECODE(val, NULL, 'was null', 10, 'was ten', 'other') as desc FROM t ORDER BY id;
SELECT DECODE(val, NULL, 'match', 'no match') as r1 FROM t;
SELECT CASE val WHEN NULL THEN 'match' ELSE 'no match' END as r2 FROM t;
SELECT DECODE(val, 10, 'first', 10, 'second', 'other') as result FROM t;
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_decode_function_basic
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:700
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, status STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'B');
INSERT INTO t VALUES (3, 'C');
INSERT INTO t VALUES (4, 'D');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, code STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'Z');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
INSERT INTO t VALUES (2, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT id, DECODE(status, 'A', 'Active', 'B', 'Busy', 'C', 'Complete', 'Unknown') as desc FROM t ORDER BY id;
SELECT id, DECODE(code, 'A', 'Found') as result FROM t ORDER BY id;
SELECT id, DECODE(val, NULL, 'was null', 10, 'was ten', 'other') as desc FROM t ORDER BY id;
SELECT DECODE(val, NULL, 'match', 'no match') as r1 FROM t;
SELECT CASE val WHEN NULL THEN 'match' ELSE 'no match' END as r2 FROM t;
SELECT DECODE(val, 10, 'first', 10, 'second', 'other') as result FROM t;
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_decode_no_default
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:734
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, code STRING);
INSERT INTO t VALUES (1, 'A');
INSERT INTO t VALUES (2, 'Z');
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
INSERT INTO t VALUES (2, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT id, DECODE(code, 'A', 'Found') as result FROM t ORDER BY id;
SELECT id, DECODE(val, NULL, 'was null', 10, 'was ten', 'other') as desc FROM t ORDER BY id;
SELECT DECODE(val, NULL, 'match', 'no match') as r1 FROM t;
SELECT CASE val WHEN NULL THEN 'match' ELSE 'no match' END as r2 FROM t;
SELECT DECODE(val, 10, 'first', 10, 'second', 'other') as result FROM t;
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_decode_null_matching
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:763
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
INSERT INTO t VALUES (2, 10);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT id, DECODE(val, NULL, 'was null', 10, 'was ten', 'other') as desc FROM t ORDER BY id;
SELECT DECODE(val, NULL, 'match', 'no match') as r1 FROM t;
SELECT CASE val WHEN NULL THEN 'match' ELSE 'no match' END as r2 FROM t;
SELECT DECODE(val, 10, 'first', 10, 'second', 'other') as result FROM t;
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_decode_vs_case_null_difference
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:791
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, NULL);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT DECODE(val, NULL, 'match', 'no match') as r1 FROM t;
SELECT CASE val WHEN NULL THEN 'match' ELSE 'no match' END as r2 FROM t;
SELECT DECODE(val, 10, 'first', 10, 'second', 'other') as result FROM t;
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_decode_first_match_wins
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:820
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT DECODE(val, 10, 'first', 10, 'second', 'other') as result FROM t;
SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_case_in_aggregate
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:846
-- ============================================================================
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, status STRING, amount INT64);
INSERT INTO orders VALUES (1, 'completed', 100);
INSERT INTO orders VALUES (2, 'completed', 200);
INSERT INTO orders VALUES (3, 'cancelled', 150);
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT SUM(CASE WHEN status = 'completed' THEN amount ELSE 0 END) as completed_total FROM orders;
SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_conditional_count
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:873
-- ============================================================================
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT64, age INT64, active BOOL);
INSERT INTO users VALUES (1, 25, TRUE);
INSERT INTO users VALUES (2, 30, TRUE);
INSERT INTO users VALUES (3, 35, FALSE);
INSERT INTO users VALUES (4, 40, TRUE);
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT
COUNT(CASE WHEN active THEN 1 END) as active_count,
COUNT(CASE WHEN NOT active THEN 1 END) as inactive_count
FROM users;
SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_case_with_group_by
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:910
-- ============================================================================
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, amount INT64);
INSERT INTO sales VALUES (1, 100);
INSERT INTO sales VALUES (2, 200);
INSERT INTO sales VALUES (3, 50);
INSERT INTO sales VALUES (4, 300);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT
CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END as size,
COUNT(*) as cnt
FROM sales
GROUP BY CASE WHEN amount >= 100 THEN 'large' ELSE 'small' END
ORDER BY size;
SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_case_in_partition_by
-- Source: conditional_expressions_extreme_edge_cases_tdd.rs:951
-- ============================================================================
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, val INT64);
INSERT INTO t VALUES (1, 10);
INSERT INTO t VALUES (2, 20);
INSERT INTO t VALUES (3, 5);
DROP TABLE IF EXISTS t;
CREATE TABLE t (id INT64, denominator INT64);
INSERT INTO t VALUES (1, 0);

SELECT id, val,
ROW_NUMBER() OVER (
PARTITION BY CASE WHEN val >= 10 THEN 'high' ELSE 'low' END
ORDER BY id
) as row_num
FROM t ORDER BY id;
SELECT CASE WHEN denominator = 0 THEN 0 ELSE 10 / denominator END as safe_div FROM t;

-- ============================================================================
-- Test: test_int64_type
-- Source: data_types.rs:5
-- ============================================================================
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (id INT64, value INT64);
INSERT INTO numbers VALUES (1, 42);
INSERT INTO numbers VALUES (2, -100);
INSERT INTO numbers VALUES (3, 0);
DROP TABLE IF EXISTS measurements;
CREATE TABLE measurements (id INT64, value FLOAT64);
INSERT INTO measurements VALUES (1, 3.14159);
INSERT INTO measurements VALUES (2, -2.5);
INSERT INTO measurements VALUES (3, 0.0);
DROP TABLE IF EXISTS texts;
CREATE TABLE texts (id INT64, content STRING);
INSERT INTO texts VALUES (1, 'Hello World');
INSERT INTO texts VALUES (2, '');
INSERT INTO texts VALUES (3, 'Special chars: @#$%');
DROP TABLE IF EXISTS flags;
CREATE TABLE flags (id INT64, active BOOL);
INSERT INTO flags VALUES (1, TRUE);
INSERT INTO flags VALUES (2, FALSE);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, created_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:00');
INSERT INTO logs VALUES (2, TIMESTAMP '2024-01-15 14:45:30');
DROP TABLE IF EXISTS nullable;
CREATE TABLE nullable (id INT64, value STRING, number INT64);
INSERT INTO nullable VALUES (1, 'text', 100);
INSERT INTO nullable VALUES (2, NULL, 200);
INSERT INTO nullable VALUES (3, 'another', NULL);
INSERT INTO nullable VALUES (4, NULL, NULL);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed ( id INT64, name STRING, score FLOAT64, active BOOL, created DATE );
INSERT INTO mixed VALUES (1, 'Alice', 95.5, TRUE, DATE '2024-01-01');
DROP TABLE IF EXISTS finances;
CREATE TABLE finances (id INT64, amount NUMERIC);
INSERT INTO finances VALUES (1, NUMERIC '123.45');
INSERT INTO finances VALUES (2, NUMERIC '0.01');
DROP TABLE IF EXISTS binary_data;
CREATE TABLE binary_data (id INT64, data BYTES);
INSERT INTO binary_data VALUES (1, B'\x01\x02\x03');
DROP TABLE IF EXISTS lists;
CREATE TABLE lists (id INT64, numbers ARRAY<INT64>);
INSERT INTO lists VALUES (1, [1, 2, 3, 4, 5]);
INSERT INTO lists VALUES (2, [10, 20]);
DROP TABLE IF EXISTS structured;
CREATE TABLE structured ( id INT64, person STRUCT<name STRING, age INT64> );
INSERT INTO structured VALUES (1, STRUCT('Alice', 30));
DROP TABLE IF EXISTS big_numbers;
CREATE TABLE big_numbers (value INT64);
INSERT INTO big_numbers VALUES (9223372036854775807);
INSERT INTO big_numbers VALUES (-9223372036854775808);
DROP TABLE IF EXISTS tiny_numbers;
CREATE TABLE tiny_numbers (value FLOAT64);
INSERT INTO tiny_numbers VALUES (0.0000001);
INSERT INTO tiny_numbers VALUES (1e-10);
DROP TABLE IF EXISTS long_texts;
CREATE TABLE long_texts (id INT64, content STRING);
DROP TABLE IF EXISTS unicode_texts;
CREATE TABLE unicode_texts (id INT64, text STRING);
INSERT INTO unicode_texts VALUES (1, 'Hello 世界');
INSERT INTO unicode_texts VALUES (2, 'Привет мир');
INSERT INTO unicode_texts VALUES (3, '😀🎉🚀');
DROP TABLE IF EXISTS nullable_ints;
CREATE TABLE nullable_ints (value INT64);
INSERT INTO nullable_ints VALUES (10);
INSERT INTO nullable_ints VALUES (NULL);
INSERT INTO nullable_ints VALUES (20);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (int_val INT64, float_val FLOAT64);
INSERT INTO numbers VALUES (10, 3.14);
DROP TABLE IF EXISTS names;
CREATE TABLE names (first STRING, last STRING);
INSERT INTO names VALUES ('John', 'Doe');
DROP TABLE IF EXISTS appointments;
CREATE TABLE appointments (id INT64, scheduled DATETIME);
INSERT INTO appointments VALUES (1, DATETIME '2024-01-15 10:30:00');
DROP TABLE IF EXISTS schedules;
CREATE TABLE schedules (id INT64, time TIME);
INSERT INTO schedules VALUES (1, TIME '10:30:00');
INSERT INTO schedules VALUES (2, TIME '14:45:30');

SELECT * FROM numbers;
SELECT * FROM measurements;
SELECT * FROM texts;
SELECT * FROM flags;
SELECT * FROM events;
SELECT * FROM logs;
SELECT * FROM nullable;
SELECT * FROM mixed;
SELECT * FROM finances;
SELECT * FROM binary_data;
SELECT * FROM lists;
SELECT * FROM structured;
SELECT * FROM big_numbers;
SELECT * FROM tiny_numbers;
SELECT * FROM long_texts;
SELECT * FROM unicode_texts;
SELECT * FROM nullable_ints WHERE value > 15;
SELECT * FROM numbers WHERE int_val < float_val;
SELECT CONCAT(first, ' ', last) as full_name FROM names;
SELECT * FROM appointments;
SELECT * FROM schedules;

-- ============================================================================
-- Test: test_float64_type
-- Source: data_types.rs:28
-- ============================================================================
DROP TABLE IF EXISTS measurements;
CREATE TABLE measurements (id INT64, value FLOAT64);
INSERT INTO measurements VALUES (1, 3.14159);
INSERT INTO measurements VALUES (2, -2.5);
INSERT INTO measurements VALUES (3, 0.0);
DROP TABLE IF EXISTS texts;
CREATE TABLE texts (id INT64, content STRING);
INSERT INTO texts VALUES (1, 'Hello World');
INSERT INTO texts VALUES (2, '');
INSERT INTO texts VALUES (3, 'Special chars: @#$%');
DROP TABLE IF EXISTS flags;
CREATE TABLE flags (id INT64, active BOOL);
INSERT INTO flags VALUES (1, TRUE);
INSERT INTO flags VALUES (2, FALSE);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, created_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:00');
INSERT INTO logs VALUES (2, TIMESTAMP '2024-01-15 14:45:30');
DROP TABLE IF EXISTS nullable;
CREATE TABLE nullable (id INT64, value STRING, number INT64);
INSERT INTO nullable VALUES (1, 'text', 100);
INSERT INTO nullable VALUES (2, NULL, 200);
INSERT INTO nullable VALUES (3, 'another', NULL);
INSERT INTO nullable VALUES (4, NULL, NULL);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed ( id INT64, name STRING, score FLOAT64, active BOOL, created DATE );
INSERT INTO mixed VALUES (1, 'Alice', 95.5, TRUE, DATE '2024-01-01');
DROP TABLE IF EXISTS finances;
CREATE TABLE finances (id INT64, amount NUMERIC);
INSERT INTO finances VALUES (1, NUMERIC '123.45');
INSERT INTO finances VALUES (2, NUMERIC '0.01');
DROP TABLE IF EXISTS binary_data;
CREATE TABLE binary_data (id INT64, data BYTES);
INSERT INTO binary_data VALUES (1, B'\x01\x02\x03');
DROP TABLE IF EXISTS lists;
CREATE TABLE lists (id INT64, numbers ARRAY<INT64>);
INSERT INTO lists VALUES (1, [1, 2, 3, 4, 5]);
INSERT INTO lists VALUES (2, [10, 20]);
DROP TABLE IF EXISTS structured;
CREATE TABLE structured ( id INT64, person STRUCT<name STRING, age INT64> );
INSERT INTO structured VALUES (1, STRUCT('Alice', 30));
DROP TABLE IF EXISTS big_numbers;
CREATE TABLE big_numbers (value INT64);
INSERT INTO big_numbers VALUES (9223372036854775807);
INSERT INTO big_numbers VALUES (-9223372036854775808);
DROP TABLE IF EXISTS tiny_numbers;
CREATE TABLE tiny_numbers (value FLOAT64);
INSERT INTO tiny_numbers VALUES (0.0000001);
INSERT INTO tiny_numbers VALUES (1e-10);
DROP TABLE IF EXISTS long_texts;
CREATE TABLE long_texts (id INT64, content STRING);
DROP TABLE IF EXISTS unicode_texts;
CREATE TABLE unicode_texts (id INT64, text STRING);
INSERT INTO unicode_texts VALUES (1, 'Hello 世界');
INSERT INTO unicode_texts VALUES (2, 'Привет мир');
INSERT INTO unicode_texts VALUES (3, '😀🎉🚀');
DROP TABLE IF EXISTS nullable_ints;
CREATE TABLE nullable_ints (value INT64);
INSERT INTO nullable_ints VALUES (10);
INSERT INTO nullable_ints VALUES (NULL);
INSERT INTO nullable_ints VALUES (20);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (int_val INT64, float_val FLOAT64);
INSERT INTO numbers VALUES (10, 3.14);
DROP TABLE IF EXISTS names;
CREATE TABLE names (first STRING, last STRING);
INSERT INTO names VALUES ('John', 'Doe');
DROP TABLE IF EXISTS appointments;
CREATE TABLE appointments (id INT64, scheduled DATETIME);
INSERT INTO appointments VALUES (1, DATETIME '2024-01-15 10:30:00');
DROP TABLE IF EXISTS schedules;
CREATE TABLE schedules (id INT64, time TIME);
INSERT INTO schedules VALUES (1, TIME '10:30:00');
INSERT INTO schedules VALUES (2, TIME '14:45:30');

SELECT * FROM measurements;
SELECT * FROM texts;
SELECT * FROM flags;
SELECT * FROM events;
SELECT * FROM logs;
SELECT * FROM nullable;
SELECT * FROM mixed;
SELECT * FROM finances;
SELECT * FROM binary_data;
SELECT * FROM lists;
SELECT * FROM structured;
SELECT * FROM big_numbers;
SELECT * FROM tiny_numbers;
SELECT * FROM long_texts;
SELECT * FROM unicode_texts;
SELECT * FROM nullable_ints WHERE value > 15;
SELECT * FROM numbers WHERE int_val < float_val;
SELECT CONCAT(first, ' ', last) as full_name FROM names;
SELECT * FROM appointments;
SELECT * FROM schedules;

-- ============================================================================
-- Test: test_string_type
-- Source: data_types.rs:51
-- ============================================================================
DROP TABLE IF EXISTS texts;
CREATE TABLE texts (id INT64, content STRING);
INSERT INTO texts VALUES (1, 'Hello World');
INSERT INTO texts VALUES (2, '');
INSERT INTO texts VALUES (3, 'Special chars: @#$%');
DROP TABLE IF EXISTS flags;
CREATE TABLE flags (id INT64, active BOOL);
INSERT INTO flags VALUES (1, TRUE);
INSERT INTO flags VALUES (2, FALSE);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, created_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:00');
INSERT INTO logs VALUES (2, TIMESTAMP '2024-01-15 14:45:30');
DROP TABLE IF EXISTS nullable;
CREATE TABLE nullable (id INT64, value STRING, number INT64);
INSERT INTO nullable VALUES (1, 'text', 100);
INSERT INTO nullable VALUES (2, NULL, 200);
INSERT INTO nullable VALUES (3, 'another', NULL);
INSERT INTO nullable VALUES (4, NULL, NULL);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed ( id INT64, name STRING, score FLOAT64, active BOOL, created DATE );
INSERT INTO mixed VALUES (1, 'Alice', 95.5, TRUE, DATE '2024-01-01');
DROP TABLE IF EXISTS finances;
CREATE TABLE finances (id INT64, amount NUMERIC);
INSERT INTO finances VALUES (1, NUMERIC '123.45');
INSERT INTO finances VALUES (2, NUMERIC '0.01');
DROP TABLE IF EXISTS binary_data;
CREATE TABLE binary_data (id INT64, data BYTES);
INSERT INTO binary_data VALUES (1, B'\x01\x02\x03');
DROP TABLE IF EXISTS lists;
CREATE TABLE lists (id INT64, numbers ARRAY<INT64>);
INSERT INTO lists VALUES (1, [1, 2, 3, 4, 5]);
INSERT INTO lists VALUES (2, [10, 20]);
DROP TABLE IF EXISTS structured;
CREATE TABLE structured ( id INT64, person STRUCT<name STRING, age INT64> );
INSERT INTO structured VALUES (1, STRUCT('Alice', 30));
DROP TABLE IF EXISTS big_numbers;
CREATE TABLE big_numbers (value INT64);
INSERT INTO big_numbers VALUES (9223372036854775807);
INSERT INTO big_numbers VALUES (-9223372036854775808);
DROP TABLE IF EXISTS tiny_numbers;
CREATE TABLE tiny_numbers (value FLOAT64);
INSERT INTO tiny_numbers VALUES (0.0000001);
INSERT INTO tiny_numbers VALUES (1e-10);
DROP TABLE IF EXISTS long_texts;
CREATE TABLE long_texts (id INT64, content STRING);
DROP TABLE IF EXISTS unicode_texts;
CREATE TABLE unicode_texts (id INT64, text STRING);
INSERT INTO unicode_texts VALUES (1, 'Hello 世界');
INSERT INTO unicode_texts VALUES (2, 'Привет мир');
INSERT INTO unicode_texts VALUES (3, '😀🎉🚀');
DROP TABLE IF EXISTS nullable_ints;
CREATE TABLE nullable_ints (value INT64);
INSERT INTO nullable_ints VALUES (10);
INSERT INTO nullable_ints VALUES (NULL);
INSERT INTO nullable_ints VALUES (20);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (int_val INT64, float_val FLOAT64);
INSERT INTO numbers VALUES (10, 3.14);
DROP TABLE IF EXISTS names;
CREATE TABLE names (first STRING, last STRING);
INSERT INTO names VALUES ('John', 'Doe');
DROP TABLE IF EXISTS appointments;
CREATE TABLE appointments (id INT64, scheduled DATETIME);
INSERT INTO appointments VALUES (1, DATETIME '2024-01-15 10:30:00');
DROP TABLE IF EXISTS schedules;
CREATE TABLE schedules (id INT64, time TIME);
INSERT INTO schedules VALUES (1, TIME '10:30:00');
INSERT INTO schedules VALUES (2, TIME '14:45:30');

SELECT * FROM texts;
SELECT * FROM flags;
SELECT * FROM events;
SELECT * FROM logs;
SELECT * FROM nullable;
SELECT * FROM mixed;
SELECT * FROM finances;
SELECT * FROM binary_data;
SELECT * FROM lists;
SELECT * FROM structured;
SELECT * FROM big_numbers;
SELECT * FROM tiny_numbers;
SELECT * FROM long_texts;
SELECT * FROM unicode_texts;
SELECT * FROM nullable_ints WHERE value > 15;
SELECT * FROM numbers WHERE int_val < float_val;
SELECT CONCAT(first, ' ', last) as full_name FROM names;
SELECT * FROM appointments;
SELECT * FROM schedules;

-- ============================================================================
-- Test: test_bool_type
-- Source: data_types.rs:74
-- ============================================================================
DROP TABLE IF EXISTS flags;
CREATE TABLE flags (id INT64, active BOOL);
INSERT INTO flags VALUES (1, TRUE);
INSERT INTO flags VALUES (2, FALSE);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, event_date DATE);
INSERT INTO events VALUES (1, DATE '2024-01-15');
INSERT INTO events VALUES (2, DATE '2024-12-31');
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (id INT64, created_at TIMESTAMP);
INSERT INTO logs VALUES (1, TIMESTAMP '2024-01-15 10:30:00');
INSERT INTO logs VALUES (2, TIMESTAMP '2024-01-15 14:45:30');
DROP TABLE IF EXISTS nullable;
CREATE TABLE nullable (id INT64, value STRING, number INT64);
INSERT INTO nullable VALUES (1, 'text', 100);
INSERT INTO nullable VALUES (2, NULL, 200);
INSERT INTO nullable VALUES (3, 'another', NULL);
INSERT INTO nullable VALUES (4, NULL, NULL);
DROP TABLE IF EXISTS mixed;
CREATE TABLE mixed ( id INT64, name STRING, score FLOAT64, active BOOL, created DATE );
INSERT INTO mixed VALUES (1, 'Alice', 95.5, TRUE, DATE '2024-01-01');
DROP TABLE IF EXISTS finances;
CREATE TABLE finances (id INT64, amount NUMERIC);
INSERT INTO finances VALUES (1, NUMERIC '123.45');
INSERT INTO finances VALUES (2, NUMERIC '0.01');
DROP TABLE IF EXISTS binary_data;
CREATE TABLE binary_data (id INT64, data BYTES);
INSERT INTO binary_data VALUES (1, B'\x01\x02\x03');
DROP TABLE IF EXISTS lists;
CREATE TABLE lists (id INT64, numbers ARRAY<INT64>);
INSERT INTO lists VALUES (1, [1, 2, 3, 4, 5]);
INSERT INTO lists VALUES (2, [10, 20]);
DROP TABLE IF EXISTS structured;
CREATE TABLE structured ( id INT64, person STRUCT<name STRING, age INT64> );
INSERT INTO structured VALUES (1, STRUCT('Alice', 30));
DROP TABLE IF EXISTS big_numbers;
CREATE TABLE big_numbers (value INT64);
INSERT INTO big_numbers VALUES (9223372036854775807);
INSERT INTO big_numbers VALUES (-9223372036854775808);
DROP TABLE IF EXISTS tiny_numbers;
CREATE TABLE tiny_numbers (value FLOAT64);
INSERT INTO tiny_numbers VALUES (0.0000001);
INSERT INTO tiny_numbers VALUES (1e-10);
DROP TABLE IF EXISTS long_texts;
CREATE TABLE long_texts (id INT64, content STRING);
DROP TABLE IF EXISTS unicode_texts;
CREATE TABLE unicode_texts (id INT64, text STRING);
INSERT INTO unicode_texts VALUES (1, 'Hello 世界');
INSERT INTO unicode_texts VALUES (2, 'Привет мир');
INSERT INTO unicode_texts VALUES (3, '😀🎉🚀');
DROP TABLE IF EXISTS nullable_ints;
CREATE TABLE nullable_ints (value INT64);
INSERT INTO nullable_ints VALUES (10);
INSERT INTO nullable_ints VALUES (NULL);
INSERT INTO nullable_ints VALUES (20);
DROP TABLE IF EXISTS numbers;
CREATE TABLE numbers (int_val INT64, float_val FLOAT64);
INSERT INTO numbers VALUES (10, 3.14);
DROP TABLE IF EXISTS names;
CREATE TABLE names (first STRING, last STRING);
INSERT INTO names VALUES ('John', 'Doe');
DROP TABLE IF EXISTS appointments;
CREATE TABLE appointments (id INT64, scheduled DATETIME);
INSERT INTO appointments VALUES (1, DATETIME '2024-01-15 10:30:00');
DROP TABLE IF EXISTS schedules;
CREATE TABLE schedules (id INT64, time TIME);
INSERT INTO schedules VALUES (1, TIME '10:30:00');
INSERT INTO schedules VALUES (2, TIME '14:45:30');

SELECT * FROM flags;
SELECT * FROM events;
SELECT * FROM logs;
SELECT * FROM nullable;
SELECT * FROM mixed;
SELECT * FROM finances;
SELECT * FROM binary_data;
SELECT * FROM lists;
SELECT * FROM structured;
SELECT * FROM big_numbers;
SELECT * FROM tiny_numbers;
SELECT * FROM long_texts;
SELECT * FROM unicode_texts;
SELECT * FROM nullable_ints WHERE value > 15;
SELECT * FROM numbers WHERE int_val < float_val;
SELECT CONCAT(first, ' ', last) as full_name FROM names;
SELECT * FROM appointments;
SELECT * FROM schedules;

-- ============================================================================
-- Test: test_cast_float_to_int64_overflow_positive
-- Source: int64_overflow_comprehensive_tdd.rs:30
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775808.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-9223372036854775809.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-9223372036854775808.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775806.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('9223372036854775808');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('-9223372036854775809');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('9223372036854775807');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('-9223372036854775808');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 9223372036854775808.0), (2, 42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '9223372036854775808'), (2, '42');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, -9223372036854775809.0), (2, -42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20), (2, 100.0), (3, -1e20), (4, -50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT value + 1 FROM data;
SELECT value - 1 FROM data;
SELECT value * 2 FROM data;
SELECT -value FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_cast_float_to_int64_overflow_negative
-- Source: int64_overflow_comprehensive_tdd.rs:47
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-9223372036854775809.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-9223372036854775808.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775806.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('9223372036854775808');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('-9223372036854775809');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('9223372036854775807');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('-9223372036854775808');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 9223372036854775808.0), (2, 42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '9223372036854775808'), (2, '42');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, -9223372036854775809.0), (2, -42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20), (2, 100.0), (3, -1e20), (4, -50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT value + 1 FROM data;
SELECT value - 1 FROM data;
SELECT value * 2 FROM data;
SELECT -value FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_cast_float_to_int64_overflow_very_large
-- Source: int64_overflow_comprehensive_tdd.rs:64
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-9223372036854775808.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775806.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('9223372036854775808');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('-9223372036854775809');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('9223372036854775807');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('-9223372036854775808');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 9223372036854775808.0), (2, 42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '9223372036854775808'), (2, '42');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, -9223372036854775809.0), (2, -42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20), (2, 100.0), (3, -1e20), (4, -50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT value + 1 FROM data;
SELECT value - 1 FROM data;
SELECT value * 2 FROM data;
SELECT -value FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_cast_float_to_int64_overflow_very_small
-- Source: int64_overflow_comprehensive_tdd.rs:81
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-9223372036854775808.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775806.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('9223372036854775808');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('-9223372036854775809');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('9223372036854775807');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('-9223372036854775808');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 9223372036854775808.0), (2, 42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '9223372036854775808'), (2, '42');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, -9223372036854775809.0), (2, -42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20), (2, 100.0), (3, -1e20), (4, -50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT value + 1 FROM data;
SELECT value - 1 FROM data;
SELECT value * 2 FROM data;
SELECT -value FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_cast_float_to_int64_max_value
-- Source: int64_overflow_comprehensive_tdd.rs:102
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-9223372036854775808.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775806.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('9223372036854775808');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('-9223372036854775809');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('9223372036854775807');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('-9223372036854775808');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 9223372036854775808.0), (2, 42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '9223372036854775808'), (2, '42');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, -9223372036854775809.0), (2, -42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20), (2, 100.0), (3, -1e20), (4, -50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT value + 1 FROM data;
SELECT value - 1 FROM data;
SELECT value * 2 FROM data;
SELECT -value FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_cast_float_to_int64_min_value
-- Source: int64_overflow_comprehensive_tdd.rs:120
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-9223372036854775808.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775806.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('9223372036854775808');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('-9223372036854775809');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('9223372036854775807');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('-9223372036854775808');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 9223372036854775808.0), (2, 42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '9223372036854775808'), (2, '42');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, -9223372036854775809.0), (2, -42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20), (2, 100.0), (3, -1e20), (4, -50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT value + 1 FROM data;
SELECT value - 1 FROM data;
SELECT value * 2 FROM data;
SELECT -value FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_cast_float_to_int64_near_max
-- Source: int64_overflow_comprehensive_tdd.rs:138
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775806.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('9223372036854775808');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('-9223372036854775809');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('9223372036854775807');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('-9223372036854775808');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 9223372036854775808.0), (2, 42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '9223372036854775808'), (2, '42');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, -9223372036854775809.0), (2, -42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20), (2, 100.0), (3, -1e20), (4, -50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT value + 1 FROM data;
SELECT value - 1 FROM data;
SELECT value * 2 FROM data;
SELECT -value FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_cast_float_to_int64_near_min
-- Source: int64_overflow_comprehensive_tdd.rs:156
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('9223372036854775808');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('-9223372036854775809');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('9223372036854775807');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('-9223372036854775808');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 9223372036854775808.0), (2, 42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '9223372036854775808'), (2, '42');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, -9223372036854775809.0), (2, -42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20), (2, 100.0), (3, -1e20), (4, -50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT value + 1 FROM data;
SELECT value - 1 FROM data;
SELECT value * 2 FROM data;
SELECT -value FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_cast_string_to_int64_overflow_positive
-- Source: int64_overflow_comprehensive_tdd.rs:178
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('9223372036854775808');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('-9223372036854775809');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('9223372036854775807');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('-9223372036854775808');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 9223372036854775808.0), (2, 42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '9223372036854775808'), (2, '42');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, -9223372036854775809.0), (2, -42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20), (2, 100.0), (3, -1e20), (4, -50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT value + 1 FROM data;
SELECT value - 1 FROM data;
SELECT value * 2 FROM data;
SELECT -value FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_cast_string_to_int64_overflow_negative
-- Source: int64_overflow_comprehensive_tdd.rs:195
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('-9223372036854775809');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('9223372036854775807');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('-9223372036854775808');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 9223372036854775808.0), (2, 42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '9223372036854775808'), (2, '42');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, -9223372036854775809.0), (2, -42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20), (2, 100.0), (3, -1e20), (4, -50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT value + 1 FROM data;
SELECT value - 1 FROM data;
SELECT value * 2 FROM data;
SELECT -value FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_cast_string_to_int64_overflow_very_large
-- Source: int64_overflow_comprehensive_tdd.rs:212
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('9223372036854775807');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('-9223372036854775808');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 9223372036854775808.0), (2, 42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '9223372036854775808'), (2, '42');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, -9223372036854775809.0), (2, -42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20), (2, 100.0), (3, -1e20), (4, -50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT value + 1 FROM data;
SELECT value - 1 FROM data;
SELECT value * 2 FROM data;
SELECT -value FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_cast_string_to_int64_max_valid
-- Source: int64_overflow_comprehensive_tdd.rs:229
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('9223372036854775807');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('-9223372036854775808');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 9223372036854775808.0), (2, 42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '9223372036854775808'), (2, '42');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, -9223372036854775809.0), (2, -42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20), (2, 100.0), (3, -1e20), (4, -50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT value + 1 FROM data;
SELECT value - 1 FROM data;
SELECT value * 2 FROM data;
SELECT -value FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_cast_string_to_int64_min_valid
-- Source: int64_overflow_comprehensive_tdd.rs:247
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('-9223372036854775808');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 9223372036854775808.0), (2, 42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '9223372036854775808'), (2, '42');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, -9223372036854775809.0), (2, -42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20), (2, 100.0), (3, -1e20), (4, -50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT CAST(value AS INT64) as int_val FROM data;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT value + 1 FROM data;
SELECT value - 1 FROM data;
SELECT value * 2 FROM data;
SELECT -value FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_try_cast_float_overflow_returns_null
-- Source: int64_overflow_comprehensive_tdd.rs:269
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 9223372036854775808.0), (2, 42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '9223372036854775808'), (2, '42');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, -9223372036854775809.0), (2, -42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20), (2, 100.0), (3, -1e20), (4, -50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT value + 1 FROM data;
SELECT value - 1 FROM data;
SELECT value * 2 FROM data;
SELECT -value FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_try_cast_string_overflow_returns_null
-- Source: int64_overflow_comprehensive_tdd.rs:287
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value STRING);
INSERT INTO data VALUES (1, '9223372036854775808'), (2, '42');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, -9223372036854775809.0), (2, -42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20), (2, 100.0), (3, -1e20), (4, -50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT value + 1 FROM data;
SELECT value - 1 FROM data;
SELECT value * 2 FROM data;
SELECT -value FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_try_cast_negative_overflow_returns_null
-- Source: int64_overflow_comprehensive_tdd.rs:305
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, -9223372036854775809.0), (2, -42.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20), (2, 100.0), (3, -1e20), (4, -50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT value + 1 FROM data;
SELECT value - 1 FROM data;
SELECT value * 2 FROM data;
SELECT -value FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_try_cast_multiple_overflow_mixed
-- Source: int64_overflow_comprehensive_tdd.rs:323
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20), (2, 100.0), (3, -1e20), (4, -50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT id, TRY_CAST(value AS INT64) as int_val FROM data ORDER BY id;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT value + 1 FROM data;
SELECT value - 1 FROM data;
SELECT value * 2 FROM data;
SELECT -value FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_try_cast_boundary_success
-- Source: int64_overflow_comprehensive_tdd.rs:341
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775807.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT value + 1 FROM data;
SELECT value - 1 FROM data;
SELECT value * 2 FROM data;
SELECT -value FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_arithmetic_addition_overflow
-- Source: int64_overflow_comprehensive_tdd.rs:363
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT value + 1 FROM data;
SELECT value - 1 FROM data;
SELECT value * 2 FROM data;
SELECT -value FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_arithmetic_subtraction_overflow
-- Source: int64_overflow_comprehensive_tdd.rs:378
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT value - 1 FROM data;
SELECT value * 2 FROM data;
SELECT -value FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_arithmetic_multiplication_overflow
-- Source: int64_overflow_comprehensive_tdd.rs:393
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT value * 2 FROM data;
SELECT -value FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_arithmetic_negation_overflow
-- Source: int64_overflow_comprehensive_tdd.rs:408
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (-9223372036854775808);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT -value FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_cast_float_precision_loss_truncation
-- Source: int64_overflow_comprehensive_tdd.rs:427
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_cast_float_precision_near_boundary
-- Source: int64_overflow_comprehensive_tdd.rs:445
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9223372036854775000.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT CAST(value AS INT64) as int_val FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_cast_float_precision_just_over_max
-- Source: int64_overflow_comprehensive_tdd.rs:463
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_cast_infinity_to_int64
-- Source: int64_overflow_comprehensive_tdd.rs:485
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_cast_negative_infinity_to_int64
-- Source: int64_overflow_comprehensive_tdd.rs:502
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (-1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_cast_nan_to_int64
-- Source: int64_overflow_comprehensive_tdd.rs:519
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT CAST(value AS INT64) FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_try_cast_infinity_returns_null
-- Source: int64_overflow_comprehensive_tdd.rs:536
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e308 * 10);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_try_cast_nan_returns_null
-- Source: int64_overflow_comprehensive_tdd.rs:554
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (0.0 / 0.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT TRY_CAST(value AS INT64) as int_val FROM data;
SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_overflow_in_where_clause
-- Source: int64_overflow_comprehensive_tdd.rs:576
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT id FROM data WHERE TRY_CAST(value AS INT64) IS NOT NULL ORDER BY id;
SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_overflow_in_aggregation
-- Source: int64_overflow_comprehensive_tdd.rs:594
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20), (3, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT COUNT(TRY_CAST(value AS INT64)) as valid_count FROM data;
SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_overflow_in_case_expression
-- Source: int64_overflow_comprehensive_tdd.rs:612
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 42.0), (2, 1e20);
DROP TABLE IF EXISTS floats;
CREATE TABLE floats (id INT64, value FLOAT64);
DROP TABLE IF EXISTS ints;
CREATE TABLE ints (id INT64, value INT64);
INSERT INTO floats VALUES (1, 42.0), (2, 1e20);
INSERT INTO ints VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 100.0), (2, 1e20), (3, 50.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
INSERT INTO data VALUES (1, 1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (1e20);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value STRING);
INSERT INTO data VALUES ('99999999999999999999');
DROP TABLE IF EXISTS data;
CREATE TABLE data (value INT64);
INSERT INTO data VALUES (9223372036854775807);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value FLOAT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (value FLOAT64);
INSERT INTO data VALUES (NULL);

SELECT id, CASE WHEN TRY_CAST(value AS INT64) IS NULL THEN 'overflow' ELSE 'ok' END as status FROM data ORDER BY id;
SELECT f.id FROM floats f JOIN ints i ON TRY_CAST(f.value AS INT64) = i.value;
SELECT id FROM data ORDER BY TRY_CAST(value AS INT64) NULLS LAST;
SELECT COALESCE(TRY_CAST(value AS INT64), 0) as safe_value FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT CAST(value AS INT64) FROM data;
SELECT value + 1 FROM data;
SELECT COUNT(*) as total, COUNT(TRY_CAST(value AS INT64)) as valid FROM data;
SELECT CAST(value AS INT64) as int_val FROM data;
SELECT TRY_CAST(value AS INT64) as int_val FROM data;

-- ============================================================================
-- Test: test_json_maximum_nesting_depth
-- Source: json_extreme_edge_cases_tdd.rs:39
-- ============================================================================
DROP TABLE IF EXISTS deep;
CREATE TABLE deep (id INT64, data JSON);
DROP TABLE IF EXISTS circular;
CREATE TABLE circular (id INT64, data JSON);
DROP TABLE IF EXISTS deep_array;
CREATE TABLE deep_array (data JSON);
DROP TABLE IF EXISTS large_str;
CREATE TABLE large_str (data JSON);
DROP TABLE IF EXISTS huge_array;
CREATE TABLE huge_array (data JSON);
DROP TABLE IF EXISTS huge_object;
CREATE TABLE huge_object (data JSON);
DROP TABLE IF EXISTS expansion;
CREATE TABLE expansion (data JSON);
DROP TABLE IF EXISTS bad_encoding;
CREATE TABLE bad_encoding (data JSON);
INSERT INTO bad_encoding VALUES ('{\;
DROP TABLE IF EXISTS surrogates;
CREATE TABLE surrogates (data JSON);
DROP TABLE IF EXISTS bom;
CREATE TABLE bom (data JSON);
DROP TABLE IF EXISTS null_bytes;
CREATE TABLE null_bytes (data JSON);
DROP TABLE IF EXISTS unicode;
CREATE TABLE unicode (data JSON);
DROP TABLE IF EXISTS big_int;
CREATE TABLE big_int (data JSON);
DROP TABLE IF EXISTS unsafe_int;
CREATE TABLE unsafe_int (data JSON);
DROP TABLE IF EXISTS tiny;
CREATE TABLE tiny (data JSON);
DROP TABLE IF EXISTS scientific;
CREATE TABLE scientific (data JSON);
DROP TABLE IF EXISTS leading_zero;
CREATE TABLE leading_zero (data JSON);
DROP TABLE IF EXISTS special_float;
CREATE TABLE special_float (data JSON);
DROP TABLE IF EXISTS escapes;
CREATE TABLE escapes (data JSON);
DROP TABLE IF EXISTS bad_escape;
CREATE TABLE bad_escape (data JSON);
DROP TABLE IF EXISTS incomplete;
CREATE TABLE incomplete (data JSON);
DROP TABLE IF EXISTS whitespace;
CREATE TABLE whitespace (data JSON);
DROP TABLE IF EXISTS unclosed;
CREATE TABLE unclosed (data JSON);
DROP TABLE IF EXISTS truncated;
CREATE TABLE truncated (data JSON);
DROP TABLE IF EXISTS recovery;
CREATE TABLE recovery (id INT64, data JSON);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, data JSON);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id STRING, name STRING);
INSERT INTO users VALUES ('u1', 'Alice');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, data JSON);
DROP TABLE IF EXISTS tree;
CREATE TABLE tree (id INT64, data JSON);
DROP TABLE IF EXISTS concurrent;
CREATE TABLE concurrent (id INT64, data JSON);
DROP TABLE IF EXISTS writes;
CREATE TABLE writes (id INT64, data JSON);
DROP TABLE IF EXISTS perf;
CREATE TABLE perf (id INT64, data JSON);
DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);
INSERT INTO recovery VALUES (1, '{bad}');

SELECT JSON_EXTRACT(data, '$.a.a.a.a.a') FROM deep WHERE id = 1;
SELECT JSON_EXTRACT(data, '$..$ref') FROM circular WHERE id = 1;
SELECT JSON_LENGTH(data, '$.large') FROM large_str;
SELECT JSON_LENGTH(data) FROM huge_array;
SELECT JSON_EXTRACT(data, '$.key500000') FROM huge_object;
SELECT JSON_EXTRACT(data, '$.lol') || JSON_EXTRACT(data, '$.lol4') FROM expansion;
SELECT JSON_EXTRACT(data, '$.emoji') FROM surrogates;
SELECT JSON_EXTRACT(data, '$.key') FROM bom;
SELECT JSON_EXTRACT(data, '$.text') FROM null_bytes;
SELECT JSON_VALUE(data, '$.num') FROM big_int;
SELECT JSON_VALUE(data, '$.num') FROM unsafe_int;
SELECT JSON_VALUE(data, '$.num') FROM tiny;
SELECT JSON_EXTRACT(data, '$.quote') FROM escapes;
SELECT COUNT(*) FROM recovery;
SELECT JSON_EXTRACT(data, '$.type') as event_type, COUNT(*) as count
FROM events
GROUP BY JSON_EXTRACT(data, '$.type')
ORDER BY count DESC;
SELECT u.name, o.id
FROM orders o
JOIN users u ON JSON_EXTRACT(o.data, '$.user_id') = u.user_id;
SELECT
JSON_EXTRACT(data, '$.region') as region,
JSON_VALUE(data, '$.amount') as amount,
SUM(CAST(JSON_VALUE(data, '$.amount') AS INT64))
OVER (PARTITION BY JSON_EXTRACT(data, '$.region')) as region_total
FROM sales;
WITH RECURSIVE tree_path AS (
SELECT id, JSON_VALUE(data, '$.name') as name
FROM tree
WHERE JSON_VALUE(data, '$.parent') IS NULL
UNION ALL
SELECT t.id, JSON_VALUE(t.data, '$.name')
FROM tree t
JOIN tree_path tp ON CAST(JSON_VALUE(t.data, '$.parent') AS INT64) = tp.id
)
SELECT * FROM tree_path;
SELECT JSON_VALUE(data, '$.value') FROM concurrent WHERE id = 1;
SELECT COUNT(*) FROM writes;
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

-- ============================================================================
-- Test: test_json_circular_reference_prevention
-- Source: json_extreme_edge_cases_tdd.rs:87
-- ============================================================================
DROP TABLE IF EXISTS circular;
CREATE TABLE circular (id INT64, data JSON);
DROP TABLE IF EXISTS deep_array;
CREATE TABLE deep_array (data JSON);
DROP TABLE IF EXISTS large_str;
CREATE TABLE large_str (data JSON);
DROP TABLE IF EXISTS huge_array;
CREATE TABLE huge_array (data JSON);
DROP TABLE IF EXISTS huge_object;
CREATE TABLE huge_object (data JSON);
DROP TABLE IF EXISTS expansion;
CREATE TABLE expansion (data JSON);
DROP TABLE IF EXISTS bad_encoding;
CREATE TABLE bad_encoding (data JSON);
INSERT INTO bad_encoding VALUES ('{\;
DROP TABLE IF EXISTS surrogates;
CREATE TABLE surrogates (data JSON);
DROP TABLE IF EXISTS bom;
CREATE TABLE bom (data JSON);
DROP TABLE IF EXISTS null_bytes;
CREATE TABLE null_bytes (data JSON);
DROP TABLE IF EXISTS unicode;
CREATE TABLE unicode (data JSON);
DROP TABLE IF EXISTS big_int;
CREATE TABLE big_int (data JSON);
DROP TABLE IF EXISTS unsafe_int;
CREATE TABLE unsafe_int (data JSON);
DROP TABLE IF EXISTS tiny;
CREATE TABLE tiny (data JSON);
DROP TABLE IF EXISTS scientific;
CREATE TABLE scientific (data JSON);
DROP TABLE IF EXISTS leading_zero;
CREATE TABLE leading_zero (data JSON);
DROP TABLE IF EXISTS special_float;
CREATE TABLE special_float (data JSON);
DROP TABLE IF EXISTS escapes;
CREATE TABLE escapes (data JSON);
DROP TABLE IF EXISTS bad_escape;
CREATE TABLE bad_escape (data JSON);
DROP TABLE IF EXISTS incomplete;
CREATE TABLE incomplete (data JSON);
DROP TABLE IF EXISTS whitespace;
CREATE TABLE whitespace (data JSON);
DROP TABLE IF EXISTS unclosed;
CREATE TABLE unclosed (data JSON);
DROP TABLE IF EXISTS truncated;
CREATE TABLE truncated (data JSON);
DROP TABLE IF EXISTS recovery;
CREATE TABLE recovery (id INT64, data JSON);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, data JSON);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id STRING, name STRING);
INSERT INTO users VALUES ('u1', 'Alice');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, data JSON);
DROP TABLE IF EXISTS tree;
CREATE TABLE tree (id INT64, data JSON);
DROP TABLE IF EXISTS concurrent;
CREATE TABLE concurrent (id INT64, data JSON);
DROP TABLE IF EXISTS writes;
CREATE TABLE writes (id INT64, data JSON);
DROP TABLE IF EXISTS perf;
CREATE TABLE perf (id INT64, data JSON);
DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);
INSERT INTO recovery VALUES (1, '{bad}');

SELECT JSON_EXTRACT(data, '$..$ref') FROM circular WHERE id = 1;
SELECT JSON_LENGTH(data, '$.large') FROM large_str;
SELECT JSON_LENGTH(data) FROM huge_array;
SELECT JSON_EXTRACT(data, '$.key500000') FROM huge_object;
SELECT JSON_EXTRACT(data, '$.lol') || JSON_EXTRACT(data, '$.lol4') FROM expansion;
SELECT JSON_EXTRACT(data, '$.emoji') FROM surrogates;
SELECT JSON_EXTRACT(data, '$.key') FROM bom;
SELECT JSON_EXTRACT(data, '$.text') FROM null_bytes;
SELECT JSON_VALUE(data, '$.num') FROM big_int;
SELECT JSON_VALUE(data, '$.num') FROM unsafe_int;
SELECT JSON_VALUE(data, '$.num') FROM tiny;
SELECT JSON_EXTRACT(data, '$.quote') FROM escapes;
SELECT COUNT(*) FROM recovery;
SELECT JSON_EXTRACT(data, '$.type') as event_type, COUNT(*) as count
FROM events
GROUP BY JSON_EXTRACT(data, '$.type')
ORDER BY count DESC;
SELECT u.name, o.id
FROM orders o
JOIN users u ON JSON_EXTRACT(o.data, '$.user_id') = u.user_id;
SELECT
JSON_EXTRACT(data, '$.region') as region,
JSON_VALUE(data, '$.amount') as amount,
SUM(CAST(JSON_VALUE(data, '$.amount') AS INT64))
OVER (PARTITION BY JSON_EXTRACT(data, '$.region')) as region_total
FROM sales;
WITH RECURSIVE tree_path AS (
SELECT id, JSON_VALUE(data, '$.name') as name
FROM tree
WHERE JSON_VALUE(data, '$.parent') IS NULL
UNION ALL
SELECT t.id, JSON_VALUE(t.data, '$.name')
FROM tree t
JOIN tree_path tp ON CAST(JSON_VALUE(t.data, '$.parent') AS INT64) = tp.id
)
SELECT * FROM tree_path;
SELECT JSON_VALUE(data, '$.value') FROM concurrent WHERE id = 1;
SELECT COUNT(*) FROM writes;
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

-- ============================================================================
-- Test: test_json_deeply_nested_array_performance
-- Source: json_extreme_edge_cases_tdd.rs:115
-- ============================================================================
DROP TABLE IF EXISTS deep_array;
CREATE TABLE deep_array (data JSON);
DROP TABLE IF EXISTS large_str;
CREATE TABLE large_str (data JSON);
DROP TABLE IF EXISTS huge_array;
CREATE TABLE huge_array (data JSON);
DROP TABLE IF EXISTS huge_object;
CREATE TABLE huge_object (data JSON);
DROP TABLE IF EXISTS expansion;
CREATE TABLE expansion (data JSON);
DROP TABLE IF EXISTS bad_encoding;
CREATE TABLE bad_encoding (data JSON);
INSERT INTO bad_encoding VALUES ('{\;
DROP TABLE IF EXISTS surrogates;
CREATE TABLE surrogates (data JSON);
DROP TABLE IF EXISTS bom;
CREATE TABLE bom (data JSON);
DROP TABLE IF EXISTS null_bytes;
CREATE TABLE null_bytes (data JSON);
DROP TABLE IF EXISTS unicode;
CREATE TABLE unicode (data JSON);
DROP TABLE IF EXISTS big_int;
CREATE TABLE big_int (data JSON);
DROP TABLE IF EXISTS unsafe_int;
CREATE TABLE unsafe_int (data JSON);
DROP TABLE IF EXISTS tiny;
CREATE TABLE tiny (data JSON);
DROP TABLE IF EXISTS scientific;
CREATE TABLE scientific (data JSON);
DROP TABLE IF EXISTS leading_zero;
CREATE TABLE leading_zero (data JSON);
DROP TABLE IF EXISTS special_float;
CREATE TABLE special_float (data JSON);
DROP TABLE IF EXISTS escapes;
CREATE TABLE escapes (data JSON);
DROP TABLE IF EXISTS bad_escape;
CREATE TABLE bad_escape (data JSON);
DROP TABLE IF EXISTS incomplete;
CREATE TABLE incomplete (data JSON);
DROP TABLE IF EXISTS whitespace;
CREATE TABLE whitespace (data JSON);
DROP TABLE IF EXISTS unclosed;
CREATE TABLE unclosed (data JSON);
DROP TABLE IF EXISTS truncated;
CREATE TABLE truncated (data JSON);
DROP TABLE IF EXISTS recovery;
CREATE TABLE recovery (id INT64, data JSON);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, data JSON);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id STRING, name STRING);
INSERT INTO users VALUES ('u1', 'Alice');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, data JSON);
DROP TABLE IF EXISTS tree;
CREATE TABLE tree (id INT64, data JSON);
DROP TABLE IF EXISTS concurrent;
CREATE TABLE concurrent (id INT64, data JSON);
DROP TABLE IF EXISTS writes;
CREATE TABLE writes (id INT64, data JSON);
DROP TABLE IF EXISTS perf;
CREATE TABLE perf (id INT64, data JSON);
DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);
INSERT INTO recovery VALUES (1, '{bad}');

SELECT JSON_LENGTH(data, '$.large') FROM large_str;
SELECT JSON_LENGTH(data) FROM huge_array;
SELECT JSON_EXTRACT(data, '$.key500000') FROM huge_object;
SELECT JSON_EXTRACT(data, '$.lol') || JSON_EXTRACT(data, '$.lol4') FROM expansion;
SELECT JSON_EXTRACT(data, '$.emoji') FROM surrogates;
SELECT JSON_EXTRACT(data, '$.key') FROM bom;
SELECT JSON_EXTRACT(data, '$.text') FROM null_bytes;
SELECT JSON_VALUE(data, '$.num') FROM big_int;
SELECT JSON_VALUE(data, '$.num') FROM unsafe_int;
SELECT JSON_VALUE(data, '$.num') FROM tiny;
SELECT JSON_EXTRACT(data, '$.quote') FROM escapes;
SELECT COUNT(*) FROM recovery;
SELECT JSON_EXTRACT(data, '$.type') as event_type, COUNT(*) as count
FROM events
GROUP BY JSON_EXTRACT(data, '$.type')
ORDER BY count DESC;
SELECT u.name, o.id
FROM orders o
JOIN users u ON JSON_EXTRACT(o.data, '$.user_id') = u.user_id;
SELECT
JSON_EXTRACT(data, '$.region') as region,
JSON_VALUE(data, '$.amount') as amount,
SUM(CAST(JSON_VALUE(data, '$.amount') AS INT64))
OVER (PARTITION BY JSON_EXTRACT(data, '$.region')) as region_total
FROM sales;
WITH RECURSIVE tree_path AS (
SELECT id, JSON_VALUE(data, '$.name') as name
FROM tree
WHERE JSON_VALUE(data, '$.parent') IS NULL
UNION ALL
SELECT t.id, JSON_VALUE(t.data, '$.name')
FROM tree t
JOIN tree_path tp ON CAST(JSON_VALUE(t.data, '$.parent') AS INT64) = tp.id
)
SELECT * FROM tree_path;
SELECT JSON_VALUE(data, '$.value') FROM concurrent WHERE id = 1;
SELECT COUNT(*) FROM writes;
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

-- ============================================================================
-- Test: test_json_extremely_large_string
-- Source: json_extreme_edge_cases_tdd.rs:150
-- ============================================================================
DROP TABLE IF EXISTS large_str;
CREATE TABLE large_str (data JSON);
DROP TABLE IF EXISTS huge_array;
CREATE TABLE huge_array (data JSON);
DROP TABLE IF EXISTS huge_object;
CREATE TABLE huge_object (data JSON);
DROP TABLE IF EXISTS expansion;
CREATE TABLE expansion (data JSON);
DROP TABLE IF EXISTS bad_encoding;
CREATE TABLE bad_encoding (data JSON);
INSERT INTO bad_encoding VALUES ('{\;
DROP TABLE IF EXISTS surrogates;
CREATE TABLE surrogates (data JSON);
DROP TABLE IF EXISTS bom;
CREATE TABLE bom (data JSON);
DROP TABLE IF EXISTS null_bytes;
CREATE TABLE null_bytes (data JSON);
DROP TABLE IF EXISTS unicode;
CREATE TABLE unicode (data JSON);
DROP TABLE IF EXISTS big_int;
CREATE TABLE big_int (data JSON);
DROP TABLE IF EXISTS unsafe_int;
CREATE TABLE unsafe_int (data JSON);
DROP TABLE IF EXISTS tiny;
CREATE TABLE tiny (data JSON);
DROP TABLE IF EXISTS scientific;
CREATE TABLE scientific (data JSON);
DROP TABLE IF EXISTS leading_zero;
CREATE TABLE leading_zero (data JSON);
DROP TABLE IF EXISTS special_float;
CREATE TABLE special_float (data JSON);
DROP TABLE IF EXISTS escapes;
CREATE TABLE escapes (data JSON);
DROP TABLE IF EXISTS bad_escape;
CREATE TABLE bad_escape (data JSON);
DROP TABLE IF EXISTS incomplete;
CREATE TABLE incomplete (data JSON);
DROP TABLE IF EXISTS whitespace;
CREATE TABLE whitespace (data JSON);
DROP TABLE IF EXISTS unclosed;
CREATE TABLE unclosed (data JSON);
DROP TABLE IF EXISTS truncated;
CREATE TABLE truncated (data JSON);
DROP TABLE IF EXISTS recovery;
CREATE TABLE recovery (id INT64, data JSON);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, data JSON);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id STRING, name STRING);
INSERT INTO users VALUES ('u1', 'Alice');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, data JSON);
DROP TABLE IF EXISTS tree;
CREATE TABLE tree (id INT64, data JSON);
DROP TABLE IF EXISTS concurrent;
CREATE TABLE concurrent (id INT64, data JSON);
DROP TABLE IF EXISTS writes;
CREATE TABLE writes (id INT64, data JSON);
DROP TABLE IF EXISTS perf;
CREATE TABLE perf (id INT64, data JSON);
DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);
INSERT INTO recovery VALUES (1, '{bad}');

SELECT JSON_LENGTH(data, '$.large') FROM large_str;
SELECT JSON_LENGTH(data) FROM huge_array;
SELECT JSON_EXTRACT(data, '$.key500000') FROM huge_object;
SELECT JSON_EXTRACT(data, '$.lol') || JSON_EXTRACT(data, '$.lol4') FROM expansion;
SELECT JSON_EXTRACT(data, '$.emoji') FROM surrogates;
SELECT JSON_EXTRACT(data, '$.key') FROM bom;
SELECT JSON_EXTRACT(data, '$.text') FROM null_bytes;
SELECT JSON_VALUE(data, '$.num') FROM big_int;
SELECT JSON_VALUE(data, '$.num') FROM unsafe_int;
SELECT JSON_VALUE(data, '$.num') FROM tiny;
SELECT JSON_EXTRACT(data, '$.quote') FROM escapes;
SELECT COUNT(*) FROM recovery;
SELECT JSON_EXTRACT(data, '$.type') as event_type, COUNT(*) as count
FROM events
GROUP BY JSON_EXTRACT(data, '$.type')
ORDER BY count DESC;
SELECT u.name, o.id
FROM orders o
JOIN users u ON JSON_EXTRACT(o.data, '$.user_id') = u.user_id;
SELECT
JSON_EXTRACT(data, '$.region') as region,
JSON_VALUE(data, '$.amount') as amount,
SUM(CAST(JSON_VALUE(data, '$.amount') AS INT64))
OVER (PARTITION BY JSON_EXTRACT(data, '$.region')) as region_total
FROM sales;
WITH RECURSIVE tree_path AS (
SELECT id, JSON_VALUE(data, '$.name') as name
FROM tree
WHERE JSON_VALUE(data, '$.parent') IS NULL
UNION ALL
SELECT t.id, JSON_VALUE(t.data, '$.name')
FROM tree t
JOIN tree_path tp ON CAST(JSON_VALUE(t.data, '$.parent') AS INT64) = tp.id
)
SELECT * FROM tree_path;
SELECT JSON_VALUE(data, '$.value') FROM concurrent WHERE id = 1;
SELECT COUNT(*) FROM writes;
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

-- ============================================================================
-- Test: test_json_array_with_million_elements
-- Source: json_extreme_edge_cases_tdd.rs:187
-- ============================================================================
DROP TABLE IF EXISTS huge_array;
CREATE TABLE huge_array (data JSON);
DROP TABLE IF EXISTS huge_object;
CREATE TABLE huge_object (data JSON);
DROP TABLE IF EXISTS expansion;
CREATE TABLE expansion (data JSON);
DROP TABLE IF EXISTS bad_encoding;
CREATE TABLE bad_encoding (data JSON);
INSERT INTO bad_encoding VALUES ('{\;
DROP TABLE IF EXISTS surrogates;
CREATE TABLE surrogates (data JSON);
DROP TABLE IF EXISTS bom;
CREATE TABLE bom (data JSON);
DROP TABLE IF EXISTS null_bytes;
CREATE TABLE null_bytes (data JSON);
DROP TABLE IF EXISTS unicode;
CREATE TABLE unicode (data JSON);
DROP TABLE IF EXISTS big_int;
CREATE TABLE big_int (data JSON);
DROP TABLE IF EXISTS unsafe_int;
CREATE TABLE unsafe_int (data JSON);
DROP TABLE IF EXISTS tiny;
CREATE TABLE tiny (data JSON);
DROP TABLE IF EXISTS scientific;
CREATE TABLE scientific (data JSON);
DROP TABLE IF EXISTS leading_zero;
CREATE TABLE leading_zero (data JSON);
DROP TABLE IF EXISTS special_float;
CREATE TABLE special_float (data JSON);
DROP TABLE IF EXISTS escapes;
CREATE TABLE escapes (data JSON);
DROP TABLE IF EXISTS bad_escape;
CREATE TABLE bad_escape (data JSON);
DROP TABLE IF EXISTS incomplete;
CREATE TABLE incomplete (data JSON);
DROP TABLE IF EXISTS whitespace;
CREATE TABLE whitespace (data JSON);
DROP TABLE IF EXISTS unclosed;
CREATE TABLE unclosed (data JSON);
DROP TABLE IF EXISTS truncated;
CREATE TABLE truncated (data JSON);
DROP TABLE IF EXISTS recovery;
CREATE TABLE recovery (id INT64, data JSON);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, data JSON);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id STRING, name STRING);
INSERT INTO users VALUES ('u1', 'Alice');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, data JSON);
DROP TABLE IF EXISTS tree;
CREATE TABLE tree (id INT64, data JSON);
DROP TABLE IF EXISTS concurrent;
CREATE TABLE concurrent (id INT64, data JSON);
DROP TABLE IF EXISTS writes;
CREATE TABLE writes (id INT64, data JSON);
DROP TABLE IF EXISTS perf;
CREATE TABLE perf (id INT64, data JSON);
DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);
INSERT INTO recovery VALUES (1, '{bad}');

SELECT JSON_LENGTH(data) FROM huge_array;
SELECT JSON_EXTRACT(data, '$.key500000') FROM huge_object;
SELECT JSON_EXTRACT(data, '$.lol') || JSON_EXTRACT(data, '$.lol4') FROM expansion;
SELECT JSON_EXTRACT(data, '$.emoji') FROM surrogates;
SELECT JSON_EXTRACT(data, '$.key') FROM bom;
SELECT JSON_EXTRACT(data, '$.text') FROM null_bytes;
SELECT JSON_VALUE(data, '$.num') FROM big_int;
SELECT JSON_VALUE(data, '$.num') FROM unsafe_int;
SELECT JSON_VALUE(data, '$.num') FROM tiny;
SELECT JSON_EXTRACT(data, '$.quote') FROM escapes;
SELECT COUNT(*) FROM recovery;
SELECT JSON_EXTRACT(data, '$.type') as event_type, COUNT(*) as count
FROM events
GROUP BY JSON_EXTRACT(data, '$.type')
ORDER BY count DESC;
SELECT u.name, o.id
FROM orders o
JOIN users u ON JSON_EXTRACT(o.data, '$.user_id') = u.user_id;
SELECT
JSON_EXTRACT(data, '$.region') as region,
JSON_VALUE(data, '$.amount') as amount,
SUM(CAST(JSON_VALUE(data, '$.amount') AS INT64))
OVER (PARTITION BY JSON_EXTRACT(data, '$.region')) as region_total
FROM sales;
WITH RECURSIVE tree_path AS (
SELECT id, JSON_VALUE(data, '$.name') as name
FROM tree
WHERE JSON_VALUE(data, '$.parent') IS NULL
UNION ALL
SELECT t.id, JSON_VALUE(t.data, '$.name')
FROM tree t
JOIN tree_path tp ON CAST(JSON_VALUE(t.data, '$.parent') AS INT64) = tp.id
)
SELECT * FROM tree_path;
SELECT JSON_VALUE(data, '$.value') FROM concurrent WHERE id = 1;
SELECT COUNT(*) FROM writes;
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

-- ============================================================================
-- Test: test_json_object_with_million_keys
-- Source: json_extreme_edge_cases_tdd.rs:232
-- ============================================================================
DROP TABLE IF EXISTS huge_object;
CREATE TABLE huge_object (data JSON);
DROP TABLE IF EXISTS expansion;
CREATE TABLE expansion (data JSON);
DROP TABLE IF EXISTS bad_encoding;
CREATE TABLE bad_encoding (data JSON);
INSERT INTO bad_encoding VALUES ('{\;
DROP TABLE IF EXISTS surrogates;
CREATE TABLE surrogates (data JSON);
DROP TABLE IF EXISTS bom;
CREATE TABLE bom (data JSON);
DROP TABLE IF EXISTS null_bytes;
CREATE TABLE null_bytes (data JSON);
DROP TABLE IF EXISTS unicode;
CREATE TABLE unicode (data JSON);
DROP TABLE IF EXISTS big_int;
CREATE TABLE big_int (data JSON);
DROP TABLE IF EXISTS unsafe_int;
CREATE TABLE unsafe_int (data JSON);
DROP TABLE IF EXISTS tiny;
CREATE TABLE tiny (data JSON);
DROP TABLE IF EXISTS scientific;
CREATE TABLE scientific (data JSON);
DROP TABLE IF EXISTS leading_zero;
CREATE TABLE leading_zero (data JSON);
DROP TABLE IF EXISTS special_float;
CREATE TABLE special_float (data JSON);
DROP TABLE IF EXISTS escapes;
CREATE TABLE escapes (data JSON);
DROP TABLE IF EXISTS bad_escape;
CREATE TABLE bad_escape (data JSON);
DROP TABLE IF EXISTS incomplete;
CREATE TABLE incomplete (data JSON);
DROP TABLE IF EXISTS whitespace;
CREATE TABLE whitespace (data JSON);
DROP TABLE IF EXISTS unclosed;
CREATE TABLE unclosed (data JSON);
DROP TABLE IF EXISTS truncated;
CREATE TABLE truncated (data JSON);
DROP TABLE IF EXISTS recovery;
CREATE TABLE recovery (id INT64, data JSON);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, data JSON);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id STRING, name STRING);
INSERT INTO users VALUES ('u1', 'Alice');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, data JSON);
DROP TABLE IF EXISTS tree;
CREATE TABLE tree (id INT64, data JSON);
DROP TABLE IF EXISTS concurrent;
CREATE TABLE concurrent (id INT64, data JSON);
DROP TABLE IF EXISTS writes;
CREATE TABLE writes (id INT64, data JSON);
DROP TABLE IF EXISTS perf;
CREATE TABLE perf (id INT64, data JSON);
DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);
INSERT INTO recovery VALUES (1, '{bad}');

SELECT JSON_EXTRACT(data, '$.key500000') FROM huge_object;
SELECT JSON_EXTRACT(data, '$.lol') || JSON_EXTRACT(data, '$.lol4') FROM expansion;
SELECT JSON_EXTRACT(data, '$.emoji') FROM surrogates;
SELECT JSON_EXTRACT(data, '$.key') FROM bom;
SELECT JSON_EXTRACT(data, '$.text') FROM null_bytes;
SELECT JSON_VALUE(data, '$.num') FROM big_int;
SELECT JSON_VALUE(data, '$.num') FROM unsafe_int;
SELECT JSON_VALUE(data, '$.num') FROM tiny;
SELECT JSON_EXTRACT(data, '$.quote') FROM escapes;
SELECT COUNT(*) FROM recovery;
SELECT JSON_EXTRACT(data, '$.type') as event_type, COUNT(*) as count
FROM events
GROUP BY JSON_EXTRACT(data, '$.type')
ORDER BY count DESC;
SELECT u.name, o.id
FROM orders o
JOIN users u ON JSON_EXTRACT(o.data, '$.user_id') = u.user_id;
SELECT
JSON_EXTRACT(data, '$.region') as region,
JSON_VALUE(data, '$.amount') as amount,
SUM(CAST(JSON_VALUE(data, '$.amount') AS INT64))
OVER (PARTITION BY JSON_EXTRACT(data, '$.region')) as region_total
FROM sales;
WITH RECURSIVE tree_path AS (
SELECT id, JSON_VALUE(data, '$.name') as name
FROM tree
WHERE JSON_VALUE(data, '$.parent') IS NULL
UNION ALL
SELECT t.id, JSON_VALUE(t.data, '$.name')
FROM tree t
JOIN tree_path tp ON CAST(JSON_VALUE(t.data, '$.parent') AS INT64) = tp.id
)
SELECT * FROM tree_path;
SELECT JSON_VALUE(data, '$.value') FROM concurrent WHERE id = 1;
SELECT COUNT(*) FROM writes;
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

-- ============================================================================
-- Test: test_json_billion_laughs_attack
-- Source: json_extreme_edge_cases_tdd.rs:271
-- ============================================================================
DROP TABLE IF EXISTS expansion;
CREATE TABLE expansion (data JSON);
DROP TABLE IF EXISTS bad_encoding;
CREATE TABLE bad_encoding (data JSON);
INSERT INTO bad_encoding VALUES ('{\;
DROP TABLE IF EXISTS surrogates;
CREATE TABLE surrogates (data JSON);
DROP TABLE IF EXISTS bom;
CREATE TABLE bom (data JSON);
DROP TABLE IF EXISTS null_bytes;
CREATE TABLE null_bytes (data JSON);
DROP TABLE IF EXISTS unicode;
CREATE TABLE unicode (data JSON);
DROP TABLE IF EXISTS big_int;
CREATE TABLE big_int (data JSON);
DROP TABLE IF EXISTS unsafe_int;
CREATE TABLE unsafe_int (data JSON);
DROP TABLE IF EXISTS tiny;
CREATE TABLE tiny (data JSON);
DROP TABLE IF EXISTS scientific;
CREATE TABLE scientific (data JSON);
DROP TABLE IF EXISTS leading_zero;
CREATE TABLE leading_zero (data JSON);
DROP TABLE IF EXISTS special_float;
CREATE TABLE special_float (data JSON);
DROP TABLE IF EXISTS escapes;
CREATE TABLE escapes (data JSON);
DROP TABLE IF EXISTS bad_escape;
CREATE TABLE bad_escape (data JSON);
DROP TABLE IF EXISTS incomplete;
CREATE TABLE incomplete (data JSON);
DROP TABLE IF EXISTS whitespace;
CREATE TABLE whitespace (data JSON);
DROP TABLE IF EXISTS unclosed;
CREATE TABLE unclosed (data JSON);
DROP TABLE IF EXISTS truncated;
CREATE TABLE truncated (data JSON);
DROP TABLE IF EXISTS recovery;
CREATE TABLE recovery (id INT64, data JSON);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, data JSON);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id STRING, name STRING);
INSERT INTO users VALUES ('u1', 'Alice');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, data JSON);
DROP TABLE IF EXISTS tree;
CREATE TABLE tree (id INT64, data JSON);
DROP TABLE IF EXISTS concurrent;
CREATE TABLE concurrent (id INT64, data JSON);
DROP TABLE IF EXISTS writes;
CREATE TABLE writes (id INT64, data JSON);
DROP TABLE IF EXISTS perf;
CREATE TABLE perf (id INT64, data JSON);
DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);
INSERT INTO recovery VALUES (1, '{bad}');

SELECT JSON_EXTRACT(data, '$.lol') || JSON_EXTRACT(data, '$.lol4') FROM expansion;
SELECT JSON_EXTRACT(data, '$.emoji') FROM surrogates;
SELECT JSON_EXTRACT(data, '$.key') FROM bom;
SELECT JSON_EXTRACT(data, '$.text') FROM null_bytes;
SELECT JSON_VALUE(data, '$.num') FROM big_int;
SELECT JSON_VALUE(data, '$.num') FROM unsafe_int;
SELECT JSON_VALUE(data, '$.num') FROM tiny;
SELECT JSON_EXTRACT(data, '$.quote') FROM escapes;
SELECT COUNT(*) FROM recovery;
SELECT JSON_EXTRACT(data, '$.type') as event_type, COUNT(*) as count
FROM events
GROUP BY JSON_EXTRACT(data, '$.type')
ORDER BY count DESC;
SELECT u.name, o.id
FROM orders o
JOIN users u ON JSON_EXTRACT(o.data, '$.user_id') = u.user_id;
SELECT
JSON_EXTRACT(data, '$.region') as region,
JSON_VALUE(data, '$.amount') as amount,
SUM(CAST(JSON_VALUE(data, '$.amount') AS INT64))
OVER (PARTITION BY JSON_EXTRACT(data, '$.region')) as region_total
FROM sales;
WITH RECURSIVE tree_path AS (
SELECT id, JSON_VALUE(data, '$.name') as name
FROM tree
WHERE JSON_VALUE(data, '$.parent') IS NULL
UNION ALL
SELECT t.id, JSON_VALUE(t.data, '$.name')
FROM tree t
JOIN tree_path tp ON CAST(JSON_VALUE(t.data, '$.parent') AS INT64) = tp.id
)
SELECT * FROM tree_path;
SELECT JSON_VALUE(data, '$.value') FROM concurrent WHERE id = 1;
SELECT COUNT(*) FROM writes;
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

-- ============================================================================
-- Test: test_json_invalid_utf8_sequences
-- Source: json_extreme_edge_cases_tdd.rs:308
-- ============================================================================
DROP TABLE IF EXISTS bad_encoding;
CREATE TABLE bad_encoding (data JSON);
INSERT INTO bad_encoding VALUES ('{\;
DROP TABLE IF EXISTS surrogates;
CREATE TABLE surrogates (data JSON);
DROP TABLE IF EXISTS bom;
CREATE TABLE bom (data JSON);
DROP TABLE IF EXISTS null_bytes;
CREATE TABLE null_bytes (data JSON);
DROP TABLE IF EXISTS unicode;
CREATE TABLE unicode (data JSON);
DROP TABLE IF EXISTS big_int;
CREATE TABLE big_int (data JSON);
DROP TABLE IF EXISTS unsafe_int;
CREATE TABLE unsafe_int (data JSON);
DROP TABLE IF EXISTS tiny;
CREATE TABLE tiny (data JSON);
DROP TABLE IF EXISTS scientific;
CREATE TABLE scientific (data JSON);
DROP TABLE IF EXISTS leading_zero;
CREATE TABLE leading_zero (data JSON);
DROP TABLE IF EXISTS special_float;
CREATE TABLE special_float (data JSON);
DROP TABLE IF EXISTS escapes;
CREATE TABLE escapes (data JSON);
DROP TABLE IF EXISTS bad_escape;
CREATE TABLE bad_escape (data JSON);
DROP TABLE IF EXISTS incomplete;
CREATE TABLE incomplete (data JSON);
DROP TABLE IF EXISTS whitespace;
CREATE TABLE whitespace (data JSON);
DROP TABLE IF EXISTS unclosed;
CREATE TABLE unclosed (data JSON);
DROP TABLE IF EXISTS truncated;
CREATE TABLE truncated (data JSON);
DROP TABLE IF EXISTS recovery;
CREATE TABLE recovery (id INT64, data JSON);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, data JSON);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id STRING, name STRING);
INSERT INTO users VALUES ('u1', 'Alice');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, data JSON);
DROP TABLE IF EXISTS tree;
CREATE TABLE tree (id INT64, data JSON);
DROP TABLE IF EXISTS concurrent;
CREATE TABLE concurrent (id INT64, data JSON);
DROP TABLE IF EXISTS writes;
CREATE TABLE writes (id INT64, data JSON);
DROP TABLE IF EXISTS perf;
CREATE TABLE perf (id INT64, data JSON);
DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);
INSERT INTO recovery VALUES (1, '{bad}');

SELECT JSON_EXTRACT(data, '$.emoji') FROM surrogates;
SELECT JSON_EXTRACT(data, '$.key') FROM bom;
SELECT JSON_EXTRACT(data, '$.text') FROM null_bytes;
SELECT JSON_VALUE(data, '$.num') FROM big_int;
SELECT JSON_VALUE(data, '$.num') FROM unsafe_int;
SELECT JSON_VALUE(data, '$.num') FROM tiny;
SELECT JSON_EXTRACT(data, '$.quote') FROM escapes;
SELECT COUNT(*) FROM recovery;
SELECT JSON_EXTRACT(data, '$.type') as event_type, COUNT(*) as count
FROM events
GROUP BY JSON_EXTRACT(data, '$.type')
ORDER BY count DESC;
SELECT u.name, o.id
FROM orders o
JOIN users u ON JSON_EXTRACT(o.data, '$.user_id') = u.user_id;
SELECT
JSON_EXTRACT(data, '$.region') as region,
JSON_VALUE(data, '$.amount') as amount,
SUM(CAST(JSON_VALUE(data, '$.amount') AS INT64))
OVER (PARTITION BY JSON_EXTRACT(data, '$.region')) as region_total
FROM sales;
WITH RECURSIVE tree_path AS (
SELECT id, JSON_VALUE(data, '$.name') as name
FROM tree
WHERE JSON_VALUE(data, '$.parent') IS NULL
UNION ALL
SELECT t.id, JSON_VALUE(t.data, '$.name')
FROM tree t
JOIN tree_path tp ON CAST(JSON_VALUE(t.data, '$.parent') AS INT64) = tp.id
)
SELECT * FROM tree_path;
SELECT JSON_VALUE(data, '$.value') FROM concurrent WHERE id = 1;
SELECT COUNT(*) FROM writes;
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

-- ============================================================================
-- Test: test_json_surrogate_pairs
-- Source: json_extreme_edge_cases_tdd.rs:330
-- ============================================================================
DROP TABLE IF EXISTS surrogates;
CREATE TABLE surrogates (data JSON);
DROP TABLE IF EXISTS bom;
CREATE TABLE bom (data JSON);
DROP TABLE IF EXISTS null_bytes;
CREATE TABLE null_bytes (data JSON);
DROP TABLE IF EXISTS unicode;
CREATE TABLE unicode (data JSON);
DROP TABLE IF EXISTS big_int;
CREATE TABLE big_int (data JSON);
DROP TABLE IF EXISTS unsafe_int;
CREATE TABLE unsafe_int (data JSON);
DROP TABLE IF EXISTS tiny;
CREATE TABLE tiny (data JSON);
DROP TABLE IF EXISTS scientific;
CREATE TABLE scientific (data JSON);
DROP TABLE IF EXISTS leading_zero;
CREATE TABLE leading_zero (data JSON);
DROP TABLE IF EXISTS special_float;
CREATE TABLE special_float (data JSON);
DROP TABLE IF EXISTS escapes;
CREATE TABLE escapes (data JSON);
DROP TABLE IF EXISTS bad_escape;
CREATE TABLE bad_escape (data JSON);
DROP TABLE IF EXISTS incomplete;
CREATE TABLE incomplete (data JSON);
DROP TABLE IF EXISTS whitespace;
CREATE TABLE whitespace (data JSON);
DROP TABLE IF EXISTS unclosed;
CREATE TABLE unclosed (data JSON);
DROP TABLE IF EXISTS truncated;
CREATE TABLE truncated (data JSON);
DROP TABLE IF EXISTS recovery;
CREATE TABLE recovery (id INT64, data JSON);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, data JSON);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id STRING, name STRING);
INSERT INTO users VALUES ('u1', 'Alice');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, data JSON);
DROP TABLE IF EXISTS tree;
CREATE TABLE tree (id INT64, data JSON);
DROP TABLE IF EXISTS concurrent;
CREATE TABLE concurrent (id INT64, data JSON);
DROP TABLE IF EXISTS writes;
CREATE TABLE writes (id INT64, data JSON);
DROP TABLE IF EXISTS perf;
CREATE TABLE perf (id INT64, data JSON);
DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);
INSERT INTO recovery VALUES (1, '{bad}');

SELECT JSON_EXTRACT(data, '$.emoji') FROM surrogates;
SELECT JSON_EXTRACT(data, '$.key') FROM bom;
SELECT JSON_EXTRACT(data, '$.text') FROM null_bytes;
SELECT JSON_VALUE(data, '$.num') FROM big_int;
SELECT JSON_VALUE(data, '$.num') FROM unsafe_int;
SELECT JSON_VALUE(data, '$.num') FROM tiny;
SELECT JSON_EXTRACT(data, '$.quote') FROM escapes;
SELECT COUNT(*) FROM recovery;
SELECT JSON_EXTRACT(data, '$.type') as event_type, COUNT(*) as count
FROM events
GROUP BY JSON_EXTRACT(data, '$.type')
ORDER BY count DESC;
SELECT u.name, o.id
FROM orders o
JOIN users u ON JSON_EXTRACT(o.data, '$.user_id') = u.user_id;
SELECT
JSON_EXTRACT(data, '$.region') as region,
JSON_VALUE(data, '$.amount') as amount,
SUM(CAST(JSON_VALUE(data, '$.amount') AS INT64))
OVER (PARTITION BY JSON_EXTRACT(data, '$.region')) as region_total
FROM sales;
WITH RECURSIVE tree_path AS (
SELECT id, JSON_VALUE(data, '$.name') as name
FROM tree
WHERE JSON_VALUE(data, '$.parent') IS NULL
UNION ALL
SELECT t.id, JSON_VALUE(t.data, '$.name')
FROM tree t
JOIN tree_path tp ON CAST(JSON_VALUE(t.data, '$.parent') AS INT64) = tp.id
)
SELECT * FROM tree_path;
SELECT JSON_VALUE(data, '$.value') FROM concurrent WHERE id = 1;
SELECT COUNT(*) FROM writes;
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

-- ============================================================================
-- Test: test_json_byte_order_mark
-- Source: json_extreme_edge_cases_tdd.rs:360
-- ============================================================================
DROP TABLE IF EXISTS bom;
CREATE TABLE bom (data JSON);
DROP TABLE IF EXISTS null_bytes;
CREATE TABLE null_bytes (data JSON);
DROP TABLE IF EXISTS unicode;
CREATE TABLE unicode (data JSON);
DROP TABLE IF EXISTS big_int;
CREATE TABLE big_int (data JSON);
DROP TABLE IF EXISTS unsafe_int;
CREATE TABLE unsafe_int (data JSON);
DROP TABLE IF EXISTS tiny;
CREATE TABLE tiny (data JSON);
DROP TABLE IF EXISTS scientific;
CREATE TABLE scientific (data JSON);
DROP TABLE IF EXISTS leading_zero;
CREATE TABLE leading_zero (data JSON);
DROP TABLE IF EXISTS special_float;
CREATE TABLE special_float (data JSON);
DROP TABLE IF EXISTS escapes;
CREATE TABLE escapes (data JSON);
DROP TABLE IF EXISTS bad_escape;
CREATE TABLE bad_escape (data JSON);
DROP TABLE IF EXISTS incomplete;
CREATE TABLE incomplete (data JSON);
DROP TABLE IF EXISTS whitespace;
CREATE TABLE whitespace (data JSON);
DROP TABLE IF EXISTS unclosed;
CREATE TABLE unclosed (data JSON);
DROP TABLE IF EXISTS truncated;
CREATE TABLE truncated (data JSON);
DROP TABLE IF EXISTS recovery;
CREATE TABLE recovery (id INT64, data JSON);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, data JSON);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id STRING, name STRING);
INSERT INTO users VALUES ('u1', 'Alice');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, data JSON);
DROP TABLE IF EXISTS tree;
CREATE TABLE tree (id INT64, data JSON);
DROP TABLE IF EXISTS concurrent;
CREATE TABLE concurrent (id INT64, data JSON);
DROP TABLE IF EXISTS writes;
CREATE TABLE writes (id INT64, data JSON);
DROP TABLE IF EXISTS perf;
CREATE TABLE perf (id INT64, data JSON);
DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);
INSERT INTO recovery VALUES (1, '{bad}');

SELECT JSON_EXTRACT(data, '$.key') FROM bom;
SELECT JSON_EXTRACT(data, '$.text') FROM null_bytes;
SELECT JSON_VALUE(data, '$.num') FROM big_int;
SELECT JSON_VALUE(data, '$.num') FROM unsafe_int;
SELECT JSON_VALUE(data, '$.num') FROM tiny;
SELECT JSON_EXTRACT(data, '$.quote') FROM escapes;
SELECT COUNT(*) FROM recovery;
SELECT JSON_EXTRACT(data, '$.type') as event_type, COUNT(*) as count
FROM events
GROUP BY JSON_EXTRACT(data, '$.type')
ORDER BY count DESC;
SELECT u.name, o.id
FROM orders o
JOIN users u ON JSON_EXTRACT(o.data, '$.user_id') = u.user_id;
SELECT
JSON_EXTRACT(data, '$.region') as region,
JSON_VALUE(data, '$.amount') as amount,
SUM(CAST(JSON_VALUE(data, '$.amount') AS INT64))
OVER (PARTITION BY JSON_EXTRACT(data, '$.region')) as region_total
FROM sales;
WITH RECURSIVE tree_path AS (
SELECT id, JSON_VALUE(data, '$.name') as name
FROM tree
WHERE JSON_VALUE(data, '$.parent') IS NULL
UNION ALL
SELECT t.id, JSON_VALUE(t.data, '$.name')
FROM tree t
JOIN tree_path tp ON CAST(JSON_VALUE(t.data, '$.parent') AS INT64) = tp.id
)
SELECT * FROM tree_path;
SELECT JSON_VALUE(data, '$.value') FROM concurrent WHERE id = 1;
SELECT COUNT(*) FROM writes;
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

-- ============================================================================
-- Test: test_json_null_bytes_in_strings
-- Source: json_extreme_edge_cases_tdd.rs:388
-- ============================================================================
DROP TABLE IF EXISTS null_bytes;
CREATE TABLE null_bytes (data JSON);
DROP TABLE IF EXISTS unicode;
CREATE TABLE unicode (data JSON);
DROP TABLE IF EXISTS big_int;
CREATE TABLE big_int (data JSON);
DROP TABLE IF EXISTS unsafe_int;
CREATE TABLE unsafe_int (data JSON);
DROP TABLE IF EXISTS tiny;
CREATE TABLE tiny (data JSON);
DROP TABLE IF EXISTS scientific;
CREATE TABLE scientific (data JSON);
DROP TABLE IF EXISTS leading_zero;
CREATE TABLE leading_zero (data JSON);
DROP TABLE IF EXISTS special_float;
CREATE TABLE special_float (data JSON);
DROP TABLE IF EXISTS escapes;
CREATE TABLE escapes (data JSON);
DROP TABLE IF EXISTS bad_escape;
CREATE TABLE bad_escape (data JSON);
DROP TABLE IF EXISTS incomplete;
CREATE TABLE incomplete (data JSON);
DROP TABLE IF EXISTS whitespace;
CREATE TABLE whitespace (data JSON);
DROP TABLE IF EXISTS unclosed;
CREATE TABLE unclosed (data JSON);
DROP TABLE IF EXISTS truncated;
CREATE TABLE truncated (data JSON);
DROP TABLE IF EXISTS recovery;
CREATE TABLE recovery (id INT64, data JSON);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, data JSON);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id STRING, name STRING);
INSERT INTO users VALUES ('u1', 'Alice');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, data JSON);
DROP TABLE IF EXISTS tree;
CREATE TABLE tree (id INT64, data JSON);
DROP TABLE IF EXISTS concurrent;
CREATE TABLE concurrent (id INT64, data JSON);
DROP TABLE IF EXISTS writes;
CREATE TABLE writes (id INT64, data JSON);
DROP TABLE IF EXISTS perf;
CREATE TABLE perf (id INT64, data JSON);
DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);
INSERT INTO recovery VALUES (1, '{bad}');

SELECT JSON_EXTRACT(data, '$.text') FROM null_bytes;
SELECT JSON_VALUE(data, '$.num') FROM big_int;
SELECT JSON_VALUE(data, '$.num') FROM unsafe_int;
SELECT JSON_VALUE(data, '$.num') FROM tiny;
SELECT JSON_EXTRACT(data, '$.quote') FROM escapes;
SELECT COUNT(*) FROM recovery;
SELECT JSON_EXTRACT(data, '$.type') as event_type, COUNT(*) as count
FROM events
GROUP BY JSON_EXTRACT(data, '$.type')
ORDER BY count DESC;
SELECT u.name, o.id
FROM orders o
JOIN users u ON JSON_EXTRACT(o.data, '$.user_id') = u.user_id;
SELECT
JSON_EXTRACT(data, '$.region') as region,
JSON_VALUE(data, '$.amount') as amount,
SUM(CAST(JSON_VALUE(data, '$.amount') AS INT64))
OVER (PARTITION BY JSON_EXTRACT(data, '$.region')) as region_total
FROM sales;
WITH RECURSIVE tree_path AS (
SELECT id, JSON_VALUE(data, '$.name') as name
FROM tree
WHERE JSON_VALUE(data, '$.parent') IS NULL
UNION ALL
SELECT t.id, JSON_VALUE(t.data, '$.name')
FROM tree t
JOIN tree_path tp ON CAST(JSON_VALUE(t.data, '$.parent') AS INT64) = tp.id
)
SELECT * FROM tree_path;
SELECT JSON_VALUE(data, '$.value') FROM concurrent WHERE id = 1;
SELECT COUNT(*) FROM writes;
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

-- ============================================================================
-- Test: test_json_all_unicode_escapes
-- Source: json_extreme_edge_cases_tdd.rs:410
-- ============================================================================
DROP TABLE IF EXISTS unicode;
CREATE TABLE unicode (data JSON);
DROP TABLE IF EXISTS big_int;
CREATE TABLE big_int (data JSON);
DROP TABLE IF EXISTS unsafe_int;
CREATE TABLE unsafe_int (data JSON);
DROP TABLE IF EXISTS tiny;
CREATE TABLE tiny (data JSON);
DROP TABLE IF EXISTS scientific;
CREATE TABLE scientific (data JSON);
DROP TABLE IF EXISTS leading_zero;
CREATE TABLE leading_zero (data JSON);
DROP TABLE IF EXISTS special_float;
CREATE TABLE special_float (data JSON);
DROP TABLE IF EXISTS escapes;
CREATE TABLE escapes (data JSON);
DROP TABLE IF EXISTS bad_escape;
CREATE TABLE bad_escape (data JSON);
DROP TABLE IF EXISTS incomplete;
CREATE TABLE incomplete (data JSON);
DROP TABLE IF EXISTS whitespace;
CREATE TABLE whitespace (data JSON);
DROP TABLE IF EXISTS unclosed;
CREATE TABLE unclosed (data JSON);
DROP TABLE IF EXISTS truncated;
CREATE TABLE truncated (data JSON);
DROP TABLE IF EXISTS recovery;
CREATE TABLE recovery (id INT64, data JSON);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, data JSON);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id STRING, name STRING);
INSERT INTO users VALUES ('u1', 'Alice');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, data JSON);
DROP TABLE IF EXISTS tree;
CREATE TABLE tree (id INT64, data JSON);
DROP TABLE IF EXISTS concurrent;
CREATE TABLE concurrent (id INT64, data JSON);
DROP TABLE IF EXISTS writes;
CREATE TABLE writes (id INT64, data JSON);
DROP TABLE IF EXISTS perf;
CREATE TABLE perf (id INT64, data JSON);
DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);
INSERT INTO recovery VALUES (1, '{bad}');

SELECT JSON_VALUE(data, '$.num') FROM big_int;
SELECT JSON_VALUE(data, '$.num') FROM unsafe_int;
SELECT JSON_VALUE(data, '$.num') FROM tiny;
SELECT JSON_EXTRACT(data, '$.quote') FROM escapes;
SELECT COUNT(*) FROM recovery;
SELECT JSON_EXTRACT(data, '$.type') as event_type, COUNT(*) as count
FROM events
GROUP BY JSON_EXTRACT(data, '$.type')
ORDER BY count DESC;
SELECT u.name, o.id
FROM orders o
JOIN users u ON JSON_EXTRACT(o.data, '$.user_id') = u.user_id;
SELECT
JSON_EXTRACT(data, '$.region') as region,
JSON_VALUE(data, '$.amount') as amount,
SUM(CAST(JSON_VALUE(data, '$.amount') AS INT64))
OVER (PARTITION BY JSON_EXTRACT(data, '$.region')) as region_total
FROM sales;
WITH RECURSIVE tree_path AS (
SELECT id, JSON_VALUE(data, '$.name') as name
FROM tree
WHERE JSON_VALUE(data, '$.parent') IS NULL
UNION ALL
SELECT t.id, JSON_VALUE(t.data, '$.name')
FROM tree t
JOIN tree_path tp ON CAST(JSON_VALUE(t.data, '$.parent') AS INT64) = tp.id
)
SELECT * FROM tree_path;
SELECT JSON_VALUE(data, '$.value') FROM concurrent WHERE id = 1;
SELECT COUNT(*) FROM writes;
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

-- ============================================================================
-- Test: test_json_number_max_safe_integer
-- Source: json_extreme_edge_cases_tdd.rs:445
-- ============================================================================
DROP TABLE IF EXISTS big_int;
CREATE TABLE big_int (data JSON);
DROP TABLE IF EXISTS unsafe_int;
CREATE TABLE unsafe_int (data JSON);
DROP TABLE IF EXISTS tiny;
CREATE TABLE tiny (data JSON);
DROP TABLE IF EXISTS scientific;
CREATE TABLE scientific (data JSON);
DROP TABLE IF EXISTS leading_zero;
CREATE TABLE leading_zero (data JSON);
DROP TABLE IF EXISTS special_float;
CREATE TABLE special_float (data JSON);
DROP TABLE IF EXISTS escapes;
CREATE TABLE escapes (data JSON);
DROP TABLE IF EXISTS bad_escape;
CREATE TABLE bad_escape (data JSON);
DROP TABLE IF EXISTS incomplete;
CREATE TABLE incomplete (data JSON);
DROP TABLE IF EXISTS whitespace;
CREATE TABLE whitespace (data JSON);
DROP TABLE IF EXISTS unclosed;
CREATE TABLE unclosed (data JSON);
DROP TABLE IF EXISTS truncated;
CREATE TABLE truncated (data JSON);
DROP TABLE IF EXISTS recovery;
CREATE TABLE recovery (id INT64, data JSON);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, data JSON);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id STRING, name STRING);
INSERT INTO users VALUES ('u1', 'Alice');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, data JSON);
DROP TABLE IF EXISTS tree;
CREATE TABLE tree (id INT64, data JSON);
DROP TABLE IF EXISTS concurrent;
CREATE TABLE concurrent (id INT64, data JSON);
DROP TABLE IF EXISTS writes;
CREATE TABLE writes (id INT64, data JSON);
DROP TABLE IF EXISTS perf;
CREATE TABLE perf (id INT64, data JSON);
DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);
INSERT INTO recovery VALUES (1, '{bad}');

SELECT JSON_VALUE(data, '$.num') FROM big_int;
SELECT JSON_VALUE(data, '$.num') FROM unsafe_int;
SELECT JSON_VALUE(data, '$.num') FROM tiny;
SELECT JSON_EXTRACT(data, '$.quote') FROM escapes;
SELECT COUNT(*) FROM recovery;
SELECT JSON_EXTRACT(data, '$.type') as event_type, COUNT(*) as count
FROM events
GROUP BY JSON_EXTRACT(data, '$.type')
ORDER BY count DESC;
SELECT u.name, o.id
FROM orders o
JOIN users u ON JSON_EXTRACT(o.data, '$.user_id') = u.user_id;
SELECT
JSON_EXTRACT(data, '$.region') as region,
JSON_VALUE(data, '$.amount') as amount,
SUM(CAST(JSON_VALUE(data, '$.amount') AS INT64))
OVER (PARTITION BY JSON_EXTRACT(data, '$.region')) as region_total
FROM sales;
WITH RECURSIVE tree_path AS (
SELECT id, JSON_VALUE(data, '$.name') as name
FROM tree
WHERE JSON_VALUE(data, '$.parent') IS NULL
UNION ALL
SELECT t.id, JSON_VALUE(t.data, '$.name')
FROM tree t
JOIN tree_path tp ON CAST(JSON_VALUE(t.data, '$.parent') AS INT64) = tp.id
)
SELECT * FROM tree_path;
SELECT JSON_VALUE(data, '$.value') FROM concurrent WHERE id = 1;
SELECT COUNT(*) FROM writes;
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

-- ============================================================================
-- Test: test_json_number_beyond_safe_integer
-- Source: json_extreme_edge_cases_tdd.rs:477
-- ============================================================================
DROP TABLE IF EXISTS unsafe_int;
CREATE TABLE unsafe_int (data JSON);
DROP TABLE IF EXISTS tiny;
CREATE TABLE tiny (data JSON);
DROP TABLE IF EXISTS scientific;
CREATE TABLE scientific (data JSON);
DROP TABLE IF EXISTS leading_zero;
CREATE TABLE leading_zero (data JSON);
DROP TABLE IF EXISTS special_float;
CREATE TABLE special_float (data JSON);
DROP TABLE IF EXISTS escapes;
CREATE TABLE escapes (data JSON);
DROP TABLE IF EXISTS bad_escape;
CREATE TABLE bad_escape (data JSON);
DROP TABLE IF EXISTS incomplete;
CREATE TABLE incomplete (data JSON);
DROP TABLE IF EXISTS whitespace;
CREATE TABLE whitespace (data JSON);
DROP TABLE IF EXISTS unclosed;
CREATE TABLE unclosed (data JSON);
DROP TABLE IF EXISTS truncated;
CREATE TABLE truncated (data JSON);
DROP TABLE IF EXISTS recovery;
CREATE TABLE recovery (id INT64, data JSON);
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, data JSON);
DROP TABLE IF EXISTS users;
CREATE TABLE users (user_id STRING, name STRING);
INSERT INTO users VALUES ('u1', 'Alice');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (id INT64, data JSON);
DROP TABLE IF EXISTS tree;
CREATE TABLE tree (id INT64, data JSON);
DROP TABLE IF EXISTS concurrent;
CREATE TABLE concurrent (id INT64, data JSON);
DROP TABLE IF EXISTS writes;
CREATE TABLE writes (id INT64, data JSON);
DROP TABLE IF EXISTS perf;
CREATE TABLE perf (id INT64, data JSON);
DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);
INSERT INTO recovery VALUES (1, '{bad}');

SELECT JSON_VALUE(data, '$.num') FROM unsafe_int;
SELECT JSON_VALUE(data, '$.num') FROM tiny;
SELECT JSON_EXTRACT(data, '$.quote') FROM escapes;
SELECT COUNT(*) FROM recovery;
SELECT JSON_EXTRACT(data, '$.type') as event_type, COUNT(*) as count
FROM events
GROUP BY JSON_EXTRACT(data, '$.type')
ORDER BY count DESC;
SELECT u.name, o.id
FROM orders o
JOIN users u ON JSON_EXTRACT(o.data, '$.user_id') = u.user_id;
SELECT
JSON_EXTRACT(data, '$.region') as region,
JSON_VALUE(data, '$.amount') as amount,
SUM(CAST(JSON_VALUE(data, '$.amount') AS INT64))
OVER (PARTITION BY JSON_EXTRACT(data, '$.region')) as region_total
FROM sales;
WITH RECURSIVE tree_path AS (
SELECT id, JSON_VALUE(data, '$.name') as name
FROM tree
WHERE JSON_VALUE(data, '$.parent') IS NULL
UNION ALL
SELECT t.id, JSON_VALUE(t.data, '$.name')
FROM tree t
JOIN tree_path tp ON CAST(JSON_VALUE(t.data, '$.parent') AS INT64) = tp.id
)
SELECT * FROM tree_path;
SELECT JSON_VALUE(data, '$.value') FROM concurrent WHERE id = 1;
SELECT COUNT(*) FROM writes;
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

-- ============================================================================
-- Test: test_cast_int64_max_to_float64
-- Source: type_casting_edge_cases_tdd.rs:28
-- ============================================================================
DROP TABLE IF EXISTS limits;
CREATE TABLE limits (id INT64, max_int INT64);
DROP TABLE IF EXISTS limits;
CREATE TABLE limits (id INT64, min_int INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large_float FLOAT64);
INSERT INTO data VALUES (1, 9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, neg_float FLOAT64);
INSERT INTO data VALUES (1, -9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, f FLOAT64);
INSERT INTO data VALUES (1, 3.7), (2, -3.7), (3, 3.2), (4, -3.2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64);
INSERT INTO data VALUES (1, 42), (2, -42), (3, 0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large_int INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '  ');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '123abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '3.14');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'abc'), (2, '123'), (3, 'xyz');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, f FLOAT64);
INSERT INTO data VALUES (1, 9.223372036854776e18), (2, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 10.0), (2, 10, 10.1), (3, 10, 9.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 3, 2.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, a INT64, b STRING);
INSERT INTO data VALUES (1, 10, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value STRING);
INSERT INTO data VALUES (1, 'A', '100'), (2, 'B', 'N/A'), (3, 'A', '200');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '30');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value INT64);
INSERT INTO data VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30);
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_val STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO config VALUES ('50');
INSERT INTO data VALUES (1, 30), (2, 60), (3, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false), (3, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, num INT64);
INSERT INTO data VALUES (1, 0), (2, 1), (3, -5), (4, 42), (5, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE'), (5, '1'), (6, '0');

SELECT id, CAST(max_int AS FLOAT64) as max_float FROM limits;
SELECT id, CAST(min_int AS FLOAT64) as min_float FROM limits;
SELECT CAST(large_float AS INT64) FROM data;
SELECT CAST(neg_float AS INT64) FROM data;
SELECT CAST(value AS STRING) as str_val FROM data;
SELECT CAST(text AS INT64) as int_val FROM data;
SELECT CAST(CAST(CAST(value AS STRING) AS INT64) AS FLOAT64) as final_val FROM data;
SELECT id, CAST(f AS INT64) as int_val FROM data ORDER BY id;
SELECT id, CAST(i AS FLOAT64) as f FROM data ORDER BY id;
SELECT CAST(large_int AS FLOAT64) as f FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT id, TRY_CAST(text AS INT64) as safe_int FROM data ORDER BY id;
SELECT id, TRY_CAST(f AS INT64) as safe_int FROM data ORDER BY id;
SELECT i + f as sum FROM data;
SELECT id FROM data WHERE i = f ORDER BY id;
SELECT i * f as product FROM data;
SELECT a + CAST(b AS INT64) as sum FROM data;
SELECT id,
CASE WHEN category = 'A' THEN CAST(value AS INT64)
ELSE 0
END as parsed_value
FROM data
ORDER BY id;
SELECT id FROM data WHERE CAST(text_num AS INT64) > 8 ORDER BY id;
SELECT SUM(CAST(text_num AS INT64)) as total FROM data;
SELECT category, CAST(SUM(value) AS STRING) as total_str
FROM data
GROUP BY category
ORDER BY category;
SELECT id FROM data WHERE value < (SELECT CAST(max_val AS INT64) FROM config) ORDER BY id;
SELECT CAST(CAST(value AS STRING) AS INT64) as roundtrip FROM data;
SELECT CAST(CAST(large AS FLOAT64) AS INT64) as roundtrip FROM data;
SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id;
SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id;
SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id;

-- ============================================================================
-- Test: test_cast_int64_min_to_float64
-- Source: type_casting_edge_cases_tdd.rs:49
-- ============================================================================
DROP TABLE IF EXISTS limits;
CREATE TABLE limits (id INT64, min_int INT64);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large_float FLOAT64);
INSERT INTO data VALUES (1, 9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, neg_float FLOAT64);
INSERT INTO data VALUES (1, -9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, f FLOAT64);
INSERT INTO data VALUES (1, 3.7), (2, -3.7), (3, 3.2), (4, -3.2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64);
INSERT INTO data VALUES (1, 42), (2, -42), (3, 0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large_int INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '  ');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '123abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '3.14');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'abc'), (2, '123'), (3, 'xyz');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, f FLOAT64);
INSERT INTO data VALUES (1, 9.223372036854776e18), (2, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 10.0), (2, 10, 10.1), (3, 10, 9.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 3, 2.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, a INT64, b STRING);
INSERT INTO data VALUES (1, 10, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value STRING);
INSERT INTO data VALUES (1, 'A', '100'), (2, 'B', 'N/A'), (3, 'A', '200');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '30');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value INT64);
INSERT INTO data VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30);
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_val STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO config VALUES ('50');
INSERT INTO data VALUES (1, 30), (2, 60), (3, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false), (3, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, num INT64);
INSERT INTO data VALUES (1, 0), (2, 1), (3, -5), (4, 42), (5, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE'), (5, '1'), (6, '0');

SELECT id, CAST(min_int AS FLOAT64) as min_float FROM limits;
SELECT CAST(large_float AS INT64) FROM data;
SELECT CAST(neg_float AS INT64) FROM data;
SELECT CAST(value AS STRING) as str_val FROM data;
SELECT CAST(text AS INT64) as int_val FROM data;
SELECT CAST(CAST(CAST(value AS STRING) AS INT64) AS FLOAT64) as final_val FROM data;
SELECT id, CAST(f AS INT64) as int_val FROM data ORDER BY id;
SELECT id, CAST(i AS FLOAT64) as f FROM data ORDER BY id;
SELECT CAST(large_int AS FLOAT64) as f FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT id, TRY_CAST(text AS INT64) as safe_int FROM data ORDER BY id;
SELECT id, TRY_CAST(f AS INT64) as safe_int FROM data ORDER BY id;
SELECT i + f as sum FROM data;
SELECT id FROM data WHERE i = f ORDER BY id;
SELECT i * f as product FROM data;
SELECT a + CAST(b AS INT64) as sum FROM data;
SELECT id,
CASE WHEN category = 'A' THEN CAST(value AS INT64)
ELSE 0
END as parsed_value
FROM data
ORDER BY id;
SELECT id FROM data WHERE CAST(text_num AS INT64) > 8 ORDER BY id;
SELECT SUM(CAST(text_num AS INT64)) as total FROM data;
SELECT category, CAST(SUM(value) AS STRING) as total_str
FROM data
GROUP BY category
ORDER BY category;
SELECT id FROM data WHERE value < (SELECT CAST(max_val AS INT64) FROM config) ORDER BY id;
SELECT CAST(CAST(value AS STRING) AS INT64) as roundtrip FROM data;
SELECT CAST(CAST(large AS FLOAT64) AS INT64) as roundtrip FROM data;
SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id;
SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id;
SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id;

-- ============================================================================
-- Test: test_cast_large_float_to_int64_overflow
-- Source: type_casting_edge_cases_tdd.rs:69
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large_float FLOAT64);
INSERT INTO data VALUES (1, 9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, neg_float FLOAT64);
INSERT INTO data VALUES (1, -9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, f FLOAT64);
INSERT INTO data VALUES (1, 3.7), (2, -3.7), (3, 3.2), (4, -3.2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64);
INSERT INTO data VALUES (1, 42), (2, -42), (3, 0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large_int INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '  ');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '123abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '3.14');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'abc'), (2, '123'), (3, 'xyz');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, f FLOAT64);
INSERT INTO data VALUES (1, 9.223372036854776e18), (2, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 10.0), (2, 10, 10.1), (3, 10, 9.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 3, 2.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, a INT64, b STRING);
INSERT INTO data VALUES (1, 10, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value STRING);
INSERT INTO data VALUES (1, 'A', '100'), (2, 'B', 'N/A'), (3, 'A', '200');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '30');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value INT64);
INSERT INTO data VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30);
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_val STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO config VALUES ('50');
INSERT INTO data VALUES (1, 30), (2, 60), (3, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false), (3, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, num INT64);
INSERT INTO data VALUES (1, 0), (2, 1), (3, -5), (4, 42), (5, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE'), (5, '1'), (6, '0');

SELECT CAST(large_float AS INT64) FROM data;
SELECT CAST(neg_float AS INT64) FROM data;
SELECT CAST(value AS STRING) as str_val FROM data;
SELECT CAST(text AS INT64) as int_val FROM data;
SELECT CAST(CAST(CAST(value AS STRING) AS INT64) AS FLOAT64) as final_val FROM data;
SELECT id, CAST(f AS INT64) as int_val FROM data ORDER BY id;
SELECT id, CAST(i AS FLOAT64) as f FROM data ORDER BY id;
SELECT CAST(large_int AS FLOAT64) as f FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT id, TRY_CAST(text AS INT64) as safe_int FROM data ORDER BY id;
SELECT id, TRY_CAST(f AS INT64) as safe_int FROM data ORDER BY id;
SELECT i + f as sum FROM data;
SELECT id FROM data WHERE i = f ORDER BY id;
SELECT i * f as product FROM data;
SELECT a + CAST(b AS INT64) as sum FROM data;
SELECT id,
CASE WHEN category = 'A' THEN CAST(value AS INT64)
ELSE 0
END as parsed_value
FROM data
ORDER BY id;
SELECT id FROM data WHERE CAST(text_num AS INT64) > 8 ORDER BY id;
SELECT SUM(CAST(text_num AS INT64)) as total FROM data;
SELECT category, CAST(SUM(value) AS STRING) as total_str
FROM data
GROUP BY category
ORDER BY category;
SELECT id FROM data WHERE value < (SELECT CAST(max_val AS INT64) FROM config) ORDER BY id;
SELECT CAST(CAST(value AS STRING) AS INT64) as roundtrip FROM data;
SELECT CAST(CAST(large AS FLOAT64) AS INT64) as roundtrip FROM data;
SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id;
SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id;
SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id;

-- ============================================================================
-- Test: test_cast_negative_large_float_to_int64_underflow
-- Source: type_casting_edge_cases_tdd.rs:86
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, neg_float FLOAT64);
INSERT INTO data VALUES (1, -9.223372036854776e18);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, f FLOAT64);
INSERT INTO data VALUES (1, 3.7), (2, -3.7), (3, 3.2), (4, -3.2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64);
INSERT INTO data VALUES (1, 42), (2, -42), (3, 0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large_int INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '  ');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '123abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '3.14');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'abc'), (2, '123'), (3, 'xyz');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, f FLOAT64);
INSERT INTO data VALUES (1, 9.223372036854776e18), (2, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 10.0), (2, 10, 10.1), (3, 10, 9.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 3, 2.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, a INT64, b STRING);
INSERT INTO data VALUES (1, 10, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value STRING);
INSERT INTO data VALUES (1, 'A', '100'), (2, 'B', 'N/A'), (3, 'A', '200');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '30');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value INT64);
INSERT INTO data VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30);
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_val STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO config VALUES ('50');
INSERT INTO data VALUES (1, 30), (2, 60), (3, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false), (3, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, num INT64);
INSERT INTO data VALUES (1, 0), (2, 1), (3, -5), (4, 42), (5, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE'), (5, '1'), (6, '0');

SELECT CAST(neg_float AS INT64) FROM data;
SELECT CAST(value AS STRING) as str_val FROM data;
SELECT CAST(text AS INT64) as int_val FROM data;
SELECT CAST(CAST(CAST(value AS STRING) AS INT64) AS FLOAT64) as final_val FROM data;
SELECT id, CAST(f AS INT64) as int_val FROM data ORDER BY id;
SELECT id, CAST(i AS FLOAT64) as f FROM data ORDER BY id;
SELECT CAST(large_int AS FLOAT64) as f FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT id, TRY_CAST(text AS INT64) as safe_int FROM data ORDER BY id;
SELECT id, TRY_CAST(f AS INT64) as safe_int FROM data ORDER BY id;
SELECT i + f as sum FROM data;
SELECT id FROM data WHERE i = f ORDER BY id;
SELECT i * f as product FROM data;
SELECT a + CAST(b AS INT64) as sum FROM data;
SELECT id,
CASE WHEN category = 'A' THEN CAST(value AS INT64)
ELSE 0
END as parsed_value
FROM data
ORDER BY id;
SELECT id FROM data WHERE CAST(text_num AS INT64) > 8 ORDER BY id;
SELECT SUM(CAST(text_num AS INT64)) as total FROM data;
SELECT category, CAST(SUM(value) AS STRING) as total_str
FROM data
GROUP BY category
ORDER BY category;
SELECT id FROM data WHERE value < (SELECT CAST(max_val AS INT64) FROM config) ORDER BY id;
SELECT CAST(CAST(value AS STRING) AS INT64) as roundtrip FROM data;
SELECT CAST(CAST(large AS FLOAT64) AS INT64) as roundtrip FROM data;
SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id;
SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id;
SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id;

-- ============================================================================
-- Test: test_cast_null_int_to_string
-- Source: type_casting_edge_cases_tdd.rs:106
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, f FLOAT64);
INSERT INTO data VALUES (1, 3.7), (2, -3.7), (3, 3.2), (4, -3.2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64);
INSERT INTO data VALUES (1, 42), (2, -42), (3, 0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large_int INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '  ');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '123abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '3.14');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'abc'), (2, '123'), (3, 'xyz');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, f FLOAT64);
INSERT INTO data VALUES (1, 9.223372036854776e18), (2, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 10.0), (2, 10, 10.1), (3, 10, 9.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 3, 2.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, a INT64, b STRING);
INSERT INTO data VALUES (1, 10, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value STRING);
INSERT INTO data VALUES (1, 'A', '100'), (2, 'B', 'N/A'), (3, 'A', '200');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '30');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value INT64);
INSERT INTO data VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30);
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_val STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO config VALUES ('50');
INSERT INTO data VALUES (1, 30), (2, 60), (3, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false), (3, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, num INT64);
INSERT INTO data VALUES (1, 0), (2, 1), (3, -5), (4, 42), (5, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE'), (5, '1'), (6, '0');

SELECT CAST(value AS STRING) as str_val FROM data;
SELECT CAST(text AS INT64) as int_val FROM data;
SELECT CAST(CAST(CAST(value AS STRING) AS INT64) AS FLOAT64) as final_val FROM data;
SELECT id, CAST(f AS INT64) as int_val FROM data ORDER BY id;
SELECT id, CAST(i AS FLOAT64) as f FROM data ORDER BY id;
SELECT CAST(large_int AS FLOAT64) as f FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT id, TRY_CAST(text AS INT64) as safe_int FROM data ORDER BY id;
SELECT id, TRY_CAST(f AS INT64) as safe_int FROM data ORDER BY id;
SELECT i + f as sum FROM data;
SELECT id FROM data WHERE i = f ORDER BY id;
SELECT i * f as product FROM data;
SELECT a + CAST(b AS INT64) as sum FROM data;
SELECT id,
CASE WHEN category = 'A' THEN CAST(value AS INT64)
ELSE 0
END as parsed_value
FROM data
ORDER BY id;
SELECT id FROM data WHERE CAST(text_num AS INT64) > 8 ORDER BY id;
SELECT SUM(CAST(text_num AS INT64)) as total FROM data;
SELECT category, CAST(SUM(value) AS STRING) as total_str
FROM data
GROUP BY category
ORDER BY category;
SELECT id FROM data WHERE value < (SELECT CAST(max_val AS INT64) FROM config) ORDER BY id;
SELECT CAST(CAST(value AS STRING) AS INT64) as roundtrip FROM data;
SELECT CAST(CAST(large AS FLOAT64) AS INT64) as roundtrip FROM data;
SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id;
SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id;
SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id;

-- ============================================================================
-- Test: test_cast_null_string_to_int
-- Source: type_casting_edge_cases_tdd.rs:125
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, f FLOAT64);
INSERT INTO data VALUES (1, 3.7), (2, -3.7), (3, 3.2), (4, -3.2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64);
INSERT INTO data VALUES (1, 42), (2, -42), (3, 0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large_int INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '  ');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '123abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '3.14');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'abc'), (2, '123'), (3, 'xyz');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, f FLOAT64);
INSERT INTO data VALUES (1, 9.223372036854776e18), (2, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 10.0), (2, 10, 10.1), (3, 10, 9.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 3, 2.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, a INT64, b STRING);
INSERT INTO data VALUES (1, 10, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value STRING);
INSERT INTO data VALUES (1, 'A', '100'), (2, 'B', 'N/A'), (3, 'A', '200');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '30');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value INT64);
INSERT INTO data VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30);
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_val STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO config VALUES ('50');
INSERT INTO data VALUES (1, 30), (2, 60), (3, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false), (3, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, num INT64);
INSERT INTO data VALUES (1, 0), (2, 1), (3, -5), (4, 42), (5, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE'), (5, '1'), (6, '0');

SELECT CAST(text AS INT64) as int_val FROM data;
SELECT CAST(CAST(CAST(value AS STRING) AS INT64) AS FLOAT64) as final_val FROM data;
SELECT id, CAST(f AS INT64) as int_val FROM data ORDER BY id;
SELECT id, CAST(i AS FLOAT64) as f FROM data ORDER BY id;
SELECT CAST(large_int AS FLOAT64) as f FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT id, TRY_CAST(text AS INT64) as safe_int FROM data ORDER BY id;
SELECT id, TRY_CAST(f AS INT64) as safe_int FROM data ORDER BY id;
SELECT i + f as sum FROM data;
SELECT id FROM data WHERE i = f ORDER BY id;
SELECT i * f as product FROM data;
SELECT a + CAST(b AS INT64) as sum FROM data;
SELECT id,
CASE WHEN category = 'A' THEN CAST(value AS INT64)
ELSE 0
END as parsed_value
FROM data
ORDER BY id;
SELECT id FROM data WHERE CAST(text_num AS INT64) > 8 ORDER BY id;
SELECT SUM(CAST(text_num AS INT64)) as total FROM data;
SELECT category, CAST(SUM(value) AS STRING) as total_str
FROM data
GROUP BY category
ORDER BY category;
SELECT id FROM data WHERE value < (SELECT CAST(max_val AS INT64) FROM config) ORDER BY id;
SELECT CAST(CAST(value AS STRING) AS INT64) as roundtrip FROM data;
SELECT CAST(CAST(large AS FLOAT64) AS INT64) as roundtrip FROM data;
SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id;
SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id;
SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id;

-- ============================================================================
-- Test: test_cast_null_preserves_through_chain
-- Source: type_casting_edge_cases_tdd.rs:144
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, f FLOAT64);
INSERT INTO data VALUES (1, 3.7), (2, -3.7), (3, 3.2), (4, -3.2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64);
INSERT INTO data VALUES (1, 42), (2, -42), (3, 0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large_int INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '  ');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '123abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '3.14');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'abc'), (2, '123'), (3, 'xyz');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, f FLOAT64);
INSERT INTO data VALUES (1, 9.223372036854776e18), (2, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 10.0), (2, 10, 10.1), (3, 10, 9.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 3, 2.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, a INT64, b STRING);
INSERT INTO data VALUES (1, 10, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value STRING);
INSERT INTO data VALUES (1, 'A', '100'), (2, 'B', 'N/A'), (3, 'A', '200');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '30');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value INT64);
INSERT INTO data VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30);
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_val STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO config VALUES ('50');
INSERT INTO data VALUES (1, 30), (2, 60), (3, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false), (3, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, num INT64);
INSERT INTO data VALUES (1, 0), (2, 1), (3, -5), (4, 42), (5, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE'), (5, '1'), (6, '0');

SELECT CAST(CAST(CAST(value AS STRING) AS INT64) AS FLOAT64) as final_val FROM data;
SELECT id, CAST(f AS INT64) as int_val FROM data ORDER BY id;
SELECT id, CAST(i AS FLOAT64) as f FROM data ORDER BY id;
SELECT CAST(large_int AS FLOAT64) as f FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT id, TRY_CAST(text AS INT64) as safe_int FROM data ORDER BY id;
SELECT id, TRY_CAST(f AS INT64) as safe_int FROM data ORDER BY id;
SELECT i + f as sum FROM data;
SELECT id FROM data WHERE i = f ORDER BY id;
SELECT i * f as product FROM data;
SELECT a + CAST(b AS INT64) as sum FROM data;
SELECT id,
CASE WHEN category = 'A' THEN CAST(value AS INT64)
ELSE 0
END as parsed_value
FROM data
ORDER BY id;
SELECT id FROM data WHERE CAST(text_num AS INT64) > 8 ORDER BY id;
SELECT SUM(CAST(text_num AS INT64)) as total FROM data;
SELECT category, CAST(SUM(value) AS STRING) as total_str
FROM data
GROUP BY category
ORDER BY category;
SELECT id FROM data WHERE value < (SELECT CAST(max_val AS INT64) FROM config) ORDER BY id;
SELECT CAST(CAST(value AS STRING) AS INT64) as roundtrip FROM data;
SELECT CAST(CAST(large AS FLOAT64) AS INT64) as roundtrip FROM data;
SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id;
SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id;
SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id;

-- ============================================================================
-- Test: test_cast_float_to_int_truncates
-- Source: type_casting_edge_cases_tdd.rs:169
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, f FLOAT64);
INSERT INTO data VALUES (1, 3.7), (2, -3.7), (3, 3.2), (4, -3.2);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64);
INSERT INTO data VALUES (1, 42), (2, -42), (3, 0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large_int INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '  ');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '123abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '3.14');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'abc'), (2, '123'), (3, 'xyz');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, f FLOAT64);
INSERT INTO data VALUES (1, 9.223372036854776e18), (2, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 10.0), (2, 10, 10.1), (3, 10, 9.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 3, 2.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, a INT64, b STRING);
INSERT INTO data VALUES (1, 10, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value STRING);
INSERT INTO data VALUES (1, 'A', '100'), (2, 'B', 'N/A'), (3, 'A', '200');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '30');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value INT64);
INSERT INTO data VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30);
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_val STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO config VALUES ('50');
INSERT INTO data VALUES (1, 30), (2, 60), (3, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false), (3, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, num INT64);
INSERT INTO data VALUES (1, 0), (2, 1), (3, -5), (4, 42), (5, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE'), (5, '1'), (6, '0');

SELECT id, CAST(f AS INT64) as int_val FROM data ORDER BY id;
SELECT id, CAST(i AS FLOAT64) as f FROM data ORDER BY id;
SELECT CAST(large_int AS FLOAT64) as f FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT id, TRY_CAST(text AS INT64) as safe_int FROM data ORDER BY id;
SELECT id, TRY_CAST(f AS INT64) as safe_int FROM data ORDER BY id;
SELECT i + f as sum FROM data;
SELECT id FROM data WHERE i = f ORDER BY id;
SELECT i * f as product FROM data;
SELECT a + CAST(b AS INT64) as sum FROM data;
SELECT id,
CASE WHEN category = 'A' THEN CAST(value AS INT64)
ELSE 0
END as parsed_value
FROM data
ORDER BY id;
SELECT id FROM data WHERE CAST(text_num AS INT64) > 8 ORDER BY id;
SELECT SUM(CAST(text_num AS INT64)) as total FROM data;
SELECT category, CAST(SUM(value) AS STRING) as total_str
FROM data
GROUP BY category
ORDER BY category;
SELECT id FROM data WHERE value < (SELECT CAST(max_val AS INT64) FROM config) ORDER BY id;
SELECT CAST(CAST(value AS STRING) AS INT64) as roundtrip FROM data;
SELECT CAST(CAST(large AS FLOAT64) AS INT64) as roundtrip FROM data;
SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id;
SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id;
SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id;

-- ============================================================================
-- Test: test_cast_int_to_float_exact_small_values
-- Source: type_casting_edge_cases_tdd.rs:192
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64);
INSERT INTO data VALUES (1, 42), (2, -42), (3, 0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large_int INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '  ');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '123abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '3.14');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'abc'), (2, '123'), (3, 'xyz');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, f FLOAT64);
INSERT INTO data VALUES (1, 9.223372036854776e18), (2, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 10.0), (2, 10, 10.1), (3, 10, 9.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 3, 2.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, a INT64, b STRING);
INSERT INTO data VALUES (1, 10, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value STRING);
INSERT INTO data VALUES (1, 'A', '100'), (2, 'B', 'N/A'), (3, 'A', '200');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '30');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value INT64);
INSERT INTO data VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30);
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_val STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO config VALUES ('50');
INSERT INTO data VALUES (1, 30), (2, 60), (3, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false), (3, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, num INT64);
INSERT INTO data VALUES (1, 0), (2, 1), (3, -5), (4, 42), (5, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE'), (5, '1'), (6, '0');

SELECT id, CAST(i AS FLOAT64) as f FROM data ORDER BY id;
SELECT CAST(large_int AS FLOAT64) as f FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT id, TRY_CAST(text AS INT64) as safe_int FROM data ORDER BY id;
SELECT id, TRY_CAST(f AS INT64) as safe_int FROM data ORDER BY id;
SELECT i + f as sum FROM data;
SELECT id FROM data WHERE i = f ORDER BY id;
SELECT i * f as product FROM data;
SELECT a + CAST(b AS INT64) as sum FROM data;
SELECT id,
CASE WHEN category = 'A' THEN CAST(value AS INT64)
ELSE 0
END as parsed_value
FROM data
ORDER BY id;
SELECT id FROM data WHERE CAST(text_num AS INT64) > 8 ORDER BY id;
SELECT SUM(CAST(text_num AS INT64)) as total FROM data;
SELECT category, CAST(SUM(value) AS STRING) as total_str
FROM data
GROUP BY category
ORDER BY category;
SELECT id FROM data WHERE value < (SELECT CAST(max_val AS INT64) FROM config) ORDER BY id;
SELECT CAST(CAST(value AS STRING) AS INT64) as roundtrip FROM data;
SELECT CAST(CAST(large AS FLOAT64) AS INT64) as roundtrip FROM data;
SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id;
SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id;
SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id;

-- ============================================================================
-- Test: test_cast_large_int_to_float_precision_loss
-- Source: type_casting_edge_cases_tdd.rs:214
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large_int INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '  ');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '123abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '3.14');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'abc'), (2, '123'), (3, 'xyz');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, f FLOAT64);
INSERT INTO data VALUES (1, 9.223372036854776e18), (2, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 10.0), (2, 10, 10.1), (3, 10, 9.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 3, 2.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, a INT64, b STRING);
INSERT INTO data VALUES (1, 10, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value STRING);
INSERT INTO data VALUES (1, 'A', '100'), (2, 'B', 'N/A'), (3, 'A', '200');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '30');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value INT64);
INSERT INTO data VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30);
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_val STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO config VALUES ('50');
INSERT INTO data VALUES (1, 30), (2, 60), (3, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false), (3, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, num INT64);
INSERT INTO data VALUES (1, 0), (2, 1), (3, -5), (4, 42), (5, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE'), (5, '1'), (6, '0');

SELECT CAST(large_int AS FLOAT64) as f FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT id, TRY_CAST(text AS INT64) as safe_int FROM data ORDER BY id;
SELECT id, TRY_CAST(f AS INT64) as safe_int FROM data ORDER BY id;
SELECT i + f as sum FROM data;
SELECT id FROM data WHERE i = f ORDER BY id;
SELECT i * f as product FROM data;
SELECT a + CAST(b AS INT64) as sum FROM data;
SELECT id,
CASE WHEN category = 'A' THEN CAST(value AS INT64)
ELSE 0
END as parsed_value
FROM data
ORDER BY id;
SELECT id FROM data WHERE CAST(text_num AS INT64) > 8 ORDER BY id;
SELECT SUM(CAST(text_num AS INT64)) as total FROM data;
SELECT category, CAST(SUM(value) AS STRING) as total_str
FROM data
GROUP BY category
ORDER BY category;
SELECT id FROM data WHERE value < (SELECT CAST(max_val AS INT64) FROM config) ORDER BY id;
SELECT CAST(CAST(value AS STRING) AS INT64) as roundtrip FROM data;
SELECT CAST(CAST(large AS FLOAT64) AS INT64) as roundtrip FROM data;
SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id;
SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id;
SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id;

-- ============================================================================
-- Test: test_cast_invalid_string_to_int
-- Source: type_casting_edge_cases_tdd.rs:241
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '  ');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '123abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '3.14');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'abc'), (2, '123'), (3, 'xyz');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, f FLOAT64);
INSERT INTO data VALUES (1, 9.223372036854776e18), (2, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 10.0), (2, 10, 10.1), (3, 10, 9.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 3, 2.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, a INT64, b STRING);
INSERT INTO data VALUES (1, 10, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value STRING);
INSERT INTO data VALUES (1, 'A', '100'), (2, 'B', 'N/A'), (3, 'A', '200');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '30');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value INT64);
INSERT INTO data VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30);
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_val STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO config VALUES ('50');
INSERT INTO data VALUES (1, 30), (2, 60), (3, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false), (3, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, num INT64);
INSERT INTO data VALUES (1, 0), (2, 1), (3, -5), (4, 42), (5, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE'), (5, '1'), (6, '0');

SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT id, TRY_CAST(text AS INT64) as safe_int FROM data ORDER BY id;
SELECT id, TRY_CAST(f AS INT64) as safe_int FROM data ORDER BY id;
SELECT i + f as sum FROM data;
SELECT id FROM data WHERE i = f ORDER BY id;
SELECT i * f as product FROM data;
SELECT a + CAST(b AS INT64) as sum FROM data;
SELECT id,
CASE WHEN category = 'A' THEN CAST(value AS INT64)
ELSE 0
END as parsed_value
FROM data
ORDER BY id;
SELECT id FROM data WHERE CAST(text_num AS INT64) > 8 ORDER BY id;
SELECT SUM(CAST(text_num AS INT64)) as total FROM data;
SELECT category, CAST(SUM(value) AS STRING) as total_str
FROM data
GROUP BY category
ORDER BY category;
SELECT id FROM data WHERE value < (SELECT CAST(max_val AS INT64) FROM config) ORDER BY id;
SELECT CAST(CAST(value AS STRING) AS INT64) as roundtrip FROM data;
SELECT CAST(CAST(large AS FLOAT64) AS INT64) as roundtrip FROM data;
SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id;
SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id;
SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id;

-- ============================================================================
-- Test: test_cast_empty_string_to_int
-- Source: type_casting_edge_cases_tdd.rs:257
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '  ');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '123abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '3.14');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'abc'), (2, '123'), (3, 'xyz');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, f FLOAT64);
INSERT INTO data VALUES (1, 9.223372036854776e18), (2, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 10.0), (2, 10, 10.1), (3, 10, 9.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 3, 2.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, a INT64, b STRING);
INSERT INTO data VALUES (1, 10, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value STRING);
INSERT INTO data VALUES (1, 'A', '100'), (2, 'B', 'N/A'), (3, 'A', '200');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '30');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value INT64);
INSERT INTO data VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30);
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_val STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO config VALUES ('50');
INSERT INTO data VALUES (1, 30), (2, 60), (3, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false), (3, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, num INT64);
INSERT INTO data VALUES (1, 0), (2, 1), (3, -5), (4, 42), (5, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE'), (5, '1'), (6, '0');

SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT id, TRY_CAST(text AS INT64) as safe_int FROM data ORDER BY id;
SELECT id, TRY_CAST(f AS INT64) as safe_int FROM data ORDER BY id;
SELECT i + f as sum FROM data;
SELECT id FROM data WHERE i = f ORDER BY id;
SELECT i * f as product FROM data;
SELECT a + CAST(b AS INT64) as sum FROM data;
SELECT id,
CASE WHEN category = 'A' THEN CAST(value AS INT64)
ELSE 0
END as parsed_value
FROM data
ORDER BY id;
SELECT id FROM data WHERE CAST(text_num AS INT64) > 8 ORDER BY id;
SELECT SUM(CAST(text_num AS INT64)) as total FROM data;
SELECT category, CAST(SUM(value) AS STRING) as total_str
FROM data
GROUP BY category
ORDER BY category;
SELECT id FROM data WHERE value < (SELECT CAST(max_val AS INT64) FROM config) ORDER BY id;
SELECT CAST(CAST(value AS STRING) AS INT64) as roundtrip FROM data;
SELECT CAST(CAST(large AS FLOAT64) AS INT64) as roundtrip FROM data;
SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id;
SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id;
SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id;

-- ============================================================================
-- Test: test_cast_whitespace_string_to_int
-- Source: type_casting_edge_cases_tdd.rs:273
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '  ');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '123abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '3.14');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'abc'), (2, '123'), (3, 'xyz');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, f FLOAT64);
INSERT INTO data VALUES (1, 9.223372036854776e18), (2, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 10.0), (2, 10, 10.1), (3, 10, 9.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 3, 2.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, a INT64, b STRING);
INSERT INTO data VALUES (1, 10, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value STRING);
INSERT INTO data VALUES (1, 'A', '100'), (2, 'B', 'N/A'), (3, 'A', '200');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '30');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value INT64);
INSERT INTO data VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30);
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_val STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO config VALUES ('50');
INSERT INTO data VALUES (1, 30), (2, 60), (3, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false), (3, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, num INT64);
INSERT INTO data VALUES (1, 0), (2, 1), (3, -5), (4, 42), (5, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE'), (5, '1'), (6, '0');

SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT id, TRY_CAST(text AS INT64) as safe_int FROM data ORDER BY id;
SELECT id, TRY_CAST(f AS INT64) as safe_int FROM data ORDER BY id;
SELECT i + f as sum FROM data;
SELECT id FROM data WHERE i = f ORDER BY id;
SELECT i * f as product FROM data;
SELECT a + CAST(b AS INT64) as sum FROM data;
SELECT id,
CASE WHEN category = 'A' THEN CAST(value AS INT64)
ELSE 0
END as parsed_value
FROM data
ORDER BY id;
SELECT id FROM data WHERE CAST(text_num AS INT64) > 8 ORDER BY id;
SELECT SUM(CAST(text_num AS INT64)) as total FROM data;
SELECT category, CAST(SUM(value) AS STRING) as total_str
FROM data
GROUP BY category
ORDER BY category;
SELECT id FROM data WHERE value < (SELECT CAST(max_val AS INT64) FROM config) ORDER BY id;
SELECT CAST(CAST(value AS STRING) AS INT64) as roundtrip FROM data;
SELECT CAST(CAST(large AS FLOAT64) AS INT64) as roundtrip FROM data;
SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id;
SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id;
SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id;

-- ============================================================================
-- Test: test_cast_partial_number_string_to_int
-- Source: type_casting_edge_cases_tdd.rs:290
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '123abc');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '3.14');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'abc'), (2, '123'), (3, 'xyz');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, f FLOAT64);
INSERT INTO data VALUES (1, 9.223372036854776e18), (2, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 10.0), (2, 10, 10.1), (3, 10, 9.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 3, 2.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, a INT64, b STRING);
INSERT INTO data VALUES (1, 10, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value STRING);
INSERT INTO data VALUES (1, 'A', '100'), (2, 'B', 'N/A'), (3, 'A', '200');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '30');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value INT64);
INSERT INTO data VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30);
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_val STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO config VALUES ('50');
INSERT INTO data VALUES (1, 30), (2, 60), (3, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false), (3, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, num INT64);
INSERT INTO data VALUES (1, 0), (2, 1), (3, -5), (4, 42), (5, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE'), (5, '1'), (6, '0');

SELECT CAST(text AS INT64) FROM data;
SELECT CAST(text AS INT64) FROM data;
SELECT id, TRY_CAST(text AS INT64) as safe_int FROM data ORDER BY id;
SELECT id, TRY_CAST(f AS INT64) as safe_int FROM data ORDER BY id;
SELECT i + f as sum FROM data;
SELECT id FROM data WHERE i = f ORDER BY id;
SELECT i * f as product FROM data;
SELECT a + CAST(b AS INT64) as sum FROM data;
SELECT id,
CASE WHEN category = 'A' THEN CAST(value AS INT64)
ELSE 0
END as parsed_value
FROM data
ORDER BY id;
SELECT id FROM data WHERE CAST(text_num AS INT64) > 8 ORDER BY id;
SELECT SUM(CAST(text_num AS INT64)) as total FROM data;
SELECT category, CAST(SUM(value) AS STRING) as total_str
FROM data
GROUP BY category
ORDER BY category;
SELECT id FROM data WHERE value < (SELECT CAST(max_val AS INT64) FROM config) ORDER BY id;
SELECT CAST(CAST(value AS STRING) AS INT64) as roundtrip FROM data;
SELECT CAST(CAST(large AS FLOAT64) AS INT64) as roundtrip FROM data;
SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id;
SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id;
SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id;

-- ============================================================================
-- Test: test_cast_float_string_to_int
-- Source: type_casting_edge_cases_tdd.rs:306
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, '3.14');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'abc'), (2, '123'), (3, 'xyz');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, f FLOAT64);
INSERT INTO data VALUES (1, 9.223372036854776e18), (2, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 10.0), (2, 10, 10.1), (3, 10, 9.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 3, 2.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, a INT64, b STRING);
INSERT INTO data VALUES (1, 10, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value STRING);
INSERT INTO data VALUES (1, 'A', '100'), (2, 'B', 'N/A'), (3, 'A', '200');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '30');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value INT64);
INSERT INTO data VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30);
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_val STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO config VALUES ('50');
INSERT INTO data VALUES (1, 30), (2, 60), (3, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false), (3, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, num INT64);
INSERT INTO data VALUES (1, 0), (2, 1), (3, -5), (4, 42), (5, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE'), (5, '1'), (6, '0');

SELECT CAST(text AS INT64) FROM data;
SELECT id, TRY_CAST(text AS INT64) as safe_int FROM data ORDER BY id;
SELECT id, TRY_CAST(f AS INT64) as safe_int FROM data ORDER BY id;
SELECT i + f as sum FROM data;
SELECT id FROM data WHERE i = f ORDER BY id;
SELECT i * f as product FROM data;
SELECT a + CAST(b AS INT64) as sum FROM data;
SELECT id,
CASE WHEN category = 'A' THEN CAST(value AS INT64)
ELSE 0
END as parsed_value
FROM data
ORDER BY id;
SELECT id FROM data WHERE CAST(text_num AS INT64) > 8 ORDER BY id;
SELECT SUM(CAST(text_num AS INT64)) as total FROM data;
SELECT category, CAST(SUM(value) AS STRING) as total_str
FROM data
GROUP BY category
ORDER BY category;
SELECT id FROM data WHERE value < (SELECT CAST(max_val AS INT64) FROM config) ORDER BY id;
SELECT CAST(CAST(value AS STRING) AS INT64) as roundtrip FROM data;
SELECT CAST(CAST(large AS FLOAT64) AS INT64) as roundtrip FROM data;
SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id;
SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id;
SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id;

-- ============================================================================
-- Test: test_try_cast_invalid_returns_null
-- Source: type_casting_edge_cases_tdd.rs:327
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'abc'), (2, '123'), (3, 'xyz');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, f FLOAT64);
INSERT INTO data VALUES (1, 9.223372036854776e18), (2, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 10.0), (2, 10, 10.1), (3, 10, 9.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 3, 2.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, a INT64, b STRING);
INSERT INTO data VALUES (1, 10, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value STRING);
INSERT INTO data VALUES (1, 'A', '100'), (2, 'B', 'N/A'), (3, 'A', '200');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '30');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value INT64);
INSERT INTO data VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30);
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_val STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO config VALUES ('50');
INSERT INTO data VALUES (1, 30), (2, 60), (3, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false), (3, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, num INT64);
INSERT INTO data VALUES (1, 0), (2, 1), (3, -5), (4, 42), (5, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE'), (5, '1'), (6, '0');

SELECT id, TRY_CAST(text AS INT64) as safe_int FROM data ORDER BY id;
SELECT id, TRY_CAST(f AS INT64) as safe_int FROM data ORDER BY id;
SELECT i + f as sum FROM data;
SELECT id FROM data WHERE i = f ORDER BY id;
SELECT i * f as product FROM data;
SELECT a + CAST(b AS INT64) as sum FROM data;
SELECT id,
CASE WHEN category = 'A' THEN CAST(value AS INT64)
ELSE 0
END as parsed_value
FROM data
ORDER BY id;
SELECT id FROM data WHERE CAST(text_num AS INT64) > 8 ORDER BY id;
SELECT SUM(CAST(text_num AS INT64)) as total FROM data;
SELECT category, CAST(SUM(value) AS STRING) as total_str
FROM data
GROUP BY category
ORDER BY category;
SELECT id FROM data WHERE value < (SELECT CAST(max_val AS INT64) FROM config) ORDER BY id;
SELECT CAST(CAST(value AS STRING) AS INT64) as roundtrip FROM data;
SELECT CAST(CAST(large AS FLOAT64) AS INT64) as roundtrip FROM data;
SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id;
SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id;
SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id;

-- ============================================================================
-- Test: test_try_cast_overflow_returns_null
-- Source: type_casting_edge_cases_tdd.rs:349
-- ============================================================================
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, f FLOAT64);
INSERT INTO data VALUES (1, 9.223372036854776e18), (2, 100.0);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 3.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 10, 10.0), (2, 10, 10.1), (3, 10, 9.9);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, i INT64, f FLOAT64);
INSERT INTO data VALUES (1, 3, 2.5);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, a INT64, b STRING);
INSERT INTO data VALUES (1, 10, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value STRING);
INSERT INTO data VALUES (1, 'A', '100'), (2, 'B', 'N/A'), (3, 'A', '200');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '5');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text_num STRING);
INSERT INTO data VALUES (1, '10'), (2, '20'), (3, '30');
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, category STRING, value INT64);
INSERT INTO data VALUES (1, 'A', 10), (2, 'A', 20), (3, 'B', 30);
DROP TABLE IF EXISTS config;
CREATE TABLE config (max_val STRING);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO config VALUES ('50');
INSERT INTO data VALUES (1, 30), (2, 60), (3, 40);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, value INT64);
INSERT INTO data VALUES (1, 42);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, large INT64);
INSERT INTO data VALUES (1, 9007199254740993);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, flag BOOL);
INSERT INTO data VALUES (1, true), (2, false), (3, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, num INT64);
INSERT INTO data VALUES (1, 0), (2, 1), (3, -5), (4, 42), (5, NULL);
DROP TABLE IF EXISTS data;
CREATE TABLE data (id INT64, text STRING);
INSERT INTO data VALUES (1, 'true'), (2, 'false'), (3, 'TRUE'), (4, 'FALSE'), (5, '1'), (6, '0');

SELECT id, TRY_CAST(f AS INT64) as safe_int FROM data ORDER BY id;
SELECT i + f as sum FROM data;
SELECT id FROM data WHERE i = f ORDER BY id;
SELECT i * f as product FROM data;
SELECT a + CAST(b AS INT64) as sum FROM data;
SELECT id,
CASE WHEN category = 'A' THEN CAST(value AS INT64)
ELSE 0
END as parsed_value
FROM data
ORDER BY id;
SELECT id FROM data WHERE CAST(text_num AS INT64) > 8 ORDER BY id;
SELECT SUM(CAST(text_num AS INT64)) as total FROM data;
SELECT category, CAST(SUM(value) AS STRING) as total_str
FROM data
GROUP BY category
ORDER BY category;
SELECT id FROM data WHERE value < (SELECT CAST(max_val AS INT64) FROM config) ORDER BY id;
SELECT CAST(CAST(value AS STRING) AS INT64) as roundtrip FROM data;
SELECT CAST(CAST(large AS FLOAT64) AS INT64) as roundtrip FROM data;
SELECT id, CAST(flag AS INT64) as int_flag FROM data ORDER BY id;
SELECT id, CAST(num AS BOOL) as bool_val FROM data ORDER BY id;
SELECT id, CAST(text AS BOOL) as bool_val FROM data ORDER BY id;
