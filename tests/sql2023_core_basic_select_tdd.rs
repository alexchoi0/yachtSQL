#![allow(dead_code)]
#![allow(unused_variables)]

use yachtsql::{DialectType, QueryExecutor};

fn create_executor() -> QueryExecutor {
    QueryExecutor::with_dialect(DialectType::PostgreSQL)
}

fn setup_equipment(executor: &mut QueryExecutor) {
    executor
        .execute_sql("DROP TABLE IF EXISTS equipment")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE equipment (id INT64, name STRING, price FLOAT64)")
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO equipment VALUES
            (1, 'Apple', 1.99),
            (2, 'Banana', 0.99),
            (3, 'Cherry', 2.99),
            (4, 'Date', 3.49)",
        )
        .unwrap();
}

#[test]
fn test_select_all_equipment() {
    let mut executor = create_executor();
    setup_equipment(&mut executor);

    let result = executor
        .execute_sql("SELECT id, name, price FROM equipment ORDER BY id")
        .unwrap();

    assert_eq!(result.num_rows(), 4);

    let id_col = result.column(0).unwrap();
    let name_col = result.column(1).unwrap();
    let price_col = result.column(2).unwrap();

    assert_eq!(id_col.get(0).unwrap().as_i64(), Some(1));
    assert_eq!(name_col.get(0).unwrap().as_str(), Some("Apple"));
    assert!((price_col.get(0).unwrap().as_f64().unwrap() - 1.99).abs() < 0.001);

    assert_eq!(id_col.get(1).unwrap().as_i64(), Some(2));
    assert_eq!(name_col.get(1).unwrap().as_str(), Some("Banana"));
    assert!((price_col.get(1).unwrap().as_f64().unwrap() - 0.99).abs() < 0.001);

    assert_eq!(id_col.get(2).unwrap().as_i64(), Some(3));
    assert_eq!(name_col.get(2).unwrap().as_str(), Some("Cherry"));
    assert!((price_col.get(2).unwrap().as_f64().unwrap() - 2.99).abs() < 0.001);

    assert_eq!(id_col.get(3).unwrap().as_i64(), Some(4));
    assert_eq!(name_col.get(3).unwrap().as_str(), Some("Date"));
    assert!((price_col.get(3).unwrap().as_f64().unwrap() - 3.49).abs() < 0.001);
}

#[test]
fn test_filter_equipment_price_gt_1_5() {
    let mut executor = create_executor();
    setup_equipment(&mut executor);

    let result = executor
        .execute_sql(
            "SELECT id, name, price FROM equipment WHERE price > 1.5 ORDER BY price DESC, id",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    let id_col = result.column(0).unwrap();
    let name_col = result.column(1).unwrap();
    let price_col = result.column(2).unwrap();

    assert_eq!(id_col.get(0).unwrap().as_i64(), Some(4));
    assert_eq!(name_col.get(0).unwrap().as_str(), Some("Date"));

    assert_eq!(id_col.get(1).unwrap().as_i64(), Some(3));
    assert_eq!(name_col.get(1).unwrap().as_str(), Some("Cherry"));

    assert_eq!(id_col.get(2).unwrap().as_i64(), Some(1));
    assert_eq!(name_col.get(2).unwrap().as_str(), Some("Apple"));
}

#[test]
fn test_order_equipment_by_price_desc_limit_2() {
    let mut executor = create_executor();
    setup_equipment(&mut executor);

    let result = executor
        .execute_sql("SELECT id, name, price FROM equipment ORDER BY price DESC, id LIMIT 2")
        .unwrap();

    assert_eq!(result.num_rows(), 2);

    let id_col = result.column(0).unwrap();
    let name_col = result.column(1).unwrap();

    assert_eq!(id_col.get(0).unwrap().as_i64(), Some(4));
    assert_eq!(name_col.get(0).unwrap().as_str(), Some("Date"));

    assert_eq!(id_col.get(1).unwrap().as_i64(), Some(3));
    assert_eq!(name_col.get(1).unwrap().as_str(), Some("Cherry"));
}

fn setup_crew_members(executor: &mut QueryExecutor) {
    executor
        .execute_sql("DROP TABLE IF EXISTS crew_members")
        .unwrap();
    executor
        .execute_sql(
            "CREATE TABLE crew_members (id INT64, name STRING, age INT64, salary INT64, fleet STRING)",
        )
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO crew_members VALUES
            (1, 'Alice', 30, 60000, 'Engineering'),
            (2, 'Bob', 28, 52000, 'Operations'),
            (3, 'Charlie', 35, 58000, 'Engineering'),
            (4, 'Diana', 30, 61000, 'Command')",
        )
        .unwrap();
}

