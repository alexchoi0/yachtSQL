#![allow(dead_code)]
#![allow(unused_variables)]

use yachtsql::{DialectType, QueryExecutor};

fn create_executor() -> QueryExecutor {
    QueryExecutor::with_dialect(DialectType::PostgreSQL)
}

mod primary_key {
    use super::*;

    #[test]
    fn test_create_table_with_primary_key() {
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
            "CREATE TABLE with PRIMARY KEY should succeed"
        );

        let query = executor.execute_sql("SELECT * FROM pk_test");
        assert!(query.is_ok(), "Table should be queryable");
    }

    #[test]
    fn test_primary_key_insert() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS pk_test")
            .unwrap();
        executor
            .execute_sql(
                "CREATE TABLE pk_test (
                id INT64 PRIMARY KEY,
                name STRING
            )",
            )
            .unwrap();

        let result1 = executor.execute_sql("INSERT INTO pk_test VALUES (1, 'Alice')");
        assert!(result1.is_ok(), "First INSERT should succeed");

        let result2 = executor.execute_sql("INSERT INTO pk_test VALUES (2, 'Bob')");
        assert!(result2.is_ok(), "INSERT with different key should succeed");

        let query = executor.execute_sql("SELECT * FROM pk_test").unwrap();
        assert_eq!(query.num_rows(), 2, "Should have 2 rows");
    }

    #[test]
    fn test_primary_key_uniqueness_violation() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS pk_test")
            .unwrap();
        executor
            .execute_sql(
                "CREATE TABLE pk_test (
                id INT64 PRIMARY KEY,
                name STRING
            )",
            )
            .unwrap();

        executor
            .execute_sql("INSERT INTO pk_test VALUES (1, 'Alice')")
            .unwrap();

        let result = executor.execute_sql("INSERT INTO pk_test VALUES (1, 'Bob')");
        assert!(
            result.is_err(),
            "INSERT with duplicate PRIMARY KEY should fail"
        );
    }

    #[test]
    fn test_primary_key_not_null() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS pk_test")
            .unwrap();
        executor
            .execute_sql(
                "CREATE TABLE pk_test (
                id INT64 PRIMARY KEY,
                name STRING
            )",
            )
            .unwrap();

        let result = executor.execute_sql("INSERT INTO pk_test VALUES (NULL, 'Alice')");
        assert!(result.is_err(), "INSERT with NULL PRIMARY KEY should fail");
    }

    #[test]
    fn test_composite_primary_key() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS composite_pk")
            .unwrap();
        executor
            .execute_sql(
                "CREATE TABLE composite_pk (
                tenant_id INT64,
                user_id INT64,
                name STRING,
                PRIMARY KEY (tenant_id, user_id)
            )",
            )
            .unwrap();

        executor
            .execute_sql("INSERT INTO composite_pk VALUES (1, 1, 'Alice')")
            .unwrap();
        executor
            .execute_sql("INSERT INTO composite_pk VALUES (1, 2, 'Bob')")
            .unwrap();
        executor
            .execute_sql("INSERT INTO composite_pk VALUES (2, 1, 'Charlie')")
            .unwrap();

        let result = executor.execute_sql("INSERT INTO composite_pk VALUES (1, 1, 'Diana')");
        assert!(
            result.is_err(),
            "INSERT with duplicate composite PRIMARY KEY should fail"
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
    fn test_named_primary_key_constraint() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS named_pk")
            .unwrap();
        let result = executor.execute_sql(
            "CREATE TABLE named_pk (
                id INT64,
                name STRING,
                CONSTRAINT pk_named_pk PRIMARY KEY (id)
            )",
        );

        assert!(
            result.is_ok(),
            "CREATE TABLE with named PRIMARY KEY should succeed"
        );
    }
}

mod unique_constraint {
    use super::*;

    #[test]
    fn test_create_table_with_unique() {
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
    fn test_unique_constraint_enforcement() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS unique_test")
            .unwrap();
        executor
            .execute_sql(
                "CREATE TABLE unique_test (
                id INT64,
                email STRING UNIQUE
            )",
            )
            .unwrap();

        executor
            .execute_sql("INSERT INTO unique_test VALUES (1, 'alice@test.com')")
            .unwrap();

        executor
            .execute_sql("INSERT INTO unique_test VALUES (2, 'bob@test.com')")
            .unwrap();

