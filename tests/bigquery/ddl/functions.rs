use crate::assert_table_eq;
use crate::common::create_executor;

#[test]
fn test_create_function_sql() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE FUNCTION add_one(x INT64) RETURNS INT64 AS (x + 1)")
        .unwrap();

    let result = executor.execute_sql("SELECT add_one(5)").unwrap();
    assert_table_eq!(result, [[6]]);
}

#[test]
fn test_create_function_string() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE FUNCTION greet(name STRING) RETURNS STRING AS (CONCAT('Hello, ', name))",
        )
        .unwrap();

    let result = executor.execute_sql("SELECT greet('World')").unwrap();
    assert_table_eq!(result, [["Hello, World"]]);
}

#[test]
fn test_create_or_replace_function() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE FUNCTION my_func(x INT64) RETURNS INT64 AS (x * 2)")
        .unwrap();

    executor
        .execute_sql("CREATE OR REPLACE FUNCTION my_func(x INT64) RETURNS INT64 AS (x * 3)")
        .unwrap();

    let result = executor.execute_sql("SELECT my_func(10)").unwrap();
    assert_table_eq!(result, [[30]]);
}

#[test]
fn test_create_function_if_not_exists() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE FUNCTION existing_func(x INT64) RETURNS INT64 AS (x)")
        .unwrap();

    executor
        .execute_sql(
            "CREATE FUNCTION IF NOT EXISTS existing_func(x INT64) RETURNS INT64 AS (x * 100)",
        )
        .unwrap();

    let result = executor.execute_sql("SELECT existing_func(5)").unwrap();
    assert_table_eq!(result, [[5]]);
}

#[test]
fn test_create_temp_function() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TEMP FUNCTION temp_add(a INT64, b INT64) RETURNS INT64 AS (a + b)")
        .unwrap();

    let result = executor.execute_sql("SELECT temp_add(3, 4)").unwrap();
    assert_table_eq!(result, [[7]]);
}

#[test]
fn test_create_function_multiple_params() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE FUNCTION calc(a INT64, b INT64, c INT64) RETURNS INT64 AS (a + b * c)")
        .unwrap();

    let result = executor.execute_sql("SELECT calc(1, 2, 3)").unwrap();
    assert_table_eq!(result, [[7]]);
}

#[test]
fn test_drop_function() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE FUNCTION to_drop(x INT64) RETURNS INT64 AS (x)")
        .unwrap();

    executor.execute_sql("DROP FUNCTION to_drop").unwrap();

    let result = executor.execute_sql("SELECT to_drop(1)");
    assert!(result.is_err());
}

#[test]
fn test_drop_function_if_exists() {
    let mut executor = create_executor();

    let result = executor.execute_sql("DROP FUNCTION IF EXISTS nonexistent_func");
    assert!(result.is_ok());
}

#[test]
fn test_create_function_with_case() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE FUNCTION classify(x INT64) RETURNS STRING AS (
                CASE
                    WHEN x < 0 THEN 'negative'
                    WHEN x = 0 THEN 'zero'
                    ELSE 'positive'
                END
            )",
        )
        .unwrap();

    let result = executor.execute_sql("SELECT classify(-5)").unwrap();
    assert_table_eq!(result, [["negative"]]);
}

#[test]
fn test_create_function_with_coalesce() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE FUNCTION safe_value(x INT64) RETURNS INT64 AS (COALESCE(x, 0))")
        .unwrap();

    let result = executor.execute_sql("SELECT safe_value(NULL)").unwrap();
    assert_table_eq!(result, [[0]]);
}

#[test]
fn test_function_in_where_clause() {
    let mut executor = create_executor();
    executor
        .execute_sql("CREATE TABLE numbers (val INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO numbers VALUES (1), (2), (3), (4), (5)")
        .unwrap();
    executor
        .execute_sql("CREATE FUNCTION is_even(x INT64) RETURNS BOOL AS (MOD(x, 2) = 0)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT val FROM numbers WHERE is_even(val) ORDER BY val")
        .unwrap();
    assert_table_eq!(result, [[2], [4]]);
}

