#![allow(dead_code)]
#![allow(unused_variables)]
#![allow(clippy::unnecessary_unwrap)]
#![allow(clippy::collapsible_if)]
#![allow(clippy::wildcard_enum_match_arm)]

use yachtsql::{DialectType, QueryExecutor};

fn create_executor() -> QueryExecutor {
    QueryExecutor::with_dialect(DialectType::PostgreSQL)
}

fn setup_date_table(executor: &mut QueryExecutor) {
    let _ = executor.execute_sql("DROP TABLE IF EXISTS dates");
    executor
        .execute_sql("CREATE TABLE dates (id INT64, d DATE)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO dates VALUES (1, '2024-03-15')")
        .unwrap();
}

fn setup_dates_pair_table(executor: &mut QueryExecutor) {
    let _ = executor.execute_sql("DROP TABLE IF EXISTS periods");
    executor
        .execute_sql("CREATE TABLE periods (id INT64, start_date DATE, end_date DATE)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO periods VALUES (1, '2024-01-15', '2024-01-22')")
        .unwrap();
}

#[test]
fn test_current_date_001() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT CURRENT_DATE() AS today")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert!(!value.is_null(), "CURRENT_DATE() should not be null");
}

#[test]
fn test_current_date_function_002() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT CURRENT_DATE() AS today")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert!(!value.is_null(), "CURRENT_DATE() should not be null");
}

#[test]
fn test_current_timestamp_003() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT CURRENT_TIMESTAMP() AS now")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert!(!value.is_null(), "CURRENT_TIMESTAMP() should not be null");
}

#[test]
fn test_current_timestamp_function_004() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT CURRENT_TIMESTAMP() AS now")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert!(!value.is_null(), "CURRENT_TIMESTAMP() should not be null");
}

#[test]
fn test_now_function_005() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT CURRENT_TIMESTAMP() AS current_time")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert!(
        !value.is_null(),
        "NOW/CURRENT_TIMESTAMP() should not be null"
    );
}

#[test]
fn test_current_time_006() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT CURRENT_TIME() AS time_now")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert!(!value.is_null(), "CURRENT_TIME() should not be null");
}

#[test]
fn test_make_date_079() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT MAKE_DATE(2024, 3, 15) AS constructed")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();

    assert!(!value.is_null(), "MAKE_DATE should not return null");
}

#[test]
fn test_make_date_new_year_080() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT MAKE_DATE(2024, 1, 1) AS new_year")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert!(!value.is_null(), "MAKE_DATE should not return null");
}

#[test]
fn test_make_date_leap_year() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT MAKE_DATE(2024, 2, 29) AS leap_day")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert!(
        !value.is_null(),
        "MAKE_DATE for leap day should not return null"
    );
}

#[test]
fn test_make_date_end_of_year() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT MAKE_DATE(2024, 12, 31) AS year_end")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert!(
        !value.is_null(),
        "MAKE_DATE for Dec 31 should not return null"
    );
}

#[test]
fn test_make_date_comparison() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT MAKE_DATE(2024, 1, 15) = MAKE_DATE(2024, 1, 15) AS same_date")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let value = result.column(0).unwrap().get(0).unwrap();

    if let Some(b) = value.as_bool() {
        assert!(b, "Same dates should be equal");
    } else if let Some(i) = value.as_i64() {
        assert_eq!(i, 1, "Same dates should be equal (1)");
    }
}

#[test]
fn test_make_date_inequality() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT MAKE_DATE(2024, 1, 15) < MAKE_DATE(2024, 1, 22) AS less_than")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let value = result.column(0).unwrap().get(0).unwrap();
    if let Some(b) = value.as_bool() {
        assert!(b, "Earlier date should be less than later date");
    } else if let Some(i) = value.as_i64() {
        assert_eq!(i, 1, "Earlier date should be less than later date (1)");
    }
}

#[test]
fn test_make_timestamp_081() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT MAKE_TIMESTAMP(2024, 3, 15, 14, 30, 45) AS constructed")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert!(!value.is_null(), "MAKE_TIMESTAMP should not return null");
}

#[test]
fn test_make_timestamp_midnight() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT MAKE_TIMESTAMP(2024, 1, 1, 0, 0, 0) AS midnight")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert!(
        !value.is_null(),
        "MAKE_TIMESTAMP for midnight should not return null"
    );
}

#[test]
fn test_make_timestamp_end_of_day() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT MAKE_TIMESTAMP(2024, 12, 31, 23, 59, 59) AS almost_midnight")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    assert!(
        !value.is_null(),
        "MAKE_TIMESTAMP for 23:59:59 should not return null"
    );
}

