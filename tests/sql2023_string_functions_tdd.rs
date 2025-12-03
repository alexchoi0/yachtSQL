#![allow(dead_code)]
#![allow(unused_variables)]
#![allow(clippy::unnecessary_unwrap)]
#![allow(clippy::collapsible_if)]
#![allow(clippy::wildcard_enum_match_arm)]

use yachtsql::{DialectType, QueryExecutor};

fn create_executor() -> QueryExecutor {
    QueryExecutor::with_dialect(DialectType::PostgreSQL)
}

fn execute_and_get_string(executor: &mut QueryExecutor, sql: &str) -> Result<String, String> {
    let result = executor
        .execute_sql(sql)
        .map_err(|e| format!("Query failed: {:?}", e))?;

    let column = result.column(0).ok_or("No result column")?;
    let value = column
        .get(0)
        .map_err(|e| format!("Failed to get value: {:?}", e))?;

    value
        .as_str()
        .map(|s| s.to_string())
        .ok_or_else(|| format!("Value is not a string: {}", value))
}

fn execute_and_get_i64(executor: &mut QueryExecutor, sql: &str) -> Result<i64, String> {
    let result = executor
        .execute_sql(sql)
        .map_err(|e| format!("Query failed: {:?}", e))?;

    let column = result.column(0).ok_or("No result column")?;
    let value = column
        .get(0)
        .map_err(|e| format!("Failed to get value: {:?}", e))?;

    value
        .as_i64()
        .ok_or_else(|| format!("Value is not i64: {}", value))
}

fn execute_and_expect_success(executor: &mut QueryExecutor, sql: &str) -> yachtsql::RecordBatch {
    executor.execute_sql(sql).expect("Query should succeed")
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

#[test]
fn test_length_basic() {
    let mut executor = create_executor();
    let result = execute_and_get_i64(&mut executor, "SELECT LENGTH('hello') AS len");
    assert_eq!(result.unwrap(), 5);
}

#[test]
fn test_length_empty_string() {
    let mut executor = create_executor();
    let result = execute_and_get_i64(&mut executor, "SELECT LENGTH('') AS len");
    assert_eq!(result.unwrap(), 0);
}

#[test]
fn test_length_with_spaces() {
    let mut executor = create_executor();
    let result = execute_and_get_i64(&mut executor, "SELECT LENGTH('  hello  ') AS len");
    assert_eq!(result.unwrap(), 9);
}

#[test]
fn test_length_unicode_characters() {
    let mut executor = create_executor();
    let result = execute_and_get_i64(&mut executor, "SELECT LENGTH('hello 世界') AS len");

    assert_eq!(result.unwrap(), 8);
}

#[test]
fn test_length_unicode_accents() {
    let mut executor = create_executor();
    let result = execute_and_get_i64(&mut executor, "SELECT LENGTH('café') AS len");

    assert_eq!(result.unwrap(), 4);
}

#[test]
fn test_length_null() {
    let mut executor = create_executor();
    let is_null = execute_and_check_null(&mut executor, "SELECT LENGTH(NULL) AS len");
    assert!(is_null.unwrap());
}

#[test]
fn test_char_length() {
    let mut executor = create_executor();
    let result = execute_and_get_i64(&mut executor, "SELECT CHAR_LENGTH('hello') AS len");
    assert_eq!(result.unwrap(), 5);
}

#[test]
fn test_character_length() {
    let mut executor = create_executor();
    let result = execute_and_get_i64(&mut executor, "SELECT CHARACTER_LENGTH('hello') AS len");
    assert_eq!(result.unwrap(), 5);
}

#[test]
fn test_position_found() {
    let mut executor = create_executor();
    let result = execute_and_get_i64(
        &mut executor,
        "SELECT POSITION('world' IN 'hello world') AS pos",
    );
    assert_eq!(result.unwrap(), 7);
}

#[test]
fn test_position_not_found() {
    let mut executor = create_executor();
    let result = execute_and_get_i64(
        &mut executor,
        "SELECT POSITION('xyz' IN 'hello world') AS pos",
    );
    assert_eq!(result.unwrap(), 0);
}

#[test]
fn test_position_at_start() {
    let mut executor = create_executor();
    let result = execute_and_get_i64(
        &mut executor,
        "SELECT POSITION('hello' IN 'hello world') AS pos",
    );
    assert_eq!(result.unwrap(), 1);
}

#[test]
fn test_position_case_sensitive() {
    let mut executor = create_executor();
    let result = execute_and_get_i64(
        &mut executor,
        "SELECT POSITION('WORLD' IN 'hello world') AS pos",
    );
    assert_eq!(result.unwrap(), 0);
}

#[test]
fn test_position_empty_substring() {
    let mut executor = create_executor();
    let result = execute_and_get_i64(&mut executor, "SELECT POSITION('' IN 'hello') AS pos");

    assert_eq!(result.unwrap(), 1);
}

#[test]
fn test_position_null() {
    let mut executor = create_executor();
    let is_null = execute_and_check_null(&mut executor, "SELECT POSITION('test' IN NULL) AS pos");
    assert!(is_null.unwrap());
}

#[test]
fn test_strpos_found() {
    let mut executor = create_executor();
    let result = execute_and_get_i64(
        &mut executor,
        "SELECT STRPOS('hello world', 'world') AS pos",
    );
    assert_eq!(result.unwrap(), 7);
}

#[test]
fn test_strpos_not_found() {
    let mut executor = create_executor();
    let result = execute_and_get_i64(&mut executor, "SELECT STRPOS('hello world', 'xyz') AS pos");
    assert_eq!(result.unwrap(), 0);
}

#[test]
fn test_left_basic() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT LEFT('hello world', 5) AS result");
    assert_eq!(result.unwrap(), "hello");
}

