#![allow(dead_code)]
#![allow(unused_variables)]
#![allow(clippy::unnecessary_unwrap)]
#![allow(clippy::collapsible_if)]
#![allow(clippy::wildcard_enum_match_arm)]

mod common;
use common::{
    column_i64, column_nullable_i64, column_strings, get_i64, get_string, is_null, setup_executor,
};

#[test]
fn test_union_all_basic() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor.execute_sql("CREATE TABLE t1 (val INT64)").unwrap();
    executor.execute_sql("CREATE TABLE t2 (val INT64)").unwrap();
    executor
        .execute_sql("INSERT INTO t1 VALUES (1), (2), (3)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t2 VALUES (4), (5), (6)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT val FROM t1 UNION ALL SELECT val FROM t2 ORDER BY val LIMIT 3")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
    let vals = column_i64(&result, 0);
    assert_eq!(vals, vec![1, 2, 3]);
}

#[test]
fn test_union_all_with_offset() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor.execute_sql("CREATE TABLE t1 (val INT64)").unwrap();
    executor.execute_sql("CREATE TABLE t2 (val INT64)").unwrap();
    executor
        .execute_sql("INSERT INTO t1 VALUES (1), (2)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t2 VALUES (3), (4)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT val FROM t1 UNION ALL SELECT val FROM t2 ORDER BY val OFFSET 2")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
    let vals = column_i64(&result, 0);
    assert_eq!(vals, vec![3, 4]);
}

#[test]
fn test_union_all_with_nulls() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor.execute_sql("CREATE TABLE t1 (val INT64)").unwrap();
    executor.execute_sql("CREATE TABLE t2 (val INT64)").unwrap();
    executor
        .execute_sql("INSERT INTO t1 VALUES (1), (NULL)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t2 VALUES (NULL), (2)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT val FROM t1 UNION ALL SELECT val FROM t2")
        .unwrap();

    assert_eq!(result.num_rows(), 4);
}

#[test]
fn test_union_all_same_values() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor.execute_sql("CREATE TABLE t1 (val INT64)").unwrap();
    executor.execute_sql("CREATE TABLE t2 (val INT64)").unwrap();
    executor
        .execute_sql("INSERT INTO t1 VALUES (1), (2)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t2 VALUES (1), (2)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT val FROM t1 UNION ALL SELECT val FROM t2 ORDER BY val")
        .unwrap();

    assert_eq!(result.num_rows(), 4);
    let vals = column_i64(&result, 0);
    assert_eq!(vals, vec![1, 1, 2, 2]);
}

#[test]
fn test_union_distinct_with_nulls() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor.execute_sql("CREATE TABLE t1 (val INT64)").unwrap();
    executor.execute_sql("CREATE TABLE t2 (val INT64)").unwrap();
    executor
        .execute_sql("INSERT INTO t1 VALUES (1), (NULL)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t2 VALUES (NULL), (2)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT val FROM t1 UNION SELECT val FROM t2")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
}

#[test]
fn test_union_distinct_multiple_nulls() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor.execute_sql("CREATE TABLE t1 (val INT64)").unwrap();
    executor.execute_sql("CREATE TABLE t2 (val INT64)").unwrap();
    executor
        .execute_sql("INSERT INTO t1 VALUES (NULL), (NULL), (1)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t2 VALUES (NULL), (1)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT val FROM t1 UNION SELECT val FROM t2")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_union_distinct_same_values() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor.execute_sql("CREATE TABLE t1 (val INT64)").unwrap();
    executor.execute_sql("CREATE TABLE t2 (val INT64)").unwrap();
    executor
        .execute_sql("INSERT INTO t1 VALUES (1), (2)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t2 VALUES (1), (2)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT val FROM t1 UNION SELECT val FROM t2 ORDER BY val")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
    let vals = column_i64(&result, 0);
    assert_eq!(vals, vec![1, 2]);
}

#[test]
fn test_union_three_tables() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t3").unwrap();
    executor.execute_sql("CREATE TABLE t1 (val INT64)").unwrap();
    executor.execute_sql("CREATE TABLE t2 (val INT64)").unwrap();
    executor.execute_sql("CREATE TABLE t3 (val INT64)").unwrap();
    executor.execute_sql("INSERT INTO t1 VALUES (1)").unwrap();
    executor.execute_sql("INSERT INTO t2 VALUES (2)").unwrap();
    executor.execute_sql("INSERT INTO t3 VALUES (3)").unwrap();

    let result = executor
        .execute_sql(
            "SELECT val FROM t1 UNION SELECT val FROM t2 UNION SELECT val FROM t3 ORDER BY val",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);
    let vals = column_i64(&result, 0);
    assert_eq!(vals, vec![1, 2, 3]);
}

