#![allow(dead_code)]
#![allow(unused_variables)]
#![allow(clippy::unnecessary_unwrap)]
#![allow(clippy::collapsible_if)]
#![allow(clippy::wildcard_enum_match_arm)]

mod common;
use common::setup_executor;

#[test]
fn test_case_searched_basic() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64, score INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (1, 95), (2, 75), (3, 55), (4, 35)")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT id, score, CASE WHEN score >= 90 THEN 'A' WHEN score >= 80 THEN 'B' WHEN score >= 70 THEN 'C' WHEN score >= 60 THEN 'D' ELSE 'F' END as grade FROM test ORDER BY id"
    ).unwrap();
    let grade_col = result.column(2).unwrap();

    assert_eq!(grade_col.get(0).unwrap().as_str().unwrap(), "A");
    assert_eq!(grade_col.get(1).unwrap().as_str().unwrap(), "C");
    assert_eq!(grade_col.get(2).unwrap().as_str().unwrap(), "F");
    assert_eq!(grade_col.get(3).unwrap().as_str().unwrap(), "F");
}

#[test]
fn test_case_searched_with_complex_conditions() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE employees (id INT64, salary INT64, years INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO employees VALUES (1, 50000, 2), (2, 80000, 5), (3, 120000, 10)")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT id, CASE WHEN salary > 100000 AND years >= 10 THEN 'Senior' WHEN salary > 70000 OR years >= 5 THEN 'Mid' ELSE 'Junior' END as level FROM employees ORDER BY id"
    ).unwrap();
    let level_col = result.column(1).unwrap();

    assert_eq!(level_col.get(0).unwrap().as_str().unwrap(), "Junior");
    assert_eq!(level_col.get(1).unwrap().as_str().unwrap(), "Mid");
    assert_eq!(level_col.get(2).unwrap().as_str().unwrap(), "Senior");
}

#[test]
fn test_case_searched_without_else() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64, val INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (1, 10), (2, 20)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT id, CASE WHEN val > 15 THEN 'HIGH' END as category FROM test ORDER BY id",
        )
        .unwrap();
    let col = result.column(1).unwrap();

    assert!(col.get(0).unwrap().is_null());
    assert_eq!(col.get(1).unwrap().as_str().unwrap(), "HIGH");
}

#[test]
fn test_case_searched_with_null_handling() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64, val INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (1, NULL), (2, 0), (3, 10)")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT id, CASE WHEN val IS NULL THEN 'NULL' WHEN val = 0 THEN 'ZERO' WHEN val > 0 THEN 'POSITIVE' ELSE 'NEGATIVE' END as category FROM test ORDER BY id"
    ).unwrap();
    let col = result.column(1).unwrap();

    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "NULL");
    assert_eq!(col.get(1).unwrap().as_str().unwrap(), "ZERO");
    assert_eq!(col.get(2).unwrap().as_str().unwrap(), "POSITIVE");
}

#[test]
fn test_case_searched_with_numeric_results() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64, category STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (1, 'A'), (2, 'B'), (3, 'C')")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT id, CASE WHEN category = 'A' THEN 100 WHEN category = 'B' THEN 50 ELSE 0 END as points FROM test ORDER BY id"
    ).unwrap();
    let col = result.column(1).unwrap();

    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 100);
    assert_eq!(col.get(1).unwrap().as_i64().unwrap(), 50);
    assert_eq!(col.get(2).unwrap().as_i64().unwrap(), 0);
}

#[test]
fn test_case_simple_basic() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64, day_num INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (1, 1), (2, 2), (3, 3), (4, 7)")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT id, CASE day_num WHEN 1 THEN 'Monday' WHEN 2 THEN 'Tuesday' WHEN 3 THEN 'Wednesday' WHEN 4 THEN 'Thursday' WHEN 5 THEN 'Friday' WHEN 6 THEN 'Saturday' WHEN 7 THEN 'Sunday' ELSE 'Unknown' END as day_name FROM test ORDER BY id"
    ).unwrap();
    let col = result.column(1).unwrap();

    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "Monday");
    assert_eq!(col.get(1).unwrap().as_str().unwrap(), "Tuesday");
    assert_eq!(col.get(2).unwrap().as_str().unwrap(), "Wednesday");
    assert_eq!(col.get(3).unwrap().as_str().unwrap(), "Sunday");
}

#[test]
fn test_case_simple_with_strings() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64, status STRING)")
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO test VALUES (1, 'active'), (2, 'pending'), (3, 'closed'), (4, 'unknown')",
        )
        .unwrap();

    let result = executor.execute_sql(
        "SELECT id, CASE status WHEN 'active' THEN 1 WHEN 'pending' THEN 2 WHEN 'closed' THEN 3 ELSE 0 END as status_code FROM test ORDER BY id"
    ).unwrap();
    let col = result.column(1).unwrap();

    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 1);
    assert_eq!(col.get(1).unwrap().as_i64().unwrap(), 2);
    assert_eq!(col.get(2).unwrap().as_i64().unwrap(), 3);
    assert_eq!(col.get(3).unwrap().as_i64().unwrap(), 0);
}

