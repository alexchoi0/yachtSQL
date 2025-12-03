mod common;

use common::{get_f64, get_i64, get_string, is_null};
use yachtsql::{DialectType, QueryExecutor};

fn create_executor() -> QueryExecutor {
    QueryExecutor::with_dialect(DialectType::PostgreSQL)
}

mod uuidv7_basic {
    use super::*;

    #[test]
    fn test_uuidv7_returns_valid_uuid_format() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT uuidv7() as uuid")
            .expect("uuidv7 should succeed");

        assert_eq!(result.num_rows(), 1);
        let uuid = get_string(&result, 0, 0);

        assert_eq!(uuid.len(), 36, "UUID should be 36 characters");
        assert_eq!(&uuid[8..9], "-", "UUID should have hyphen at position 8");
        assert_eq!(&uuid[13..14], "-", "UUID should have hyphen at position 13");
        assert_eq!(&uuid[18..19], "-", "UUID should have hyphen at position 18");
        assert_eq!(&uuid[23..24], "-", "UUID should have hyphen at position 23");
    }

    #[test]
    fn test_uuidv7_version_marker_is_7() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT uuidv7() as uuid")
            .expect("uuidv7 should succeed");

        let uuid = get_string(&result, 0, 0);

        assert_eq!(
            &uuid[14..15],
            "7",
            "UUID version should be 7, got {}",
            &uuid[14..15]
        );
    }

    #[test]
    fn test_uuidv7_variant_bits_correct() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT uuidv7() as uuid")
            .expect("uuidv7 should succeed");

        let uuid = get_string(&result, 0, 0);

        let variant = &uuid[19..20];
        assert!(
            variant == "8" || variant == "9" || variant == "a" || variant == "b",
            "UUID variant should be 8/9/a/b, got {}",
            variant
        );
    }

    #[test]
    fn test_uuidv7_generates_unique_values() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT uuidv7() as u1, uuidv7() as u2")
            .expect("should generate two UUIDs");

        let uuid1 = get_string(&result, 0, 0);
        let uuid2 = get_string(&result, 1, 0);

        assert_ne!(
            uuid1, uuid2,
            "Each uuidv7() call should return unique value"
        );
    }
}

mod uuidv7_timestamp_ordering {
    use std::thread;
    use std::time::Duration;

    use super::*;

    #[test]
    fn test_uuidv7_sequential_calls_are_ordered() {
        let mut executor = create_executor();

        let result1 = executor.execute_sql("SELECT uuidv7() as uuid").unwrap();
        thread::sleep(Duration::from_millis(2));
        let result2 = executor.execute_sql("SELECT uuidv7() as uuid").unwrap();

        let uuid1 = get_string(&result1, 0, 0);
        let uuid2 = get_string(&result2, 0, 0);

        assert!(
            uuid1 < uuid2,
            "UUIDv7 should be ordered by timestamp: {} should be < {}",
            uuid1,
            uuid2
        );
    }

    #[test]
    fn test_uuidv7_can_be_sorted() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TABLE uuid_test (id INT, uuid_val STRING)")
            .unwrap();

        for i in 0..5 {
            executor
                .execute_sql(&format!("INSERT INTO uuid_test VALUES ({}, uuidv7())", i))
                .unwrap();
            thread::sleep(Duration::from_millis(1));
        }

        let result = executor
            .execute_sql("SELECT uuid_val FROM uuid_test ORDER BY uuid_val")
            .expect("Should be able to ORDER BY uuidv7 values");

        assert_eq!(result.num_rows(), 5);
    }
}

mod uuidv4_tests {
    use super::*;

    #[test]
    fn test_uuidv4_returns_valid_uuid_format() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT uuidv4() as uuid")
            .expect("uuidv4 should succeed");

        let uuid = get_string(&result, 0, 0);
        assert_eq!(uuid.len(), 36, "UUID should be 36 characters");
    }

    #[test]
    fn test_uuidv4_version_marker_is_4() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT uuidv4() as uuid")
            .expect("uuidv4 should succeed");

        let uuid = get_string(&result, 0, 0);
        assert_eq!(
            &uuid[14..15],
            "4",
            "UUID version should be 4, got {}",
            &uuid[14..15]
        );
    }

    #[test]
    fn test_uuidv4_generates_unique_values() {
        let mut executor = create_executor();

        let r1 = executor.execute_sql("SELECT uuidv4()").unwrap();
        let r2 = executor.execute_sql("SELECT uuidv4()").unwrap();

        let u1 = get_string(&r1, 0, 0);
        let u2 = get_string(&r2, 0, 0);

        assert_ne!(u1, u2, "UUIDv4 should generate unique values");
    }
}

mod casefold_basic {
    use super::*;