#[test]
fn test_intersect_with_nulls() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor.execute_sql("CREATE TABLE t1 (val INT64)").unwrap();
    executor.execute_sql("CREATE TABLE t2 (val INT64)").unwrap();
    executor
        .execute_sql("INSERT INTO t1 VALUES (1), (NULL)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t2 VALUES (1), (NULL)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT val FROM t1 INTERSECT SELECT val FROM t2")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_intersect_no_common() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor.execute_sql("CREATE TABLE t1 (val INT64)").unwrap();
    executor.execute_sql("CREATE TABLE t2 (val INT64)").unwrap();
    executor
        .execute_sql("INSERT INTO t1 VALUES (1), (2)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t2 VALUES (3), (4)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT val FROM t1 INTERSECT SELECT val FROM t2")
        .unwrap();

    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_intersect_partial_overlap() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor.execute_sql("CREATE TABLE t1 (val INT64)").unwrap();
    executor.execute_sql("CREATE TABLE t2 (val INT64)").unwrap();
    executor
        .execute_sql("INSERT INTO t1 VALUES (1), (2), (3)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t2 VALUES (2), (3), (4)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT val FROM t1 INTERSECT SELECT val FROM t2 ORDER BY val")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
    let vals = column_i64(&result, 0);
    assert_eq!(vals, vec![2, 3]);
}

#[test]
fn test_except_basic() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor.execute_sql("CREATE TABLE t1 (val INT64)").unwrap();
    executor.execute_sql("CREATE TABLE t2 (val INT64)").unwrap();
    executor
        .execute_sql("INSERT INTO t1 VALUES (1), (2), (3)")
        .unwrap();
    executor.execute_sql("INSERT INTO t2 VALUES (2)").unwrap();

    let result = executor
        .execute_sql("SELECT val FROM t1 EXCEPT SELECT val FROM t2 ORDER BY val")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
    let vals = column_i64(&result, 0);
    assert_eq!(vals, vec![1, 3]);
}

#[test]
fn test_except_with_nulls() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor.execute_sql("CREATE TABLE t1 (val INT64)").unwrap();
    executor.execute_sql("CREATE TABLE t2 (val INT64)").unwrap();
    executor
        .execute_sql("INSERT INTO t1 VALUES (1), (NULL)")
        .unwrap();
    executor.execute_sql("INSERT INTO t2 VALUES (1)").unwrap();

    let result = executor
        .execute_sql("SELECT val FROM t1 EXCEPT SELECT val FROM t2")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    assert!(is_null(&result, 0, 0));
}

#[test]
fn test_except_empty_result() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor.execute_sql("CREATE TABLE t1 (val INT64)").unwrap();
    executor.execute_sql("CREATE TABLE t2 (val INT64)").unwrap();
    executor
        .execute_sql("INSERT INTO t1 VALUES (1), (2)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t2 VALUES (1), (2), (3)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT val FROM t1 EXCEPT SELECT val FROM t2")
        .unwrap();

    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_order_by_nulls_first() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS data").unwrap();
    executor
        .execute_sql("CREATE TABLE data (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (10), (NULL), (20), (5)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT value FROM data ORDER BY value NULLS FIRST")
        .unwrap();

    assert_eq!(result.num_rows(), 4);
    let vals = column_nullable_i64(&result, 0);
    assert_eq!(vals[0], None);
    assert_eq!(vals[1], Some(5));
    assert_eq!(vals[2], Some(10));
    assert_eq!(vals[3], Some(20));
}

#[test]
fn test_order_by_nulls_last() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS data").unwrap();
    executor
        .execute_sql("CREATE TABLE data (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (10), (NULL), (20), (5)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT value FROM data ORDER BY value NULLS LAST")
        .unwrap();

    assert_eq!(result.num_rows(), 4);
    let vals = column_nullable_i64(&result, 0);
    assert_eq!(vals[0], Some(5));
    assert_eq!(vals[1], Some(10));
    assert_eq!(vals[2], Some(20));
    assert_eq!(vals[3], None);
}

