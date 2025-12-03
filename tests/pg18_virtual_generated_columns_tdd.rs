mod common;

use common::{get_f64, get_i64, get_string, is_null};
use yachtsql::{DialectType, QueryExecutor};

fn create_executor() -> QueryExecutor {
    QueryExecutor::with_dialect(DialectType::PostgreSQL)
}

mod virtual_column_basic {
    use super::*;

    #[test]
    fn test_create_table_with_virtual_column_explicit() {
        let mut executor = create_executor();

        let result = executor.execute_sql(
            "CREATE TABLE products (
                price DECIMAL(10,2),
                quantity INT,
                total DECIMAL(10,2) GENERATED ALWAYS AS (price * quantity) VIRTUAL
            )",
        );
        assert!(
            result.is_ok(),
            "CREATE TABLE with VIRTUAL column should succeed: {:?}",
            result.err()
        );
    }

    #[test]
    fn test_create_table_with_virtual_column_implicit() {
        let mut executor = create_executor();

        let result = executor.execute_sql(
            "CREATE TABLE items (
                base_price DECIMAL(10,2),
                tax_rate DECIMAL(5,2),
                total_price DECIMAL(10,2) GENERATED ALWAYS AS (base_price * (1 + tax_rate))
            )",
        );
        assert!(
            result.is_ok(),
            "CREATE TABLE with implicit VIRTUAL column should succeed: {:?}",
            result.err()
        );
    }

    #[test]
    fn test_virtual_column_computed_on_select() {
        let mut executor = create_executor();

        executor
            .execute_sql(
                "CREATE TABLE orders (
                    unit_price DECIMAL(10,2),
                    qty INT,
                    line_total DECIMAL(10,2) GENERATED ALWAYS AS (unit_price * qty) VIRTUAL
                )",
            )
            .expect("CREATE TABLE should succeed");

        executor
            .execute_sql("INSERT INTO orders (unit_price, qty) VALUES (10.00, 5)")
            .expect("INSERT should succeed");

        let result = executor
            .execute_sql("SELECT unit_price, qty, line_total FROM orders")
            .expect("SELECT should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_f64(&result, 2, 0), 50.0);
    }

    #[test]
    fn test_virtual_column_with_string_expression() {
        let mut executor = create_executor();

        executor
            .execute_sql(
                "CREATE TABLE users (
                    first_name TEXT,
                    last_name TEXT,
                    full_name TEXT GENERATED ALWAYS AS (first_name || ' ' || last_name) VIRTUAL
                )",
            )
            .expect("CREATE TABLE should succeed");

        executor
            .execute_sql("INSERT INTO users (first_name, last_name) VALUES ('John', 'Doe')")
            .expect("INSERT should succeed");

        let result = executor
            .execute_sql("SELECT full_name FROM users")
            .expect("SELECT should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_string(&result, 0, 0), "John Doe");
    }
}

mod virtual_vs_stored {
    use super::*;

    #[test]
    fn test_stored_column_still_works() {
        let mut executor = create_executor();

        let result = executor.execute_sql(
            "CREATE TABLE legacy_products (
                price DECIMAL(10,2),
                quantity INT,
                total DECIMAL(10,2) GENERATED ALWAYS AS (price * quantity) STORED
            )",
        );
        assert!(
            result.is_ok(),
            "CREATE TABLE with STORED column should succeed: {:?}",
            result.err()
        );
    }

    #[test]
    fn test_virtual_column_reflects_updated_values() {
        let mut executor = create_executor();

        executor
            .execute_sql(
                "CREATE TABLE inventory (
                    item_count INT,
                    item_price DECIMAL(10,2),
                    total_value DECIMAL(10,2) GENERATED ALWAYS AS (item_count * item_price) VIRTUAL
                )",
            )
            .expect("CREATE TABLE should succeed");

        executor
            .execute_sql("INSERT INTO inventory (item_count, item_price) VALUES (10, 5.00)")
            .expect("INSERT should succeed");

        let result = executor
            .execute_sql("SELECT total_value FROM inventory")
            .expect("SELECT should succeed");
        assert_eq!(get_f64(&result, 0, 0), 50.0);

        executor
            .execute_sql("UPDATE inventory SET item_count = 20")
            .expect("UPDATE should succeed");

        let result = executor
            .execute_sql("SELECT total_value FROM inventory")
            .expect("SELECT should succeed");
        assert_eq!(get_f64(&result, 0, 0), 100.0);
    }
}

mod virtual_column_restrictions {
    use super::*;

    #[test]
    fn test_cannot_insert_into_virtual_column() {
        let mut executor = create_executor();

        executor
            .execute_sql(
                "CREATE TABLE calc (
                    a INT,
                    b INT,
                    sum_ab INT GENERATED ALWAYS AS (a + b) VIRTUAL
                )",
            )
            .expect("CREATE TABLE should succeed");