#[test]
fn test_if_function_basic() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64, val INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (1, 10), (2, -5), (3, 0)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT id, IF(val > 0, 'positive', 'non-positive') as sign FROM test ORDER BY id",
        )
        .unwrap();
    let col = result.column(1).unwrap();

    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "positive");
    assert_eq!(col.get(1).unwrap().as_str().unwrap(), "non-positive");
    assert_eq!(col.get(2).unwrap().as_str().unwrap(), "non-positive");
}

#[test]
fn test_if_function_with_null() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64, val INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (1, NULL), (2, 10)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id, IF(val > 5, 'yes', 'no') as result FROM test ORDER BY id")
        .unwrap();
    let col = result.column(1).unwrap();

    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "no");
    assert_eq!(col.get(1).unwrap().as_str().unwrap(), "yes");
}

#[test]
fn test_if_function_with_numeric_results() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64, quantity INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (1, 100), (2, 50)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT id, quantity * IF(quantity >= 100, 0.9, 1.0) as price FROM test ORDER BY id",
        )
        .unwrap();
    let col = result.column(1).unwrap();

    assert_eq!(col.get(0).unwrap().as_f64().unwrap(), 90.0);
    assert_eq!(col.get(1).unwrap().as_f64().unwrap(), 50.0);
}

#[test]
fn test_nested_if_functions() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64, score INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (1, 95), (2, 75), (3, 55)")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT id, IF(score >= 90, 'A', IF(score >= 70, 'B', 'C')) as grade FROM test ORDER BY id"
    ).unwrap();
    let col = result.column(1).unwrap();

    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "A");
    assert_eq!(col.get(1).unwrap().as_str().unwrap(), "B");
    assert_eq!(col.get(2).unwrap().as_str().unwrap(), "C");
}

#[test]
fn test_iif_function_basic() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64, is_active BOOL)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (1, TRUE), (2, FALSE)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT id, IIF(is_active, 'Active', 'Inactive') as status FROM test ORDER BY id",
        )
        .unwrap();
    let col = result.column(1).unwrap();

    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "Active");
    assert_eq!(col.get(1).unwrap().as_str().unwrap(), "Inactive");
}

#[test]
fn test_decode_basic() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64, status_code INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (1, 1), (2, 2), (3, 3), (4, 99)")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT id, DECODE(status_code, 1, 'New', 2, 'In Progress', 3, 'Done', 'Unknown') as status FROM test ORDER BY id"
    ).unwrap();
    let col = result.column(1).unwrap();

    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "New");
    assert_eq!(col.get(1).unwrap().as_str().unwrap(), "In Progress");
    assert_eq!(col.get(2).unwrap().as_str().unwrap(), "Done");
    assert_eq!(col.get(3).unwrap().as_str().unwrap(), "Unknown");
}

#[test]
fn test_decode_without_default() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64, val INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (1, 1), (2, 2), (3, 99)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id, DECODE(val, 1, 'one', 2, 'two') as name FROM test ORDER BY id")
        .unwrap();
    let col = result.column(1).unwrap();

    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "one");
    assert_eq!(col.get(1).unwrap().as_str().unwrap(), "two");
    assert!(col.get(2).unwrap().is_null());
}

#[test]
fn test_decode_with_strings() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64, country STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (1, 'US'), (2, 'UK'), (3, 'FR'), (4, 'XX')")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT id, DECODE(country, 'US', 'United States', 'UK', 'United Kingdom', 'FR', 'France', 'Other') as country_name FROM test ORDER BY id"
    ).unwrap();
    let col = result.column(1).unwrap();

    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "United States");
    assert_eq!(col.get(1).unwrap().as_str().unwrap(), "United Kingdom");
    assert_eq!(col.get(2).unwrap().as_str().unwrap(), "France");
    assert_eq!(col.get(3).unwrap().as_str().unwrap(), "Other");
}

#[test]
fn test_decode_with_null() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64, val INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (1, NULL), (2, 1)")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT id, DECODE(val, NULL, 'is null', 1, 'is one', 'other') as result FROM test ORDER BY id"
    ).unwrap();
    let col = result.column(1).unwrap();

    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "is null");
    assert_eq!(col.get(1).unwrap().as_str().unwrap(), "is one");
}

#[test]
fn test_nested_case_expressions() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64, category STRING, score INT64)")
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO test VALUES (1, 'A', 95), (2, 'A', 55), (3, 'B', 85), (4, 'B', 45)",
        )
        .unwrap();

    let result = executor.execute_sql(
        "SELECT id, CASE category WHEN 'A' THEN CASE WHEN score >= 90 THEN 'A-High' ELSE 'A-Low' END WHEN 'B' THEN CASE WHEN score >= 80 THEN 'B-High' ELSE 'B-Low' END ELSE 'Unknown' END as result FROM test ORDER BY id"
    ).unwrap();
    let col = result.column(1).unwrap();

    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "A-High");
    assert_eq!(col.get(1).unwrap().as_str().unwrap(), "A-Low");
    assert_eq!(col.get(2).unwrap().as_str().unwrap(), "B-High");
    assert_eq!(col.get(3).unwrap().as_str().unwrap(), "B-Low");
}

