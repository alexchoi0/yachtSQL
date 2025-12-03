mod common;

use common::is_null;
use yachtsql::{DialectType, QueryExecutor};

fn create_executor() -> QueryExecutor {
    QueryExecutor::with_dialect(DialectType::PostgreSQL)
}

mod basic_macaddr {
    use super::*;

    #[test]
    fn test_macaddr_column_type() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TABLE network_devices (id INT, mac MACADDR)")
            .expect("CREATE TABLE with MACADDR should work");

        executor
            .execute_sql("INSERT INTO network_devices VALUES (1, '08:00:2b:01:02:03')")
            .expect("INSERT MACADDR should work");

        let result = executor
            .execute_sql("SELECT mac FROM network_devices WHERE id = 1")
            .expect("SELECT MACADDR should work");

        assert_eq!(result.num_rows(), 1);
        assert!(!is_null(&result, 0, 0), "MACADDR should not return NULL");
    }

    #[test]
    fn test_macaddr_literal() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT CAST('08:00:2b:01:02:03' AS MACADDR) as mac")
            .expect("MACADDR literal should parse");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "MACADDR literal should not return NULL"
        );
    }

    #[test]
    fn test_macaddr_cast_from_string() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT CAST('08:00:2b:01:02:03' AS MACADDR) as mac")
            .expect("CAST to MACADDR should work");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "CAST to MACADDR should not return NULL"
        );
    }
}

mod basic_macaddr8 {
    use super::*;

    #[test]
    fn test_macaddr8_column_type() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TABLE network_devices8 (id INT, mac MACADDR8)")
            .expect("CREATE TABLE with MACADDR8 should work");

        executor
            .execute_sql("INSERT INTO network_devices8 VALUES (1, '08:00:2b:01:02:03:04:05')")
            .expect("INSERT MACADDR8 should work");

        let result = executor
            .execute_sql("SELECT mac FROM network_devices8 WHERE id = 1")
            .expect("SELECT MACADDR8 should work");

        assert_eq!(result.num_rows(), 1);
        assert!(!is_null(&result, 0, 0), "MACADDR8 should not return NULL");
    }

    #[test]
    fn test_macaddr8_literal() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT CAST('08:00:2b:01:02:03:04:05' AS MACADDR8) as mac")
            .expect("MACADDR8 literal should parse");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "MACADDR8 literal should not return NULL"
        );
    }

    #[test]
    fn test_macaddr8_cast_from_string() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT CAST('08:00:2b:01:02:03:04:05' AS MACADDR8) as mac")
            .expect("CAST to MACADDR8 should work");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "CAST to MACADDR8 should not return NULL"
        );
    }

    #[test]
    fn test_macaddr8_from_macaddr() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT CAST('08:00:2b:01:02:03' AS MACADDR8) as mac")
            .expect("CAST 6-byte string to MACADDR8 should work");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "CAST to MACADDR8 should not return NULL"
        );
    }
}

mod macaddr_formats {
    use super::*;

    #[test]
    fn test_macaddr_colon_format() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT CAST('08:00:2b:01:02:03' AS MACADDR) as mac")
            .expect("Colon format should work");

        assert_eq!(result.num_rows(), 1);
        assert!(!is_null(&result, 0, 0));
    }

    #[test]
    fn test_macaddr_hyphen_format() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT CAST('08-00-2b-01-02-03' AS MACADDR) as mac")
            .expect("Hyphen format should work");

        assert_eq!(result.num_rows(), 1);
        assert!(!is_null(&result, 0, 0));
    }

    #[test]
    fn test_macaddr_dot_format() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT CAST('0800.2b01.0203' AS MACADDR) as mac")
            .expect("Dot format should work");

        assert_eq!(result.num_rows(), 1);
        assert!(!is_null(&result, 0, 0));
    }

    #[test]
    fn test_macaddr_uppercase() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT CAST('08:00:2B:01:02:03' AS MACADDR) as mac")
            .expect("Uppercase should work");

        assert_eq!(result.num_rows(), 1);
        assert!(!is_null(&result, 0, 0));
    }

    #[test]
    fn test_macaddr_mixed_case() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT CAST('08:00:2B:01:02:03' AS MACADDR) = CAST('08:00:2b:01:02:03' AS MACADDR) as eq")
            .expect("Mixed case comparison should work");

        assert_eq!(result.num_rows(), 1);
    }
}

mod macaddr_comparisons {
    use super::*;

    #[test]
    fn test_macaddr_equality() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT CAST('08:00:2b:01:02:03' AS MACADDR) = CAST('08:00:2b:01:02:03' AS MACADDR) as eq")
            .expect("MACADDR equality should work");

