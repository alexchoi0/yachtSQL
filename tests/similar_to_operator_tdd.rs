#![allow(dead_code)]
#![allow(unused_variables)]
#![allow(clippy::unnecessary_unwrap)]
#![allow(clippy::collapsible_if)]
#![allow(clippy::wildcard_enum_match_arm)]

use yachtsql::{DialectType, QueryExecutor};

fn create_executor() -> QueryExecutor {
    QueryExecutor::with_dialect(DialectType::PostgreSQL)
}

fn execute_and_get_bool(executor: &mut QueryExecutor, sql: &str) -> Result<bool, String> {
    let result = executor
        .execute_sql(sql)
        .map_err(|e| format!("Query failed: {:?}", e))?;

    let column = result.column(0).ok_or("No result column")?;
    let value = column
        .get(0)
        .map_err(|e| format!("Failed to get value: {:?}", e))?;

    value
        .as_bool()
        .ok_or_else(|| format!("Value is not bool: {}", value))
}

fn execute_and_check_null(executor: &mut QueryExecutor, sql: &str) -> Result<bool, String> {
    let result = executor
        .execute_sql(sql)
        .map_err(|e| format!("Query failed: {:?}", e))?;

    let column = result.column(0).ok_or("No result column")?;
    let value = column
        .get(0)
        .map_err(|e| format!("Failed to get value: {:?}", e))?;

    Ok(value.is_null())
}

fn execute_and_get_strings(executor: &mut QueryExecutor, sql: &str) -> Result<Vec<String>, String> {
    let result = executor
        .execute_sql(sql)
        .map_err(|e| format!("Query failed: {:?}", e))?;

    let column = result.column(0).ok_or("No result column")?;
    let mut values = Vec::new();

    for i in 0..result.num_rows() {
        let value = column
            .get(i)
            .map_err(|e| format!("Failed to get value at row {}: {:?}", i, e))?;
        if let Some(s) = value.as_str() {
            values.push(s.to_string());
        }
    }

    Ok(values)
}

fn execute_and_expect_success(executor: &mut QueryExecutor, sql: &str) -> yachtsql::RecordBatch {
    executor.execute_sql(sql).expect("Query should succeed")
}

#[test]
fn test_similar_to_percent_wildcard_prefix() {
    let mut executor = create_executor();

    let result = execute_and_get_bool(&mut executor, "SELECT 'Alice' SIMILAR TO 'A%'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'Andrew' SIMILAR TO 'A%'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'Bob' SIMILAR TO 'A%'");
    assert_eq!(result, Ok(false));
}

#[test]
fn test_similar_to_percent_wildcard_suffix() {
    let mut executor = create_executor();

    let result = execute_and_get_bool(&mut executor, "SELECT 'hello' SIMILAR TO '%lo'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'world' SIMILAR TO '%lo'");
    assert_eq!(result, Ok(false));
}

#[test]
fn test_similar_to_percent_wildcard_both() {
    let mut executor = create_executor();

    let result = execute_and_get_bool(&mut executor, "SELECT 'hello' SIMILAR TO '%ell%'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'world' SIMILAR TO '%ell%'");
    assert_eq!(result, Ok(false));
}

#[test]
fn test_similar_to_underscore_wildcard() {
    let mut executor = create_executor();

    let result = execute_and_get_bool(&mut executor, "SELECT 'Bob' SIMILAR TO '___'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'Al' SIMILAR TO '___'");
    assert_eq!(result, Ok(false));

    let result = execute_and_get_bool(&mut executor, "SELECT 'Alice' SIMILAR TO '___'");
    assert_eq!(result, Ok(false));
}

#[test]
fn test_similar_to_mixed_wildcards() {
    let mut executor = create_executor();

    let result = execute_and_get_bool(&mut executor, "SELECT 'hello' SIMILAR TO 'h_llo'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'hello' SIMILAR TO 'h_%'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'h' SIMILAR TO 'h_%'");
    assert_eq!(result, Ok(false));
}