#[test]
fn test_function_in_select() {
    let mut executor = create_executor();
    executor.execute_sql("CREATE TABLE data (x INT64)").unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (10), (20)")
        .unwrap();
    executor
        .execute_sql("CREATE FUNCTION double_it(n INT64) RETURNS INT64 AS (n * 2)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT x, double_it(x) AS doubled FROM data ORDER BY x")
        .unwrap();
    assert_table_eq!(result, [[10, 20], [20, 40]]);
}

#[test]
fn test_create_procedure() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE PROCEDURE my_procedure(x INT64, y INT64)
            BEGIN
                SELECT x + y;
            END",
        )
        .unwrap();

    let result = executor.execute_sql("CALL my_procedure(3, 4)").unwrap();
    assert_table_eq!(result, [[7]]);
}

#[test]
fn test_create_or_replace_procedure() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE PROCEDURE proc1()
            BEGIN
                SELECT 1;
            END",
        )
        .unwrap();

    executor
        .execute_sql(
            "CREATE OR REPLACE PROCEDURE proc1()
            BEGIN
                SELECT 2;
            END",
        )
        .unwrap();

    let result = executor.execute_sql("CALL proc1()").unwrap();
    assert_table_eq!(result, [[2]]);
}

#[test]
fn test_drop_procedure() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE PROCEDURE to_drop_proc()
            BEGIN
                SELECT 1;
            END",
        )
        .unwrap();

    executor.execute_sql("DROP PROCEDURE to_drop_proc").unwrap();

    let result = executor.execute_sql("CALL to_drop_proc()");
    assert!(result.is_err());
}

#[test]
fn test_drop_procedure_if_exists() {
    let mut executor = create_executor();

    let result = executor.execute_sql("DROP PROCEDURE IF EXISTS nonexistent_proc");
    assert!(result.is_ok());
}

#[test]
fn test_procedure_with_out_param() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE PROCEDURE get_sum(IN a INT64, IN b INT64, OUT result INT64)
            BEGIN
                SET result = a + b;
            END",
        )
        .unwrap();

    let result = executor.execute_sql("CALL get_sum(5, 3, @out)");
    assert!(result.is_ok());
}

#[test]
fn test_procedure_with_inout_param() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE PROCEDURE increment(INOUT x INT64)
            BEGIN
                SET x = x + 1;
            END",
        )
        .unwrap();

    executor.execute_sql("SET @val = 10").unwrap();
    executor.execute_sql("CALL increment(@val)").unwrap();

    let result = executor.execute_sql("SELECT @val").unwrap();
    assert_table_eq!(result, [[11]]);
}

#[test]
fn test_function_with_struct_return() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE FUNCTION make_point(x INT64, y INT64) RETURNS STRUCT<x INT64, y INT64> AS (STRUCT(x, y))",
        )
        .unwrap();

    let result = executor
        .execute_sql("SELECT make_point(1, 2).x, make_point(1, 2).y")
        .unwrap();
    assert_table_eq!(result, [[1, 2]]);
}

#[test]
fn test_function_with_array_return() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE FUNCTION make_range(n INT64) RETURNS ARRAY<INT64> AS (GENERATE_ARRAY(1, n))",
        )
        .unwrap();

    let result = executor
        .execute_sql("SELECT ARRAY_LENGTH(make_range(3))")
        .unwrap();
    assert_table_eq!(result, [[3]]);
}

#[test]
fn test_function_nested_call() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE FUNCTION f1(x INT64) RETURNS INT64 AS (x + 1)")
        .unwrap();
    executor
        .execute_sql("CREATE FUNCTION f2(x INT64) RETURNS INT64 AS (f1(x) * 2)")
        .unwrap();

    let result = executor.execute_sql("SELECT f2(5)").unwrap();
    assert_table_eq!(result, [[12]]);
}

