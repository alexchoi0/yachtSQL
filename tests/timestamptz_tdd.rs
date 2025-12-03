mod common;

use chrono::Timelike;
use common::setup_executor;

fn create_executor() -> yachtsql::QueryExecutor {
    setup_executor()
}

mod parsing {
    use super::*;

    #[test]
    fn test_timestamptz_with_utc_offset() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00+05:00' AS ts")
            .expect("TIMESTAMPTZ parsing should succeed");

        assert_eq!(result.num_rows(), 1, "Should return exactly one row");

        let ts_col = result.column(0).expect("Should have ts column");
        let ts_val = ts_col.get(0).expect("Should have value");
        assert!(
            ts_val.as_timestamp().is_some(),
            "Should be a timestamp value"
        );

        let ts = ts_val.as_timestamp().unwrap();

        assert_eq!(ts.hour(), 5, "Hour should be 5 in UTC");
    }

    #[test]
    fn test_timestamptz_with_negative_offset() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00-05:00' AS ts")
            .expect("TIMESTAMPTZ with negative offset should succeed");

        assert_eq!(result.num_rows(), 1);

        let ts_col = result.column(0).expect("Should have ts column");
        let ts_val = ts_col.get(0).expect("Should have value");
        let ts = ts_val.as_timestamp().expect("Should be timestamp");

        assert_eq!(ts.hour(), 15, "Hour should be 15 in UTC");
    }

    #[test]
    fn test_timestamptz_with_utc_indicator() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC' AS ts")
            .expect("TIMESTAMPTZ with UTC should succeed");

        assert_eq!(result.num_rows(), 1);

        let ts_col = result.column(0).expect("Should have ts column");
        let ts_val = ts_col.get(0).expect("Should have value");
        let ts = ts_val.as_timestamp().expect("Should be timestamp");

        assert_eq!(ts.hour(), 10, "Hour should be 10 in UTC");
    }

    #[test]
    fn test_timestamptz_iso8601_format() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT TIMESTAMP WITH TIME ZONE '2024-01-15T10:00:00+05:00' AS ts")
            .expect("TIMESTAMPTZ ISO8601 should succeed");

        assert_eq!(result.num_rows(), 1);

        let ts_col = result.column(0).expect("Should have ts column");
        let ts_val = ts_col.get(0).expect("Should have value");
        let ts = ts_val.as_timestamp().expect("Should be timestamp");

        assert_eq!(ts.hour(), 5, "Hour should be 5 in UTC");
    }

    #[test]
    fn test_timestamptz_with_fractional_seconds() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00.123456 UTC' AS ts")
            .expect("TIMESTAMPTZ with fractional seconds should succeed");

        assert_eq!(result.num_rows(), 1);

        let ts_col = result.column(0).expect("Should have ts column");
        let ts_val = ts_col.get(0).expect("Should have value");
        let ts = ts_val.as_timestamp().expect("Should be timestamp");

        let micros = ts.timestamp_subsec_micros();
        assert_eq!(micros, 123456, "Microseconds should be 123456");
    }

    #[test]
    fn test_timestamptz_with_named_timezone() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql(
                "SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 America/New_York' AS ts",
            )
            .expect("TIMESTAMPTZ with named timezone should succeed");

        assert_eq!(result.num_rows(), 1);

        let ts_col = result.column(0).expect("Should have ts column");
        let ts_val = ts_col.get(0).expect("Should have value");
        let ts = ts_val.as_timestamp().expect("Should be timestamp");

        assert_eq!(ts.hour(), 15, "Hour should be 15 in UTC");
    }
}

mod at_time_zone {
    use super::*;

    #[test]
    fn test_at_time_zone_utc_to_named() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql(
                "SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 15:00:00 UTC'
                 AT TIME ZONE 'America/New_York' AS ts",
            )
            .expect("AT TIME ZONE should succeed");

        assert_eq!(result.num_rows(), 1);

        let ts_col = result.column(0).expect("Should have ts column");
        let ts_val = ts_col.get(0).expect("Should have value");

        assert!(
            ts_val.as_timestamp().is_some() || ts_val.as_datetime().is_some(),
            "Should be timestamp or datetime"
        );
    }

    #[test]
    fn test_at_time_zone_plain_timestamp_to_zone() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql(
                "SELECT TIMESTAMP '2024-01-15 10:00:00' AT TIME ZONE 'America/New_York' AS ts",
            )
            .expect("Plain TIMESTAMP AT TIME ZONE should succeed");

        assert_eq!(result.num_rows(), 1);

        let ts_col = result.column(0).expect("Should have ts column");
        let ts_val = ts_col.get(0).expect("Should have value");
        let ts = ts_val.as_timestamp().expect("Should be timestamp");

        assert_eq!(ts.hour(), 15, "Hour should be 15 in UTC");
    }

    #[test]
    fn test_at_time_zone_round_trip() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql(
                "SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 America/New_York'
                 AT TIME ZONE 'UTC'
                 AT TIME ZONE 'America/New_York' AS ts",
            )
            .expect("AT TIME ZONE round trip should succeed");

        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_at_time_zone_cross_timezone() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql(
                "SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 America/New_York'
                 AT TIME ZONE 'Asia/Tokyo' AS ts",
            )
            .expect("AT TIME ZONE cross timezone should succeed");

        assert_eq!(result.num_rows(), 1);
    }
}