#[test]
fn test_left_zero() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT LEFT('hello', 0) AS result");
    assert_eq!(result.unwrap(), "");
}

#[test]
fn test_left_exceeds_length() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT LEFT('hello', 100) AS result");
    assert_eq!(result.unwrap(), "hello");
}

#[test]
fn test_right_basic() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT RIGHT('hello world', 5) AS result");
    assert_eq!(result.unwrap(), "world");
}

#[test]
fn test_right_zero() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT RIGHT('hello', 0) AS result");
    assert_eq!(result.unwrap(), "");
}

#[test]
fn test_right_exceeds_length() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT RIGHT('hello', 100) AS result");
    assert_eq!(result.unwrap(), "hello");
}

#[test]
fn test_substring_with_position_and_length() {
    let mut executor = create_executor();
    let result = execute_and_get_string(
        &mut executor,
        "SELECT SUBSTRING('hello world', 7, 5) AS result",
    );
    assert_eq!(result.unwrap(), "world");
}

#[test]
fn test_substring_from_start() {
    let mut executor = create_executor();
    let result = execute_and_get_string(
        &mut executor,
        "SELECT SUBSTRING('hello world', 1, 5) AS result",
    );
    assert_eq!(result.unwrap(), "hello");
}

#[test]
fn test_upper_basic() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT UPPER('hello') AS result");
    assert_eq!(result.unwrap(), "HELLO");
}

#[test]
fn test_upper_mixed_case() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT UPPER('Hello World') AS result");
    assert_eq!(result.unwrap(), "HELLO WORLD");
}

#[test]
fn test_lower_basic() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT LOWER('HELLO') AS result");
    assert_eq!(result.unwrap(), "hello");
}

#[test]
fn test_lower_mixed_case() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT LOWER('Hello World') AS result");
    assert_eq!(result.unwrap(), "hello world");
}

#[test]
fn test_initcap_lowercase() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT INITCAP('hello world') AS result");
    assert_eq!(result.unwrap(), "Hello World");
}

#[test]
fn test_initcap_uppercase() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT INITCAP('HELLO WORLD') AS result");
    assert_eq!(result.unwrap(), "Hello World");
}

#[test]
fn test_initcap_mixed_case() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT INITCAP('hELLo WoRLd') AS result");
    assert_eq!(result.unwrap(), "Hello World");
}

