use yachtsql::{DialectType, QueryExecutor};

fn create_executor() -> QueryExecutor {
    QueryExecutor::with_dialect(DialectType::PostgreSQL)
}

mod create_table_basic {
    use super::*;

    #[test]
    fn test_create_table_int64_string() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS users").unwrap();
        let result = executor.execute_sql(
            "CREATE TABLE users (
                id INT64,
                name STRING,
                age INT64
            )",
        );

        assert!(
            result.is_ok(),
            "CREATE TABLE with INT64 and STRING should succeed"
        );

        let query = executor.execute_sql("SELECT * FROM users");
        assert!(query.is_ok(), "Table should be queryable");
    }

    #[test]
    fn test_create_table_float64() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS equipment")
            .unwrap();
        let result = executor.execute_sql(
            "CREATE TABLE equipment (
                id INT64,
                name STRING,
                price FLOAT64
            )",
        );

        assert!(result.is_ok(), "CREATE TABLE with FLOAT64 should succeed");
    }

    #[test]
    fn test_create_table_bool() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS flags").unwrap();
        let result = executor.execute_sql(
            "CREATE TABLE flags (
                id INT64,
                active BOOL
            )",
        );

        assert!(result.is_ok(), "CREATE TABLE with BOOL should succeed");
    }

    #[test]
    fn test_create_table_single_column() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS single").unwrap();
        let result = executor.execute_sql("CREATE TABLE single (id INT64)");

        assert!(
            result.is_ok(),
            "CREATE TABLE with single column should succeed"
        );
    }
}

mod create_table_if_not_exists {
    use super::*;

    #[test]
    fn test_idempotent_creation() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS test").unwrap();

        let result1 = executor.execute_sql(
            "CREATE TABLE IF NOT EXISTS test (
                id INT64,
                name STRING
            )",
        );
        assert!(
            result1.is_ok(),
            "First CREATE TABLE IF NOT EXISTS should succeed"
        );

        let result2 = executor.execute_sql(
            "CREATE TABLE IF NOT EXISTS test (
                id INT64,
                name STRING
            )",
        );
        assert!(
            result2.is_ok(),
            "Second CREATE TABLE IF NOT EXISTS should succeed (no error)"
        );
    }

    #[test]
    fn test_with_primary_key_constraint() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS users").unwrap();
        let result = executor.execute_sql(
            "CREATE TABLE IF NOT EXISTS users (
                id INT64,
                email STRING,
                CONSTRAINT pk_users PRIMARY KEY (id)
            )",
        );

        assert!(
            result.is_ok(),
            "CREATE TABLE IF NOT EXISTS with PRIMARY KEY constraint should succeed"
        );
    }
}

mod complex_data_types {
    use super::*;

    #[test]
    fn test_date_type() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS events").unwrap();
        let result = executor.execute_sql(
            "CREATE TABLE events (
                id INT64,
                event_date DATE
            )",
        );

        assert!(result.is_ok(), "CREATE TABLE with DATE should succeed");
    }

    #[test]
    fn test_timestamp_type() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS logs").unwrap();
        let result = executor.execute_sql(
            "CREATE TABLE logs (
                id INT64,
                created_at TIMESTAMP
            )",
        );

        assert!(result.is_ok(), "CREATE TABLE with TIMESTAMP should succeed");
    }

    #[test]
    fn test_numeric_type() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS finances")
            .unwrap();
        let result = executor.execute_sql(
            "CREATE TABLE finances (
                id INT64,
                amount NUMERIC
            )",
        );

        assert!(result.is_ok(), "CREATE TABLE with NUMERIC should succeed");
    }

    #[test]
    fn test_numeric_with_precision() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS prices").unwrap();
        let result = executor.execute_sql(
            "CREATE TABLE prices (
                id INT64,
                amount NUMERIC(10, 2)
            )",
        );

        assert!(
            result.is_ok(),
            "CREATE TABLE with NUMERIC(10,2) should succeed"
        );
    }

    #[test]
    fn test_decimal_type() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS test_decimal")
            .unwrap();
        let result = executor.execute_sql("CREATE TABLE test_decimal (val DECIMAL(10, 2))");

        assert!(result.is_ok(), "CREATE TABLE with DECIMAL should succeed");
    }

    #[test]
    fn test_array_type() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS lists").unwrap();
        let result = executor.execute_sql(
            "CREATE TABLE lists (
                id INT64,
                numbers ARRAY<INT64>
            )",
        );

        assert!(
            result.is_ok(),
            "CREATE TABLE with ARRAY<INT64> should succeed"
        );
    }

    #[test]
    fn test_mixed_types() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS mixed").unwrap();
        let result = executor.execute_sql(
            "CREATE TABLE mixed (
                id INT64,
                name STRING,
                score FLOAT64,
                active BOOL,
                created DATE
            )",
        );

        assert!(
            result.is_ok(),
            "CREATE TABLE with mixed types should succeed"
        );

        let query = executor.execute_sql("SELECT * FROM mixed");
        assert!(query.is_ok());
        assert_eq!(query.unwrap().num_columns(), 5);
    }
}