    #[test]
    fn test_casefold_lowercase_unchanged() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT casefold('hello')")
            .expect("casefold should succeed");

        assert_eq!(get_string(&result, 0, 0), "hello");
    }

    #[test]
    fn test_casefold_uppercase_to_lowercase() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT casefold('HELLO')")
            .expect("casefold should succeed");

        assert_eq!(get_string(&result, 0, 0), "hello");
    }

    #[test]
    fn test_casefold_mixed_case() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT casefold('HeLLo WoRLD')")
            .expect("casefold should succeed");

        assert_eq!(get_string(&result, 0, 0), "hello world");
    }

    #[test]
    fn test_casefold_null_returns_null() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT casefold(NULL)")
            .expect("casefold(NULL) should succeed");

        assert!(is_null(&result, 0, 0));
    }

    #[test]
    fn test_casefold_empty_string() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT casefold('')")
            .expect("casefold('') should succeed");

        assert_eq!(get_string(&result, 0, 0), "");
    }
}

mod casefold_unicode {
    use super::*;

    #[test]
    fn test_casefold_german_sharp_s() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT casefold('Straße')")
            .expect("casefold should handle German");

        assert_eq!(get_string(&result, 0, 0), "strasse");
    }

    #[test]
    fn test_casefold_differs_from_lower() {
        let mut executor = create_executor();

        let casefold_result = executor.execute_sql("SELECT casefold('ß')").unwrap();
        let lower_result = executor.execute_sql("SELECT LOWER('ß')").unwrap();

        let casefolded = get_string(&casefold_result, 0, 0);
        let lowered = get_string(&lower_result, 0, 0);

        assert_eq!(casefolded, "ss", "casefold should expand ß to ss");
        assert_eq!(lowered, "ß", "LOWER should keep ß as is");
    }
}

mod crc32_tests {
    use super::*;

    #[test]
    fn test_crc32_empty_string() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT crc32('')")
            .expect("crc32('') should succeed");

        assert_eq!(get_i64(&result, 0, 0), 0);
    }

    #[test]
    fn test_crc32_standard_test_vector() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT crc32('123456789')")
            .expect("crc32 should succeed");

        assert_eq!(get_i64(&result, 0, 0), 0xCBF43926_i64);
    }

    #[test]
    fn test_crc32_hello_world() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT crc32('Hello, World!')")
            .expect("crc32 should succeed");

        assert_ne!(get_i64(&result, 0, 0), 0);
    }

    #[test]
    fn test_crc32_null_returns_null() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT crc32(NULL)")
            .expect("crc32(NULL) should succeed");

        assert!(is_null(&result, 0, 0));
    }
}

mod crc32c_tests {
    use super::*;

    #[test]
    fn test_crc32c_standard_test_vector() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT crc32c('123456789')")
            .expect("crc32c should succeed");

        assert_eq!(get_i64(&result, 0, 0), 0xE3069283_i64);
    }

    #[test]
    fn test_crc32c_differs_from_crc32() {
        let mut executor = create_executor();

        let crc32_result = executor.execute_sql("SELECT crc32('test')").unwrap();
        let crc32c_result = executor.execute_sql("SELECT crc32c('test')").unwrap();

        assert_ne!(
            get_i64(&crc32_result, 0, 0),
            get_i64(&crc32c_result, 0, 0),
            "CRC32 and CRC32C should produce different checksums"
        );
    }

    #[test]
    fn test_crc32c_null_returns_null() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT crc32c(NULL)")
            .expect("crc32c(NULL) should succeed");

        assert!(is_null(&result, 0, 0));
    }
}

mod gamma_tests {
    use super::*;

    fn assert_float_eq(actual: f64, expected: f64, tolerance: f64) {
        assert!(
            (actual - expected).abs() < tolerance,
            "Expected {} to be within {} of {}, but difference was {}",
            actual,
            tolerance,
            expected,
            (actual - expected).abs()
        );
    }

    #[test]
    fn test_gamma_of_1_equals_1() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT gamma(1)")
            .expect("gamma(1) should succeed");

        assert_float_eq(get_f64(&result, 0, 0), 1.0, 1e-10);
    }

    #[test]
    fn test_gamma_of_2_equals_1() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT gamma(2)")
            .expect("gamma(2) should succeed");

        assert_float_eq(get_f64(&result, 0, 0), 1.0, 1e-10);
    }

    #[test]
    fn test_gamma_of_5_equals_24() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT gamma(5)")
            .expect("gamma(5) should succeed");

        assert_float_eq(get_f64(&result, 0, 0), 24.0, 1e-10);
    }

    #[test]
    fn test_gamma_of_half() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT gamma(0.5)")
            .expect("gamma(0.5) should succeed");

        let sqrt_pi = std::f64::consts::PI.sqrt();
        assert_float_eq(get_f64(&result, 0, 0), sqrt_pi, 1e-10);
    }

    #[test]
    fn test_gamma_null_returns_null() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT gamma(NULL)")
            .expect("gamma(NULL) should succeed");

        assert!(is_null(&result, 0, 0));
    }
}