#[test]
fn test_trim_both_sides() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT TRIM('  hello  ') AS result");
    assert_eq!(result.unwrap(), "hello");
}

#[test]
fn test_trim_leading() {
    let mut executor = create_executor();

    let result = execute_and_get_string(&mut executor, "SELECT LTRIM('  hello  ') AS result");
    assert_eq!(result.unwrap(), "hello  ");
}

#[test]
fn test_trim_trailing() {
    let mut executor = create_executor();

    let result = execute_and_get_string(&mut executor, "SELECT RTRIM('  hello  ') AS result");
    assert_eq!(result.unwrap(), "  hello");
}

#[test]
fn test_trim_specific_character() {
    let mut executor = create_executor();
    let result = execute_and_get_string(
        &mut executor,
        "SELECT TRIM('x' FROM 'xxxhelloxxx') AS result",
    );
    assert_eq!(result.unwrap(), "hello");
}

#[test]
fn test_ltrim() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT LTRIM('  hello  ') AS result");
    assert_eq!(result.unwrap(), "hello  ");
}

#[test]
fn test_rtrim() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT RTRIM('  hello  ') AS result");
    assert_eq!(result.unwrap(), "  hello");
}

#[test]
fn test_lpad_with_character() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT LPAD('hello', 10, '*') AS result");
    assert_eq!(result.unwrap(), "*****hello");
}

#[test]
fn test_lpad_no_padding_needed() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT LPAD('hello', 5, '*') AS result");
    assert_eq!(result.unwrap(), "hello");
}

#[test]
fn test_lpad_truncate() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT LPAD('hello', 3, '*') AS result");
    assert_eq!(result.unwrap(), "hel");
}

#[test]
fn test_lpad_multichar_fill() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT LPAD('hello', 10, 'xy') AS result");
    assert_eq!(result.unwrap(), "xyxyxhello");
}

#[test]
fn test_lpad_default_space() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT LPAD('hello', 8) AS result");
    assert_eq!(result.unwrap(), "   hello");
}

#[test]
fn test_rpad_with_character() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT RPAD('hello', 10, '*') AS result");
    assert_eq!(result.unwrap(), "hello*****");
}

#[test]
fn test_rpad_no_padding_needed() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT RPAD('hello', 5, '*') AS result");
    assert_eq!(result.unwrap(), "hello");
}

#[test]
fn test_rpad_multichar_fill() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT RPAD('hello', 10, 'xy') AS result");
    assert_eq!(result.unwrap(), "helloxyxyx");
}

#[test]
fn test_concat_basic() {
    let mut executor = create_executor();
    let result = execute_and_get_string(
        &mut executor,
        "SELECT CONCAT('hello', ' ', 'world') AS result",
    );
    assert_eq!(result.unwrap(), "hello world");
}

#[test]
fn test_concat_multiple() {
    let mut executor = create_executor();
    let result =
        execute_and_get_string(&mut executor, "SELECT CONCAT('a', 'b', 'c', 'd') AS result");
    assert_eq!(result.unwrap(), "abcd");
}

#[test]
fn test_concat_with_null() {
    let mut executor = create_executor();
    let result = execute_and_get_string(
        &mut executor,
        "SELECT CONCAT('hello', NULL, 'world') AS result",
    );

    assert_eq!(result.unwrap(), "helloworld");
}

#[test]
fn test_repeat_basic() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT REPEAT('ha', 3) AS result");
    assert_eq!(result.unwrap(), "hahaha");
}

#[test]
fn test_repeat_zero() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT REPEAT('hello', 0) AS result");
    assert_eq!(result.unwrap(), "");
}

#[test]
fn test_repeat_one() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT REPEAT('hello', 1) AS result");
    assert_eq!(result.unwrap(), "hello");
}

#[test]
fn test_reverse_basic() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT REVERSE('hello') AS result");
    assert_eq!(result.unwrap(), "olleh");
}

#[test]
fn test_reverse_palindrome() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT REVERSE('racecar') AS result");
    assert_eq!(result.unwrap(), "racecar");
}

