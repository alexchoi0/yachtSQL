

use yachtsql::QueryExecutor;
use yachtsql_parser::DialectType;

mod primary_key {
    use super::*;

    #[test]
    fn test_primary_key_single_column() {
        let mut executor = QueryExecutor::with_dialect(DialectType::ClickHouse);


        executor
            .execute_sql("CREATE TABLE users (id Int64 PRIMARY KEY, name String)")
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
        let mut executor = QueryExecutor::with_dialect(DialectType::ClickHouse);


        executor
            .execute_sql(
                "CREATE TABLE orders (
                    order_id Int64,
                    line_id Int64,
                    product String,
                    PRIMARY KEY (order_id, line_id)
                )",
            )
            .expect("CREATE TABLE with composite PRIMARY KEY should succeed");

        executor
            .execute_sql("INSERT INTO orders VALUES (1, 1, 'Widget')")
            .expect("INSERT should succeed");

        executor
            .execute_sql("INSERT INTO orders VALUES (1, 2, 'Gadget')")
            .expect("INSERT with same order_id, different line_id should succeed");
    }

    #[test]
    fn test_primary_key_with_order_by() {
        let mut executor = QueryExecutor::with_dialect(DialectType::ClickHouse);


        executor
            .execute_sql(
                "CREATE TABLE events (
                    event_date Date,
                    event_id Int64,
                    event_type String,
                    PRIMARY KEY (event_date, event_id)
                )",
            )
            .expect("CREATE TABLE with date-based PRIMARY KEY should succeed");
    }
}

mod not_null {
    use super::*;

    #[test]
    fn test_non_nullable_column() {
        let mut executor = QueryExecutor::with_dialect(DialectType::ClickHouse);


        executor
            .execute_sql(
                "CREATE TABLE required_fields (
                    id Int64,
                    name String,
                    email String
                )",
            )
            .expect("CREATE TABLE with non-nullable columns should succeed");

        executor
            .execute_sql("INSERT INTO required_fields VALUES (1, 'Alice', 'alice@example.com')")
            .expect("Valid values should succeed");
    }

    #[test]
    fn test_nullable_column() {
        let mut executor = QueryExecutor::with_dialect(DialectType::ClickHouse);


        executor
            .execute_sql(
                "CREATE TABLE users (
                    id Int64,
                    name String,
                    phone Nullable(String)
                )",
            )
            .expect("CREATE TABLE with Nullable should succeed");

        executor
            .execute_sql("INSERT INTO users VALUES (1, 'Alice', NULL)")
            .expect("INSERT NULL into Nullable column should succeed");
    }

    #[test]
    fn test_explicit_not_null() {
        let mut executor = QueryExecutor::with_dialect(DialectType::ClickHouse);


        executor
            .execute_sql(
                "CREATE TABLE data (
                    id Int64 NOT NULL,
                    value String NOT NULL
                )",
            )
            .expect("CREATE TABLE with explicit NOT NULL should succeed");
    }
}

mod default_values {
    use super::*;

    #[test]
    fn test_default_literal() {
        let mut executor = QueryExecutor::with_dialect(DialectType::ClickHouse);

        executor
            .execute_sql(
                "CREATE TABLE logs (
                    id Int64,
                    message String,
                    level String DEFAULT 'INFO'
                )",
            )
            .expect("CREATE TABLE with DEFAULT should succeed");


        executor
            .execute_sql("INSERT INTO logs (id, message) VALUES (1, 'Test message')")
            .expect("INSERT using default should succeed");
    }

    #[test]
    fn test_default_now() {
        let mut executor = QueryExecutor::with_dialect(DialectType::ClickHouse);


        executor
            .execute_sql(
                "CREATE TABLE events (
                    id Int64,
                    name String,
                    created_at DateTime DEFAULT now()
                )",
            )
            .expect("CREATE TABLE with now() default should succeed");
    }

    #[test]
    fn test_default_numeric() {
        let mut executor = QueryExecutor::with_dialect(DialectType::ClickHouse);

        executor
            .execute_sql(
                "CREATE TABLE counters (
                    id Int64,
                    name String,
                    count Int64 DEFAULT 0
                )",
            )
            .expect("CREATE TABLE with numeric default should succeed");

        executor
            .execute_sql("INSERT INTO counters (id, name) VALUES (1, 'page_views')")
            .expect("INSERT with numeric default should succeed");
    }

    #[test]
    fn test_default_expression() {
        let mut executor = QueryExecutor::with_dialect(DialectType::ClickHouse);


        executor
            .execute_sql(
                "CREATE TABLE dates (
                    id Int64,
                    created_date Date DEFAULT today()
                )",
            )
            .expect("CREATE TABLE with expression default should succeed");
    }
}