        let result = executor.execute_sql("INSERT INTO unique_test VALUES (3, 'alice@test.com')");
        assert!(
            result.is_err(),
            "INSERT with duplicate UNIQUE value should fail"
        );
    }

    #[test]
    fn test_unique_allows_multiple_nulls() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS unique_test")
            .unwrap();
        executor
            .execute_sql(
                "CREATE TABLE unique_test (
                id INT64,
                email STRING UNIQUE
            )",
            )
            .unwrap();

        executor
            .execute_sql("INSERT INTO unique_test VALUES (1, NULL)")
            .unwrap();
        let result = executor.execute_sql("INSERT INTO unique_test VALUES (2, NULL)");
        assert!(
            result.is_ok(),
            "UNIQUE should allow multiple NULL values (SQL standard)"
        );
    }

    #[test]
    fn test_table_level_unique() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS unique_test")
            .unwrap();
        let result = executor.execute_sql(
            "CREATE TABLE unique_test (
                id INT64,
                email STRING,
                UNIQUE (email)
            )",
        );

        assert!(
            result.is_ok(),
            "CREATE TABLE with table-level UNIQUE should succeed"
        );
    }

    #[test]
    fn test_composite_unique() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS composite_unique")
            .unwrap();
        executor
            .execute_sql(
                "CREATE TABLE composite_unique (
                first_name STRING,
                last_name STRING,
                age INT64,
                UNIQUE (first_name, last_name)
            )",
            )
            .unwrap();

        executor
            .execute_sql("INSERT INTO composite_unique VALUES ('Alice', 'Smith', 30)")
            .unwrap();
        executor
            .execute_sql("INSERT INTO composite_unique VALUES ('Alice', 'Jones', 25)")
            .unwrap();
        executor
            .execute_sql("INSERT INTO composite_unique VALUES ('Bob', 'Smith', 35)")
            .unwrap();

        let result =
            executor.execute_sql("INSERT INTO composite_unique VALUES ('Alice', 'Smith', 40)");
        assert!(
            result.is_err(),
            "INSERT with duplicate composite UNIQUE should fail"
        );
    }

    #[test]
    fn test_multiple_unique_constraints() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS multi_unique")
            .unwrap();
        let result = executor.execute_sql(
            "CREATE TABLE multi_unique (
                id INT64,
                email STRING,
                username STRING,
                UNIQUE (email),
                UNIQUE (username)
            )",
        );

        assert!(
            result.is_ok(),
            "CREATE TABLE with multiple UNIQUE constraints should succeed"
        );
    }
}

mod not_null_constraint {
    use super::*;

    #[test]
    fn test_create_table_with_not_null() {
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
    fn test_not_null_enforcement() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS nn_test")
            .unwrap();
        executor
            .execute_sql(
                "CREATE TABLE nn_test (
                id INT64 NOT NULL,
                name STRING
            )",
            )
            .unwrap();

        let result = executor.execute_sql("INSERT INTO nn_test VALUES (1, 'Alice')");
        assert!(result.is_ok(), "INSERT with non-NULL value should succeed");

        let result = executor.execute_sql("INSERT INTO nn_test VALUES (NULL, 'Bob')");
        assert!(
            result.is_err(),
            "INSERT with NULL in NOT NULL column should fail"
        );
    }

    #[test]
    fn test_multiple_not_null_columns() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS multi_nn")
            .unwrap();
        executor
            .execute_sql(
                "CREATE TABLE multi_nn (
                id INT64 NOT NULL,
                name STRING NOT NULL,
                email STRING NOT NULL
            )",
            )
            .unwrap();

        let result =
            executor.execute_sql("INSERT INTO multi_nn VALUES (1, 'Alice', 'alice@test.com')");
        assert!(result.is_ok());

        let result = executor.execute_sql("INSERT INTO multi_nn VALUES (2, NULL, 'bob@test.com')");
        assert!(result.is_err());

        let result = executor.execute_sql("INSERT INTO multi_nn VALUES (3, 'Charlie', NULL)");
        assert!(result.is_err());
    }

    #[test]
    fn test_not_null_with_unique() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS nn_unique")
            .unwrap();
        let result = executor.execute_sql(
            "CREATE TABLE nn_unique (
                id INT64,
                email STRING NOT NULL UNIQUE
            )",
        );

        assert!(
            result.is_ok(),
            "CREATE TABLE with NOT NULL UNIQUE should succeed"
        );
    }
}

mod check_constraint {
    use super::*;