#[test]
fn test_reverse_empty() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT REVERSE('') AS result");
    assert_eq!(result.unwrap(), "");
}

#[test]
fn test_reverse_unicode() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT REVERSE('hello世界') AS result");
    assert_eq!(result.unwrap(), "界世olleh");
}

#[test]
fn test_replace_basic() {
    let mut executor = create_executor();
    let result = execute_and_get_string(
        &mut executor,
        "SELECT REPLACE('hello world', 'world', 'there') AS result",
    );
    assert_eq!(result.unwrap(), "hello there");
}

#[test]
fn test_replace_all_occurrences() {
    let mut executor = create_executor();
    let result =
        execute_and_get_string(&mut executor, "SELECT REPLACE('aaaa', 'a', 'b') AS result");
    assert_eq!(result.unwrap(), "bbbb");
}

#[test]
fn test_replace_no_match() {
    let mut executor = create_executor();
    let result = execute_and_get_string(
        &mut executor,
        "SELECT REPLACE('hello', 'xyz', 'abc') AS result",
    );
    assert_eq!(result.unwrap(), "hello");
}

#[test]
fn test_ascii_lowercase_a() {
    let mut executor = create_executor();
    let result = execute_and_get_i64(&mut executor, "SELECT ASCII('a') AS result");
    assert_eq!(result.unwrap(), 97);
}

#[test]
fn test_ascii_uppercase_a() {
    let mut executor = create_executor();
    let result = execute_and_get_i64(&mut executor, "SELECT ASCII('A') AS result");
    assert_eq!(result.unwrap(), 65);
}

#[test]
fn test_ascii_digit_zero() {
    let mut executor = create_executor();
    let result = execute_and_get_i64(&mut executor, "SELECT ASCII('0') AS result");
    assert_eq!(result.unwrap(), 48);
}

#[test]
fn test_ascii_space() {
    let mut executor = create_executor();
    let result = execute_and_get_i64(&mut executor, "SELECT ASCII(' ') AS result");
    assert_eq!(result.unwrap(), 32);
}

#[test]
fn test_ascii_first_char() {
    let mut executor = create_executor();
    let result = execute_and_get_i64(&mut executor, "SELECT ASCII('hello') AS result");
    assert_eq!(result.unwrap(), 104);
}

#[test]
fn test_chr_lowercase_a() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT CHR(97) AS result");
    assert_eq!(result.unwrap(), "a");
}

#[test]
fn test_chr_uppercase_a() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT CHR(65) AS result");
    assert_eq!(result.unwrap(), "A");
}

#[test]
fn test_chr_space() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT CHR(32) AS result");
    assert_eq!(result.unwrap(), " ");
}

#[test]
fn test_chr_newline() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT CHR(10) AS result");
    assert_eq!(result.unwrap(), "\n");
}

#[test]
fn test_chr_ascii_roundtrip() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT CHR(ASCII('X')) AS result");
    assert_eq!(result.unwrap(), "X");
}

#[test]
fn test_translate_basic() {
    let mut executor = create_executor();
    let result = execute_and_get_string(
        &mut executor,
        "SELECT TRANSLATE('hello', 'el', 'ip') AS result",
    );

    assert_eq!(result.unwrap(), "hippo");
}

#[test]
fn test_translate_remove_characters() {
    let mut executor = create_executor();
    let result = execute_and_get_string(
        &mut executor,
        "SELECT TRANSLATE('abc123def', '0123456789', '') AS result",
    );
    assert_eq!(result.unwrap(), "abcdef");
}

#[test]
fn test_translate_partial_replacement() {
    let mut executor = create_executor();
    let result = execute_and_get_string(
        &mut executor,
        "SELECT TRANSLATE('abc123', '0123456789', 'XYZ') AS result",
    );

    assert_eq!(result.unwrap(), "abcYZ");
}

#[test]
fn test_translate_no_matches() {
    let mut executor = create_executor();
    let result = execute_and_get_string(
        &mut executor,
        "SELECT TRANSLATE('hello', '123', 'abc') AS result",
    );
    assert_eq!(result.unwrap(), "hello");
}

