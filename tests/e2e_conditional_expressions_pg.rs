use yachtsql::QueryExecutor;
use yachtsql_parser::DialectType;

fn setup_executor() -> QueryExecutor {
    QueryExecutor::with_dialect(DialectType::PostgreSQL)
}

#[test]
fn test_case_searched_basic() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE users (name STRING, age INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO users VALUES ('Alice', 17), ('Bob', 30), ('Carol', 70)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT name, CASE WHEN age < 18 THEN 'Minor' WHEN age < 65 THEN 'Adult' ELSE 'Senior' END as age_group FROM users ORDER BY name",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);
    let col = result.column(1).unwrap();
    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "Minor");
    assert_eq!(col.get(1).unwrap().as_str().unwrap(), "Adult");
    assert_eq!(col.get(2).unwrap().as_str().unwrap(), "Senior");
}

#[test]
fn test_case_searched_no_else() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE test (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (5), (15)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT CASE WHEN value < 10 THEN 'low' END as category FROM test ORDER BY value",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 2);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "low");
    assert!(col.get(1).unwrap().is_null());
}

#[test]
fn test_case_searched_with_null_check() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE test (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (NULL), (10)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT CASE WHEN value IS NULL THEN 'null' ELSE 'not null' END as status FROM test ORDER BY status",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_case_simple_basic() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE users (name STRING, status STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO users VALUES ('Alice', 'A'), ('Bob', 'I'), ('Carol', 'X')")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT name, CASE status WHEN 'A' THEN 'Active' WHEN 'I' THEN 'Inactive' ELSE 'Unknown' END as status_text FROM users ORDER BY name",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);
    let col = result.column(1).unwrap();
    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "Active");
    assert_eq!(col.get(1).unwrap().as_str().unwrap(), "Inactive");
    assert_eq!(col.get(2).unwrap().as_str().unwrap(), "Unknown");
}

#[test]
fn test_case_simple_with_integers() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE test (code INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO test VALUES (1), (2), (3)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT CASE code WHEN 1 THEN 'one' WHEN 2 THEN 'two' ELSE 'other' END as name FROM test ORDER BY code",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "one");
    assert_eq!(col.get(1).unwrap().as_str().unwrap(), "two");
    assert_eq!(col.get(2).unwrap().as_str().unwrap(), "other");
}

#[test]
fn test_case_nested() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (type STRING, value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES ('A', 150), ('A', 50), ('B', 100)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT CASE WHEN type = 'A' THEN CASE WHEN value > 100 THEN 'High A' ELSE 'Low A' END ELSE 'Other' END as category FROM data ORDER BY type, value",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "Low A");
    assert_eq!(col.get(1).unwrap().as_str().unwrap(), "High A");
    assert_eq!(col.get(2).unwrap().as_str().unwrap(), "Other");
}

#[test]
fn test_coalesce_basic() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE users (preferred_name STRING, first_name STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO users VALUES (NULL, 'Alice'), ('Bobby', 'Robert'), (NULL, NULL)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT COALESCE(preferred_name, first_name, 'Anonymous') as display_name FROM users",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "Alice");
    assert_eq!(col.get(1).unwrap().as_str().unwrap(), "Bobby");
    assert_eq!(col.get(2).unwrap().as_str().unwrap(), "Anonymous");
}

#[test]
fn test_coalesce_with_numbers() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (a INT64, b INT64, c INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (NULL, NULL, 3), (NULL, 2, 3), (1, 2, 3)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT COALESCE(a, b, c, 0) as result FROM data")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 3);
    assert_eq!(col.get(1).unwrap().as_i64().unwrap(), 2);
    assert_eq!(col.get(2).unwrap().as_i64().unwrap(), 1);
}

#[test]
fn test_coalesce_all_null() {
    let mut executor = setup_executor();

    let result = executor
        .execute_sql("SELECT COALESCE(NULL, NULL, NULL) as result")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    assert!(result.column(0).unwrap().get(0).unwrap().is_null());
}

#[test]
fn test_nullif_equal_values() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (a INT64, b INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (10, 10), (10, 20)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT NULLIF(a, b) as result FROM data ORDER BY b")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
    let col = result.column(0).unwrap();
    assert!(col.get(0).unwrap().is_null());
    assert_eq!(col.get(1).unwrap().as_i64().unwrap(), 10);
}

#[test]
fn test_nullif_safe_division() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE calculations (value INT64, divisor INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO calculations VALUES (100, 0), (100, 5)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT value / NULLIF(divisor, 0) as result FROM calculations ORDER BY divisor",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 2);
    let col = result.column(0).unwrap();
    assert!(col.get(0).unwrap().is_null());
    assert_eq!(col.get(1).unwrap().as_i64().unwrap(), 20);
}

#[test]
fn test_greatest_via_case() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (a INT64, b INT64, c INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, 5, 3), (10, 2, 8)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT CASE WHEN a >= b AND a >= c THEN a WHEN b >= c THEN b ELSE c END as max_val FROM data ORDER BY a",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 2);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 5);
    assert_eq!(col.get(1).unwrap().as_i64().unwrap(), 10);
}