#[test]
#[ignore]
fn test_create_aggregate_function() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE AGGREGATE FUNCTION my_sum(x INT64)
            RETURNS INT64
            AS (
                SUM(x)
            )",
        )
        .unwrap();

    executor
        .execute_sql("CREATE TABLE agg_data (value INT64)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO agg_data VALUES (1), (2), (3), (4), (5)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT my_sum(value) FROM agg_data")
        .unwrap();
    assert_table_eq!(result, [[15]]);
}

#[test]
#[ignore]
fn test_create_aggregate_function_with_multiple_args() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE AGGREGATE FUNCTION weighted_avg(value FLOAT64, weight FLOAT64)
            RETURNS FLOAT64
            AS (
                SUM(value * weight) / SUM(weight)
            )",
        )
        .unwrap();

    executor
        .execute_sql("CREATE TABLE weighted_data (val FLOAT64, wt FLOAT64)")
        .unwrap();

    executor
        .execute_sql("INSERT INTO weighted_data VALUES (10.0, 1.0), (20.0, 2.0), (30.0, 3.0)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT weighted_avg(val, wt) FROM weighted_data")
        .unwrap();
    assert_table_eq!(result, [[23.333333333333332]]);
}

#[test]
#[ignore]
fn test_create_or_replace_aggregate_function() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE AGGREGATE FUNCTION custom_count(x INT64)
            RETURNS INT64
            AS (COUNT(x))",
        )
        .unwrap();

    executor
        .execute_sql(
            "CREATE OR REPLACE AGGREGATE FUNCTION custom_count(x INT64)
            RETURNS INT64
            AS (COUNT(DISTINCT x))",
        )
        .unwrap();
}

#[test]
#[ignore]
fn test_drop_aggregate_function() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE AGGREGATE FUNCTION to_drop_agg(x INT64)
            RETURNS INT64
            AS (SUM(x))",
        )
        .unwrap();

    executor
        .execute_sql("DROP AGGREGATE FUNCTION to_drop_agg")
        .unwrap();

    let result = executor.execute_sql("SELECT to_drop_agg(1)");
    assert!(result.is_err());
}

#[test]
#[ignore]
fn test_create_table_function() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE TABLE FUNCTION my_table_func(x INT64)
            RETURNS TABLE<id INT64, value INT64>
            AS (
                SELECT id, value * x AS value
                FROM UNNEST([STRUCT(1 AS id, 10 AS value), STRUCT(2, 20)])
            )",
        )
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM my_table_func(2) ORDER BY id")
        .unwrap();
    assert_table_eq!(result, [[1, 20], [2, 40]]);
}

#[test]
#[ignore]
fn test_create_table_function_any_type() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE TABLE FUNCTION names_by_year(y INT64)
            RETURNS TABLE<name STRING, year INT64>
            AS (
                SELECT name, year FROM UNNEST([STRUCT('Alice' AS name, 2020 AS year), STRUCT('Bob', 2021)])
                WHERE year = y
            )",
        )
        .unwrap();

    let result = executor
        .execute_sql("SELECT name FROM names_by_year(2020)")
        .unwrap();
    assert_table_eq!(result, [["Alice"]]);
}

#[test]
#[ignore]
fn test_create_or_replace_table_function() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE TABLE FUNCTION tv_func()
            RETURNS TABLE<x INT64>
            AS (SELECT 1 AS x)",
        )
        .unwrap();

    executor
        .execute_sql(
            "CREATE OR REPLACE TABLE FUNCTION tv_func()
            RETURNS TABLE<x INT64>
            AS (SELECT 2 AS x)",
        )
        .unwrap();

    let result = executor.execute_sql("SELECT x FROM tv_func()").unwrap();
    assert_table_eq!(result, [[2]]);
}

