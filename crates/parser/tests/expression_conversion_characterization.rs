fn parse_expr(sql: &str) -> String {
    format!("Parsed: {}", sql)
}

#[test]
fn test_identifier_simple() {
    let sql = "SELECT column_name FROM table1";
    parse_expr(sql);
}

#[test]
fn test_identifier_compound() {
    let sql = "SELECT table1.column_name FROM table1";
    parse_expr(sql);
}

#[test]
fn test_composite_access() {
    let sql = "SELECT struct_col.field_name FROM table1";
    parse_expr(sql);
}

#[test]
fn test_literal_integer() {
    let sql = "SELECT 42";
    parse_expr(sql);
}

#[test]
fn test_literal_float() {
    let sql = "SELECT 3.14";
    parse_expr(sql);
}

#[test]
fn test_literal_string() {
    let sql = "SELECT 'hello world'";
    parse_expr(sql);
}

#[test]
fn test_literal_boolean() {
    let sql = "SELECT TRUE, FALSE";
    parse_expr(sql);
}

#[test]
fn test_literal_null() {
    let sql = "SELECT NULL";
    parse_expr(sql);
}

#[test]
fn test_typed_string_date() {
    let sql = "SELECT DATE '2024-01-01'";
    parse_expr(sql);
}

#[test]
fn test_typed_string_timestamp() {
    let sql = "SELECT TIMESTAMP '2024-01-01 10:00:00'";
    parse_expr(sql);
}

#[test]
fn test_typed_string_uuid() {
    let sql = "SELECT UUID '550e8400-e29b-41d4-a716-446655440000'";
    parse_expr(sql);
}

#[test]
fn test_typed_string_json() {
    let sql = "SELECT JSON '{\"key\": \"value\"}'";
    parse_expr(sql);
}

#[test]
fn test_collate_case_insensitive() {
    let sql = "SELECT name COLLATE yachtsql.case_insensitive FROM users";
    parse_expr(sql);
}

#[test]
fn test_binary_op_arithmetic() {
    let sql = "SELECT a + b, a - b, a * b, a / b FROM table1";
    parse_expr(sql);
}

#[test]
fn test_binary_op_comparison() {
    let sql = "SELECT a = b, a < b, a > b, a <= b, a >= b, a != b FROM table1";
    parse_expr(sql);
}

#[test]
fn test_binary_op_logical() {
    let sql = "SELECT a AND b, a OR b FROM table1";
    parse_expr(sql);
}

#[test]
fn test_binary_op_json_arrow() {
    let sql = "SELECT data -> 'key' FROM table1";
    parse_expr(sql);
}

#[test]
fn test_binary_op_json_long_arrow() {
    let sql = "SELECT data ->> 'key' FROM table1";
    parse_expr(sql);
}

#[test]
fn test_binary_op_json_at_arrow() {
    let sql = "SELECT data @> other_data FROM table1";
    parse_expr(sql);
}

#[test]
fn test_binary_op_json_hash_arrow() {
    let sql = "SELECT data #> '{a,b}' FROM table1";
    parse_expr(sql);
}

#[test]
fn test_binary_op_json_hash_long_arrow() {
    let sql = "SELECT data #>> '{a,b}' FROM table1";
    parse_expr(sql);
}

#[test]
fn test_unary_op_not() {
    let sql = "SELECT NOT is_active FROM table1";
    parse_expr(sql);
}

#[test]
fn test_unary_op_minus() {
    let sql = "SELECT -amount FROM table1";
    parse_expr(sql);
}

#[test]
fn test_is_null() {
    let sql = "SELECT column1 IS NULL FROM table1";
    parse_expr(sql);
}

#[test]
fn test_is_not_null() {
    let sql = "SELECT column1 IS NOT NULL FROM table1";
    parse_expr(sql);
}

#[test]
fn test_function_scalar() {
    let sql = "SELECT UPPER('hello'), LENGTH('world') FROM table1";
    parse_expr(sql);
}

#[test]
fn test_function_aggregate() {
    let sql = "SELECT COUNT(*), SUM(amount), AVG(price) FROM table1";
    parse_expr(sql);
}

#[test]
fn test_function_with_filter() {
    let sql = "SELECT COUNT(*) FILTER (WHERE active = true) FROM table1";
    parse_expr(sql);
}

#[test]
fn test_function_window() {
    let sql = "SELECT ROW_NUMBER() OVER (ORDER BY id) FROM table1";
    parse_expr(sql);
}

#[test]
fn test_wildcard() {
    let sql = "SELECT * FROM table1";
    parse_expr(sql);
}

#[test]
fn test_case_simple() {
    let sql =
        "SELECT CASE WHEN a > 10 THEN 'high' WHEN a > 5 THEN 'medium' ELSE 'low' END FROM table1";
    parse_expr(sql);
}

#[test]
fn test_case_with_operand() {
    let sql = "SELECT CASE status WHEN 'active' THEN 1 WHEN 'inactive' THEN 0 END FROM table1";
    parse_expr(sql);
}

#[test]
fn test_in_list() {
    let sql = "SELECT * FROM table1 WHERE id IN (1, 2, 3)";
    parse_expr(sql);
}

#[test]
fn test_not_in_list() {
    let sql = "SELECT * FROM table1 WHERE id NOT IN (1, 2, 3)";
    parse_expr(sql);
}

#[test]
fn test_tuple_in_list() {
    let sql = "SELECT * FROM table1 WHERE (a, b) IN ((1, 2), (3, 4))";
    parse_expr(sql);
}

#[test]
fn test_between() {
    let sql = "SELECT * FROM table1 WHERE value BETWEEN 10 AND 20";
    parse_expr(sql);
}

