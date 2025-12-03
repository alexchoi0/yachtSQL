mod common;

use yachtsql::{DialectType, QueryExecutor};

fn create_executor() -> QueryExecutor {
    QueryExecutor::with_dialect(DialectType::PostgreSQL)
}

mod create_domain_parsing {
    use super::*;

    #[test]
    fn test_create_domain_basic() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE DOMAIN positive_int AS INT64 CHECK (VALUE > 0)")
            .expect("CREATE DOMAIN should succeed");
    }

    #[test]
    fn test_create_domain_with_default() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE DOMAIN status_code AS STRING DEFAULT 'pending'")
            .expect("CREATE DOMAIN with DEFAULT should succeed");
    }

    #[test]
    fn test_create_domain_with_not_null() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE DOMAIN required_name AS STRING NOT NULL")
            .expect("CREATE DOMAIN with NOT NULL should succeed");
    }

    #[test]
    fn test_create_domain_with_check_constraint() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE DOMAIN percentage AS INT64 CHECK (VALUE >= 0 AND VALUE <= 100)")
            .expect("CREATE DOMAIN with CHECK should succeed");
    }

    #[test]
    fn test_create_domain_with_named_constraint() {
        let mut executor = create_executor();

        executor
            .execute_sql(
                "CREATE DOMAIN email AS STRING CONSTRAINT valid_email CHECK (VALUE LIKE '%@%.%')",
            )
            .expect("CREATE DOMAIN with named constraint should succeed");
    }

    #[test]
    fn test_create_domain_full_syntax() {
        let mut executor = create_executor();

        executor
            .execute_sql(
                "CREATE DOMAIN price AS NUMERIC(10, 2) DEFAULT 0.00 NOT NULL CHECK (VALUE >= 0)",
            )
            .expect("CREATE DOMAIN with full syntax should succeed");
    }

    #[test]
    fn test_create_domain_with_schema() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE DOMAIN public.age AS INT64 CHECK (VALUE >= 0 AND VALUE <= 150)")
            .expect("CREATE DOMAIN with schema qualification should succeed");
    }

    #[test]
    fn test_create_domain_multiple_constraints() {
        let mut executor = create_executor();

        executor
            .execute_sql(
                "CREATE DOMAIN valid_rating AS INT64
                 CHECK (VALUE >= 1)
                 CHECK (VALUE <= 5)",
            )
            .expect("CREATE DOMAIN with multiple constraints should succeed");
    }
}

mod drop_domain_parsing {
    use super::*;

    #[test]
    fn test_drop_domain_basic() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE DOMAIN temp_domain AS INT64")
            .expect("CREATE DOMAIN should succeed");

        executor
            .execute_sql("DROP DOMAIN temp_domain")
            .expect("DROP DOMAIN should succeed");
    }

    #[test]
    fn test_drop_domain_if_exists() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP DOMAIN IF EXISTS nonexistent_domain")
            .expect("DROP DOMAIN IF EXISTS should succeed even if domain doesn't exist");
    }

    #[test]
    fn test_drop_domain_cascade() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE DOMAIN cascade_domain AS INT64")
            .unwrap();

        executor
            .execute_sql("DROP DOMAIN cascade_domain CASCADE")
            .expect("DROP DOMAIN CASCADE should succeed");
    }

    #[test]
    fn test_drop_domain_restrict() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE DOMAIN restrict_domain AS INT64")
            .unwrap();

        executor
            .execute_sql("DROP DOMAIN restrict_domain RESTRICT")
            .expect("DROP DOMAIN RESTRICT should succeed");
    }

    #[test]
    fn test_drop_domain_multiple() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE DOMAIN domain1 AS INT64")
            .unwrap();
        executor
            .execute_sql("CREATE DOMAIN domain2 AS INT64")
            .unwrap();

        executor
            .execute_sql("DROP DOMAIN domain1, domain2")
            .expect("DROP DOMAIN with multiple names should succeed");
    }

    #[test]
    fn test_drop_nonexistent_domain_fails() {
        let mut executor = create_executor();

        let result = executor.execute_sql("DROP DOMAIN nonexistent_domain");

        assert!(
            result.is_err(),
            "Dropping nonexistent domain without IF EXISTS should fail"
        );
    }
}

