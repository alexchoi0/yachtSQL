mod common;

use common::is_null;
use yachtsql::{DialectType, QueryExecutor};

fn create_executor() -> QueryExecutor {
    QueryExecutor::with_dialect(DialectType::PostgreSQL)
}

mod basic_interval_parsing {
    use super::*;

    #[test]
    fn test_interval_hour_literal() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT INTERVAL '1' HOUR as one_hour")
            .expect("INTERVAL '1' HOUR should parse");

        assert_eq!(result.num_rows(), 1);

        assert!(
            !is_null(&result, 0, 0),
            "INTERVAL should not return NULL - interval parsing not implemented"
        );
    }

    #[test]
    fn test_interval_day_literal() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT INTERVAL '2' DAY as two_days")
            .expect("INTERVAL '2' DAY should parse");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "INTERVAL should not return NULL - interval parsing not implemented"
        );
    }

    #[test]
    fn test_interval_month_literal() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT INTERVAL '3' MONTH as three_months")
            .expect("INTERVAL '3' MONTH should parse");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "INTERVAL should not return NULL - interval parsing not implemented"
        );
    }

    #[test]
    fn test_interval_year_literal() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT INTERVAL '1' YEAR as one_year")
            .expect("INTERVAL '1' YEAR should parse");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "INTERVAL should not return NULL - interval parsing not implemented"
        );
    }

    #[test]
    fn test_interval_minute_literal() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT INTERVAL '30' MINUTE as thirty_minutes")
            .expect("INTERVAL '30' MINUTE should parse");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "INTERVAL should not return NULL - interval parsing not implemented"
        );
    }

    #[test]
    fn test_interval_second_literal() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT INTERVAL '45' SECOND as forty_five_seconds")
            .expect("INTERVAL '45' SECOND should parse");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "INTERVAL should not return NULL - interval parsing not implemented"
        );
    }

    #[test]
    fn test_interval_compound_value() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT INTERVAL '1 day 2 hours 30 minutes' as duration")
            .expect("Compound INTERVAL should parse");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "INTERVAL should not return NULL - interval parsing not implemented"
        );
    }

    #[test]
    fn test_interval_years_months_days() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT INTERVAL '2 years 3 months 4 days' as long_duration")
            .expect("Year-month-day INTERVAL should parse");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "INTERVAL should not return NULL - interval parsing not implemented"
        );
    }

    #[test]
    fn test_interval_negative_value() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT INTERVAL '-2' HOUR as negative_hours")
            .expect("Negative INTERVAL should parse");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "INTERVAL should not return NULL - interval parsing not implemented"
        );
    }

    #[test]
    fn test_interval_fractional_seconds() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT INTERVAL '1.5' SECOND as fractional")
            .expect("Fractional INTERVAL should parse");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "INTERVAL should not return NULL - interval parsing not implemented"
        );
    }
}

mod interval_arithmetic {
    use super::*;

    #[test]
    fn test_timestamp_plus_interval_hour() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS events").unwrap();
        executor
            .execute_sql("CREATE TABLE events (id INT64, event_time TIMESTAMP)")
            .unwrap();
        executor
            .execute_sql("INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:00:00')")
            .unwrap();

        let result = executor
            .execute_sql(
                "SELECT event_time + INTERVAL '1' HOUR as one_hour_later FROM events WHERE id = 1",
            )
            .expect("TIMESTAMP + INTERVAL should work");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "TIMESTAMP + INTERVAL should not return NULL"
        );
    }

    #[test]
    fn test_timestamp_plus_interval_day() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS events").unwrap();
        executor
            .execute_sql("CREATE TABLE events (id INT64, event_time TIMESTAMP)")
            .unwrap();
        executor
            .execute_sql("INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:00:00')")
            .unwrap();

        let result = executor
            .execute_sql(
                "SELECT event_time + INTERVAL '1' DAY as one_day_later FROM events WHERE id = 1",
            )
            .expect("TIMESTAMP + INTERVAL should work");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "TIMESTAMP + INTERVAL should not return NULL"
        );
    }

    #[test]
    fn test_timestamp_minus_interval() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS events").unwrap();
        executor
            .execute_sql("CREATE TABLE events (id INT64, event_time TIMESTAMP)")
            .unwrap();
        executor
            .execute_sql("INSERT INTO events VALUES (1, TIMESTAMP '2024-01-15 10:00:00')")
            .unwrap();

        let result = executor
            .execute_sql(
                "SELECT event_time - INTERVAL '2' HOUR as two_hours_earlier FROM events WHERE id = 1",
            )
            .expect("TIMESTAMP - INTERVAL should work");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "TIMESTAMP - INTERVAL should not return NULL"
        );
    }

    #[test]
    fn test_interval_plus_interval() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT INTERVAL '1' HOUR + INTERVAL '30' MINUTE as total_duration")
            .expect("INTERVAL + INTERVAL should work");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "INTERVAL + INTERVAL should not return NULL"
        );
    }

    #[test]
    fn test_interval_minus_interval() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT INTERVAL '2' HOUR - INTERVAL '30' MINUTE as remaining")
            .expect("INTERVAL - INTERVAL should work");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "INTERVAL - INTERVAL should not return NULL"
        );
    }

    #[test]
    fn test_interval_multiply_scalar() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT INTERVAL '1' HOUR * 3 as triple_duration")
            .expect("INTERVAL * scalar should work");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "INTERVAL * scalar should not return NULL"
        );
    }

    #[test]
    fn test_interval_divide_scalar() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT INTERVAL '6' HOUR / 2 as half_duration")
            .expect("INTERVAL / scalar should work");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "INTERVAL / scalar should not return NULL"
        );
    }
}