mod comparisons {
    use super::*;

    #[test]
    fn test_timestamptz_equality_same_moment() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql(
                "SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 America/New_York'
                 = TIMESTAMP WITH TIME ZONE '2024-01-15 15:00:00 UTC' AS are_equal",
            )
            .expect("TIMESTAMPTZ equality should succeed");

        assert_eq!(result.num_rows(), 1);

        let col = result.column(0).expect("Should have column");
        let val = col.get(0).expect("Should have value");
        assert_eq!(val.as_bool(), Some(true), "Same moments should be equal");
    }

    #[test]
    fn test_timestamptz_less_than() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql(
                "SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC'
                 < TIMESTAMP WITH TIME ZONE '2024-01-15 15:00:00 UTC' AS is_less",
            )
            .expect("TIMESTAMPTZ less than should succeed");

        assert_eq!(result.num_rows(), 1);

        let col = result.column(0).expect("Should have column");
        let val = col.get(0).expect("Should have value");
        assert_eq!(val.as_bool(), Some(true), "10:00 < 15:00 should be true");
    }

    #[test]
    fn test_timestamptz_greater_than() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql(
                "SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 15:00:00 UTC'
                 > TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC' AS is_greater",
            )
            .expect("TIMESTAMPTZ greater than should succeed");

        assert_eq!(result.num_rows(), 1);

        let col = result.column(0).expect("Should have column");
        let val = col.get(0).expect("Should have value");
        assert_eq!(val.as_bool(), Some(true), "15:00 > 10:00 should be true");
    }

    #[test]
    fn test_timestamptz_compare_with_plain_timestamp() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql(
                "SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC'
                 > TIMESTAMP '2024-01-15 09:00:00' AS is_greater",
            )
            .expect("TIMESTAMPTZ vs TIMESTAMP comparison should succeed");

        assert_eq!(result.num_rows(), 1);

        let col = result.column(0).expect("Should have column");
        let val = col.get(0).expect("Should have value");
        assert_eq!(val.as_bool(), Some(true));
    }

    #[test]
    fn test_timestamptz_null_comparison() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql(
                "SELECT CAST(NULL AS TIMESTAMP WITH TIME ZONE)
                 = TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC' AS result",
            )
            .expect("TIMESTAMPTZ NULL comparison should succeed");

        assert_eq!(result.num_rows(), 1);

        let col = result.column(0).expect("Should have column");
        let val = col.get(0).expect("Should have value");
        assert!(val.is_null(), "NULL comparison should return NULL");
    }
}

mod arithmetic {
    use super::*;

    #[test]
    fn test_timestamptz_plus_interval_hours() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql(
                "SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC'
                 + INTERVAL '2' HOUR AS ts",
            )
            .expect("TIMESTAMPTZ + INTERVAL should succeed");

        assert_eq!(result.num_rows(), 1);

        let ts_col = result.column(0).expect("Should have ts column");
        let ts_val = ts_col.get(0).expect("Should have value");
        let ts = ts_val.as_timestamp().expect("Should be timestamp");

        assert_eq!(ts.hour(), 12, "Hour should be 12 (10 + 2)");
    }

    #[test]
    fn test_timestamptz_minus_interval_hours() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql(
                "SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC'
                 - INTERVAL '3' HOUR AS ts",
            )
            .expect("TIMESTAMPTZ - INTERVAL should succeed");

        assert_eq!(result.num_rows(), 1);

        let ts_col = result.column(0).expect("Should have ts column");
        let ts_val = ts_col.get(0).expect("Should have value");
        let ts = ts_val.as_timestamp().expect("Should be timestamp");

        assert_eq!(ts.hour(), 7, "Hour should be 7 (10 - 3)");
    }

    #[test]
    fn test_timestamptz_difference() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql(
                "SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 15:00:00 UTC'
                 - TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC' AS time_diff",
            )
            .expect("TIMESTAMPTZ difference should succeed");

        assert_eq!(result.num_rows(), 1);

        let col = result.column(0).expect("Should have column");
        let val = col.get(0).expect("Should have value");
        let interval = val.as_interval().expect("Should be interval");

        let expected_micros = 5 * 60 * 60 * 1_000_000_i64;
        assert_eq!(interval.micros, expected_micros, "Should be 5 hours");
    }

    #[test]
    fn test_timestamptz_null_arithmetic() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql(
                "SELECT CAST(NULL AS TIMESTAMP WITH TIME ZONE) + INTERVAL '1' HOUR AS result",
            )
            .expect("TIMESTAMPTZ NULL arithmetic should succeed");

        assert_eq!(result.num_rows(), 1);

        let col = result.column(0).expect("Should have column");
        let val = col.get(0).expect("Should have value");
        assert!(val.is_null(), "NULL + INTERVAL should be NULL");
    }
}