#[test]
fn test_similar_to_alternation() {
    let mut executor = create_executor();

    let result = execute_and_get_bool(&mut executor, "SELECT 'Alice' SIMILAR TO 'Alice|Bob'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'Bob' SIMILAR TO 'Alice|Bob'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'Charlie' SIMILAR TO 'Alice|Bob'");
    assert_eq!(result, Ok(false));
}

#[test]
fn test_similar_to_alternation_multiple() {
    let mut executor = create_executor();

    let result = execute_and_get_bool(
        &mut executor,
        "SELECT 'Alice' SIMILAR TO 'Alice|Bob|Charlie'",
    );
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(
        &mut executor,
        "SELECT 'Charlie' SIMILAR TO 'Alice|Bob|Charlie'",
    );
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(
        &mut executor,
        "SELECT 'David' SIMILAR TO 'Alice|Bob|Charlie'",
    );
    assert_eq!(result, Ok(false));
}

#[test]
fn test_similar_to_character_class() {
    let mut executor = create_executor();

    let result = execute_and_get_bool(&mut executor, "SELECT 'Alice' SIMILAR TO '[ABC]%'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'Bob' SIMILAR TO '[ABC]%'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'David' SIMILAR TO '[ABC]%'");
    assert_eq!(result, Ok(false));
}

#[test]
fn test_similar_to_negated_character_class() {
    let mut executor = create_executor();

    let result = execute_and_get_bool(&mut executor, "SELECT 'David' SIMILAR TO '[^ABC]%'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'Alice' SIMILAR TO '[^ABC]%'");
    assert_eq!(result, Ok(false));
}

#[test]
fn test_similar_to_character_range() {
    let mut executor = create_executor();

    let result = execute_and_get_bool(&mut executor, "SELECT 'abc' SIMILAR TO '[a-z]+'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'ABC' SIMILAR TO '[a-z]+'");
    assert_eq!(result, Ok(false));

    let result = execute_and_get_bool(&mut executor, "SELECT '123' SIMILAR TO '[0-9]+'");
    assert_eq!(result, Ok(true));
}

#[test]
fn test_similar_to_asterisk_quantifier() {
    let mut executor = create_executor();

    let result = execute_and_get_bool(&mut executor, "SELECT 'a' SIMILAR TO 'a*'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'aaa' SIMILAR TO 'a*'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT '' SIMILAR TO 'a*'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'b' SIMILAR TO 'a*'");
    assert_eq!(result, Ok(false));
}

#[test]
fn test_similar_to_plus_quantifier() {
    let mut executor = create_executor();

    let result = execute_and_get_bool(&mut executor, "SELECT 'a' SIMILAR TO 'a+'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'aaa' SIMILAR TO 'a+'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT '' SIMILAR TO 'a+'");
    assert_eq!(result, Ok(false));
}

#[test]
fn test_similar_to_question_quantifier() {
    let mut executor = create_executor();

    let result = execute_and_get_bool(&mut executor, "SELECT 'color' SIMILAR TO 'colou?r'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'colour' SIMILAR TO 'colou?r'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'colouur' SIMILAR TO 'colou?r'");
    assert_eq!(result, Ok(false));
}

#[test]
fn test_similar_to_exact_repetition() {
    let mut executor = create_executor();

    let result = execute_and_get_bool(&mut executor, "SELECT 'aaa' SIMILAR TO 'a{3}'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'aa' SIMILAR TO 'a{3}'");
    assert_eq!(result, Ok(false));

    let result = execute_and_get_bool(&mut executor, "SELECT 'aaaa' SIMILAR TO 'a{3}'");
    assert_eq!(result, Ok(false));
}

#[test]
fn test_similar_to_range_repetition() {
    let mut executor = create_executor();

    let result = execute_and_get_bool(&mut executor, "SELECT 'aa' SIMILAR TO 'a{2,4}'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'aaaa' SIMILAR TO 'a{2,4}'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'a' SIMILAR TO 'a{2,4}'");
    assert_eq!(result, Ok(false));

    let result = execute_and_get_bool(&mut executor, "SELECT 'aaaaa' SIMILAR TO 'a{2,4}'");
    assert_eq!(result, Ok(false));
}

