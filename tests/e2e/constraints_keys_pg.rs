

use yachtsql::QueryExecutor;
use yachtsql_parser::DialectType;

mod primary_key {
    use super::*;

    #[test]
    fn test_primary_key_single_column() {
        let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

        executor
            .execute_sql("CREATE TABLE users (id INTEGER PRIMARY KEY, name VARCHAR(100))")
            .expect("CREATE TABLE with PRIMARY KEY should succeed");

        executor
            .execute_sql("INSERT INTO users VALUES (1, 'Alice')")
            .expect("INSERT should succeed");

        let result = executor
            .execute_sql("SELECT id, name FROM users")
            .expect("SELECT should succeed");
        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_primary_key_composite() {
        let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

        executor
            .execute_sql(
                "CREATE TABLE orders (
                    order_id INTEGER,
                    line_id INTEGER,
                    product VARCHAR(100),
                    PRIMARY KEY (order_id, line_id)
                )",
            )
            .expect("CREATE TABLE with composite PRIMARY KEY should succeed");

        executor
            .execute_sql("INSERT INTO orders VALUES (1, 1, 'Widget')")
            .expect("INSERT should succeed");

        executor
            .execute_sql("INSERT INTO orders VALUES (1, 2, 'Gadget')")
            .expect("INSERT with different line_id should succeed");


        let result = executor
            .execute_sql("SELECT * FROM orders")
            .expect("SELECT should succeed");
        assert_eq!(result.num_rows(), 2);
    }

    #[test]
    fn test_primary_key_rejects_duplicate() {
        let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

        executor
            .execute_sql("CREATE TABLE users (id INTEGER PRIMARY KEY, name VARCHAR(100))")
            .expect("CREATE TABLE should succeed");

        executor
            .execute_sql("INSERT INTO users VALUES (1, 'Alice')")
            .expect("INSERT should succeed");

        let result = executor.execute_sql("INSERT INTO users VALUES (1, 'Bob')");
        assert!(
            result.is_err(),
            "Should reject duplicate PRIMARY KEY value"
        );
    }

    #[test]
    fn test_primary_key_rejects_null() {
        let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

        executor
            .execute_sql("CREATE TABLE users (id INTEGER PRIMARY KEY, name VARCHAR(100))")
            .expect("CREATE TABLE should succeed");

        let result = executor.execute_sql("INSERT INTO users VALUES (NULL, 'Alice')");
        assert!(result.is_err(), "Should reject NULL in PRIMARY KEY column");
    }
}

mod foreign_key {
    use super::*;

    #[test]
    fn test_foreign_key_inline_references() {
        let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

        executor
            .execute_sql("CREATE TABLE users (id INTEGER PRIMARY KEY, name VARCHAR(100))")
            .expect("CREATE parent table should succeed");

        executor
            .execute_sql(
                "CREATE TABLE orders (
                    id INTEGER PRIMARY KEY,
                    user_id INTEGER REFERENCES users(id)
                )",
            )
            .expect("CREATE TABLE with REFERENCES should succeed");

        executor
            .execute_sql("INSERT INTO users VALUES (1, 'Alice')")
            .expect("INSERT into parent should succeed");

        executor
            .execute_sql("INSERT INTO orders VALUES (100, 1)")
            .expect("INSERT with valid foreign key should succeed");
    }

    #[test]
    fn test_foreign_key_table_constraint() {
        let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

        executor
            .execute_sql("CREATE TABLE users (id INTEGER PRIMARY KEY, name VARCHAR(100))")
            .expect("CREATE parent table should succeed");

        executor
            .execute_sql(
                "CREATE TABLE orders (
                    id INTEGER PRIMARY KEY,
                    user_id INTEGER,
                    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
                )",
            )
            .expect("CREATE TABLE with FOREIGN KEY constraint should succeed");

        executor
            .execute_sql("INSERT INTO users VALUES (1, 'Alice')")
            .expect("INSERT into parent should succeed");

        executor
            .execute_sql("INSERT INTO orders VALUES (100, 1)")
            .expect("INSERT with valid foreign key should succeed");
    }

    #[test]
    fn test_foreign_key_named_constraint() {
        let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

        executor
            .execute_sql("CREATE TABLE users (id INTEGER PRIMARY KEY, name VARCHAR(100))")
            .expect("CREATE parent table should succeed");


        executor
            .execute_sql(
                "CREATE TABLE orders (
                    id INTEGER PRIMARY KEY,
                    user_id INTEGER,
                    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(id)
                        ON UPDATE CASCADE ON DELETE SET NULL
                )",
            )
            .expect("CREATE TABLE with named FOREIGN KEY should succeed");
    }
}