#[test]
fn test_translate_special_characters() {
    let mut executor = create_executor();
    let result = execute_and_get_string(
        &mut executor,
        "SELECT TRANSLATE('a-b_c.d', '-_.', '   ') AS result",
    );
    assert_eq!(result.unwrap(), "a b c d");
}

#[test]
fn test_format_string_substitution() {
    let mut executor = create_executor();
    let result = execute_and_get_string(
        &mut executor,
        "SELECT FORMAT('Hello, %s!', 'World') AS result",
    );
    assert_eq!(result.unwrap(), "Hello, World!");
}

#[test]
fn test_format_integer_substitution() {
    let mut executor = create_executor();
    let result = execute_and_get_string(
        &mut executor,
        "SELECT FORMAT('The answer is %d', 42) AS result",
    );
    assert_eq!(result.unwrap(), "The answer is 42");
}

#[test]
fn test_format_float_substitution() {
    let mut executor = create_executor();
    let result = execute_and_get_string(
        &mut executor,
        "SELECT FORMAT('Pi is approximately %.2f', 3.14159) AS result",
    );
    assert_eq!(result.unwrap(), "Pi is approximately 3.14");
}

#[test]
fn test_format_multiple_substitutions() {
    let mut executor = create_executor();
    let result = execute_and_get_string(
        &mut executor,
        "SELECT FORMAT('%s has %d apples', 'John', 5) AS result",
    );
    assert_eq!(result.unwrap(), "John has 5 apples");
}

#[test]
fn test_format_mixed_types() {
    let mut executor = create_executor();
    let result = execute_and_get_string(
        &mut executor,
        "SELECT FORMAT('%s is %d years old with a score of %.1f', 'Bob', 30, 95.5) AS result",
    );
    assert_eq!(result.unwrap(), "Bob is 30 years old with a score of 95.5");
}

#[test]
fn test_format_no_placeholders() {
    let mut executor = create_executor();
    let result = execute_and_get_string(
        &mut executor,
        "SELECT FORMAT('Just a plain string') AS result",
    );
    assert_eq!(result.unwrap(), "Just a plain string");
}

#[test]
fn test_format_escape_percent() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT FORMAT('100%% complete') AS result");
    assert_eq!(result.unwrap(), "100% complete");
}

#[test]
fn test_format_width_and_precision() {
    let mut executor = create_executor();
    let result = execute_and_get_string(
        &mut executor,
        "SELECT FORMAT('Value: %10.3f', 123.456789) AS result",
    );
    assert_eq!(result.unwrap(), "Value:    123.457");
}

#[test]
fn test_quote_ident_simple() {
    let mut executor = create_executor();
    let result =
        execute_and_get_string(&mut executor, "SELECT QUOTE_IDENT('column_name') AS result");

    let r = result.unwrap();
    assert!(r == "column_name" || r == "\"column_name\"");
}

#[test]
fn test_quote_ident_with_spaces() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT QUOTE_IDENT('my column') AS result");
    assert_eq!(result.unwrap(), "\"my column\"");
}

#[test]
fn test_quote_ident_with_double_quotes() {
    let mut executor = create_executor();
    let result = execute_and_get_string(
        &mut executor,
        r#"SELECT QUOTE_IDENT('my"column') AS result"#,
    );
    assert_eq!(result.unwrap(), r#""my""column""#);
}

#[test]
fn test_quote_ident_special_chars() {
    let mut executor = create_executor();
    let result =
        execute_and_get_string(&mut executor, "SELECT QUOTE_IDENT('table$name') AS result");
    assert_eq!(result.unwrap(), "\"table$name\"");
}

#[test]
fn test_quote_ident_empty() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT QUOTE_IDENT('') AS result");
    assert_eq!(result.unwrap(), "\"\"");
}

#[test]
fn test_quote_ident_reserved_keyword() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT QUOTE_IDENT('select') AS result");
    assert_eq!(result.unwrap(), "\"select\"");
}

#[test]
fn test_quote_literal_simple() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT QUOTE_LITERAL('hello') AS result");
    assert_eq!(result.unwrap(), "'hello'");
}