#[test]
fn test_similar_to_grouping() {
    let mut executor = create_executor();

    let result = execute_and_get_bool(&mut executor, "SELECT 'catfish' SIMILAR TO '(cat|dog)fish'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'dogfish' SIMILAR TO '(cat|dog)fish'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(
        &mut executor,
        "SELECT 'goldfish' SIMILAR TO '(cat|dog)fish'",
    );
    assert_eq!(result, Ok(false));
}

#[test]
fn test_similar_to_grouping_with_quantifier() {
    let mut executor = create_executor();

    let result = execute_and_get_bool(&mut executor, "SELECT 'abab' SIMILAR TO '(ab)+'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'ab' SIMILAR TO '(ab)+'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'abc' SIMILAR TO '(ab)+'");
    assert_eq!(result, Ok(false));
}

#[test]
fn test_not_similar_to() {
    let mut executor = create_executor();

    let result = execute_and_get_bool(&mut executor, "SELECT 'Bob' NOT SIMILAR TO 'A%'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'Alice' NOT SIMILAR TO 'A%'");
    assert_eq!(result, Ok(false));
}

#[test]
fn test_not_similar_to_complex() {
    let mut executor = create_executor();

    let result = execute_and_get_bool(&mut executor, "SELECT 'Charlie' NOT SIMILAR TO 'Alice|Bob'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'Alice' NOT SIMILAR TO 'Alice|Bob'");
    assert_eq!(result, Ok(false));
}

#[test]
fn test_similar_to_null_value() {
    let mut executor = create_executor();

    let is_null = execute_and_check_null(&mut executor, "SELECT NULL SIMILAR TO 'A%'");
    assert_eq!(is_null, Ok(true));
}

#[test]
fn test_similar_to_null_pattern() {
    let mut executor = create_executor();

    let is_null = execute_and_check_null(&mut executor, "SELECT 'Alice' SIMILAR TO NULL");
    assert_eq!(is_null, Ok(true));
}

#[test]
fn test_similar_to_both_null() {
    let mut executor = create_executor();

    let is_null = execute_and_check_null(&mut executor, "SELECT NULL SIMILAR TO NULL");
    assert_eq!(is_null, Ok(true));
}

#[test]
fn test_similar_to_case_sensitive() {
    let mut executor = create_executor();

    let result = execute_and_get_bool(&mut executor, "SELECT 'Alice' SIMILAR TO 'Alice'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'ALICE' SIMILAR TO 'Alice'");
    assert_eq!(result, Ok(false));

    let result = execute_and_get_bool(&mut executor, "SELECT 'alice' SIMILAR TO 'Alice'");
    assert_eq!(result, Ok(false));
}

#[test]
fn test_similar_to_case_insensitive_workaround() {
    let mut executor = create_executor();

    let result = execute_and_get_bool(&mut executor, "SELECT 'Alice' SIMILAR TO '[Aa]lice'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'alice' SIMILAR TO '[Aa]lice'");
    assert_eq!(result, Ok(true));
}

#[test]
fn test_similar_to_empty_string() {
    let mut executor = create_executor();

    let result = execute_and_get_bool(&mut executor, "SELECT '' SIMILAR TO ''");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT '' SIMILAR TO 'a'");
    assert_eq!(result, Ok(false));

    let result = execute_and_get_bool(&mut executor, "SELECT '' SIMILAR TO '%'");
    assert_eq!(result, Ok(true));
}

#[test]
fn test_similar_to_email_pattern() {
    let mut executor = create_executor();

    let result = execute_and_get_bool(
        &mut executor,
        "SELECT 'alice@example.com' SIMILAR TO '%@%.%'",
    );
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'invalid' SIMILAR TO '%@%.%'");
    assert_eq!(result, Ok(false));
}