mod unique_constraint {
    use super::*;

    #[test]
    fn test_unique_column_constraint() {
        let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

        executor
            .execute_sql(
                "CREATE TABLE products (
                    id INTEGER PRIMARY KEY,
                    sku VARCHAR(50) UNIQUE
                )",
            )
            .expect("CREATE TABLE with UNIQUE should succeed");

        executor
            .execute_sql("INSERT INTO products VALUES (1, 'SKU-001')")
            .expect("INSERT should succeed");

        let result = executor.execute_sql("INSERT INTO products VALUES (2, 'SKU-001')");
        assert!(result.is_err(), "Should reject duplicate UNIQUE value");
    }

    #[test]
    fn test_unique_composite_constraint() {
        let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

        executor
            .execute_sql(
                "CREATE TABLE products (
                    id INTEGER PRIMARY KEY,
                    category VARCHAR(50),
                    name VARCHAR(100),
                    UNIQUE (category, name)
                )",
            )
            .expect("CREATE TABLE with composite UNIQUE should succeed");

        executor
            .execute_sql("INSERT INTO products VALUES (1, 'Electronics', 'Widget')")
            .expect("INSERT should succeed");


        executor
            .execute_sql("INSERT INTO products VALUES (2, 'Electronics', 'Gadget')")
            .expect("Different name in same category should succeed");


        executor
            .execute_sql("INSERT INTO products VALUES (3, 'Toys', 'Widget')")
            .expect("Same name in different category should succeed");


        let result =
            executor.execute_sql("INSERT INTO products VALUES (4, 'Electronics', 'Widget')");
        assert!(
            result.is_err(),
            "Should reject duplicate (category, name) combination"
        );
    }

    #[test]
    fn test_unique_allows_multiple_nulls() {
        let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

        executor
            .execute_sql(
                "CREATE TABLE products (
                    id INTEGER PRIMARY KEY,
                    sku VARCHAR(50) UNIQUE
                )",
            )
            .expect("CREATE TABLE should succeed");


        executor
            .execute_sql("INSERT INTO products VALUES (1, NULL)")
            .expect("First NULL should succeed");

        executor
            .execute_sql("INSERT INTO products VALUES (2, NULL)")
            .expect("Second NULL should also succeed (SQL standard)");

        let result = executor
            .execute_sql("SELECT * FROM products")
            .expect("SELECT should succeed");
        assert_eq!(result.num_rows(), 2);
    }

    #[test]
    fn test_unique_named_constraint() {
        let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

        executor
            .execute_sql(
                "CREATE TABLE users (
                    id INTEGER PRIMARY KEY,
                    email VARCHAR(255),
                    CONSTRAINT unique_email UNIQUE (email)
                )",
            )
            .expect("CREATE TABLE with named UNIQUE constraint should succeed");
    }
}

mod check_constraint {
    use super::*;

    #[test]
    fn test_check_column_constraint() {
        let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

        executor
            .execute_sql(
                "CREATE TABLE employees (
                    id INTEGER PRIMARY KEY,
                    age INTEGER CHECK (age >= 18)
                )",
            )
            .expect("CREATE TABLE with CHECK should succeed");

