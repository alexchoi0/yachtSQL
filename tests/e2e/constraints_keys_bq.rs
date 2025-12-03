use yachtsql::QueryExecutor;
use yachtsql_parser::DialectType;

mod primary_key {
    use super::*;

    #[test]
    fn test_primary_key_single_column() {
        let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);


        executor
            .execute_sql(
                "CREATE TABLE users (
                    id INT64 PRIMARY KEY NOT ENFORCED,
                    name STRING
                )",
            )
            .expect("CREATE TABLE with PRIMARY KEY NOT ENFORCED should succeed");

        executor
            .execute_sql("INSERT INTO users VALUES (1, 'Alice')")
            .expect("INSERT should succeed");

        let result = executor
            .execute_sql("SELECT id, name FROM users")
            .expect("SELECT should succeed");
        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_primary_key_without_not_enforced() {
        let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);


        executor
            .execute_sql(
                "CREATE TABLE simple_table (
                    id INT64 PRIMARY KEY,
                    value STRING
                )",
            )
            .expect("CREATE TABLE with PRIMARY KEY should succeed");
    }
}

mod foreign_key {
    use super::*;

    #[test]
    fn test_foreign_key_not_enforced() {
        let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);

        executor
            .execute_sql(
                "CREATE TABLE users (
                    id INT64 PRIMARY KEY NOT ENFORCED,
                    name STRING
                )",
            )
            .expect("CREATE parent table should succeed");


        executor
            .execute_sql(
                "CREATE TABLE orders (
                    id INT64 PRIMARY KEY NOT ENFORCED,
                    user_id INT64,
                    FOREIGN KEY (user_id) REFERENCES users(id) NOT ENFORCED
                )",
            )
            .expect("CREATE TABLE with FOREIGN KEY NOT ENFORCED should succeed");


        executor
            .execute_sql("INSERT INTO orders VALUES (100, 999)")
            .expect("INSERT with non-existent FK should succeed (NOT ENFORCED)");
    }

    #[test]
    fn test_foreign_key_inline_syntax() {
        let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);

        executor
            .execute_sql(
                "CREATE TABLE departments (
                    id INT64 PRIMARY KEY NOT ENFORCED,
                    name STRING
                )",
            )
            .expect("CREATE departments should succeed");

        executor
            .execute_sql(
                "CREATE TABLE employees (
                    id INT64 PRIMARY KEY NOT ENFORCED,
                    department_id INT64 REFERENCES departments(id) NOT ENFORCED,
                    name STRING
                )",
            )
            .expect("CREATE TABLE with inline REFERENCES should succeed");
    }
}

mod not_null {
    use super::*;

    #[test]
    fn test_not_null_enforced() {
        let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);

        executor
            .execute_sql(
                "CREATE TABLE required_fields (
                    id INT64 NOT NULL,
                    name STRING NOT NULL,
                    description STRING
                )",
            )
            .expect("CREATE TABLE with NOT NULL should succeed");

        executor
            .execute_sql("INSERT INTO required_fields VALUES (1, 'Test', 'Description')")
            .expect("Valid values should succeed");


        let result = executor.execute_sql("INSERT INTO required_fields VALUES (2, NULL, 'Test')");
        assert!(result.is_err(), "Should reject NULL in NOT NULL column");
    }

    #[test]
    fn test_nullable_by_default() {
        let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);

        executor
            .execute_sql(
                "CREATE TABLE data (
                    id INT64 NOT NULL,
                    optional_value STRING
                )",
            )
            .expect("CREATE TABLE should succeed");


        executor
            .execute_sql("INSERT INTO data VALUES (1, NULL)")
            .expect("NULL in nullable column should succeed");
    }
}

mod default_values {
    use super::*;

    #[test]
    fn test_default_literal() {
        let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);