#[test]
fn test_select_name_salary() {
    let mut executor = create_executor();
    setup_crew_members(&mut executor);

    let result = executor
        .execute_sql("SELECT name, salary FROM crew_members ORDER BY name")
        .unwrap();

    assert_eq!(result.num_rows(), 4);

    let name_col = result.column(0).unwrap();
    let salary_col = result.column(1).unwrap();

    assert_eq!(name_col.get(0).unwrap().as_str(), Some("Alice"));
    assert_eq!(salary_col.get(0).unwrap().as_i64(), Some(60000));

    assert_eq!(name_col.get(1).unwrap().as_str(), Some("Bob"));
    assert_eq!(salary_col.get(1).unwrap().as_i64(), Some(52000));

    assert_eq!(name_col.get(2).unwrap().as_str(), Some("Charlie"));
    assert_eq!(salary_col.get(2).unwrap().as_i64(), Some(58000));

    assert_eq!(name_col.get(3).unwrap().as_str(), Some("Diana"));
    assert_eq!(salary_col.get(3).unwrap().as_i64(), Some(61000));
}

#[test]
fn test_select_crewmembers_age_and_salary() {
    let mut executor = create_executor();
    setup_crew_members(&mut executor);

    let result = executor
        .execute_sql(
            "SELECT id, name, age, salary FROM crew_members WHERE age = 30 AND salary > 58000 ORDER BY id",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 2);

    let id_col = result.column(0).unwrap();
    let name_col = result.column(1).unwrap();
    let age_col = result.column(2).unwrap();
    let salary_col = result.column(3).unwrap();

    assert_eq!(id_col.get(0).unwrap().as_i64(), Some(1));
    assert_eq!(name_col.get(0).unwrap().as_str(), Some("Alice"));
    assert_eq!(age_col.get(0).unwrap().as_i64(), Some(30));
    assert_eq!(salary_col.get(0).unwrap().as_i64(), Some(60000));

    assert_eq!(id_col.get(1).unwrap().as_i64(), Some(4));
    assert_eq!(name_col.get(1).unwrap().as_str(), Some("Diana"));
    assert_eq!(age_col.get(1).unwrap().as_i64(), Some(30));
    assert_eq!(salary_col.get(1).unwrap().as_i64(), Some(61000));
}

fn setup_users(executor: &mut QueryExecutor) {
    executor.execute_sql("DROP TABLE IF EXISTS users").unwrap();
    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING, age INT64, city STRING)")
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO users VALUES
            (1, 'Alice', 30, 'NYC'),
            (2, 'Bob', 25, 'LA'),
            (3, 'Charlie', 30, 'SF'),
            (4, 'Diana', 27, 'NYC')",
        )
        .unwrap();
}

#[test]
fn test_select_users_age_30() {
    let mut executor = create_executor();
    setup_users(&mut executor);

    let result = executor
        .execute_sql("SELECT id, name, age, city FROM users WHERE age = 30 ORDER BY name")
        .unwrap();

    assert_eq!(result.num_rows(), 2);

    let id_col = result.column(0).unwrap();
    let name_col = result.column(1).unwrap();
    let age_col = result.column(2).unwrap();
    let city_col = result.column(3).unwrap();

    assert_eq!(id_col.get(0).unwrap().as_i64(), Some(1));
    assert_eq!(name_col.get(0).unwrap().as_str(), Some("Alice"));
    assert_eq!(age_col.get(0).unwrap().as_i64(), Some(30));
    assert_eq!(city_col.get(0).unwrap().as_str(), Some("NYC"));

    assert_eq!(id_col.get(1).unwrap().as_i64(), Some(3));
    assert_eq!(name_col.get(1).unwrap().as_str(), Some("Charlie"));
    assert_eq!(age_col.get(1).unwrap().as_i64(), Some(30));
    assert_eq!(city_col.get(1).unwrap().as_str(), Some("SF"));
}