        executor
            .execute_sql("INSERT INTO employees VALUES (1, 25)")
            .expect("Valid age should succeed");

        let result = executor.execute_sql("INSERT INTO employees VALUES (2, 16)");
        assert!(result.is_err(), "Should reject age < 18");
    }

    #[test]
    fn test_check_multiple_conditions() {
        let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

        executor
            .execute_sql(
                "CREATE TABLE employees (
                    id INTEGER PRIMARY KEY,
                    age INTEGER CHECK (age >= 18),
                    salary DECIMAL CHECK (salary > 0)
                )",
            )
            .expect("CREATE TABLE with multiple CHECK constraints should succeed");

        executor
            .execute_sql("INSERT INTO employees VALUES (1, 25, 50000)")
            .expect("Valid values should succeed");

        let result = executor.execute_sql("INSERT INTO employees VALUES (2, 25, -1000)");
        assert!(result.is_err(), "Should reject negative salary");
    }

    #[test]
    fn test_check_named_constraint() {
        let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

        executor
            .execute_sql(
                "CREATE TABLE products (
                    id INTEGER PRIMARY KEY,
                    price DECIMAL,
                    CONSTRAINT positive_price CHECK (price > 0)
                )",
            )
            .expect("CREATE TABLE with named CHECK should succeed");
    }

    #[test]
    fn test_check_table_level_constraint() {
        let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

        executor
            .execute_sql(
                "CREATE TABLE date_ranges (
                    id INTEGER PRIMARY KEY,
                    start_date DATE,
                    end_date DATE,
                    CHECK (end_date >= start_date)
                )",
            )
            .expect("CREATE TABLE with table-level CHECK should succeed");
    }
}

mod not_null {
    use super::*;

    #[test]
    fn test_not_null_constraint() {
        let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

        executor
            .execute_sql(
                "CREATE TABLE required_fields (
                    id INTEGER PRIMARY KEY,
                    name VARCHAR(100) NOT NULL,
                    email VARCHAR(255) NOT NULL
                )",
            )
            .expect("CREATE TABLE with NOT NULL should succeed");

        executor
            .execute_sql("INSERT INTO required_fields VALUES (1, 'Alice', 'alice@example.com')")
            .expect("Valid values should succeed");

        let result =
            executor.execute_sql("INSERT INTO required_fields VALUES (2, NULL, 'bob@example.com')");
        assert!(result.is_err(), "Should reject NULL in NOT NULL column");
    }

    #[test]
    fn test_not_null_with_default() {
        let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

        executor
            .execute_sql(
                "CREATE TABLE users (
                    id INTEGER PRIMARY KEY,
                    name VARCHAR(100) NOT NULL,
                    status VARCHAR(20) NOT NULL DEFAULT 'active'
                )",
            )
            .expect("CREATE TABLE with NOT NULL DEFAULT should succeed");


        executor
            .execute_sql("INSERT INTO users (id, name) VALUES (1, 'Alice')")
            .expect("INSERT with default should succeed");
    }
}

mod default_values {
    use super::*;

    #[test]
    fn test_default_literal() {
        let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

        executor
            .execute_sql(
                "CREATE TABLE logs (
                    id INTEGER PRIMARY KEY,
                    message TEXT NOT NULL,
                    level VARCHAR(20) DEFAULT 'INFO'
                )",
            )
            .expect("CREATE TABLE with DEFAULT should succeed");

        executor
            .execute_sql("INSERT INTO logs (id, message) VALUES (1, 'Test message')")
            .expect("INSERT using default should succeed");

        let result = executor
            .execute_sql("SELECT level FROM logs WHERE id = 1")
            .expect("SELECT should succeed");
        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_default_current_timestamp() {
        let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

        executor
            .execute_sql(
                "CREATE TABLE events (
                    id INTEGER PRIMARY KEY,
                    name VARCHAR(100),
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                )",
            )
            .expect("CREATE TABLE with CURRENT_TIMESTAMP default should succeed");