#[test]
fn test_case_in_case() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64, val INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (1, 10), (2, -10), (3, 0)")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT id, CASE WHEN (CASE WHEN val > 0 THEN 1 ELSE 0 END) = 1 THEN 'positive' ELSE 'non-positive' END as sign FROM test ORDER BY id"
    ).unwrap();
    let col = result.column(1).unwrap();

    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "positive");
    assert_eq!(col.get(1).unwrap().as_str().unwrap(), "non-positive");
    assert_eq!(col.get(2).unwrap().as_str().unwrap(), "non-positive");
}

#[test]
fn test_case_in_aggregation() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE sales (id INT64, amount INT64, region STRING)")
        .unwrap();
    executor.execute_sql("INSERT INTO sales VALUES (1, 100, 'North'), (2, 200, 'South'), (3, 150, 'North'), (4, 250, 'South')").unwrap();

    let result = executor.execute_sql(
        "SELECT SUM(CASE WHEN region = 'North' THEN amount ELSE 0 END) as north_total, SUM(CASE WHEN region = 'South' THEN amount ELSE 0 END) as south_total FROM sales"
    ).unwrap();

    let north_col = result.column(0).unwrap();
    let south_col = result.column(1).unwrap();

    assert_eq!(north_col.get(0).unwrap().as_i64().unwrap(), 250);
    assert_eq!(south_col.get(0).unwrap().as_i64().unwrap(), 450);
}

#[test]
fn test_case_with_group_by() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE employees (id INT64, dept STRING, salary INT64)")
        .unwrap();
    executor.execute_sql("INSERT INTO employees VALUES (1, 'Sales', 50000), (2, 'Sales', 120000), (3, 'Eng', 80000), (4, 'Eng', 140000)").unwrap();

    let result = executor.execute_sql(
        "SELECT dept, COUNT(CASE WHEN salary > 100000 THEN 1 END) as high_earners, COUNT(*) as total FROM employees GROUP BY dept ORDER BY dept"
    ).unwrap();

    let dept_col = result.column(0).unwrap();
    let high_col = result.column(1).unwrap();
    let total_col = result.column(2).unwrap();

    assert_eq!(dept_col.get(0).unwrap().as_str().unwrap(), "Eng");
    assert_eq!(high_col.get(0).unwrap().as_i64().unwrap(), 1);
    assert_eq!(total_col.get(0).unwrap().as_i64().unwrap(), 2);

    assert_eq!(dept_col.get(1).unwrap().as_str().unwrap(), "Sales");
    assert_eq!(high_col.get(1).unwrap().as_i64().unwrap(), 1);
    assert_eq!(total_col.get(1).unwrap().as_i64().unwrap(), 2);
}

#[test]
fn test_decode_in_order_by() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64, priority STRING)")
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO test VALUES (1, 'low'), (2, 'high'), (3, 'medium'), (4, 'critical')",
        )
        .unwrap();

    let result = executor.execute_sql(
        "SELECT id, priority FROM test ORDER BY DECODE(priority, 'critical', 1, 'high', 2, 'medium', 3, 'low', 4, 5)"
    ).unwrap();
    let id_col = result.column(0).unwrap();

    assert_eq!(id_col.get(0).unwrap().as_i64().unwrap(), 4);
    assert_eq!(id_col.get(1).unwrap().as_i64().unwrap(), 2);
    assert_eq!(id_col.get(2).unwrap().as_i64().unwrap(), 3);
    assert_eq!(id_col.get(3).unwrap().as_i64().unwrap(), 1);
}

#[test]
fn test_case_with_all_null_results() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64, val INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (1, 10)")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT CASE WHEN val > 20 THEN NULL WHEN val > 10 THEN NULL ELSE NULL END as result FROM test"
    ).unwrap();
    let col = result.column(0).unwrap();

    assert!(col.get(0).unwrap().is_null());
}

#[test]
fn test_case_with_type_coercion() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64, val INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (1, 10), (2, 20)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT id, CASE WHEN val > 15 THEN 1.5 ELSE val END as result FROM test ORDER BY id",
        )
        .unwrap();
    let col = result.column(1).unwrap();

    assert_eq!(col.get(0).unwrap().as_f64().unwrap(), 10.0);
    assert_eq!(col.get(1).unwrap().as_f64().unwrap(), 1.5);
}

#[test]
fn test_conditional_with_empty_table() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64, val INT64)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CASE WHEN val > 0 THEN 'pos' ELSE 'neg' END FROM test")
        .unwrap();

    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_decode_with_computed_expression() {
    let mut executor = setup_executor();

    executor
        .execute_sql("CREATE TABLE test (id INT64, a INT64, b INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (1, 10, 5), (2, 20, 10)")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT id, DECODE(a + b, 15, 'fifteen', 30, 'thirty', 'other') as result FROM test ORDER BY id"
    ).unwrap();
    let col = result.column(1).unwrap();

    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "fifteen");
    assert_eq!(col.get(1).unwrap().as_str().unwrap(), "thirty");
}