#[test]
fn test_select_users_in_nyc_or_sf() {
    let mut executor = create_executor();
    setup_users(&mut executor);

    let result = executor
        .execute_sql(
            "SELECT id, name, age, city FROM users WHERE city IN ('NYC', 'SF') ORDER BY city, name",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    let id_col = result.column(0).unwrap();
    let name_col = result.column(1).unwrap();
    let city_col = result.column(3).unwrap();

    assert_eq!(name_col.get(0).unwrap().as_str(), Some("Alice"));
    assert_eq!(city_col.get(0).unwrap().as_str(), Some("NYC"));

    assert_eq!(name_col.get(1).unwrap().as_str(), Some("Diana"));
    assert_eq!(city_col.get(1).unwrap().as_str(), Some("NYC"));

    assert_eq!(name_col.get(2).unwrap().as_str(), Some("Charlie"));
    assert_eq!(city_col.get(2).unwrap().as_str(), Some("SF"));
}

fn setup_scores(executor: &mut QueryExecutor) {
    executor.execute_sql("DROP TABLE IF EXISTS scores").unwrap();
    executor
        .execute_sql("CREATE TABLE scores (name STRING, score INT64)")
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO scores VALUES
            ('Alice', 85),
            ('Bob', 92),
            ('Charlie', 78)",
        )
        .unwrap();
}

#[test]
fn test_order_scores_ascending() {
    let mut executor = create_executor();
    setup_scores(&mut executor);

    let result = executor
        .execute_sql("SELECT name, score FROM scores ORDER BY score ASC, name")
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    let name_col = result.column(0).unwrap();
    let score_col = result.column(1).unwrap();

    assert_eq!(name_col.get(0).unwrap().as_str(), Some("Charlie"));
    assert_eq!(score_col.get(0).unwrap().as_i64(), Some(78));

    assert_eq!(name_col.get(1).unwrap().as_str(), Some("Alice"));
    assert_eq!(score_col.get(1).unwrap().as_i64(), Some(85));

    assert_eq!(name_col.get(2).unwrap().as_str(), Some("Bob"));
    assert_eq!(score_col.get(2).unwrap().as_i64(), Some(92));
}

#[test]
fn test_order_scores_descending() {
    let mut executor = create_executor();
    setup_scores(&mut executor);

    let result = executor
        .execute_sql("SELECT name, score FROM scores ORDER BY score DESC, name")
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    let name_col = result.column(0).unwrap();
    let score_col = result.column(1).unwrap();

    assert_eq!(name_col.get(0).unwrap().as_str(), Some("Bob"));
    assert_eq!(score_col.get(0).unwrap().as_i64(), Some(92));

    assert_eq!(name_col.get(1).unwrap().as_str(), Some("Alice"));
    assert_eq!(score_col.get(1).unwrap().as_i64(), Some(85));

    assert_eq!(name_col.get(2).unwrap().as_str(), Some("Charlie"));
    assert_eq!(score_col.get(2).unwrap().as_i64(), Some(78));
}

fn setup_numbers(executor: &mut QueryExecutor) {
    executor
        .execute_sql("DROP TABLE IF EXISTS numbers")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE numbers (value INT64)")
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO numbers VALUES
            (1), (2), (3), (4), (5), (6), (7), (8), (9), (10)",
        )
        .unwrap();
}

#[test]
fn test_numbers_limit_5() {
    let mut executor = create_executor();
    setup_numbers(&mut executor);

    let result = executor
        .execute_sql("SELECT value FROM numbers ORDER BY value LIMIT 5")
        .unwrap();

    assert_eq!(result.num_rows(), 5);

    let value_col = result.column(0).unwrap();

    assert_eq!(value_col.get(0).unwrap().as_i64(), Some(1));
    assert_eq!(value_col.get(1).unwrap().as_i64(), Some(2));
    assert_eq!(value_col.get(2).unwrap().as_i64(), Some(3));
    assert_eq!(value_col.get(3).unwrap().as_i64(), Some(4));
    assert_eq!(value_col.get(4).unwrap().as_i64(), Some(5));
}

fn setup_empty_table(executor: &mut QueryExecutor) {
    executor
        .execute_sql("DROP TABLE IF EXISTS empty_table")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE empty_table (id INT64, name STRING)")
        .unwrap();
}

#[test]
fn test_select_empty_table() {
    let mut executor = create_executor();
    setup_empty_table(&mut executor);

    let result = executor
        .execute_sql("SELECT id, name FROM empty_table")
        .unwrap();

    assert_eq!(result.num_rows(), 0);
}

fn setup_nullable_values(executor: &mut QueryExecutor) {
    executor
        .execute_sql("DROP TABLE IF EXISTS nullable_values")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE nullable_values (id INT64, value STRING)")
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO nullable_values VALUES
            (1, 'value'),
            (2, NULL),
            (3, 'another')",
        )
        .unwrap();
}