        assert_eq!(result.num_rows(), 1);
        assert!(!is_null(&result, 0, 0));
    }

    #[test]
    fn test_macaddr_inequality() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT CAST('08:00:2b:01:02:03' AS MACADDR) <> CAST('08:00:2b:01:02:04' AS MACADDR) as neq")
            .expect("MACADDR inequality should work");

        assert_eq!(result.num_rows(), 1);
        assert!(!is_null(&result, 0, 0));
    }

    #[test]
    fn test_macaddr_less_than() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT CAST('08:00:2b:01:02:03' AS MACADDR) < CAST('08:00:2b:01:02:04' AS MACADDR) as lt")
            .expect("MACADDR less than should work");

        assert_eq!(result.num_rows(), 1);
        assert!(!is_null(&result, 0, 0));
    }

    #[test]
    fn test_macaddr_greater_than() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT CAST('08:00:2b:01:02:04' AS MACADDR) > CAST('08:00:2b:01:02:03' AS MACADDR) as gt")
            .expect("MACADDR greater than should work");

        assert_eq!(result.num_rows(), 1);
        assert!(!is_null(&result, 0, 0));
    }

    #[test]
    fn test_macaddr_less_than_or_equal() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT CAST('08:00:2b:01:02:03' AS MACADDR) <= CAST('08:00:2b:01:02:03' AS MACADDR) as lte")
            .expect("MACADDR <= should work");

        assert_eq!(result.num_rows(), 1);
        assert!(!is_null(&result, 0, 0));
    }

    #[test]
    fn test_macaddr_greater_than_or_equal() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT CAST('08:00:2b:01:02:03' AS MACADDR) >= CAST('08:00:2b:01:02:03' AS MACADDR) as gte")
            .expect("MACADDR >= should work");

        assert_eq!(result.num_rows(), 1);
        assert!(!is_null(&result, 0, 0));
    }

    #[test]
    fn test_macaddr8_comparisons() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql(
                "SELECT CAST('08:00:2b:01:02:03:04:05' AS MACADDR8) = CAST('08:00:2b:01:02:03:04:05' AS MACADDR8) as eq",
            )
            .expect("MACADDR8 equality should work");

        assert_eq!(result.num_rows(), 1);
        assert!(!is_null(&result, 0, 0));
    }
}

mod macaddr_trunc {
    use super::*;

    #[test]
    fn test_macaddr_trunc() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT trunc(CAST('08:00:2b:01:02:03' AS MACADDR)) as truncated")
            .expect("trunc(MACADDR) should work");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "trunc(MACADDR) should not return NULL"
        );
    }

    #[test]
    fn test_macaddr8_trunc() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT trunc(CAST('08:00:2b:01:02:03:04:05' AS MACADDR8)) as truncated")
            .expect("trunc(MACADDR8) should work");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "trunc(MACADDR8) should not return NULL"
        );
    }
}

mod special_macaddr {
    use super::*;

    #[test]
    fn test_broadcast_address() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT CAST('ff:ff:ff:ff:ff:ff' AS MACADDR) as broadcast")
            .expect("Broadcast address should work");

        assert_eq!(result.num_rows(), 1);
        assert!(!is_null(&result, 0, 0));
    }

    #[test]
    fn test_zero_address() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT CAST('00:00:00:00:00:00' AS MACADDR) as zero")
            .expect("Zero address should work");

        assert_eq!(result.num_rows(), 1);
        assert!(!is_null(&result, 0, 0));
    }

    #[test]
    fn test_multicast_bit() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT CAST('01:00:00:00:00:00' AS MACADDR) as multicast")
            .expect("Multicast address should work");

        assert_eq!(result.num_rows(), 1);
        assert!(!is_null(&result, 0, 0));
    }
}

mod macaddr_null {
    use super::*;

    #[test]
    fn test_macaddr_null() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TABLE mac_null_test (id INT, mac MACADDR)")
            .expect("CREATE TABLE should work");

        executor
            .execute_sql("INSERT INTO mac_null_test VALUES (1, NULL)")
            .expect("INSERT NULL should work");

        let result = executor
            .execute_sql("SELECT mac FROM mac_null_test WHERE id = 1")
            .expect("SELECT NULL should work");

        assert_eq!(result.num_rows(), 1);
        assert!(is_null(&result, 0, 0), "NULL MACADDR should be NULL");
    }

    #[test]
    fn test_macaddr_null_comparison() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT NULL::MACADDR = NULL::MACADDR as eq")
            .expect("NULL comparison should work");

        assert_eq!(result.num_rows(), 1);

        assert!(is_null(&result, 0, 0), "NULL = NULL should be NULL");
    }
}

mod macaddr_ordering {
    use super::*;

    #[test]
    fn test_macaddr_order_by() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TABLE mac_order_test (id INT, mac MACADDR)")
            .expect("CREATE TABLE should work");

        executor
            .execute_sql("INSERT INTO mac_order_test VALUES (1, '00:00:00:00:00:03'), (2, '00:00:00:00:00:01'), (3, '00:00:00:00:00:02')")
            .expect("INSERT should work");

        let result = executor
            .execute_sql("SELECT id FROM mac_order_test ORDER BY mac")
            .expect("ORDER BY MACADDR should work");

        assert_eq!(result.num_rows(), 3);
    }
}

mod macaddr_errors {
    use super::*;

    #[test]
    fn test_invalid_macaddr_format() {
        let mut executor = create_executor();

        let result = executor.execute_sql("SELECT CAST('not-a-mac' AS MACADDR) as mac");

        assert!(
            result.is_err(),
            "Invalid MAC address format should return an error"
        );
    }

    #[test]
    fn test_macaddr_wrong_length() {
        let mut executor = create_executor();

        let result = executor.execute_sql("SELECT CAST('08:00:2b:01:02' AS MACADDR) as mac");

        assert!(
            result.is_err(),
            "Wrong length MAC address should return an error"
        );
    }

    #[test]
    fn test_macaddr_invalid_hex() {
        let mut executor = create_executor();

        let result = executor.execute_sql("SELECT CAST('08:00:2b:01:02:GG' AS MACADDR) as mac");

        assert!(
            result.is_err(),
            "Invalid hex in MAC address should return an error"
        );
    }
}
