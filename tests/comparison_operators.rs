#![allow(dead_code)]
#![allow(unused_variables)]
#![allow(clippy::unnecessary_unwrap)]
#![allow(clippy::collapsible_if)]
#![allow(clippy::wildcard_enum_match_arm)]

use yachtsql::{DialectType, QueryExecutor};

#[test]
fn test_between_int() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE numbers (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (1)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (5)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (10)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (15)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM numbers WHERE value BETWEEN 5 AND 10")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_between_float() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE floats (value FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO floats VALUES (1.5)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO floats VALUES (5.5)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO floats VALUES (10.5)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO floats VALUES (15.5)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM floats WHERE value BETWEEN 5.0 AND 11.0")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_between_string() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE words (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('apple')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('banana')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('cherry')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('date')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM words WHERE value BETWEEN 'banana' AND 'cherry'")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_between_date() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE events (event_date DATE)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO events VALUES (DATE '2024-01-01')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO events VALUES (DATE '2024-01-15')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO events VALUES (DATE '2024-02-01')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO events VALUES (DATE '2024-03-01')")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT * FROM events WHERE event_date BETWEEN DATE '2024-01-10' AND DATE '2024-02-10'",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_not_between() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE numbers (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (1)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (5)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (10)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (15)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM numbers WHERE value NOT BETWEEN 5 AND 10")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_between_with_null() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE numbers (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (NULL)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (5)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (10)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM numbers WHERE value BETWEEN 0 AND 10")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_between_reversed_bounds() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE numbers (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (5)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM numbers WHERE value BETWEEN 10 AND 1")
        .unwrap();

    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_between_equal_bounds() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE numbers (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (5)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (10)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM numbers WHERE value BETWEEN 5 AND 5")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_in_int_list() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE numbers (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (1)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (2)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (3)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (4)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (5)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM numbers WHERE value IN (2, 4)")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_in_string_list() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE words (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('apple')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('banana')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('cherry')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM words WHERE value IN ('apple', 'cherry')")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_in_single_value() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE numbers (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (1)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (2)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM numbers WHERE value IN (1)")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_in_empty_list() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE numbers (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (1)")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM numbers WHERE value IN ()");

    assert!(result.is_err() || (result.is_ok() && result.unwrap().num_rows() == 0));
}

#[test]
fn test_not_in_list() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE numbers (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (1)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (2)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (3)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (4)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM numbers WHERE value NOT IN (2, 4)")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_in_with_null_in_list() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE numbers (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (1)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (2)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM numbers WHERE value IN (1, NULL)")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_in_with_null_value() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE numbers (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (NULL)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (1)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM numbers WHERE value IN (1, 2, 3)")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_not_in_with_null_in_list() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE numbers (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (1)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (2)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM numbers WHERE value NOT IN (3, NULL)")
        .unwrap();

    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_in_duplicate_values_in_list() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE numbers (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (1)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (2)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM numbers WHERE value IN (1, 1, 1, 2)")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_in_subquery() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE orders (product_id INT64)")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE products (id INT64)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO products VALUES (1)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO products VALUES (2)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO orders VALUES (1)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO orders VALUES (2)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO orders VALUES (3)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM orders WHERE product_id IN (SELECT id FROM products)")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_not_in_subquery() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE orders (product_id INT64)")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE products (id INT64)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO products VALUES (1)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO products VALUES (2)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO orders VALUES (1)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO orders VALUES (2)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO orders VALUES (3)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM orders WHERE product_id NOT IN (SELECT id FROM products)")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_in_subquery_empty_result() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE orders (product_id INT64)")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE products (id INT64)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO orders VALUES (1)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM orders WHERE product_id IN (SELECT id FROM products)")
        .unwrap();

    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_in_subquery_with_null() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE orders (product_id INT64)")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE products (id INT64)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO products VALUES (1)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO products VALUES (NULL)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO orders VALUES (1)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO orders VALUES (2)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM orders WHERE product_id IN (SELECT id FROM products)")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_like_percent_wildcard() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE words (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('apple')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('application')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('banana')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM words WHERE value LIKE 'app%'")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_like_underscore_wildcard() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE words (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('cat')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('cut')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('cart')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM words WHERE value LIKE 'c_t'")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_like_both_wildcards() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE words (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('apple')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('application')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('pineapple')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM words WHERE value LIKE '%app%'")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
}