mod table_operations {
    use super::*;

    #[test]
    fn test_timestamptz_insert_and_select() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS events").unwrap();
        executor
            .execute_sql("CREATE TABLE events (id INT64, event_time TIMESTAMP WITH TIME ZONE)")
            .unwrap();

        executor
            .execute_sql(
                "INSERT INTO events VALUES
                 (1, TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC')",
            )
            .expect("INSERT TIMESTAMPTZ should succeed");

        let result = executor
            .execute_sql("SELECT event_time FROM events WHERE id = 1")
            .expect("SELECT TIMESTAMPTZ should succeed");

        assert_eq!(result.num_rows(), 1);

        let ts_col = result.column(0).expect("Should have event_time column");
        let ts_val = ts_col.get(0).expect("Should have value");
        let ts = ts_val.as_timestamp().expect("Should be timestamp");

        assert_eq!(ts.hour(), 10, "Hour should be 10");
    }

    #[test]
    fn test_timestamptz_order_by() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS events").unwrap();
        executor
            .execute_sql("CREATE TABLE events (id INT64, event_time TIMESTAMP WITH TIME ZONE)")
            .unwrap();

        executor
            .execute_sql(
                "INSERT INTO events VALUES
                 (1, TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC'),
                 (2, TIMESTAMP WITH TIME ZONE '2024-01-15 08:00:00 America/New_York'),
                 (3, TIMESTAMP WITH TIME ZONE '2024-01-15 20:00:00 Asia/Tokyo')",
            )
            .expect("INSERT multiple TIMESTAMPTZ should succeed");

        let result = executor
            .execute_sql("SELECT id FROM events ORDER BY event_time")
            .expect("ORDER BY TIMESTAMPTZ should succeed");

        assert_eq!(result.num_rows(), 3);

        let id_col = result.column(0).expect("Should have id column");
        assert_eq!(id_col.get(0).unwrap().as_i64(), Some(1));
        assert_eq!(id_col.get(1).unwrap().as_i64(), Some(3));
        assert_eq!(id_col.get(2).unwrap().as_i64(), Some(2));
    }

    #[test]
    fn test_timestamptz_in_where_clause() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS activity")
            .unwrap();
        executor
            .execute_sql("CREATE TABLE activity (id INT64, event_time TIMESTAMP WITH TIME ZONE)")
            .unwrap();

        executor
            .execute_sql(
                "INSERT INTO activity VALUES
                 (1, TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC'),
                 (2, TIMESTAMP WITH TIME ZONE '2024-01-15 15:00:00 UTC'),
                 (3, TIMESTAMP WITH TIME ZONE '2024-01-15 20:00:00 UTC')",
            )
            .expect("INSERT should succeed");

        let result = executor
            .execute_sql(
                "SELECT id FROM activity
                 WHERE event_time > TIMESTAMP WITH TIME ZONE '2024-01-15 12:00:00 UTC'
                 ORDER BY id",
            )
            .expect("WHERE with TIMESTAMPTZ should succeed");

        assert_eq!(result.num_rows(), 2, "Should return ids 2 and 3");

        let id_col = result.column(0).expect("Should have id column");
        assert_eq!(id_col.get(0).unwrap().as_i64(), Some(2));
        assert_eq!(id_col.get(1).unwrap().as_i64(), Some(3));
    }

    #[test]
    fn test_timestamptz_null_in_table() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS logs").unwrap();
        executor
            .execute_sql("CREATE TABLE logs (id INT64, logged_at TIMESTAMP WITH TIME ZONE)")
            .unwrap();

        executor
            .execute_sql("INSERT INTO logs VALUES (1, NULL)")
            .expect("INSERT NULL TIMESTAMPTZ should succeed");

        let result = executor
            .execute_sql("SELECT logged_at FROM logs WHERE id = 1")
            .expect("SELECT NULL TIMESTAMPTZ should succeed");

        assert_eq!(result.num_rows(), 1);

        let col = result.column(0).expect("Should have column");
        let val = col.get(0).expect("Should have value");
        assert!(val.is_null(), "NULL should be returned");
    }
}