mod alter_domain_parsing {
    use super::*;

    #[test]
    fn test_alter_domain_add_constraint() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE DOMAIN alter_test AS INT64")
            .unwrap();

        executor
            .execute_sql("ALTER DOMAIN alter_test ADD CONSTRAINT positive CHECK (VALUE > 0)")
            .expect("ALTER DOMAIN ADD CONSTRAINT should succeed");
    }

    #[test]
    fn test_alter_domain_drop_constraint() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE DOMAIN drop_test AS INT64 CONSTRAINT min_value CHECK (VALUE >= 0)")
            .unwrap();

        executor
            .execute_sql("ALTER DOMAIN drop_test DROP CONSTRAINT min_value")
            .expect("ALTER DOMAIN DROP CONSTRAINT should succeed");
    }

    #[test]
    fn test_alter_domain_set_default() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE DOMAIN default_test AS INT64")
            .unwrap();

        executor
            .execute_sql("ALTER DOMAIN default_test SET DEFAULT 42")
            .expect("ALTER DOMAIN SET DEFAULT should succeed");
    }

    #[test]
    fn test_alter_domain_drop_default() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE DOMAIN drop_default_test AS INT64 DEFAULT 0")
            .unwrap();

        executor
            .execute_sql("ALTER DOMAIN drop_default_test DROP DEFAULT")
            .expect("ALTER DOMAIN DROP DEFAULT should succeed");
    }

    #[test]
    fn test_alter_domain_set_not_null() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE DOMAIN notnull_test AS INT64")
            .unwrap();

        executor
            .execute_sql("ALTER DOMAIN notnull_test SET NOT NULL")
            .expect("ALTER DOMAIN SET NOT NULL should succeed");
    }

    #[test]
    fn test_alter_domain_drop_not_null() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE DOMAIN drop_notnull_test AS INT64 NOT NULL")
            .unwrap();

        executor
            .execute_sql("ALTER DOMAIN drop_notnull_test DROP NOT NULL")
            .expect("ALTER DOMAIN DROP NOT NULL should succeed");
    }

    #[test]
    fn test_alter_domain_rename_constraint() {
        let mut executor = create_executor();

        executor
            .execute_sql(
                "CREATE DOMAIN rename_test AS INT64 CONSTRAINT old_name CHECK (VALUE >= 0)",
            )
            .unwrap();

        executor
            .execute_sql("ALTER DOMAIN rename_test RENAME CONSTRAINT old_name TO new_name")
            .expect("ALTER DOMAIN RENAME CONSTRAINT should succeed");
    }

    #[test]
    fn test_alter_domain_validate_constraint() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE DOMAIN validate_test AS INT64")
            .unwrap();

        executor
            .execute_sql("ALTER DOMAIN validate_test ADD CONSTRAINT check_val CHECK (VALUE > 0)")
            .unwrap();

        executor
            .execute_sql("ALTER DOMAIN validate_test VALIDATE CONSTRAINT check_val")
            .expect("ALTER DOMAIN VALIDATE CONSTRAINT should succeed");
    }
}

mod domain_usage {
    use super::*;

    #[test]
    fn test_domain_in_table_column() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE DOMAIN positive_amount AS FLOAT64 CHECK (VALUE > 0)")
            .unwrap();