#[test]
fn test_quote_literal_with_single_quote() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT QUOTE_LITERAL('it''s') AS result");
    assert_eq!(result.unwrap(), "'it''s'");
}

#[test]
fn test_quote_literal_with_double_quote() {
    let mut executor = create_executor();
    let result = execute_and_get_string(
        &mut executor,
        r#"SELECT QUOTE_LITERAL('say "hello"') AS result"#,
    );
    assert_eq!(result.unwrap(), r#"'say "hello"'"#);
}

#[test]
fn test_quote_literal_empty() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT QUOTE_LITERAL('') AS result");
    assert_eq!(result.unwrap(), "''");
}

#[test]
fn test_quote_literal_with_newline() {
    let mut executor = create_executor();

    let result = execute_and_get_string(
        &mut executor,
        r"SELECT QUOTE_LITERAL('line1\nline2') AS result",
    );
    assert_eq!(result.unwrap(), r"'line1\nline2'");
}

#[test]
fn test_split_basic() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT STRING_TO_ARRAY('a,b,c', ',') AS parts")
        .unwrap();
    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap();
    let r = val.to_string();
    assert!(r.contains("a") && r.contains("b") && r.contains("c"));
}

#[test]
fn test_split_no_delimiter() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT STRING_TO_ARRAY('hello', ',') AS parts")
        .unwrap();
    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap();
    let r = val.to_string();
    assert!(r.contains("hello"));
}

#[test]
fn test_split_empty_string() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT STRING_TO_ARRAY('', ',') AS parts")
        .unwrap();
    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap();
    let r = val.to_string();

    assert!(
        r == "[\"\"]"
            || r == "[]"
            || r == "['']"
            || r.is_empty()
            || r.contains("\"\"")
            || r.contains("''")
    );
}

#[test]
fn test_split_trailing_delimiter() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT STRING_TO_ARRAY('a,b,c,', ',') AS parts")
        .unwrap();
    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap();
    let r = val.to_string();

    assert!(r.contains("a") && r.contains("b") && r.contains("c"));
}

#[test]
fn test_split_consecutive_delimiters() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT STRING_TO_ARRAY('a,,b', ',') AS parts")
        .unwrap();
    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap();
    let r = val.to_string();

    assert!(r.contains("a") && r.contains("b"));
}

#[test]
fn test_split_multichar_delimiter() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT STRING_TO_ARRAY('a::b::c', '::') AS parts")
        .unwrap();
    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap();
    let r = val.to_string();
    assert!(r.contains("a") && r.contains("b") && r.contains("c"));
}

#[test]
fn test_split_space_delimiter() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT STRING_TO_ARRAY('hello world test', ' ') AS parts")
        .unwrap();
    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap();
    let r = val.to_string();
    assert!(r.contains("hello") && r.contains("world") && r.contains("test"));
}

#[test]
fn test_nested_functions_upper_left_reverse() {
    let mut executor = create_executor();
    let result = execute_and_get_string(
        &mut executor,
        "SELECT UPPER(LEFT(REVERSE('hello'), 3)) AS result",
    );

    assert_eq!(result.unwrap(), "OLL");
}

#[test]
fn test_nested_upper_trim() {
    let mut executor = create_executor();
    let result = execute_and_get_string(&mut executor, "SELECT UPPER(TRIM('  hello  ')) AS result");
    assert_eq!(result.unwrap(), "HELLO");
}

#[test]
fn test_extract_email_username() {
    let mut executor = create_executor();
    let result = execute_and_get_string(
        &mut executor,
        "SELECT SUBSTR('user@example.com', 1, POSITION('@' IN 'user@example.com') - 1) AS username",
    );
    assert_eq!(result.unwrap(), "user");
}

#[test]
fn test_extract_file_extension() {
    let mut executor = create_executor();
    let result = execute_and_get_string(
        &mut executor,
        "SELECT RIGHT('document.pdf', LENGTH('document.pdf') - POSITION('.' IN 'document.pdf')) AS extension",
    );
    assert_eq!(result.unwrap(), "pdf");
}