mod lgamma_tests {
    use super::*;

    fn assert_float_eq(actual: f64, expected: f64, tolerance: f64) {
        assert!(
            (actual - expected).abs() < tolerance,
            "Expected {} to be within {} of {}, but difference was {}",
            actual,
            tolerance,
            expected,
            (actual - expected).abs()
        );
    }

    #[test]
    fn test_lgamma_of_1_equals_0() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT lgamma(1)")
            .expect("lgamma(1) should succeed");

        assert_float_eq(get_f64(&result, 0, 0), 0.0, 1e-10);
    }

    #[test]
    fn test_lgamma_of_2_equals_0() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT lgamma(2)")
            .expect("lgamma(2) should succeed");

        assert_float_eq(get_f64(&result, 0, 0), 0.0, 1e-10);
    }

    #[test]
    fn test_lgamma_large_value_no_overflow() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT lgamma(1000)")
            .expect("lgamma(1000) should succeed");

        let val = get_f64(&result, 0, 0);
        assert!(!val.is_infinite(), "lgamma should not overflow for 1000");
        assert!(val > 0.0, "lgamma(1000) should be positive");
    }

    #[test]
    fn test_lgamma_null_returns_null() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT lgamma(NULL)")
            .expect("lgamma(NULL) should succeed");

        assert!(is_null(&result, 0, 0));
    }
}

mod array_sort_tests {
    use super::*;

    #[test]
    fn test_array_sort_integers() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT array_sort(ARRAY[3, 1, 4, 1, 5, 9, 2, 6])")
            .expect("array_sort should succeed");

        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_array_sort_strings() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT array_sort(ARRAY['banana', 'apple', 'cherry'])")
            .expect("array_sort strings should succeed");

        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_array_sort_empty() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT array_sort(array_remove(ARRAY[1], 1))")
            .expect("array_sort empty should succeed");

        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_array_sort_single_element() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT array_sort(ARRAY[42])")
            .expect("array_sort single element should succeed");

        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_array_sort_null_returns_null() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT array_sort(NULL)")
            .expect("array_sort(NULL) should succeed");

        assert!(is_null(&result, 0, 0));
    }
}

mod reverse_bytea_tests {
    use super::*;

    #[test]
    fn test_reverse_bytea_basic() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT reverse('\\x010203'::bytea)")
            .expect("reverse bytea should succeed");

        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_reverse_bytea_empty() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT reverse(''::bytea)")
            .expect("reverse empty bytea should succeed");

        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_reverse_bytea_single_byte() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT reverse('\\x42'::bytea)")
            .expect("reverse single byte should succeed");

        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_reverse_bytea_null_returns_null() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT reverse(NULL::bytea)")
            .expect("reverse(NULL) should succeed");

        assert!(is_null(&result, 0, 0));
    }
}

mod to_number_roman_tests {
    use super::*;

    #[test]
    fn test_to_number_roman_i() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT to_number('I', 'RN')")
            .expect("to_number roman I should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64(&result, 0, 0), 1);
    }

    #[test]
    fn test_to_number_roman_v() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT to_number('V', 'RN')")
            .expect("to_number roman V should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64(&result, 0, 0), 5);
    }

    #[test]
    fn test_to_number_roman_x() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT to_number('X', 'RN')")
            .expect("to_number roman X should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64(&result, 0, 0), 10);
    }

    #[test]
    fn test_to_number_roman_iv_subtractive() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT to_number('IV', 'RN')")
            .expect("to_number roman IV should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64(&result, 0, 0), 4);
    }

    #[test]
    fn test_to_number_roman_mcmxcix() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT to_number('MCMXCIX', 'RN')")
            .expect("to_number roman MCMXCIX should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64(&result, 0, 0), 1999);
    }

    #[test]
    fn test_to_number_roman_lowercase() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT to_number('viii', 'RN')")
            .expect("to_number lowercase roman should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64(&result, 0, 0), 8);
    }
}

mod int_to_bytea_cast_tests {
    use super::*;

    #[test]
    fn test_int_to_bytea_zero() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT 0::bytea")
            .expect("INT to bytea cast should succeed");

        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_int_to_bytea_positive() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT 255::bytea")
            .expect("INT to bytea cast should succeed");

        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_int_to_bytea_large() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT 16909060::bytea")
            .expect("INT to bytea cast should succeed");

        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_bigint_to_bytea() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT 72057594037927936::bytea")
            .expect("BIGINT to bytea cast should succeed");

        assert_eq!(result.num_rows(), 1);
    }
}