    #[test]
    fn test_create_table_with_check() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS check_test")
            .unwrap();
        let result = executor.execute_sql(
            "CREATE TABLE check_test (
                id INT64,
                age INT64,
                CHECK (age >= 0)
            )",
        );

        assert!(result.is_ok(), "CREATE TABLE with CHECK should succeed");
    }

    #[test]
    fn test_check_enforcement() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS check_test")
            .unwrap();
        executor
            .execute_sql(
                "CREATE TABLE check_test (
                id INT64,
                age INT64,
                CHECK (age >= 0)
            )",
            )
            .unwrap();

        let result = executor.execute_sql("INSERT INTO check_test VALUES (1, 25)");
        assert!(
            result.is_ok(),
            "INSERT with valid CHECK value should succeed"
        );

        let result = executor.execute_sql("INSERT INTO check_test VALUES (2, -1)");
        assert!(
            result.is_err(),
            "INSERT violating CHECK constraint should fail"
        );
    }

    #[test]
    fn test_check_with_null() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS check_test")
            .unwrap();
        executor
            .execute_sql(
                "CREATE TABLE check_test (
                id INT64,
                age INT64,
                CHECK (age >= 0)
            )",
            )
            .unwrap();

        let result = executor.execute_sql("INSERT INTO check_test VALUES (1, NULL)");
        assert!(
            result.is_ok(),
            "NULL should satisfy CHECK constraint (SQL standard)"
        );
    }

    #[test]
    fn test_named_check_constraint() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS named_check")
            .unwrap();
        let result = executor.execute_sql(
            "CREATE TABLE named_check (
                id INT64,
                price FLOAT64,
                CONSTRAINT chk_positive_price CHECK (price > 0)
            )",
        );

        assert!(
            result.is_ok(),
            "CREATE TABLE with named CHECK should succeed"
        );
    }

    #[test]
    fn test_multiple_check_constraints() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS multi_check")
            .unwrap();
        let result = executor.execute_sql(
            "CREATE TABLE multi_check (
                id INT64,
                age INT64,
                salary FLOAT64,
                CHECK (age >= 18),
                CHECK (salary > 0)
            )",
        );

        assert!(
            result.is_ok(),
            "CREATE TABLE with multiple CHECK constraints should succeed"
        );
    }

    #[test]
    fn test_check_comparison_operators() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS check_compare")
            .unwrap();
        executor
            .execute_sql(
                "CREATE TABLE check_compare (
                id INT64,
                min_val INT64,
                max_val INT64,
                CHECK (min_val < max_val)
            )",
            )
            .unwrap();

        let result = executor.execute_sql("INSERT INTO check_compare VALUES (1, 10, 20)");
        assert!(result.is_ok());

        let result = executor.execute_sql("INSERT INTO check_compare VALUES (2, 30, 20)");
        assert!(result.is_err());
    }
}

mod foreign_key_constraint {
    use super::*;

    fn setup_parent_table(executor: &mut QueryExecutor) {
        executor
            .execute_sql("DROP TABLE IF EXISTS child_table")
            .unwrap();
        executor
            .execute_sql("DROP TABLE IF EXISTS parent_table")
            .unwrap();
        executor
            .execute_sql("CREATE TABLE parent_table (id INT64 PRIMARY KEY, name STRING)")
            .unwrap();
        executor
            .execute_sql("INSERT INTO parent_table VALUES (1, 'Parent1'), (2, 'Parent2')")
            .unwrap();
    }

    #[test]
    fn test_create_table_with_foreign_key() {
        let mut executor = create_executor();
        setup_parent_table(&mut executor);

        let result = executor.execute_sql(
            "CREATE TABLE child_table (
                id INT64 PRIMARY KEY,
                parent_id INT64,
                FOREIGN KEY (parent_id) REFERENCES parent_table(id)
            )",
        );