        let result = executor.execute_sql("INSERT INTO calc (a, b, sum_ab) VALUES (1, 2, 999)");

        assert!(result.is_err(), "INSERT into virtual column should fail");
    }

    #[test]
    fn test_cannot_update_virtual_column() {
        let mut executor = create_executor();

        executor
            .execute_sql(
                "CREATE TABLE calc2 (
                    x INT,
                    y INT,
                    product INT GENERATED ALWAYS AS (x * y) VIRTUAL
                )",
            )
            .expect("CREATE TABLE should succeed");

        executor
            .execute_sql("INSERT INTO calc2 (x, y) VALUES (3, 4)")
            .expect("INSERT should succeed");

        let result = executor.execute_sql("UPDATE calc2 SET product = 999");

        assert!(result.is_err(), "UPDATE of virtual column should fail");
    }

    #[test]
    fn test_virtual_column_not_in_insert_column_list() {
        let mut executor = create_executor();

        executor
            .execute_sql(
                "CREATE TABLE test_insert (
                    val INT,
                    doubled INT GENERATED ALWAYS AS (val * 2) VIRTUAL
                )",
            )
            .expect("CREATE TABLE should succeed");

        let result = executor.execute_sql("INSERT INTO test_insert (val) VALUES (5)");
        assert!(
            result.is_ok(),
            "INSERT without virtual column should succeed: {:?}",
            result.err()
        );

        let result = executor
            .execute_sql("SELECT val, doubled FROM test_insert")
            .expect("SELECT should succeed");
        assert_eq!(get_i64(&result, 0, 0), 5);
        assert_eq!(get_i64(&result, 1, 0), 10);
    }
}

mod virtual_column_expressions {
    use super::*;

    #[test]
    fn test_virtual_column_with_case_expression() {
        let mut executor = create_executor();

        executor
            .execute_sql(
                "CREATE TABLE grades (
                    score INT,
                    letter_grade TEXT GENERATED ALWAYS AS (
                        CASE
                            WHEN score >= 90 THEN 'A'
                            WHEN score >= 80 THEN 'B'
                            WHEN score >= 70 THEN 'C'
                            WHEN score >= 60 THEN 'D'
                            ELSE 'F'
                        END
                    ) VIRTUAL
                )",
            )
            .expect("CREATE TABLE should succeed");

        executor
            .execute_sql("INSERT INTO grades (score) VALUES (95), (82), (71), (55)")
            .expect("INSERT should succeed");

        let result = executor
            .execute_sql("SELECT score, letter_grade FROM grades ORDER BY score DESC")
            .expect("SELECT should succeed");

        assert_eq!(result.num_rows(), 4);
        assert_eq!(get_string(&result, 1, 0), "A");
        assert_eq!(get_string(&result, 1, 1), "B");
        assert_eq!(get_string(&result, 1, 2), "C");
        assert_eq!(get_string(&result, 1, 3), "F");
    }

    #[test]
    fn test_virtual_column_with_function_call() {
        let mut executor = create_executor();

        executor
            .execute_sql(
                "CREATE TABLE lengths (
                    text_val TEXT,
                    text_length INT GENERATED ALWAYS AS (LENGTH(text_val)) VIRTUAL
                )",
            )
            .expect("CREATE TABLE should succeed");

        executor
            .execute_sql("INSERT INTO lengths (text_val) VALUES ('hello'), ('world!')")
            .expect("INSERT should succeed");

        let result = executor
            .execute_sql("SELECT text_val, text_length FROM lengths ORDER BY text_length")
            .expect("SELECT should succeed");

        assert_eq!(result.num_rows(), 2);
        assert_eq!(get_i64(&result, 1, 0), 5);
        assert_eq!(get_i64(&result, 1, 1), 6);
    }

    #[test]
    fn test_virtual_column_with_coalesce() {
        let mut executor = create_executor();

        executor
            .execute_sql(
                "CREATE TABLE with_defaults (
                    name TEXT,
                    nickname TEXT,
                    display_name TEXT GENERATED ALWAYS AS (COALESCE(nickname, name)) VIRTUAL
                )",
            )
            .expect("CREATE TABLE should succeed");

        executor
            .execute_sql("INSERT INTO with_defaults (name, nickname) VALUES ('Robert', 'Bob'), ('Alice', NULL)")
            .expect("INSERT should succeed");

        let result = executor
            .execute_sql("SELECT name, display_name FROM with_defaults ORDER BY name")
            .expect("SELECT should succeed");

        assert_eq!(result.num_rows(), 2);
        assert_eq!(get_string(&result, 1, 0), "Alice");
        assert_eq!(get_string(&result, 1, 1), "Bob");
    }
}