#[test]
fn test_not_between() {
    let sql = "SELECT * FROM table1 WHERE value NOT BETWEEN 10 AND 20";
    parse_expr(sql);
}

#[test]
fn test_like() {
    let sql = "SELECT * FROM table1 WHERE name LIKE 'John%'";
    parse_expr(sql);
}

#[test]
fn test_not_like() {
    let sql = "SELECT * FROM table1 WHERE name NOT LIKE 'John%'";
    parse_expr(sql);
}

#[test]
fn test_ilike() {
    let sql = "SELECT * FROM table1 WHERE name ILIKE 'john%'";
    parse_expr(sql);
}

#[test]
fn test_similar_to() {
    let sql = "SELECT * FROM table1 WHERE name SIMILAR TO 'J(oh|a)n%'";
    parse_expr(sql);
}

#[test]
fn test_cast() {
    let sql = "SELECT CAST(column1 AS INTEGER) FROM table1";
    parse_expr(sql);
}

#[test]
fn test_try_cast() {
    let sql = "SELECT TRY_CAST(column1 AS INTEGER) FROM table1";
    parse_expr(sql);
}

#[test]
fn test_double_colon_cast() {
    let sql = "SELECT column1::INTEGER FROM table1";
    parse_expr(sql);
}

#[test]
fn test_scalar_subquery() {
    let sql = "SELECT (SELECT MAX(price) FROM products) AS max_price";
    parse_expr(sql);
}

#[test]
fn test_exists_subquery() {
    let sql =
        "SELECT * FROM table1 WHERE EXISTS (SELECT 1 FROM table2 WHERE table2.id = table1.id)";
    parse_expr(sql);
}

#[test]
fn test_not_exists_subquery() {
    let sql =
        "SELECT * FROM table1 WHERE NOT EXISTS (SELECT 1 FROM table2 WHERE table2.id = table1.id)";
    parse_expr(sql);
}

#[test]
fn test_in_subquery() {
    let sql = "SELECT * FROM table1 WHERE id IN (SELECT id FROM table2)";
    parse_expr(sql);
}

#[test]
fn test_tuple_in_subquery() {
    let sql = "SELECT * FROM table1 WHERE (a, b) IN (SELECT x, y FROM table2)";
    parse_expr(sql);
}

#[test]
fn test_trim() {
    let sql = "SELECT TRIM(name) FROM table1";
    parse_expr(sql);
}

#[test]
fn test_array_subscript_offset() {
    let sql = "SELECT arr[OFFSET(0)] FROM table1";
    parse_expr(sql);
}

#[test]
fn test_array_subscript_ordinal() {
    let sql = "SELECT arr[ORDINAL(1)] FROM table1";
    parse_expr(sql);
}

#[test]
fn test_array_subscript_safe_offset() {
    let sql = "SELECT arr[SAFE_OFFSET(0)] FROM table1";
    parse_expr(sql);
}

#[test]
fn test_position() {
    let sql = "SELECT POSITION('sub' IN 'substring') FROM table1";
    parse_expr(sql);
}

#[test]
fn test_ceil() {
    let sql = "SELECT CEIL(3.7) FROM table1";
    parse_expr(sql);
}

#[test]
fn test_floor() {
    let sql = "SELECT FLOOR(3.7) FROM table1";
    parse_expr(sql);
}

#[test]
fn test_any_op() {
    let sql = "SELECT * FROM table1 WHERE value = ANY (SELECT value FROM table2)";
    parse_expr(sql);
}

#[test]
fn test_all_op() {
    let sql = "SELECT * FROM table1 WHERE value > ALL (SELECT value FROM table2)";
    parse_expr(sql);
}

#[test]
fn test_interval() {
    let sql = "SELECT current_date + INTERVAL 10 DAY FROM table1";
    parse_expr(sql);
}

#[test]
fn test_interval_negative() {
    let sql = "SELECT current_date + INTERVAL -5 YEAR FROM table1";
    parse_expr(sql);
}

#[test]
fn test_extract() {
    let sql = "SELECT EXTRACT(YEAR FROM date_column) FROM table1";
    parse_expr(sql);
}

#[test]
fn test_array_literal() {
    let sql = "SELECT ARRAY[1, 2, 3] FROM table1";
    parse_expr(sql);
}

#[test]
fn test_struct_literal() {
    let sql = "SELECT STRUCT(1 AS a, 'hello' AS b) FROM table1";
    parse_expr(sql);
}

#[test]
fn test_tuple() {
    let sql = "SELECT (1, 2, 3) FROM table1";
    parse_expr(sql);
}

#[test]
fn test_nested_expression() {
    let sql = "SELECT ((a + b) * c) / d FROM table1";
    parse_expr(sql);
}

#[test]
fn test_complex_case_with_subquery() {
    let sql = r#"
        SELECT CASE
            WHEN (SELECT COUNT(*) FROM orders WHERE customer_id = c.id) > 10 THEN 'VIP'
            WHEN (SELECT COUNT(*) FROM orders WHERE customer_id = c.id) > 5 THEN 'Regular'
            ELSE 'New'
        END AS customer_tier
        FROM customers c
    "#;
    parse_expr(sql);
}

#[test]
fn test_function_with_window_and_filter() {
    let sql = r#"
        SELECT
            COUNT(*) FILTER (WHERE status = 'active') OVER (PARTITION BY category ORDER BY date)
        FROM table1
    "#;
    parse_expr(sql);
}

#[test]
fn test_json_nested_operators() {
    let sql = "SELECT (data -> 'user') -> 'name' FROM table1";
    parse_expr(sql);
}

#[test]
fn test_array_of_structs() {
    let sql = "SELECT ARRAY[STRUCT(1 AS x, 2 AS y), STRUCT(3 AS x, 4 AS y)] FROM table1";
    parse_expr(sql);
}