mod interval_comparison {
    use common::get_bool;

    use super::*;

    #[test]
    fn test_interval_greater_than() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT INTERVAL '2' HOUR > INTERVAL '1' HOUR as comparison")
            .expect("INTERVAL > INTERVAL should work");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "INTERVAL comparison should not return NULL"
        );
        assert!(get_bool(&result, 0, 0), "2 hours > 1 hour should be true");
    }

    #[test]
    fn test_interval_less_than() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT INTERVAL '30' MINUTE < INTERVAL '1' HOUR as comparison")
            .expect("INTERVAL < INTERVAL should work");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "INTERVAL comparison should not return NULL"
        );
        assert!(
            get_bool(&result, 0, 0),
            "30 minutes < 1 hour should be true"
        );
    }

    #[test]
    fn test_interval_equals() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT INTERVAL '60' MINUTE = INTERVAL '1' HOUR as comparison")
            .expect("INTERVAL = INTERVAL should work");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "INTERVAL comparison should not return NULL"
        );
        assert!(
            get_bool(&result, 0, 0),
            "60 minutes = 1 hour should be true"
        );
    }

    #[test]
    fn test_interval_day_vs_hours() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT INTERVAL '1' DAY > INTERVAL '23' HOUR as comparison")
            .expect("INTERVAL DAY > INTERVAL HOUR should work");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "INTERVAL comparison should not return NULL"
        );
        assert!(get_bool(&result, 0, 0), "1 day > 23 hours should be true");
    }
}

mod interval_table_operations {
    use super::*;

    #[test]
    fn test_interval_in_where_clause() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS appointments")
            .unwrap();
        executor
            .execute_sql("CREATE TABLE appointments (id INT64, scheduled_time TIMESTAMP)")
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO appointments VALUES
                (1, TIMESTAMP '2024-01-15 09:00:00'),
                (2, TIMESTAMP '2024-01-15 11:00:00'),
                (3, TIMESTAMP '2024-01-15 14:00:00')",
            )
            .unwrap();

        let result = executor
            .execute_sql(
                "SELECT id FROM appointments
                 WHERE scheduled_time BETWEEN
                     TIMESTAMP '2024-01-15 10:00:00' - INTERVAL '2' HOUR
                     AND TIMESTAMP '2024-01-15 10:00:00' + INTERVAL '2' HOUR",
            )
            .expect("INTERVAL in WHERE clause should work");

        assert!(
            result.num_rows() >= 2,
            "Should find appointments within time window"
        );
    }

    #[test]
    fn test_interval_column_in_table() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS tasks").unwrap();
        executor
            .execute_sql("CREATE TABLE tasks (id INT64, duration INTERVAL)")
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO tasks VALUES
                (1, INTERVAL '2' HOUR),
                (2, INTERVAL '30' MINUTE),
                (3, INTERVAL '1' DAY)",
            )
            .expect("INSERT with INTERVAL values should work");

        let result = executor
            .execute_sql("SELECT id, duration FROM tasks ORDER BY id")
            .expect("SELECT with INTERVAL column should work");

        assert_eq!(result.num_rows(), 3);
    }

    #[test]
    fn test_interval_in_order_by() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS tasks").unwrap();
        executor
            .execute_sql("CREATE TABLE tasks (id INT64, duration INTERVAL)")
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO tasks VALUES
                (1, INTERVAL '2' HOUR),
                (2, INTERVAL '30' MINUTE),
                (3, INTERVAL '1' DAY)",
            )
            .expect("INSERT with INTERVAL values should work");

        let result = executor
            .execute_sql("SELECT id FROM tasks ORDER BY duration")
            .expect("ORDER BY INTERVAL should work");

        assert_eq!(result.num_rows(), 3);
    }
}

mod interval_null_handling {
    use super::*;

    #[test]
    fn test_null_interval_arithmetic() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql(
                "SELECT TIMESTAMP '2024-01-15 10:00:00' + CAST(NULL AS INTERVAL) as result",
            )
            .expect("TIMESTAMP + NULL INTERVAL should parse");

        assert_eq!(result.num_rows(), 1);
        assert!(
            is_null(&result, 0, 0),
            "TIMESTAMP + NULL INTERVAL should return NULL"
        );
    }
}

mod interval_cast_display {
    use common::get_string;

    use super::*;

    #[test]
    fn test_cast_string_to_interval() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT CAST('2 hours 30 minutes' AS INTERVAL) as duration")
            .expect("CAST to INTERVAL should parse");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "CAST to INTERVAL should not return NULL"
        );
    }

    #[test]
    fn test_cast_interval_to_string() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT CAST(INTERVAL '2 days 3 hours' AS STRING) as text")
            .expect("CAST INTERVAL to STRING should parse");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "CAST INTERVAL to STRING should not return NULL"
        );

        let text = get_string(&result, 0, 0);
        assert!(
            text.contains("2")
                || text.contains("day")
                || text.contains("3")
                || text.contains("hour"),
            "Interval string should represent the interval value, got: {}",
            text
        );
    }
}