        executor
            .execute_sql(
                "CREATE TABLE logs (
                    id INT64 NOT NULL,
                    message STRING NOT NULL,
                    level STRING DEFAULT 'INFO'
                )",
            )
            .expect("CREATE TABLE with DEFAULT should succeed");

        executor
            .execute_sql("INSERT INTO logs (id, message) VALUES (1, 'Test message')")
            .expect("INSERT using default should succeed");
    }

    #[test]
    fn test_default_current_timestamp() {
        let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);

        executor
            .execute_sql(
                "CREATE TABLE events (
                    id INT64 NOT NULL,
                    name STRING,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
                )",
            )
            .expect("CREATE TABLE with CURRENT_TIMESTAMP() default should succeed");
    }

    #[test]
    fn test_default_boolean() {
        let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);

        executor
            .execute_sql(
                "CREATE TABLE flags (
                    id INT64 NOT NULL,
                    name STRING,
                    enabled BOOL DEFAULT TRUE
                )",
            )
            .expect("CREATE TABLE with boolean default should succeed");

        executor
            .execute_sql("INSERT INTO flags (id, name) VALUES (1, 'feature_x')")
            .expect("INSERT with boolean default should succeed");
    }

    #[test]
    fn test_default_numeric() {
        let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);

        executor
            .execute_sql(
                "CREATE TABLE counters (
                    id INT64 NOT NULL,
                    name STRING,
                    count INT64 DEFAULT 0
                )",
            )
            .expect("CREATE TABLE with numeric default should succeed");
    }
}

mod bigquery_types {
    use super::*;

    #[test]
    fn test_array_with_not_null() {
        let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);

        executor
            .execute_sql(
                "CREATE TABLE tagged_items (
                    id INT64 NOT NULL,
                    tags ARRAY<STRING> NOT NULL
                )",
            )
            .expect("CREATE TABLE with ARRAY NOT NULL should succeed");
    }

}

mod unique_constraint {
    use super::*;

    #[test]
    fn test_unique_syntax_parsed() {
        let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);


        executor
            .execute_sql(
                "CREATE TABLE products (
                    id INT64 NOT NULL,
                    sku STRING UNIQUE NOT ENFORCED
                )",
            )
            .expect("CREATE TABLE with UNIQUE NOT ENFORCED should parse");
    }
}

mod integration {
    use super::*;

    #[test]
    fn test_table_with_all_bigquery_constraints() {
        let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);


        executor
            .execute_sql(
                "CREATE TABLE departments (
                    id INT64 PRIMARY KEY NOT ENFORCED,
                    name STRING NOT NULL
                )",
            )
            .expect("CREATE departments should succeed");

        executor
            .execute_sql("INSERT INTO departments VALUES (1, 'Engineering')")
            .expect("INSERT department should succeed");


        executor
            .execute_sql(
                "CREATE TABLE employees (
                    id INT64 PRIMARY KEY NOT ENFORCED,
                    email STRING NOT NULL,
                    department_id INT64 REFERENCES departments(id) NOT ENFORCED,
                    status STRING DEFAULT 'active',
                    name STRING NOT NULL
                )",
            )
            .expect("CREATE TABLE with BigQuery constraints should succeed");


        executor
            .execute_sql(
                "INSERT INTO employees (id, email, department_id, name)
                 VALUES (1, 'alice@example.com', 1, 'Alice')",
            )
            .expect("Valid insert should succeed");


        let result = executor
            .execute_sql("SELECT status FROM employees WHERE id = 1")
            .expect("SELECT should succeed");
        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_not_null_with_defaults() {
        let mut executor = QueryExecutor::with_dialect(DialectType::BigQuery);

        executor
            .execute_sql(
                "CREATE TABLE audit_log (
                    id INT64 NOT NULL,
                    action STRING NOT NULL,
                    timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
                    user_id INT64,
                    details STRING DEFAULT ''
                )",
            )
            .expect("CREATE TABLE should succeed");


        executor
            .execute_sql("INSERT INTO audit_log (id, action, user_id) VALUES (1, 'LOGIN', 100)")
            .expect("INSERT with defaults should succeed");
    }

}