#[test]
fn test_similar_to_phone_pattern() {
    let mut executor = create_executor();

    let result = execute_and_get_bool(
        &mut executor,
        "SELECT '123-456-7890' SIMILAR TO '[0-9]{3}-[0-9]{3}-[0-9]{4}'",
    );
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(
        &mut executor,
        "SELECT '555-1234' SIMILAR TO '[0-9]{3}-[0-9]{3}-[0-9]{4}'",
    );
    assert_eq!(result, Ok(false));
}

#[test]
fn test_similar_to_alphanumeric() {
    let mut executor = create_executor();

    let result = execute_and_get_bool(&mut executor, "SELECT 'test123' SIMILAR TO '[A-Za-z0-9]+'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'test-123' SIMILAR TO '[A-Za-z0-9]+'");
    assert_eq!(result, Ok(false));
}

#[test]
fn test_similar_to_complex_pattern() {
    let mut executor = create_executor();

    let result = execute_and_get_bool(&mut executor, "SELECT 'test123' SIMILAR TO 'test[0-9]+'");
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(&mut executor, "SELECT 'test' SIMILAR TO 'test[0-9]+'");
    assert_eq!(result, Ok(false));

    let result = execute_and_get_bool(&mut executor, "SELECT 'test12' SIMILAR TO 'test[0-9]+'");
    assert_eq!(result, Ok(true));
}

#[test]
fn test_similar_to_with_table_data() {
    let mut executor = create_executor();

    execute_and_expect_success(&mut executor, "DROP TABLE IF EXISTS users");
    execute_and_expect_success(&mut executor, "CREATE TABLE users (id INT64, name STRING)");
    execute_and_expect_success(
        &mut executor,
        "INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Andrew'), (4, 'Charlie')",
    );

    let result = execute_and_get_strings(
        &mut executor,
        "SELECT name FROM users WHERE name SIMILAR TO 'A%' ORDER BY name",
    );
    assert_eq!(result, Ok(vec!["Alice".to_string(), "Andrew".to_string()]));
}

#[test]
fn test_not_similar_to_with_table_data() {
    let mut executor = create_executor();

    execute_and_expect_success(&mut executor, "DROP TABLE IF EXISTS users");
    execute_and_expect_success(&mut executor, "CREATE TABLE users (id INT64, name STRING)");
    execute_and_expect_success(
        &mut executor,
        "INSERT INTO users VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Andrew'), (4, 'Charlie')",
    );

    let result = execute_and_get_strings(
        &mut executor,
        "SELECT name FROM users WHERE name NOT SIMILAR TO 'A%' ORDER BY name",
    );
    assert_eq!(result, Ok(vec!["Bob".to_string(), "Charlie".to_string()]));
}

#[test]
fn test_similar_to_alternation_with_table() {
    let mut executor = create_executor();

    execute_and_expect_success(&mut executor, "DROP TABLE IF EXISTS people");
    execute_and_expect_success(&mut executor, "CREATE TABLE people (id INT64, name STRING)");
    execute_and_expect_success(
        &mut executor,
        "INSERT INTO people VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie'), (4, 'David')",
    );

    let result = execute_and_get_strings(
        &mut executor,
        "SELECT name FROM people WHERE name SIMILAR TO 'Alice|Bob|Charlie' ORDER BY name",
    );
    assert_eq!(
        result,
        Ok(vec![
            "Alice".to_string(),
            "Bob".to_string(),
            "Charlie".to_string()
        ])
    );
}

#[test]
fn test_similar_to_in_case() {
    let mut executor = create_executor();

    let result = execute_and_get_bool(
        &mut executor,
        "SELECT CASE WHEN 'alice@example.com' SIMILAR TO '%@%.%' THEN TRUE ELSE FALSE END",
    );
    assert_eq!(result, Ok(true));

    let result = execute_and_get_bool(
        &mut executor,
        "SELECT CASE WHEN 'invalid' SIMILAR TO '%@%.%' THEN TRUE ELSE FALSE END",
    );
    assert_eq!(result, Ok(false));
}

#[test]
fn test_similar_to_invalid_pattern() {
    let mut executor = create_executor();

    let result = executor.execute_sql("SELECT 'test' SIMILAR TO '[invalid'");
    assert!(result.is_err(), "Invalid pattern should return error");
}
