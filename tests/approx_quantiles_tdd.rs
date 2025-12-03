#![allow(dead_code)]
#![allow(unused_variables)]
#![allow(clippy::unnecessary_unwrap)]
#![allow(clippy::collapsible_if)]
#![allow(clippy::wildcard_enum_match_arm)]

use yachtsql::{DialectType, QueryExecutor, Value};

fn new_bq_executor() -> QueryExecutor {
    QueryExecutor::with_dialect(DialectType::BigQuery)
}

fn value_to_f64(value: &Value) -> f64 {
    if let Some(i) = value.as_i64() {
        return i as f64;
    }
    if let Some(f) = value.as_f64() {
        return f;
    }
    panic!("expected numeric value, found {:?}", value)
}

fn assert_value_eq(expected: f64, actual: &Value) {
    let actual_val = value_to_f64(actual);
    assert!(
        (actual_val - expected).abs() < 1e-6,
        "expected {:.3}, got {:.3}",
        expected,
        actual_val
    );
}

#[test]
fn test_approx_quantiles_group_by_returns_arrays() {
    let mut executor = new_bq_executor();

    executor
        .execute_sql("CREATE TABLE scores(region STRING, score INT64)")
        .unwrap();

    executor
        .execute_sql(
            "INSERT INTO scores VALUES
             ('US', 10),
             ('US', 20),
             ('US', 30),
             ('US', 40),
             ('APAC', 5)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT region, APPROX_QUANTILES(score, 4) AS quantiles
             FROM scores
             GROUP BY region
             ORDER BY region",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 2);

    let region_col = result.column(0).unwrap();
    let quantiles_col = result.column(1).unwrap();

    assert_eq!(region_col.get(0).unwrap().as_str().unwrap(), "APAC");
    let apac_quantiles = quantiles_col.get(0).unwrap();
    let apac_array = apac_quantiles
        .as_array()
        .expect("quantiles should be ARRAY");
    assert_eq!(apac_array.len(), 5);
    for value in apac_array {
        assert_value_eq(5.0, value);
    }

    assert_eq!(region_col.get(1).unwrap().as_str().unwrap(), "US");
    let us_quantiles = quantiles_col.get(1).unwrap();
    let us_array = us_quantiles.as_array().expect("quantiles should be ARRAY");
    assert_eq!(us_array.len(), 5);
    assert_value_eq(10.0, &us_array[0]);
    assert_value_eq(40.0, &us_array[us_array.len() - 1]);
}

#[test]
fn test_approx_quantiles_empty_input_returns_null() {
    let mut executor = new_bq_executor();

    executor
        .execute_sql("CREATE TABLE metrics(value INT64)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT APPROX_QUANTILES(value, 5) AS q FROM metrics")
        .unwrap();

    assert!(result.column(0).unwrap().get(0).unwrap().is_null());
}

#[test]
fn test_approx_quantiles_all_null_input_returns_null() {
    let mut executor = new_bq_executor();

    executor
        .execute_sql("CREATE TABLE metrics(value INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO metrics VALUES (NULL), (NULL)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT APPROX_QUANTILES(value, 3) AS q FROM metrics")
        .unwrap();

    assert!(result.column(0).unwrap().get(0).unwrap().is_null());
}