mod drop_table {
    use super::*;

    #[test]
    fn test_basic_drop() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS to_drop")
            .unwrap();
        executor
            .execute_sql("CREATE TABLE to_drop (id INT64)")
            .unwrap();

        assert!(executor.execute_sql("SELECT * FROM to_drop").is_ok());

        let result = executor.execute_sql("DROP TABLE to_drop");
        assert!(result.is_ok(), "DROP TABLE should succeed");

        let query = executor.execute_sql("SELECT * FROM to_drop");
        assert!(query.is_err(), "Table should no longer exist after DROP");
    }

    #[test]
    fn test_drop_if_exists() {
        let mut executor = create_executor();

        let result = executor.execute_sql("DROP TABLE IF EXISTS nonexistent");
        assert!(
            result.is_ok(),
            "DROP TABLE IF EXISTS should not error for non-existent table"
        );
    }

    #[test]
    fn test_drop_if_exists_multiple_times() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TABLE IF NOT EXISTS temp (id INT64)")
            .unwrap();

        assert!(executor.execute_sql("DROP TABLE IF EXISTS temp").is_ok());
        assert!(executor.execute_sql("DROP TABLE IF EXISTS temp").is_ok());
        assert!(executor.execute_sql("DROP TABLE IF EXISTS temp").is_ok());
    }
}

mod truncate_table {
    use super::*;

    #[test]
    fn test_truncate_removes_rows() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS to_truncate")
            .unwrap();
        executor
            .execute_sql("CREATE TABLE to_truncate (id INT64, name STRING)")
            .unwrap();
        executor
            .execute_sql("INSERT INTO to_truncate VALUES (1, 'Alice'), (2, 'Bob')")
            .unwrap();

        let before = executor.execute_sql("SELECT * FROM to_truncate").unwrap();
        assert_eq!(before.num_rows(), 2);

        let result = executor.execute_sql("TRUNCATE TABLE to_truncate");
        assert!(result.is_ok(), "TRUNCATE TABLE should succeed");

        let after = executor.execute_sql("SELECT * FROM to_truncate").unwrap();
        assert_eq!(after.num_rows(), 0, "TRUNCATE should remove all rows");

        assert_eq!(after.num_columns(), 2, "TRUNCATE should preserve columns");
    }
}

mod edge_cases {
    use super::*;

    #[test]
    fn test_empty_table_query() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS empty_table")
            .unwrap();
        executor
            .execute_sql("CREATE TABLE empty_table (id INT64, name STRING)")
            .unwrap();

        let result = executor.execute_sql("SELECT * FROM empty_table").unwrap();
        assert_eq!(result.num_rows(), 0);
        assert_eq!(result.num_columns(), 2);
    }

    #[test]
    fn test_large_integers() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS big_numbers")
            .unwrap();
        executor
            .execute_sql("CREATE TABLE big_numbers (value INT64)")
            .unwrap();

        executor
            .execute_sql("INSERT INTO big_numbers VALUES (9223372036854775807)")
            .unwrap();

        executor
            .execute_sql("INSERT INTO big_numbers VALUES (-9223372036854775808)")
            .unwrap();

        let result = executor
            .execute_sql("SELECT * FROM big_numbers ORDER BY value")
            .unwrap();
        assert_eq!(result.num_rows(), 2);
    }

    #[test]
    fn test_very_small_floats() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS tiny_numbers")
            .unwrap();
        executor
            .execute_sql("CREATE TABLE tiny_numbers (value FLOAT64)")
            .unwrap();

        executor
            .execute_sql("INSERT INTO tiny_numbers VALUES (0.0000001)")
            .unwrap();
        executor
            .execute_sql("INSERT INTO tiny_numbers VALUES (1e-10)")
            .unwrap();

        let result = executor
            .execute_sql("SELECT * FROM tiny_numbers ORDER BY value")
            .unwrap();
        assert_eq!(result.num_rows(), 2);
    }

    #[test]
    fn test_unicode_strings() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS unicode_texts")
            .unwrap();
        executor
            .execute_sql("CREATE TABLE unicode_texts (id INT64, text STRING)")
            .unwrap();

        executor
            .execute_sql("INSERT INTO unicode_texts VALUES (1, 'Hello 世界')")
            .unwrap();
        executor
            .execute_sql("INSERT INTO unicode_texts VALUES (2, 'Привет мир')")
            .unwrap();
        executor
            .execute_sql("INSERT INTO unicode_texts VALUES (3, '😀🎉🚀')")
            .unwrap();

        let result = executor
            .execute_sql("SELECT * FROM unicode_texts ORDER BY id")
            .unwrap();
        assert_eq!(result.num_rows(), 3);
    }

    #[test]
    fn test_multiple_tables() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS table1").unwrap();
        executor.execute_sql("DROP TABLE IF EXISTS table2").unwrap();

        executor
            .execute_sql("CREATE TABLE table1 (id INT64)")
            .unwrap();
        executor
            .execute_sql("CREATE TABLE table2 (id INT64)")
            .unwrap();

        executor
            .execute_sql("INSERT INTO table1 VALUES (1)")
            .unwrap();
        executor
            .execute_sql("INSERT INTO table2 VALUES (2)")
            .unwrap();

        let result1 = executor.execute_sql("SELECT * FROM table1").unwrap();
        let result2 = executor.execute_sql("SELECT * FROM table2").unwrap();

        assert_eq!(result1.num_rows(), 1);
        assert_eq!(result2.num_rows(), 1);
    }
}