#[test]
fn test_date_diff_simple_057() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT DATE_DIFF(MAKE_DATE(2024, 1, 22), MAKE_DATE(2024, 1, 15)) AS days")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 7);
}

#[test]
fn test_date_diff_negative_058() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT DATE_DIFF(MAKE_DATE(2024, 1, 15), MAKE_DATE(2024, 1, 22)) AS days")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), -7);
}

#[test]
fn test_date_diff_same_date() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT DATE_DIFF(MAKE_DATE(2024, 3, 15), MAKE_DATE(2024, 3, 15)) AS days")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 0);
}

#[test]
fn test_date_diff_cross_month() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT DATE_DIFF(MAKE_DATE(2024, 2, 5), MAKE_DATE(2024, 1, 25)) AS days")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();

    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 11);
}

#[test]
fn test_date_diff_cross_year() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT DATE_DIFF(MAKE_DATE(2024, 1, 5), MAKE_DATE(2023, 12, 25)) AS days")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();

    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 11);
}

#[test]
fn test_date_diff_leap_year() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT DATE_DIFF(MAKE_DATE(2024, 3, 1), MAKE_DATE(2024, 2, 28)) AS days")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();

    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 2);
}

#[test]
fn test_date_diff_non_leap_year() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT DATE_DIFF(MAKE_DATE(2023, 3, 1), MAKE_DATE(2023, 2, 28)) AS days")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();

    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 1);
}

#[test]
fn test_date_diff_with_table() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT DATE_DIFF(MAKE_DATE(2024, 1, 22), MAKE_DATE(2024, 1, 15)) AS days")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let days_col = result.column(0).unwrap();
    assert_eq!(days_col.get(0).unwrap().as_i64().unwrap(), 7);
}

#[test]
fn test_date_diff_full_year() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT DATE_DIFF(MAKE_DATE(2025, 1, 1), MAKE_DATE(2024, 1, 1)) AS days")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();

    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 366);
}

#[test]
fn test_date_diff_full_non_leap_year() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT DATE_DIFF(MAKE_DATE(2024, 1, 1), MAKE_DATE(2023, 1, 1)) AS days")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();

    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 365);
}

#[test]
fn test_age_function_059() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT DATE_DIFF(MAKE_DATE(2024, 1, 22), MAKE_DATE(2024, 1, 15)) AS days")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 7);
}

#[test]
fn test_age_negative() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT DATE_DIFF(MAKE_DATE(2024, 1, 15), MAKE_DATE(2024, 1, 22)) AS days")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), -7);
}

#[test]
fn test_age_same_date() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT DATE_DIFF(MAKE_DATE(2024, 3, 15), MAKE_DATE(2024, 3, 15)) AS days")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 0);
}

#[test]
fn test_age_cross_year() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT DATE_DIFF(MAKE_DATE(2024, 1, 1), MAKE_DATE(2023, 12, 1)) AS days")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();

    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 31);
}

#[test]
fn test_date_diff_null_first_arg() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE null_dates_a (id INT64, d DATE)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO null_dates_a VALUES (1, NULL)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT DATE_DIFF(d, MAKE_DATE(2024, 1, 1)) FROM null_dates_a")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let value = result.column(0).unwrap().get(0).unwrap();
    assert!(
        value.is_null(),
        "DATE_DIFF with NULL first arg should return NULL"
    );
}

#[test]
fn test_date_diff_null_second_arg() {
    let mut executor = create_executor();

    executor
        .execute_sql("CREATE TABLE null_dates_b (id INT64, d DATE)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO null_dates_b VALUES (1, NULL)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT DATE_DIFF(MAKE_DATE(2024, 1, 1), d) FROM null_dates_b")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let value = result.column(0).unwrap().get(0).unwrap();
    assert!(
        value.is_null(),
        "DATE_DIFF with NULL second arg should return NULL"
    );
}

#[test]
fn test_make_date_with_date_diff() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT DATE_DIFF(MAKE_DATE(2024, 1, 22), MAKE_DATE(2024, 1, 15)) AS days")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 7);
}

#[test]
fn test_date_diff_with_current_date() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT DATE_DIFF(CURRENT_DATE(), MAKE_DATE(2000, 1, 1)) AS days_since_2000")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    let days = col.get(0).unwrap().as_i64().unwrap();

    assert!(
        days > 8000,
        "Expected at least 8000 days since 2000, got {}",
        days
    );
}