        executor
            .execute_sql("CREATE TABLE orders (id INT64, amount positive_amount)")
            .expect("CREATE TABLE with domain column should succeed");
    }

    #[test]
    fn test_domain_constraint_on_insert() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE DOMAIN positive_int AS INT64 CHECK (VALUE > 0)")
            .unwrap();

        executor
            .execute_sql("CREATE TABLE test_positive (id INT64, value positive_int)")
            .unwrap();

        executor
            .execute_sql("INSERT INTO test_positive VALUES (1, 10)")
            .expect("INSERT with valid domain value should succeed");

        let result = executor.execute_sql("INSERT INTO test_positive VALUES (2, -5)");
        assert!(
            result.is_err(),
            "INSERT with invalid domain value should fail"
        );
    }

    #[test]
    fn test_domain_with_default_on_insert() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE DOMAIN status AS STRING DEFAULT 'pending'")
            .unwrap();

        executor
            .execute_sql("CREATE TABLE tasks (id INT64, status status)")
            .unwrap();

        executor
            .execute_sql("INSERT INTO tasks (id) VALUES (1)")
            .expect("INSERT using domain default should succeed");

        let result = executor
            .execute_sql("SELECT status FROM tasks WHERE id = 1")
            .expect("Query should succeed");

        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_domain_not_null_constraint() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE DOMAIN required_string AS STRING NOT NULL")
            .unwrap();

        executor
            .execute_sql("CREATE TABLE test_required (id INT64, name required_string)")
            .unwrap();

        let result = executor.execute_sql("INSERT INTO test_required VALUES (1, NULL)");
        assert!(
            result.is_err(),
            "INSERT NULL into NOT NULL domain should fail"
        );
    }

    #[test]
    fn test_domain_appears_as_base_type() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE DOMAIN money AS NUMERIC(10, 2)")
            .unwrap();

        executor
            .execute_sql("CREATE TABLE accounts (id INT64, balance money)")
            .unwrap();

        executor
            .execute_sql("INSERT INTO accounts VALUES (1, 100.50)")
            .unwrap();

        let result = executor.execute_sql("SELECT balance + 10.00 FROM accounts WHERE id = 1");
        assert!(result.is_ok(), "Arithmetic on domain column should work");
    }
}

mod dialect_restrictions {
    use super::*;

    #[test]
    fn test_create_domain_bigquery_fails() {
        let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);

        let result = executor.execute_sql("CREATE DOMAIN positive_int AS INT64 CHECK (VALUE > 0)");

        assert!(
            result.is_err(),
            "CREATE DOMAIN should fail in BigQuery dialect"
        );
        let err_msg = result.unwrap_err().to_string();
        assert!(
            err_msg.contains("PostgreSQL") || err_msg.contains("not supported"),
            "Error message should indicate dialect restriction: {}",
            err_msg
        );
    }

    #[test]
    fn test_drop_domain_bigquery_fails() {
        let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);

        let result = executor.execute_sql("DROP DOMAIN some_domain");

        assert!(
            result.is_err(),
            "DROP DOMAIN should fail in BigQuery dialect"
        );
    }

    #[test]
    fn test_alter_domain_bigquery_fails() {
        let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);

        let result = executor.execute_sql("ALTER DOMAIN some_domain SET NOT NULL");

        assert!(
            result.is_err(),
            "ALTER DOMAIN should fail in BigQuery dialect"
        );
    }
}

mod edge_cases {
    use super::*;

    #[test]
    fn test_domain_with_complex_check() {
        let mut executor = create_executor();

        executor
            .execute_sql(
                "CREATE DOMAIN valid_email AS STRING
                 CHECK (VALUE LIKE '%@%' AND LENGTH(VALUE) >= 5)",
            )
            .expect("CREATE DOMAIN with complex CHECK should succeed");
    }

    #[test]
    fn test_domain_case_insensitive() {
        let mut executor = create_executor();

        executor
            .execute_sql("create domain lower_test as int64 check (value > 0)")
            .expect("lowercase CREATE DOMAIN should succeed");
    }

    #[test]
    fn test_domain_duplicate_fails() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE DOMAIN dup_test AS INT64")
            .unwrap();

        let result = executor.execute_sql("CREATE DOMAIN dup_test AS INT64");
        assert!(result.is_err(), "Creating duplicate domain should fail");
    }

    #[test]
    fn test_alter_nonexistent_domain_fails() {
        let mut executor = create_executor();

        let result = executor.execute_sql("ALTER DOMAIN nonexistent SET NOT NULL");
        assert!(result.is_err(), "ALTER on nonexistent domain should fail");
    }

    #[test]
    fn test_domain_value_keyword() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE DOMAIN check_value AS INT64 CHECK (VALUE IS NOT NULL)")
            .expect("VALUE keyword in CHECK should work");
    }
}