#[test]
fn test_order_by_desc_nulls_first() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS data").unwrap();
    executor
        .execute_sql("CREATE TABLE data (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (10), (NULL), (20), (5)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT value FROM data ORDER BY value DESC NULLS FIRST")
        .unwrap();

    assert_eq!(result.num_rows(), 4);
    let vals = column_nullable_i64(&result, 0);
    assert_eq!(vals[0], None);
    assert_eq!(vals[1], Some(20));
    assert_eq!(vals[2], Some(10));
    assert_eq!(vals[3], Some(5));
}

#[test]
fn test_order_by_desc_nulls_last() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS data").unwrap();
    executor
        .execute_sql("CREATE TABLE data (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (10), (NULL), (20), (5)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT value FROM data ORDER BY value DESC NULLS LAST")
        .unwrap();

    assert_eq!(result.num_rows(), 4);
    let vals = column_nullable_i64(&result, 0);
    assert_eq!(vals[0], Some(20));
    assert_eq!(vals[1], Some(10));
    assert_eq!(vals[2], Some(5));
    assert_eq!(vals[3], None);
}

#[test]
fn test_order_by_multiple_nulls() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS data").unwrap();
    executor
        .execute_sql("CREATE TABLE data (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (NULL), (5), (NULL), (10)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT value FROM data ORDER BY value NULLS LAST")
        .unwrap();

    assert_eq!(result.num_rows(), 4);
    let vals = column_nullable_i64(&result, 0);
    assert_eq!(vals[0], Some(5));
    assert_eq!(vals[1], Some(10));
    assert_eq!(vals[2], None);
    assert_eq!(vals[3], None);
}

#[test]
fn test_union_all_empty_tables() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS empty1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS empty2").unwrap();
    executor
        .execute_sql("CREATE TABLE empty1 (n INT64)")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE empty2 (n INT64)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT n FROM empty1 UNION ALL SELECT n FROM empty2")
        .unwrap();

    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_select_distinct_nulls() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS nulls").unwrap();
    executor
        .execute_sql("CREATE TABLE nulls (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO nulls VALUES (NULL), (NULL), (NULL)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT DISTINCT value FROM nulls")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    assert!(is_null(&result, 0, 0));
}

#[test]
fn test_order_by_same_value() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS same").unwrap();
    executor
        .execute_sql("CREATE TABLE same (id INT64, value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO same VALUES (1, 10), (2, 10), (3, 10)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id FROM same ORDER BY value, id DESC")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
    let ids = column_i64(&result, 0);
    assert_eq!(ids, vec![3, 2, 1]);
}

#[test]
fn test_all_with_empty_subquery() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS data").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS empty").unwrap();
    executor
        .execute_sql("CREATE TABLE data (val INT64)")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE empty (val INT64)")
        .unwrap();
    executor.execute_sql("INSERT INTO data VALUES (5)").unwrap();

    let result = executor
        .execute_sql("SELECT val FROM data WHERE val > ALL (SELECT val FROM empty)")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    assert_eq!(get_i64(&result, 0, 0), 5);
}

#[test]
fn test_any_with_empty_subquery() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS data").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS empty").unwrap();
    executor
        .execute_sql("CREATE TABLE data (val INT64)")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE empty (val INT64)")
        .unwrap();
    executor.execute_sql("INSERT INTO data VALUES (5)").unwrap();

    let result = executor
        .execute_sql("SELECT val FROM data WHERE val > ANY (SELECT val FROM empty)")
        .unwrap();

    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_all_with_thresholds() {
    let mut executor = setup_executor();

    executor
        .execute_sql("DROP TABLE IF EXISTS numbers")
        .unwrap();
    executor
        .execute_sql("DROP TABLE IF EXISTS thresholds")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE numbers (value INT64)")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE thresholds (threshold INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (0), (5), (10)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO thresholds VALUES (0)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT value FROM numbers WHERE value >= ALL (SELECT threshold FROM thresholds) ORDER BY value")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
    let vals = column_i64(&result, 0);
    assert_eq!(vals, vec![0, 5, 10]);
}

#[test]
fn test_any_and_all_combined() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS items").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS set_a").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS set_b").unwrap();
    executor
        .execute_sql("CREATE TABLE items (id INT64, price FLOAT64)")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE set_a (val FLOAT64)")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE set_b (val FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO items VALUES (1, 50.0), (2, 100.0)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO set_a VALUES (40.0), (60.0)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO set_b VALUES (120.0)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT id FROM items
             WHERE price > ANY (SELECT val FROM set_a)
             AND price < ALL (SELECT val FROM set_b)",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_union_null_handling() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor.execute_sql("CREATE TABLE t1 (val INT64)").unwrap();
    executor.execute_sql("CREATE TABLE t2 (val INT64)").unwrap();
    executor
        .execute_sql("INSERT INTO t1 VALUES (1), (NULL)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t2 VALUES (2), (NULL)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT val FROM t1 UNION SELECT val FROM t2")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
}