mod casting {
    use super::*;

    #[test]
    fn test_cast_timestamp_to_timestamptz() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql(
                "SELECT CAST(TIMESTAMP '2024-01-15 10:00:00' AS TIMESTAMP WITH TIME ZONE) AS ts",
            )
            .expect("CAST TIMESTAMP to TIMESTAMPTZ should succeed");

        assert_eq!(result.num_rows(), 1);

        let ts_col = result.column(0).expect("Should have ts column");
        let ts_val = ts_col.get(0).expect("Should have value");
        let ts = ts_val.as_timestamp().expect("Should be timestamp");

        assert_eq!(ts.hour(), 10, "Hour should be 10 (assumed UTC)");
    }

    #[test]
    fn test_cast_timestamptz_to_timestamp() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql(
                "SELECT CAST(TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 America/New_York' AS TIMESTAMP) AS ts",
            )
            .expect("CAST TIMESTAMPTZ to TIMESTAMP should succeed");

        assert_eq!(result.num_rows(), 1);

        let ts_col = result.column(0).expect("Should have ts column");
        let ts_val = ts_col.get(0).expect("Should have value");

        let hour = if let Some(ts) = ts_val.as_timestamp() {
            ts.hour()
        } else if let Some(dt) = ts_val.as_datetime() {
            dt.hour()
        } else {
            panic!("Expected timestamp or datetime");
        };

        assert_eq!(hour, 15, "Hour should be 15 (UTC)");
    }

    #[test]
    fn test_cast_string_to_timestamptz() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql(
                "SELECT CAST('2024-01-15 10:00:00+05:00' AS TIMESTAMP WITH TIME ZONE) AS ts",
            )
            .expect("CAST STRING to TIMESTAMPTZ should succeed");

        assert_eq!(result.num_rows(), 1);

        let ts_col = result.column(0).expect("Should have ts column");
        let ts_val = ts_col.get(0).expect("Should have value");
        let ts = ts_val.as_timestamp().expect("Should be timestamp");

        assert_eq!(ts.hour(), 5, "Hour should be 5 in UTC");
    }

    #[test]
    fn test_cast_timestamptz_to_string() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql(
                "SELECT CAST(TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC' AS STRING) AS ts_str",
            )
            .expect("CAST TIMESTAMPTZ to STRING should succeed");

        assert_eq!(result.num_rows(), 1);

        let col = result.column(0).expect("Should have column");
        let val = col.get(0).expect("Should have value");
        let s = val.as_str().expect("Should be string");

        assert!(s.contains("2024"), "String should contain year");
        assert!(s.contains("01"), "String should contain month");
        assert!(s.contains("15"), "String should contain day");
    }
}

mod errors {
    use super::*;

    #[test]
    fn test_invalid_timezone_name() {
        let mut executor = create_executor();

        let result = executor.execute_sql(
            "SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 Invalid/Timezone' AS ts",
        );

        assert!(result.is_err(), "Invalid timezone should produce error");
        let err_msg = result.unwrap_err().to_string().to_lowercase();
        assert!(
            err_msg.contains("timezone")
                || err_msg.contains("time zone")
                || err_msg.contains("invalid"),
            "Error should mention timezone issue: {}",
            err_msg
        );
    }

    #[test]
    fn test_invalid_timestamp_format() {
        let mut executor = create_executor();

        let result =
            executor.execute_sql("SELECT TIMESTAMP WITH TIME ZONE 'not-a-timestamp UTC' AS ts");

        assert!(result.is_err(), "Invalid timestamp should produce error");
    }

    #[test]
    fn test_invalid_utc_offset() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00+25:00' AS ts");

        assert!(result.is_err(), "Out of range offset should produce error");
    }
}

mod extract {
    use super::*;

    #[test]
    fn test_extract_year_from_timestamptz() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql(
                "SELECT EXTRACT(YEAR FROM TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC') AS year",
            )
            .expect("EXTRACT YEAR should succeed");

        assert_eq!(result.num_rows(), 1);

        let col = result.column(0).expect("Should have column");
        let val = col.get(0).expect("Should have value");
        assert_eq!(val.as_i64(), Some(2024));
    }

    #[test]
    fn test_extract_hour_from_timestamptz() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql(
                "SELECT EXTRACT(HOUR FROM TIMESTAMP WITH TIME ZONE '2024-01-15 10:00:00 UTC') AS hour",
            )
            .expect("EXTRACT HOUR should succeed");

        assert_eq!(result.num_rows(), 1);

        let col = result.column(0).expect("Should have column");
        let val = col.get(0).expect("Should have value");
        assert_eq!(val.as_i64(), Some(10));
    }
}