        executor
            .execute_sql("INSERT INTO events (id, name) VALUES (1, 'Test event')")
            .expect("INSERT with timestamp default should succeed");

        let result = executor
            .execute_sql("SELECT created_at FROM events WHERE id = 1")
            .expect("SELECT should succeed");
        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_default_boolean() {
        let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

        executor
            .execute_sql(
                "CREATE TABLE users (
                    id INTEGER PRIMARY KEY,
                    name VARCHAR(100),
                    active BOOLEAN DEFAULT true
                )",
            )
            .expect("CREATE TABLE with boolean default should succeed");

        executor
            .execute_sql("INSERT INTO users (id, name) VALUES (1, 'Alice')")
            .expect("INSERT with boolean default should succeed");
    }
}

mod named_constraints {
    use super::*;

    #[test]
    fn test_named_primary_key() {
        let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

        executor
            .execute_sql(
                "CREATE TABLE data (
                    id INTEGER CONSTRAINT pk_data PRIMARY KEY
                )",
            )
            .expect("CREATE TABLE with named PRIMARY KEY should succeed");
    }

    #[test]
    fn test_named_check_constraint() {
        let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

        executor
            .execute_sql(
                "CREATE TABLE data (
                    id INTEGER PRIMARY KEY,
                    value INTEGER CONSTRAINT chk_positive CHECK (value > 0)
                )",
            )
            .expect("CREATE TABLE with named CHECK should succeed");
    }

    #[test]
    fn test_named_unique_constraint() {
        let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

        executor
            .execute_sql(
                "CREATE TABLE data (
                    id INTEGER PRIMARY KEY,
                    email VARCHAR(255) CONSTRAINT unq_email UNIQUE
                )",
            )
            .expect("CREATE TABLE with named UNIQUE should succeed");
    }

    #[test]
    fn test_multiple_named_constraints() {
        let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

        executor
            .execute_sql(
                "CREATE TABLE data (
                    id INTEGER CONSTRAINT pk_data PRIMARY KEY,
                    value INTEGER CONSTRAINT chk_positive CHECK (value > 0),
                    email VARCHAR(255) CONSTRAINT unq_email UNIQUE
                )",
            )
            .expect("CREATE TABLE with multiple named constraints should succeed");
    }
}

mod integration {
    use super::*;

    #[test]
    fn test_table_with_all_constraint_types() {
        let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);


        executor
            .execute_sql("CREATE TABLE departments (id INTEGER PRIMARY KEY, name VARCHAR(100))")
            .expect("CREATE departments should succeed");

        executor
            .execute_sql("INSERT INTO departments VALUES (1, 'Engineering')")
            .expect("INSERT department should succeed");


        executor
            .execute_sql(
                "CREATE TABLE employees (
                    id INTEGER PRIMARY KEY,
                    email VARCHAR(255) UNIQUE NOT NULL,
                    department_id INTEGER REFERENCES departments(id),
                    salary DECIMAL CHECK (salary > 0),
                    status VARCHAR(20) DEFAULT 'active',
                    name VARCHAR(100) NOT NULL
                )",
            )
            .expect("CREATE TABLE with all constraints should succeed");


        executor
            .execute_sql(
                "INSERT INTO employees (id, email, department_id, salary, name)
                 VALUES (1, 'alice@example.com', 1, 75000, 'Alice')",
            )
            .expect("Valid insert should succeed");


        let result = executor
            .execute_sql("SELECT status FROM employees WHERE id = 1")
            .expect("SELECT should succeed");
        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_constraint_violation_error_messages() {
        let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

        executor
            .execute_sql(
                "CREATE TABLE products (
                    id INTEGER PRIMARY KEY,
                    price DECIMAL CONSTRAINT positive_price CHECK (price > 0)
                )",
            )
            .expect("CREATE TABLE should succeed");

        let result = executor.execute_sql("INSERT INTO products VALUES (1, -50)");
        assert!(result.is_err());

    }
}