#[test]
fn test_intersect_null_handling() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor.execute_sql("CREATE TABLE t1 (val INT64)").unwrap();
    executor.execute_sql("CREATE TABLE t2 (val INT64)").unwrap();
    executor
        .execute_sql("INSERT INTO t1 VALUES (1), (NULL)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t2 VALUES (1), (NULL)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT val FROM t1 INTERSECT SELECT val FROM t2")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_union_multi_column() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor
        .execute_sql("CREATE TABLE t1 (a INT64, b STRING)")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE t2 (a INT64, b STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t1 VALUES (1, 'x'), (2, 'y')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t2 VALUES (2, 'y'), (3, 'z')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT a, b FROM t1 UNION SELECT a, b FROM t2 ORDER BY a")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
    let a_vals = column_i64(&result, 0);
    let b_vals = column_strings(&result, 1);
    assert_eq!(a_vals, vec![1, 2, 3]);
    assert_eq!(b_vals, vec!["x", "y", "z"]);
}

#[test]
fn test_intersect_multi_column() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor
        .execute_sql("CREATE TABLE t1 (a INT64, b STRING)")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE t2 (a INT64, b STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t1 VALUES (1, 'x'), (2, 'y')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t2 VALUES (2, 'y'), (3, 'z')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT a, b FROM t1 INTERSECT SELECT a, b FROM t2")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    assert_eq!(get_i64(&result, 0, 0), 2);
    assert_eq!(get_string(&result, 1, 0), "y");
}

#[test]
fn test_except_multi_column() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor
        .execute_sql("CREATE TABLE t1 (a INT64, b STRING)")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE t2 (a INT64, b STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t1 VALUES (1, 'x'), (2, 'y')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t2 VALUES (2, 'y')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT a, b FROM t1 EXCEPT SELECT a, b FROM t2")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    assert_eq!(get_i64(&result, 0, 0), 1);
    assert_eq!(get_string(&result, 1, 0), "x");
}

#[test]
fn test_in_subquery_basic() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS orders").unwrap();
    executor
        .execute_sql("DROP TABLE IF EXISTS products")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE orders (product_id INT64)")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE products (id INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO products VALUES (1), (2)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO orders VALUES (1), (2), (3)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM orders WHERE product_id IN (SELECT id FROM products)")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_not_in_subquery_basic() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS orders").unwrap();
    executor
        .execute_sql("DROP TABLE IF EXISTS products")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE orders (product_id INT64)")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE products (id INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO products VALUES (1), (2)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO orders VALUES (1), (2), (3)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM orders WHERE product_id NOT IN (SELECT id FROM products)")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_i64(), Some(3));
}

#[test]
fn test_not_in_subquery_empty_subquery() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS orders").unwrap();
    executor
        .execute_sql("DROP TABLE IF EXISTS products")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE orders (product_id INT64)")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE products (id INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO orders VALUES (1), (2), (3)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT product_id FROM orders WHERE product_id NOT IN (SELECT id FROM products) ORDER BY product_id")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
}

#[test]
fn test_union_with_limit() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor.execute_sql("CREATE TABLE t1 (val INT64)").unwrap();
    executor.execute_sql("CREATE TABLE t2 (val INT64)").unwrap();
    executor
        .execute_sql("INSERT INTO t1 VALUES (1), (2)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t2 VALUES (3), (4)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT val FROM t1 UNION SELECT val FROM t2 ORDER BY val LIMIT 2")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
    let vals = column_i64(&result, 0);
    assert_eq!(vals, vec![1, 2]);
}

#[test]
fn test_union_with_offset_limit() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor.execute_sql("CREATE TABLE t1 (val INT64)").unwrap();
    executor.execute_sql("CREATE TABLE t2 (val INT64)").unwrap();
    executor
        .execute_sql("INSERT INTO t1 VALUES (1), (2)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t2 VALUES (3), (4), (5)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT val FROM t1 UNION SELECT val FROM t2 ORDER BY val LIMIT 2 OFFSET 1")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
    let vals = column_i64(&result, 0);
    assert_eq!(vals, vec![2, 3]);
}