mod virtual_column_nulls {
    use super::*;

    #[test]
    fn test_virtual_column_with_null_input() {
        let mut executor = create_executor();

        executor
            .execute_sql(
                "CREATE TABLE nullable (
                    a INT,
                    b INT,
                    sum_ab INT GENERATED ALWAYS AS (a + b) VIRTUAL
                )",
            )
            .expect("CREATE TABLE should succeed");

        executor
            .execute_sql("INSERT INTO nullable (a, b) VALUES (1, NULL)")
            .expect("INSERT should succeed");

        let result = executor
            .execute_sql("SELECT a, b, sum_ab FROM nullable")
            .expect("SELECT should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64(&result, 0, 0), 1);
        assert!(is_null(&result, 1, 0));
        assert!(is_null(&result, 2, 0));
    }

    #[test]
    fn test_virtual_column_is_null_check() {
        let mut executor = create_executor();

        executor
            .execute_sql(
                "CREATE TABLE test_null_check (
                    val INT,
                    doubled INT GENERATED ALWAYS AS (val * 2) VIRTUAL
                )",
            )
            .expect("CREATE TABLE should succeed");

        executor
            .execute_sql("INSERT INTO test_null_check (val) VALUES (5), (NULL)")
            .expect("INSERT should succeed");

        let result = executor
            .execute_sql("SELECT val FROM test_null_check WHERE doubled IS NULL")
            .expect("SELECT should succeed");

        assert_eq!(result.num_rows(), 1);
        assert!(is_null(&result, 0, 0));
    }
}

mod virtual_column_edge_cases {
    use super::*;

    #[test]
    fn test_multiple_virtual_columns() {
        let mut executor = create_executor();

        executor
            .execute_sql(
                "CREATE TABLE multi_virtual (
                    a INT,
                    b INT,
                    sum_ab INT GENERATED ALWAYS AS (a + b) VIRTUAL,
                    diff_ab INT GENERATED ALWAYS AS (a - b) VIRTUAL,
                    prod_ab INT GENERATED ALWAYS AS (a * b) VIRTUAL
                )",
            )
            .expect("CREATE TABLE should succeed");

        executor
            .execute_sql("INSERT INTO multi_virtual (a, b) VALUES (10, 3)")
            .expect("INSERT should succeed");

        let result = executor
            .execute_sql("SELECT sum_ab, diff_ab, prod_ab FROM multi_virtual")
            .expect("SELECT should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64(&result, 0, 0), 13);
        assert_eq!(get_i64(&result, 1, 0), 7);
        assert_eq!(get_i64(&result, 2, 0), 30);
    }

    #[test]
    fn test_virtual_column_in_where_clause() {
        let mut executor = create_executor();

        executor
            .execute_sql(
                "CREATE TABLE filterable (
                    price DECIMAL(10,2),
                    qty INT,
                    total DECIMAL(10,2) GENERATED ALWAYS AS (price * qty) VIRTUAL
                )",
            )
            .expect("CREATE TABLE should succeed");

        executor
            .execute_sql(
                "INSERT INTO filterable (price, qty) VALUES (10.00, 5), (20.00, 2), (5.00, 10)",
            )
            .expect("INSERT should succeed");

        let result = executor
            .execute_sql(
                "SELECT price, qty, total FROM filterable WHERE total >= 50 ORDER BY total",
            )
            .expect("SELECT with WHERE on virtual column should succeed");

        assert_eq!(result.num_rows(), 2);
        assert_eq!(get_f64(&result, 2, 0), 50.0);
        assert_eq!(get_f64(&result, 2, 1), 50.0);
    }

    #[test]
    fn test_virtual_column_in_order_by() {
        let mut executor = create_executor();

        executor
            .execute_sql(
                "CREATE TABLE sortable (
                    name TEXT,
                    score INT,
                    grade TEXT GENERATED ALWAYS AS (
                        CASE WHEN score >= 90 THEN 'A' ELSE 'B' END
                    ) VIRTUAL
                )",
            )
            .expect("CREATE TABLE should succeed");

        executor
            .execute_sql("INSERT INTO sortable (name, score) VALUES ('Alice', 95), ('Bob', 85), ('Carol', 92)")
            .expect("INSERT should succeed");

        let result = executor
            .execute_sql("SELECT name, grade FROM sortable ORDER BY grade, name")
            .expect("SELECT with ORDER BY virtual column should succeed");

        assert_eq!(result.num_rows(), 3);

        assert_eq!(get_string(&result, 0, 0), "Alice");
        assert_eq!(get_string(&result, 0, 1), "Carol");
        assert_eq!(get_string(&result, 0, 2), "Bob");
    }
}