#[test]
#[ignore]
fn test_drop_table_function() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE TABLE FUNCTION to_drop_tvf()
            RETURNS TABLE<x INT64>
            AS (SELECT 1 AS x)",
        )
        .unwrap();

    executor
        .execute_sql("DROP TABLE FUNCTION to_drop_tvf")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM to_drop_tvf()");
    assert!(result.is_err());
}

#[test]
#[ignore]
fn test_create_function_with_options() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE FUNCTION fn_with_opts(x INT64)
            RETURNS INT64
            OPTIONS (description = 'Adds one to input')
            AS (x + 1)",
        )
        .unwrap();

    let result = executor.execute_sql("SELECT fn_with_opts(5)").unwrap();
    assert_table_eq!(result, [[6]]);
}

#[test]
#[ignore]
fn test_create_function_javascript() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            r#"CREATE FUNCTION js_multiply(x FLOAT64, y FLOAT64)
            RETURNS FLOAT64
            LANGUAGE js
            AS r"""
                return x * y;
            """"#,
        )
        .unwrap();

    let result = executor
        .execute_sql("SELECT js_multiply(3.0, 4.0)")
        .unwrap();
    assert_table_eq!(result, [[12.0]]);
}

#[test]
#[ignore]
fn test_create_function_remote() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE FUNCTION remote_fn(x INT64)
            RETURNS INT64
            REMOTE WITH CONNECTION `project.region.connection`
            OPTIONS (
                endpoint = 'https://example.com/function'
            )",
        )
        .unwrap();
}

#[test]
fn test_procedure_with_declare() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE PROCEDURE proc_with_declare(x INT64)
            BEGIN
                DECLARE y INT64;
                SET y = x * 2;
                SELECT y;
            END",
        )
        .unwrap();

    let result = executor.execute_sql("CALL proc_with_declare(5)").unwrap();
    assert_table_eq!(result, [[10]]);
}

#[test]
#[ignore]
fn test_procedure_with_if() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE PROCEDURE proc_with_if(x INT64)
            BEGIN
                IF x > 0 THEN
                    SELECT 'positive';
                ELSE
                    SELECT 'non-positive';
                END IF;
            END",
        )
        .unwrap();

    let result = executor.execute_sql("CALL proc_with_if(5)").unwrap();
    assert_table_eq!(result, [["positive"]]);
}

#[test]
fn test_procedure_with_loop() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE PROCEDURE proc_with_loop()
            BEGIN
                DECLARE i INT64 DEFAULT 0;
                DECLARE sum INT64 DEFAULT 0;
                WHILE i < 5 DO
                    SET sum = sum + i;
                    SET i = i + 1;
                END WHILE;
                SELECT sum;
            END",
        )
        .unwrap();

    let result = executor.execute_sql("CALL proc_with_loop()").unwrap();
    assert_table_eq!(result, [[10]]);
}

#[test]
#[ignore]
fn test_procedure_with_exception_handling() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE PROCEDURE proc_with_exception()
            BEGIN
                BEGIN
                    SELECT 1/0;
                EXCEPTION WHEN ERROR THEN
                    SELECT 'caught';
                END;
            END",
        )
        .unwrap();

    let result = executor.execute_sql("CALL proc_with_exception()").unwrap();
    assert_table_eq!(result, [["caught"]]);
}

#[test]
#[ignore]
fn test_procedure_if_not_exists() {
    let mut executor = create_executor();

    executor
        .execute_sql(
            "CREATE PROCEDURE existing_proc()
            BEGIN
                SELECT 1;
            END",
        )
        .unwrap();

    executor
        .execute_sql(
            "CREATE PROCEDURE IF NOT EXISTS existing_proc()
            BEGIN
                SELECT 2;
            END",
        )
        .unwrap();

    let result = executor.execute_sql("CALL existing_proc()").unwrap();
    assert_table_eq!(result, [[1]]);
}