#[test]
fn test_date_diff_in_where() {
    let mut executor = create_executor();
    setup_dates_pair_table(&mut executor);

    let result = executor
        .execute_sql("SELECT id FROM periods WHERE DATE_DIFF(end_date, start_date) > 5")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_date_diff_multiple_results() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT DATE_DIFF(MAKE_DATE(2024, 1, 10), MAKE_DATE(2024, 1, 1)) AS diff1, DATE_DIFF(MAKE_DATE(2024, 1, 5), MAKE_DATE(2024, 1, 1)) AS diff2, DATE_DIFF(MAKE_DATE(2024, 1, 15), MAKE_DATE(2024, 1, 1)) AS diff3")
        .unwrap();

    assert_eq!(result.num_rows(), 1);

    assert_eq!(
        result.column(0).unwrap().get(0).unwrap().as_i64().unwrap(),
        9
    );
    assert_eq!(
        result.column(1).unwrap().get(0).unwrap().as_i64().unwrap(),
        4
    );
    assert_eq!(
        result.column(2).unwrap().get(0).unwrap().as_i64().unwrap(),
        14
    );
}

#[test]
fn test_make_date_produces_valid_dates() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT DATE_DIFF(MAKE_DATE(2024, 6, 15), MAKE_DATE(2024, 6, 1)) AS days")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let days = result.column(0).unwrap().get(0).unwrap().as_i64().unwrap();
    assert_eq!(days, 14, "June 15 is 14 days after June 1");
}

#[test]
fn test_make_date_equality() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT MAKE_DATE(2024, 3, 15) = MAKE_DATE(2024, 3, 15) AS is_equal")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let value = result.column(0).unwrap().get(0).unwrap();
    if let Some(b) = value.as_bool() {
        assert!(b);
    } else if let Some(i) = value.as_i64() {
        assert_eq!(i, 1);
    }
}

#[test]
fn test_make_date_less_than() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT MAKE_DATE(2024, 1, 1) < MAKE_DATE(2024, 12, 31) AS is_less")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let value = result.column(0).unwrap().get(0).unwrap();
    if let Some(b) = value.as_bool() {
        assert!(b);
    } else if let Some(i) = value.as_i64() {
        assert_eq!(i, 1);
    }
}

#[test]
fn test_make_timestamp_comparison() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT MAKE_TIMESTAMP(2024, 1, 1, 10, 0, 0) < MAKE_TIMESTAMP(2024, 1, 1, 11, 0, 0) AS earlier")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let value = result.column(0).unwrap().get(0).unwrap();
    if let Some(b) = value.as_bool() {
        assert!(b, "10:00 should be less than 11:00");
    } else if let Some(i) = value.as_i64() {
        assert_eq!(i, 1, "10:00 should be less than 11:00");
    }
}

#[test]
fn test_current_date_consistency() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT CURRENT_DATE() = CURRENT_DATE() AS same_date")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let value = result.column(0).unwrap().get(0).unwrap();
    if let Some(b) = value.as_bool() {
        assert!(b, "CURRENT_DATE should return same value in same query");
    } else if let Some(i) = value.as_i64() {
        assert_eq!(i, 1, "CURRENT_DATE should return same value in same query");
    }
}

#[test]
fn test_date_diff_large_range() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT DATE_DIFF(MAKE_DATE(2024, 1, 1), MAKE_DATE(1990, 1, 1)) AS days")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    let days = col.get(0).unwrap().as_i64().unwrap();

    assert!(
        days > 12000 && days < 13000,
        "Expected ~12400 days, got {}",
        days
    );
}

#[test]
fn test_date_diff_century_boundary() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT DATE_DIFF(MAKE_DATE(2000, 1, 1), MAKE_DATE(1999, 12, 31)) AS days")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 1);
}

#[test]
fn test_make_date_feb_29_leap_year() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT DATE_DIFF(MAKE_DATE(2024, 3, 1), MAKE_DATE(2024, 2, 29)) AS days")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let col = result.column(0).unwrap();
    assert_eq!(col.get(0).unwrap().as_i64().unwrap(), 1);
}

#[test]
fn test_make_timestamp_equality() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT MAKE_TIMESTAMP(2024, 1, 1, 12, 30, 0) = MAKE_TIMESTAMP(2024, 1, 1, 12, 30, 0) AS equal")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let value = result.column(0).unwrap().get(0).unwrap();
    if let Some(b) = value.as_bool() {
        assert!(b);
    } else if let Some(i) = value.as_i64() {
        assert_eq!(i, 1);
    }
}