#[test]
fn test_union_order_by_desc() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor.execute_sql("CREATE TABLE t1 (val INT64)").unwrap();
    executor.execute_sql("CREATE TABLE t2 (val INT64)").unwrap();
    executor
        .execute_sql("INSERT INTO t1 VALUES (1), (3)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t2 VALUES (2), (4)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT val FROM t1 UNION SELECT val FROM t2 ORDER BY val DESC")
        .unwrap();

    assert_eq!(result.num_rows(), 4);
    let vals = column_i64(&result, 0);
    assert_eq!(vals, vec![4, 3, 2, 1]);
}

#[test]
fn test_union_all_preserves_order() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor.execute_sql("CREATE TABLE t1 (val INT64)").unwrap();
    executor.execute_sql("CREATE TABLE t2 (val INT64)").unwrap();
    executor.execute_sql("INSERT INTO t1 VALUES (5)").unwrap();
    executor.execute_sql("INSERT INTO t2 VALUES (3)").unwrap();

    let result = executor
        .execute_sql("SELECT val FROM t1 UNION ALL SELECT val FROM t2")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_intersect_with_duplicates() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor.execute_sql("CREATE TABLE t1 (val INT64)").unwrap();
    executor.execute_sql("CREATE TABLE t2 (val INT64)").unwrap();
    executor
        .execute_sql("INSERT INTO t1 VALUES (1), (1), (2)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t2 VALUES (1), (2), (2)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT val FROM t1 INTERSECT SELECT val FROM t2 ORDER BY val")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
    let vals = column_i64(&result, 0);
    assert_eq!(vals, vec![1, 2]);
}

#[test]
fn test_except_with_duplicates() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor.execute_sql("CREATE TABLE t1 (val INT64)").unwrap();
    executor.execute_sql("CREATE TABLE t2 (val INT64)").unwrap();
    executor
        .execute_sql("INSERT INTO t1 VALUES (1), (1), (2), (3)")
        .unwrap();
    executor.execute_sql("INSERT INTO t2 VALUES (2)").unwrap();

    let result = executor
        .execute_sql("SELECT val FROM t1 EXCEPT SELECT val FROM t2 ORDER BY val")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
    let vals = column_i64(&result, 0);
    assert_eq!(vals, vec![1, 3]);
}

#[test]
fn test_union_strings() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor
        .execute_sql("CREATE TABLE t1 (name STRING)")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE t2 (name STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t1 VALUES ('Alice'), ('Bob')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t2 VALUES ('Bob'), ('Charlie')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT name FROM t1 UNION SELECT name FROM t2 ORDER BY name")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
    let names = column_strings(&result, 0);
    assert_eq!(names, vec!["Alice", "Bob", "Charlie"]);
}

#[test]
fn test_union_floats() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor
        .execute_sql("CREATE TABLE t1 (val FLOAT64)")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE t2 (val FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t1 VALUES (1.5), (2.5)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO t2 VALUES (2.5), (3.5)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT val FROM t1 UNION SELECT val FROM t2")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
}

#[test]
fn test_except_all_removed() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor.execute_sql("CREATE TABLE t1 (val INT64)").unwrap();
    executor.execute_sql("CREATE TABLE t2 (val INT64)").unwrap();
    executor.execute_sql("INSERT INTO t1 VALUES (1)").unwrap();
    executor.execute_sql("INSERT INTO t2 VALUES (1)").unwrap();

    let result = executor
        .execute_sql("SELECT val FROM t1 EXCEPT SELECT val FROM t2")
        .unwrap();

    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_intersect_empty_first() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor.execute_sql("CREATE TABLE t1 (val INT64)").unwrap();
    executor.execute_sql("CREATE TABLE t2 (val INT64)").unwrap();

    executor.execute_sql("INSERT INTO t2 VALUES (1)").unwrap();

    let result = executor
        .execute_sql("SELECT val FROM t1 INTERSECT SELECT val FROM t2")
        .unwrap();

    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_except_empty_second() {
    let mut executor = setup_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t1").unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS t2").unwrap();
    executor.execute_sql("CREATE TABLE t1 (val INT64)").unwrap();
    executor.execute_sql("CREATE TABLE t2 (val INT64)").unwrap();
    executor
        .execute_sql("INSERT INTO t1 VALUES (1), (2)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT val FROM t1 EXCEPT SELECT val FROM t2 ORDER BY val")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
    let vals = column_i64(&result, 0);
    assert_eq!(vals, vec![1, 2]);
}