mod create_drop_cycle {
    use super::*;

    #[test]
    fn test_recreate_pattern() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS cycle_test")
            .unwrap();
        executor
            .execute_sql("CREATE TABLE IF NOT EXISTS cycle_test (id INT64)")
            .unwrap();
        executor
            .execute_sql("INSERT INTO cycle_test VALUES (1)")
            .unwrap();

        let result1 = executor.execute_sql("SELECT * FROM cycle_test").unwrap();
        assert_eq!(result1.num_rows(), 1);

        executor.execute_sql("DROP TABLE cycle_test").unwrap();
        executor
            .execute_sql("CREATE TABLE cycle_test (id INT64, name STRING)")
            .unwrap();
        executor
            .execute_sql("INSERT INTO cycle_test VALUES (2, 'Bob')")
            .unwrap();

        let result2 = executor.execute_sql("SELECT * FROM cycle_test").unwrap();
        assert_eq!(result2.num_rows(), 1);
        assert_eq!(result2.num_columns(), 2);
    }
}

mod constraints {
    use super::*;

    #[test]
    fn test_primary_key_inline() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS pk_test")
            .unwrap();
        let result = executor.execute_sql(
            "CREATE TABLE pk_test (
                id INT64 PRIMARY KEY,
                name STRING
            )",
        );

        assert!(
            result.is_ok(),
            "CREATE TABLE with inline PRIMARY KEY should succeed"
        );
    }

    #[test]
    fn test_not_null_constraint() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS nn_test")
            .unwrap();
        let result = executor.execute_sql(
            "CREATE TABLE nn_test (
                id INT64 NOT NULL,
                name STRING
            )",
        );

        assert!(result.is_ok(), "CREATE TABLE with NOT NULL should succeed");
    }

    #[test]
    fn test_unique_constraint() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS unique_test")
            .unwrap();
        let result = executor.execute_sql(
            "CREATE TABLE unique_test (
                id INT64,
                email STRING UNIQUE
            )",
        );

        assert!(result.is_ok(), "CREATE TABLE with UNIQUE should succeed");
    }

    #[test]
    fn test_multiple_constraints() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS multi_constraint")
            .unwrap();
        let result = executor.execute_sql(
            "CREATE TABLE multi_constraint (
                id INT64 PRIMARY KEY,
                email STRING NOT NULL UNIQUE,
                name STRING
            )",
        );

        assert!(
            result.is_ok(),
            "CREATE TABLE with multiple constraints should succeed"
        );
    }

    #[test]
    fn test_table_level_primary_key() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS table_pk")
            .unwrap();
        let result = executor.execute_sql(
            "CREATE TABLE table_pk (
                id INT64,
                name STRING,
                PRIMARY KEY (id)
            )",
        );

        assert!(
            result.is_ok(),
            "CREATE TABLE with table-level PRIMARY KEY should succeed"
        );
    }

    #[test]
    fn test_composite_primary_key() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS composite_pk")
            .unwrap();
        let result = executor.execute_sql(
            "CREATE TABLE composite_pk (
                tenant_id INT64,
                user_id INT64,
                name STRING,
                PRIMARY KEY (tenant_id, user_id)
            )",
        );

        assert!(
            result.is_ok(),
            "CREATE TABLE with composite PRIMARY KEY should succeed"
        );
    }
}