mod check_constraint {
    use super::*;

    #[test]
    fn test_check_constraint_syntax() {
        let mut executor = QueryExecutor::with_dialect(DialectType::ClickHouse);


        executor
            .execute_sql(
                "CREATE TABLE employees (
                    id Int64,
                    age Int64 CHECK (age >= 18)
                )",
            )
            .expect("CREATE TABLE with CHECK should succeed (syntax parsing)");
    }

    #[test]
    fn test_check_named_constraint() {
        let mut executor = QueryExecutor::with_dialect(DialectType::ClickHouse);

        executor
            .execute_sql(
                "CREATE TABLE products (
                    id Int64,
                    price Float64,
                    CONSTRAINT positive_price CHECK (price > 0)
                )",
            )
            .expect("CREATE TABLE with named CHECK should succeed");
    }

    #[test]
    fn test_check_multiple_constraints() {
        let mut executor = QueryExecutor::with_dialect(DialectType::ClickHouse);

        executor
            .execute_sql(
                "CREATE TABLE data (
                    id Int64,
                    value Int64 CHECK (value > 0),
                    percentage Float64 CHECK (percentage >= 0 AND percentage <= 100)
                )",
            )
            .expect("CREATE TABLE with multiple CHECK constraints should succeed");
    }
}

mod unique_constraint {
    use super::*;

    #[test]
    fn test_unique_syntax_parsing() {
        let mut executor = QueryExecutor::with_dialect(DialectType::ClickHouse);


        executor
            .execute_sql(
                "CREATE TABLE products (
                    id Int64,
                    sku String UNIQUE
                )",
            )
            .expect("CREATE TABLE with UNIQUE should parse successfully");
    }

    #[test]
    fn test_unique_composite() {
        let mut executor = QueryExecutor::with_dialect(DialectType::ClickHouse);

        executor
            .execute_sql(
                "CREATE TABLE products (
                    id Int64,
                    category String,
                    name String,
                    UNIQUE (category, name)
                )",
            )
            .expect("CREATE TABLE with composite UNIQUE should parse");
    }
}

mod integration {
    use super::*;

    #[test]
    fn test_table_with_multiple_features() {
        let mut executor = QueryExecutor::with_dialect(DialectType::ClickHouse);

        executor
            .execute_sql(
                "CREATE TABLE analytics (
                    event_date Date,
                    event_id Int64,
                    user_id Nullable(Int64),
                    event_type String DEFAULT 'unknown',
                    value Float64 CHECK (value >= 0),
                    PRIMARY KEY (event_date, event_id)
                )",
            )
            .expect("CREATE TABLE with multiple features should succeed");

        executor
            .execute_sql("INSERT INTO analytics VALUES ('2024-01-15', 1, 100, 'click', 1.5)")
            .expect("INSERT should succeed");

        executor
            .execute_sql("INSERT INTO analytics VALUES ('2024-01-15', 2, NULL, 'view', 0.0)")
            .expect("INSERT with NULL user_id should succeed");
    }

    #[test]
    fn test_clickhouse_specific_types_with_defaults() {
        let mut executor = QueryExecutor::with_dialect(DialectType::ClickHouse);

        executor
            .execute_sql(
                "CREATE TABLE metrics (
                    id Int64,
                    name LowCardinality(String),
                    tags Array(String) DEFAULT [],
                    created_at DateTime64(3) DEFAULT now64(3)
                )",
            )
            .expect("CREATE TABLE with ClickHouse-specific types should succeed");
    }

    #[test]
    fn test_basic_data_operations() {
        let mut executor = QueryExecutor::with_dialect(DialectType::ClickHouse);

        executor
            .execute_sql(
                "CREATE TABLE test_data (
                    id Int64,
                    name String NOT NULL,
                    value Float64 DEFAULT 0.0
                )",
            )
            .expect("CREATE TABLE should succeed");


        executor
            .execute_sql("INSERT INTO test_data VALUES (1, 'first', 10.5)")
            .expect("INSERT should succeed");

        executor
            .execute_sql("INSERT INTO test_data (id, name) VALUES (2, 'second')")
            .expect("INSERT with default should succeed");

        let result = executor
            .execute_sql("SELECT * FROM test_data ORDER BY id")
            .expect("SELECT should succeed");
        assert_eq!(result.num_rows(), 2);
    }
}