#[test]
fn test_least_via_case() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE quotes (price1 INT64, price2 INT64, price3 INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO quotes VALUES (100, 90, 95), (50, 60, 55)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT CASE WHEN price1 <= price2 AND price1 <= price3 THEN price1 WHEN price2 <= price3 THEN price2 ELSE price3 END as min_price FROM quotes ORDER BY price1",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 2);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 50);
    assert_eq!(col.get(1).unwrap().as_i64().unwrap(), 90);
}

#[test]
fn test_case_conditional_bool() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE users (name STRING, active BOOL)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO users VALUES ('Alice', TRUE), ('Bob', FALSE)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT name, CASE WHEN active THEN 'Yes' ELSE 'No' END as status FROM users ORDER BY name")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
    let col = result.column(1).unwrap();
    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "Yes");
    assert_eq!(col.get(1).unwrap().as_str().unwrap(), "No");
}

#[test]
fn test_case_conditional_comparison() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE students (name STRING, score INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO students VALUES ('Alice', 75), ('Bob', 55)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT name, CASE WHEN score >= 60 THEN 'Pass' ELSE 'Fail' END as grade FROM students ORDER BY name")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
    let col = result.column(1).unwrap();
    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "Pass");
    assert_eq!(col.get(1).unwrap().as_str().unwrap(), "Fail");
}

#[test]
fn test_is_null() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (NULL), (0), (10)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM data WHERE value IS NULL")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_is_not_null() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (NULL), (0), (10)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM data WHERE value IS NOT NULL ORDER BY value")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_boolean_and() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE products (name STRING, in_stock BOOL, price INT64)")
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO products VALUES ('A', TRUE, 50), ('B', TRUE, 150), ('C', FALSE, 50)",
        )
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM products WHERE in_stock AND price < 100")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    assert_eq!(
        result.column(0).unwrap().get(0).unwrap().as_str().unwrap(),
        "A"
    );
}

#[test]
fn test_boolean_or() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE users (name STRING, active BOOL, admin BOOL)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO users VALUES ('Alice', TRUE, FALSE), ('Bob', FALSE, TRUE), ('Carol', FALSE, FALSE)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM users WHERE active OR admin ORDER BY name")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_boolean_not() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (name STRING, deleted BOOL)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES ('A', FALSE), ('B', TRUE), ('C', FALSE)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM data WHERE NOT deleted ORDER BY name")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_range_comparison_numeric() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE orders (id INT64, total INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO orders VALUES (1, 50), (2, 200), (3, 400), (4, 600)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM orders WHERE total >= 100 AND total <= 500 ORDER BY id")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 2);
    assert_eq!(col.get(1).unwrap().as_i64().unwrap(), 3);
}

#[test]
fn test_range_comparison_string() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE events (id INT64, date STRING)")
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO events VALUES (1, '2024-01-15'), (2, '2024-06-15'), (3, '2025-01-15')",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT * FROM events WHERE date >= '2024-01-01' AND date <= '2024-12-31' ORDER BY id",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_in_list_strings() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE users (name STRING, status STRING)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO users VALUES ('Alice', 'active'), ('Bob', 'pending'), ('Carol', 'closed'), ('Dave', 'review')")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT * FROM users WHERE status IN ('active', 'pending', 'review') ORDER BY name",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);
}

#[test]
fn test_in_list_numbers() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (id INT64, value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1, 10), (2, 20), (3, 30), (4, 40), (5, 50)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM data WHERE id IN (1, 2, 3, 4, 5) ORDER BY id")
        .unwrap();

    assert_eq!(result.num_rows(), 5);
}

#[test]
fn test_not_in_list() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (id INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (1), (2), (3), (4), (5)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM data WHERE id NOT IN (1, 2, 3) ORDER BY id")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 4);
    assert_eq!(col.get(1).unwrap().as_i64().unwrap(), 5);
}

#[test]
fn test_case_with_coalesce() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE data (value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (NULL), (5), (15)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT CASE WHEN COALESCE(value, 0) > 10 THEN 'high' ELSE 'low' END as category FROM data ORDER BY value NULLS FIRST",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "low");
    assert_eq!(col.get(1).unwrap().as_str().unwrap(), "low");
    assert_eq!(col.get(2).unwrap().as_str().unwrap(), "high");
}

#[test]
fn test_nested_case_with_nullif() {
    let mut executor = setup_executor();
    executor
        .execute_sql("CREATE TABLE calculations (a INT64, b INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO calculations VALUES (10, 10), (10, 5)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT CASE WHEN NULLIF(a, b) IS NULL THEN 'equal' ELSE 'not equal' END as result FROM calculations ORDER BY b")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_str().unwrap(), "not equal");
    assert_eq!(col.get(1).unwrap().as_str().unwrap(), "equal");
}