        assert!(
            result.is_ok(),
            "CREATE TABLE with FOREIGN KEY should succeed"
        );
    }

    #[test]
    fn test_column_level_references() {
        let mut executor = create_executor();
        setup_parent_table(&mut executor);

        let result = executor.execute_sql(
            "CREATE TABLE child_table (
                id INT64 PRIMARY KEY,
                parent_id INT64 REFERENCES parent_table(id)
            )",
        );

        assert!(
            result.is_ok(),
            "CREATE TABLE with column-level REFERENCES should succeed"
        );
    }

    #[test]
    fn test_on_delete_cascade() {
        let mut executor = create_executor();
        setup_parent_table(&mut executor);

        let result = executor.execute_sql(
            "CREATE TABLE child_table (
                id INT64 PRIMARY KEY,
                parent_id INT64,
                FOREIGN KEY (parent_id) REFERENCES parent_table(id) ON DELETE CASCADE
            )",
        );

        assert!(
            result.is_ok(),
            "CREATE TABLE with ON DELETE CASCADE should succeed"
        );
    }

    #[test]
    fn test_on_delete_set_null() {
        let mut executor = create_executor();
        setup_parent_table(&mut executor);

        let result = executor.execute_sql(
            "CREATE TABLE child_table (
                id INT64 PRIMARY KEY,
                parent_id INT64,
                FOREIGN KEY (parent_id) REFERENCES parent_table(id) ON DELETE SET NULL
            )",
        );

        assert!(
            result.is_ok(),
            "CREATE TABLE with ON DELETE SET NULL should succeed"
        );
    }

    #[test]
    fn test_on_update_cascade() {
        let mut executor = create_executor();
        setup_parent_table(&mut executor);

        let result = executor.execute_sql(
            "CREATE TABLE child_table (
                id INT64 PRIMARY KEY,
                parent_id INT64,
                FOREIGN KEY (parent_id) REFERENCES parent_table(id) ON UPDATE CASCADE
            )",
        );

        assert!(
            result.is_ok(),
            "CREATE TABLE with ON UPDATE CASCADE should succeed"
        );
    }

    #[test]
    fn test_composite_foreign_key() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS composite_child")
            .unwrap();
        executor
            .execute_sql("DROP TABLE IF EXISTS composite_parent")
            .unwrap();
        executor
            .execute_sql(
                "CREATE TABLE composite_parent (
                tenant_id INT64,
                user_id INT64,
                name STRING,
                PRIMARY KEY (tenant_id, user_id)
            )",
            )
            .unwrap();

        let result = executor.execute_sql(
            "CREATE TABLE composite_child (
                id INT64 PRIMARY KEY,
                tenant_id INT64,
                user_id INT64,
                FOREIGN KEY (tenant_id, user_id) REFERENCES composite_parent(tenant_id, user_id)
            )",
        );

        assert!(
            result.is_ok(),
            "CREATE TABLE with composite FOREIGN KEY should succeed"
        );
    }

    #[test]
    fn test_self_referencing_foreign_key() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS employees")
            .unwrap();
        let result = executor.execute_sql(
            "CREATE TABLE employees (
                id INT64 PRIMARY KEY,
                manager_id INT64,
                name STRING,
                FOREIGN KEY (manager_id) REFERENCES employees(id)
            )",
        );

        assert!(
            result.is_ok(),
            "CREATE TABLE with self-referencing FOREIGN KEY should succeed"
        );
    }

    #[test]
    fn test_multiple_foreign_keys() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS orders").unwrap();
        executor
            .execute_sql("DROP TABLE IF EXISTS customers")
            .unwrap();
        executor
            .execute_sql("DROP TABLE IF EXISTS products")
            .unwrap();

        executor
            .execute_sql("CREATE TABLE customers (id INT64 PRIMARY KEY, name STRING)")
            .unwrap();
        executor
            .execute_sql("CREATE TABLE products (id INT64 PRIMARY KEY, name STRING)")
            .unwrap();

        let result = executor.execute_sql(
            "CREATE TABLE orders (
                id INT64 PRIMARY KEY,
                customer_id INT64,
                product_id INT64,
                FOREIGN KEY (customer_id) REFERENCES customers(id),
                FOREIGN KEY (product_id) REFERENCES products(id)
            )",
        );

        assert!(
            result.is_ok(),
            "CREATE TABLE with multiple FOREIGN KEYs should succeed"
        );
    }
}

mod default_constraint {
    use super::*;