#[test]
fn test_like_exact_match() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE words (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('apple')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('application')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM words WHERE value LIKE 'apple'")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_like_starts_with() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE words (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('hello world')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('hello there')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('goodbye')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM words WHERE value LIKE 'hello%'")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_like_ends_with() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE words (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('test.txt')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('file.txt')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('doc.pdf')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM words WHERE value LIKE '%.txt'")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_like_case_sensitive() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE words (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('Apple')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('apple')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM words WHERE value LIKE 'apple'")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_not_like() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE words (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('apple')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('banana')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('apricot')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM words WHERE value NOT LIKE 'ap%'")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_like_with_null() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE words (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES (NULL)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('apple')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM words WHERE value LIKE '%'")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_like_empty_string() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE words (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('a')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM words WHERE value LIKE ''")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_like_all_pattern() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE words (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('apple')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('banana')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM words WHERE value LIKE '%'")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_ilike_case_insensitive() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE words (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('Apple')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('APPLE')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('apple')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM words WHERE value ILIKE 'apple'")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
}

#[test]
fn test_ilike_with_wildcards() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE words (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('Apple')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('application')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('APPLY')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM words WHERE value ILIKE 'app%'")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
}

#[test]
fn test_not_ilike() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE words (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('Apple')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('Banana')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM words WHERE value NOT ILIKE 'apple'")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_not_equal_diamond_operator() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE numbers (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (1)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (2)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (3)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM numbers WHERE value <> 2")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_not_equal_string() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE words (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('apple')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('banana')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM words WHERE value <> 'apple'")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_not_equal_with_null() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE numbers (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (NULL)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (1)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM numbers WHERE value <> 1")
        .unwrap();

    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_between_and_in_combined() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE numbers (value INT64)")
        .unwrap();
    for i in 1..=20 {
        executor
            .execute_sql(&format!("INSERT INTO numbers VALUES ({})", i))
            .unwrap();
    }

    let result = executor
        .execute_sql("SELECT * FROM numbers WHERE value BETWEEN 5 AND 15 AND value IN (7, 10, 13)")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
}

#[test]
fn test_like_and_not_in_combined() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE words (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('apple')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('application')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('apricot')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('banana')")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT * FROM words WHERE value LIKE 'ap%' AND value NOT IN ('apple', 'apricot')",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_between_or_in() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE numbers (value INT64)")
        .unwrap();
    for i in 1..=10 {
        executor
            .execute_sql(&format!("INSERT INTO numbers VALUES ({})", i))
            .unwrap();
    }

    let result = executor
        .execute_sql("SELECT * FROM numbers WHERE value BETWEEN 3 AND 5 OR value IN (8, 9)")
        .unwrap();

    assert_eq!(result.num_rows(), 5);
}

#[test]
fn test_like_complex_pattern() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE words (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('a1b2c3')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('a1b3c3')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('x1y2z3')")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM words WHERE value LIKE 'a_b_c_'")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_between_with_expressions() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE numbers (a INT64, b INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (5, 3)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (10, 5)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM numbers WHERE a + b BETWEEN 8 AND 15")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_in_with_expressions() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE numbers (a INT64, b INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (5, 5)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (3, 7)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM numbers WHERE a + b IN (10, 20)")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_like_escape_special_chars() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE words (value STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('50%')")
        .unwrap();
    executor
        .execute_sql("INSERT INTO words VALUES ('100%')")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM words WHERE value LIKE '50%'");

    assert!(result.is_ok());
}