#[test]
fn test_palindrome_check_true() {
    let mut executor = create_executor();
    let result = execute_and_get_bool(
        &mut executor,
        "SELECT 'racecar' = REVERSE('racecar') AS is_palindrome",
    );
    assert!(result.unwrap());
}

#[test]
fn test_palindrome_check_false() {
    let mut executor = create_executor();
    let result = execute_and_get_bool(
        &mut executor,
        "SELECT 'hello' = REVERSE('hello') AS is_palindrome",
    );
    assert!(!result.unwrap());
}

#[test]
fn test_full_name_formatting() {
    let mut executor = create_executor();
    let result = execute_and_get_string(
        &mut executor,
        "SELECT CONCAT(INITCAP('john'), ' ', INITCAP('doe')) AS full_name",
    );
    assert_eq!(result.unwrap(), "John Doe");
}

#[test]
fn test_word_count_using_split() {
    let mut executor = create_executor();

    let result = execute_and_get_i64(
        &mut executor,
        "SELECT ARRAY_LENGTH(STRING_TO_ARRAY('the quick brown fox', ' ')) AS word_count",
    );
    assert_eq!(result.unwrap(), 4);
}

#[test]
fn test_null_handling_across_functions() {
    let mut executor = create_executor();
    let result = executor.execute_sql(
        "SELECT LENGTH(NULL) AS len, REVERSE(NULL) AS rev, CONCAT('hello', NULL) AS concat_null"
    ).expect("Query should succeed");

    let len_col = result.column(0).unwrap();
    let len_val = len_col.get(0).unwrap();
    assert!(len_val.is_null());

    let rev_col = result.column(1).unwrap();
    let rev_val = rev_col.get(0).unwrap();
    assert!(rev_val.is_null());

    let concat_col = result.column(2).unwrap();
    let concat_val = concat_col.get(0).unwrap();
    assert_eq!(concat_val.as_str().unwrap_or(""), "hello");
}

#[test]
fn test_empty_string_handling() {
    let mut executor = create_executor();
    let result = executor
        .execute_sql(
            "SELECT LENGTH('') AS len, UPPER('') AS upper, REVERSE('') AS rev, TRIM('') AS trim",
        )
        .expect("Query should succeed");

    let len_col = result.column(0).unwrap();
    let len_val = len_col.get(0).unwrap();
    assert_eq!(len_val.as_i64(), Some(0));

    let upper_col = result.column(1).unwrap();
    let upper_val = upper_col.get(0).unwrap();
    assert_eq!(upper_val.as_str().unwrap_or("ERROR"), "");

    let rev_col = result.column(2).unwrap();
    let rev_val = rev_col.get(0).unwrap();
    assert_eq!(rev_val.as_str().unwrap_or("ERROR"), "");

    let trim_col = result.column(3).unwrap();
    let trim_val = trim_col.get(0).unwrap();
    assert_eq!(trim_val.as_str().unwrap_or("ERROR"), "");
}

#[test]
fn test_unicode_handling() {
    let mut executor = create_executor();
    let result = executor.execute_sql(
        "SELECT LENGTH('café') AS len, UPPER('café') AS upper, LOWER('CAFÉ') AS lower, REVERSE('café') AS rev"
    ).expect("Query should succeed");

    let len_col = result.column(0).unwrap();
    let len_val = len_col.get(0).unwrap();
    assert_eq!(len_val.as_i64(), Some(4));

    let upper_col = result.column(1).unwrap();
    let upper_val = upper_col.get(0).unwrap();
    assert_eq!(upper_val.as_str().unwrap_or("ERROR"), "CAFÉ");

    let lower_col = result.column(2).unwrap();
    let lower_val = lower_col.get(0).unwrap();
    assert_eq!(lower_val.as_str().unwrap_or("ERROR"), "café");

    let rev_col = result.column(3).unwrap();
    let rev_val = rev_col.get(0).unwrap();
    assert_eq!(rev_val.as_str().unwrap_or("ERROR"), "éfac");
}