    #[test]
    fn test_create_table_with_default() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS default_test")
            .unwrap();
        let result = executor.execute_sql(
            "CREATE TABLE default_test (
                id INT64,
                status STRING DEFAULT 'active',
                count INT64 DEFAULT 0
            )",
        );

        assert!(result.is_ok(), "CREATE TABLE with DEFAULT should succeed");
    }

    #[test]
    fn test_default_string_value() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS default_test")
            .unwrap();
        executor
            .execute_sql(
                "CREATE TABLE default_test (
                id INT64,
                status STRING DEFAULT 'pending'
            )",
            )
            .unwrap();

        executor
            .execute_sql("INSERT INTO default_test (id) VALUES (1)")
            .unwrap();

        let result = executor
            .execute_sql("SELECT status FROM default_test WHERE id = 1")
            .unwrap();
        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_default_integer_value() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS default_test")
            .unwrap();
        executor
            .execute_sql(
                "CREATE TABLE default_test (
                id INT64,
                count INT64 DEFAULT 0
            )",
            )
            .unwrap();

        executor
            .execute_sql("INSERT INTO default_test (id) VALUES (1)")
            .unwrap();

        let result = executor
            .execute_sql("SELECT count FROM default_test WHERE id = 1")
            .unwrap();
        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_default_boolean_value() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS default_test")
            .unwrap();
        executor
            .execute_sql(
                "CREATE TABLE default_test (
                id INT64,
                active BOOL DEFAULT TRUE
            )",
            )
            .unwrap();

        executor
            .execute_sql("INSERT INTO default_test (id) VALUES (1)")
            .unwrap();

        let result = executor
            .execute_sql("SELECT active FROM default_test WHERE id = 1")
            .unwrap();
        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_explicit_null_overrides_default() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS default_test")
            .unwrap();
        executor
            .execute_sql(
                "CREATE TABLE default_test (
                id INT64,
                status STRING DEFAULT 'active'
            )",
            )
            .unwrap();

        executor
            .execute_sql("INSERT INTO default_test (id, status) VALUES (1, NULL)")
            .unwrap();

        let result = executor
            .execute_sql("SELECT status FROM default_test WHERE id = 1")
            .unwrap();
        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_default_with_not_null() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS default_test")
            .unwrap();
        let result = executor.execute_sql(
            "CREATE TABLE default_test (
                id INT64,
                status STRING NOT NULL DEFAULT 'active'
            )",
        );

        assert!(
            result.is_ok(),
            "CREATE TABLE with NOT NULL DEFAULT should succeed"
        );
    }
}

mod combined_constraints {
    use super::*;

    #[test]
    fn test_all_constraint_types() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS all_constraints")
            .unwrap();
        executor
            .execute_sql("DROP TABLE IF EXISTS departments")
            .unwrap();

        executor
            .execute_sql("CREATE TABLE departments (id INT64 PRIMARY KEY, name STRING)")
            .unwrap();

        let result = executor.execute_sql(
            "CREATE TABLE all_constraints (
                id INT64 PRIMARY KEY,
                email STRING NOT NULL UNIQUE,
                dept_id INT64,
                salary FLOAT64,
                status STRING DEFAULT 'active',
                FOREIGN KEY (dept_id) REFERENCES departments(id),
                CHECK (salary > 0)
            )",
        );

        assert!(
            result.is_ok(),
            "CREATE TABLE with all constraint types should succeed"
        );
    }

    #[test]
    fn test_primary_key_implies_not_null() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS pk_nn_test")
            .unwrap();
        executor
            .execute_sql(
                "CREATE TABLE pk_nn_test (
                id INT64 PRIMARY KEY,
                name STRING
            )",
            )
            .unwrap();

        let result = executor.execute_sql("INSERT INTO pk_nn_test VALUES (NULL, 'Test')");
        assert!(result.is_err(), "PRIMARY KEY should not accept NULL");
    }

    #[test]
    fn test_unique_with_not_null() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS un_nn_test")
            .unwrap();
        executor
            .execute_sql(
                "CREATE TABLE un_nn_test (
                id INT64,
                email STRING NOT NULL UNIQUE
            )",
            )
            .unwrap();

        executor
            .execute_sql("INSERT INTO un_nn_test VALUES (1, 'test@test.com')")
            .unwrap();

        let result = executor.execute_sql("INSERT INTO un_nn_test VALUES (2, NULL)");
        assert!(result.is_err(), "NOT NULL UNIQUE should not accept NULL");

        let result = executor.execute_sql("INSERT INTO un_nn_test VALUES (3, 'test@test.com')");
        assert!(
            result.is_err(),
            "NOT NULL UNIQUE should not accept duplicates"
        );
    }
}

mod basic_select_tests {
    use super::*;

    #[test]
    fn test_null_is_null_and_true() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT NULL IS NULL AND TRUE as result")
            .unwrap();
        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_is_not_null_or_false() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT 5 IS NOT NULL OR FALSE as result")
            .unwrap();
        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_complex_boolean_expression() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT NOT (2 + 3 * 4 - 1) > 10 OR 'test' IS NOT NULL as result")
            .unwrap();
        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_arithmetic_expression() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT 0 * 100 + -5 as result")
            .unwrap();
        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_division_operations() {
        let mut executor = create_executor();
        let result = executor
            .execute_sql("SELECT 42 / 1 as div_one, 42 / 42 as div_self")
            .unwrap();
        assert_eq!(result.num_rows(), 1);
        assert_eq!(result.num_columns(), 2);
    }
}