#[test]
fn test_select_nullable_all() {
    let mut executor = create_executor();
    setup_nullable_values(&mut executor);

    let result = executor
        .execute_sql("SELECT id, value FROM nullable_values ORDER BY id")
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    let id_col = result.column(0).unwrap();
    let value_col = result.column(1).unwrap();

    assert_eq!(id_col.get(0).unwrap().as_i64(), Some(1));
    assert_eq!(value_col.get(0).unwrap().as_str(), Some("value"));

    assert_eq!(id_col.get(1).unwrap().as_i64(), Some(2));
    assert!(value_col.get(1).unwrap().is_null());

    assert_eq!(id_col.get(2).unwrap().as_i64(), Some(3));
    assert_eq!(value_col.get(2).unwrap().as_str(), Some("another"));
}

#[test]
fn test_select_nullable_where_null() {
    let mut executor = create_executor();
    setup_nullable_values(&mut executor);

    let result = executor
        .execute_sql("SELECT id, value FROM nullable_values WHERE value IS NULL ORDER BY id")
        .unwrap();

    assert_eq!(result.num_rows(), 1);

    let id_col = result.column(0).unwrap();
    assert_eq!(id_col.get(0).unwrap().as_i64(), Some(2));
}

#[test]
fn test_select_nullable_where_not_null() {
    let mut executor = create_executor();
    setup_nullable_values(&mut executor);

    let result = executor
        .execute_sql("SELECT id, value FROM nullable_values WHERE value IS NOT NULL ORDER BY id")
        .unwrap();

    assert_eq!(result.num_rows(), 2);

    let id_col = result.column(0).unwrap();
    let value_col = result.column(1).unwrap();

    assert_eq!(id_col.get(0).unwrap().as_i64(), Some(1));
    assert_eq!(value_col.get(0).unwrap().as_str(), Some("value"));

    assert_eq!(id_col.get(1).unwrap().as_i64(), Some(3));
    assert_eq!(value_col.get(1).unwrap().as_str(), Some("another"));
}

fn setup_data(executor: &mut QueryExecutor) {
    executor.execute_sql("DROP TABLE IF EXISTS data").unwrap();
    executor
        .execute_sql("CREATE TABLE data (a INT64, b INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO data VALUES (10, 20)")
        .unwrap();
}

#[test]
fn test_select_data_sum() {
    let mut executor = create_executor();
    setup_data(&mut executor);

    let result = executor
        .execute_sql("SELECT a + b AS sum FROM data")
        .unwrap();

    assert_eq!(result.num_rows(), 1);

    let sum_col = result.column(0).unwrap();
    assert_eq!(sum_col.get(0).unwrap().as_i64(), Some(30));
}

fn setup_calc(executor: &mut QueryExecutor) {
    executor.execute_sql("DROP TABLE IF EXISTS calc").unwrap();
    executor
        .execute_sql("CREATE TABLE calc (x INT64, y INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO calc VALUES (5, 3)")
        .unwrap();
}

#[test]
fn test_select_calc_arithmetic() {
    let mut executor = create_executor();
    setup_calc(&mut executor);

    let result = executor
        .execute_sql("SELECT x + y AS addition, x * y AS multiplication FROM calc")
        .unwrap();

    assert_eq!(result.num_rows(), 1);

    let addition_col = result.column(0).unwrap();
    let multiplication_col = result.column(1).unwrap();

    assert_eq!(addition_col.get(0).unwrap().as_i64(), Some(8));
    assert_eq!(multiplication_col.get(0).unwrap().as_i64(), Some(15));
}

fn setup_complex(executor: &mut QueryExecutor) {
    executor
        .execute_sql("DROP TABLE IF EXISTS complex")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE complex (a INT64, b INT64, c INT64)")
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO complex VALUES
            (1, 2, 3),
            (4, 5, 6),
            (7, 8, 9)",
        )
        .unwrap();
}

#[test]
fn test_select_complex_condition() {
    let mut executor = create_executor();
    setup_complex(&mut executor);

    let result = executor
        .execute_sql("SELECT a, b, c FROM complex WHERE (a > 2 AND b < 8) OR c = 3 ORDER BY a")
        .unwrap();

    assert_eq!(result.num_rows(), 2);

    let a_col = result.column(0).unwrap();
    let b_col = result.column(1).unwrap();
    let c_col = result.column(2).unwrap();

    assert_eq!(a_col.get(0).unwrap().as_i64(), Some(1));
    assert_eq!(b_col.get(0).unwrap().as_i64(), Some(2));
    assert_eq!(c_col.get(0).unwrap().as_i64(), Some(3));

    assert_eq!(a_col.get(1).unwrap().as_i64(), Some(4));
    assert_eq!(b_col.get(1).unwrap().as_i64(), Some(5));
    assert_eq!(c_col.get(1).unwrap().as_i64(), Some(6));
}
