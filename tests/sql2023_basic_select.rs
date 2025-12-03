use yachtsql::{DialectType, QueryExecutor};

fn create_executor() -> QueryExecutor {
    QueryExecutor::with_dialect(DialectType::PostgreSQL)
}

mod equipment {
    use super::*;

    fn setup(executor: &mut QueryExecutor) {
        executor
            .execute_sql("DROP TABLE IF EXISTS equipment")
            .unwrap();
        executor
            .execute_sql("CREATE TABLE equipment (id INT64, name STRING, price FLOAT64)")
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO equipment VALUES
                (1, 'Apple', 1.99),
                (2, 'Banana', 0.99),
                (3, 'Cherry', 2.99),
                (4, 'Date', 3.49)",
            )
            .unwrap();
    }

    #[test]
    fn test_select_all() {
        let mut executor = create_executor();
        setup(&mut executor);

        let result = executor
            .execute_sql("SELECT id, name, price FROM equipment ORDER BY id")
            .expect("SELECT should succeed");

        assert_eq!(result.num_rows(), 4, "Should return 4 rows");
        assert_eq!(result.num_columns(), 3, "Should return 3 columns");
    }

    #[test]
    fn test_filter_price_greater_than() {
        let mut executor = create_executor();
        setup(&mut executor);

        let result = executor
            .execute_sql(
                "SELECT id, name, price FROM equipment WHERE price > 1.5 ORDER BY price DESC, id",
            )
            .expect("SELECT with WHERE should succeed");

        assert_eq!(
            result.num_rows(),
            3,
            "Should return 3 rows with price > 1.5"
        );
    }

    #[test]
    fn test_order_by_with_limit() {
        let mut executor = create_executor();
        setup(&mut executor);

        let result = executor
            .execute_sql("SELECT id, name, price FROM equipment ORDER BY price DESC, id LIMIT 2")
            .expect("SELECT with ORDER BY and LIMIT should succeed");

        assert_eq!(result.num_rows(), 2, "LIMIT 2 should return 2 rows");
    }
}

mod crew_members {
    use super::*;

    fn setup(executor: &mut QueryExecutor) {
        executor
            .execute_sql("DROP TABLE IF EXISTS crew_members")
            .unwrap();
        executor
            .execute_sql(
                "CREATE TABLE crew_members (id INT64, name STRING, age INT64, salary INT64, fleet STRING)",
            )
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO crew_members VALUES
                (1, 'Alice', 30, 60000, 'Engineering'),
                (2, 'Bob', 28, 52000, 'Operations'),
                (3, 'Charlie', 35, 58000, 'Engineering'),
                (4, 'Diana', 30, 61000, 'Command')",
            )
            .unwrap();
    }

    #[test]
    fn test_select_name_salary() {
        let mut executor = create_executor();
        setup(&mut executor);

        let result = executor
            .execute_sql("SELECT name, salary FROM crew_members ORDER BY name")
            .expect("SELECT name, salary should succeed");

        assert_eq!(result.num_rows(), 4);
        assert_eq!(result.num_columns(), 2);
    }

    #[test]
    fn test_filter_age_and_salary() {
        let mut executor = create_executor();
        setup(&mut executor);

        let result = executor
            .execute_sql(
                "SELECT id, name, age, salary FROM crew_members WHERE age = 30 AND salary > 58000 ORDER BY id",
            )
            .expect("SELECT with AND condition should succeed");

        assert_eq!(result.num_rows(), 2, "Should return Alice and Diana");
    }
}

mod users {
    use super::*;

    fn setup(executor: &mut QueryExecutor) {
        executor.execute_sql("DROP TABLE IF EXISTS users").unwrap();
        executor
            .execute_sql("CREATE TABLE users (id INT64, name STRING, age INT64, city STRING)")
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO users VALUES
                (1, 'Alice', 30, 'NYC'),
                (2, 'Bob', 25, 'LA'),
                (3, 'Charlie', 30, 'SF'),
                (4, 'Diana', 27, 'NYC')",
            )
            .unwrap();
    }

    #[test]
    fn test_filter_by_age() {
        let mut executor = create_executor();
        setup(&mut executor);

        let result = executor
            .execute_sql("SELECT id, name, age, city FROM users WHERE age = 30 ORDER BY name")
            .expect("SELECT with WHERE age = 30 should succeed");

        assert_eq!(result.num_rows(), 2, "Should return Alice and Charlie");
    }

    #[test]
    fn test_filter_with_in_clause() {
        let mut executor = create_executor();
        setup(&mut executor);

        let result = executor
            .execute_sql("SELECT id, name, age, city FROM users WHERE city IN ('NYC', 'SF') ORDER BY city, name")
            .expect("SELECT with IN clause should succeed");

        assert_eq!(result.num_rows(), 3, "Should return users in NYC or SF");
    }
}

mod scores {
    use super::*;

    fn setup(executor: &mut QueryExecutor) {
        executor.execute_sql("DROP TABLE IF EXISTS scores").unwrap();
        executor
            .execute_sql("CREATE TABLE scores (name STRING, score INT64)")
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO scores VALUES
                ('Alice', 85),
                ('Bob', 92),
                ('Charlie', 78)",
            )
            .unwrap();
    }

    #[test]
    fn test_order_ascending() {
        let mut executor = create_executor();
        setup(&mut executor);

        let result = executor
            .execute_sql("SELECT name, score FROM scores ORDER BY score ASC, name")
            .expect("ORDER BY ASC should succeed");

        assert_eq!(result.num_rows(), 3);
    }

    #[test]
    fn test_order_descending() {
        let mut executor = create_executor();
        setup(&mut executor);

        let result = executor
            .execute_sql("SELECT name, score FROM scores ORDER BY score DESC, name")
            .expect("ORDER BY DESC should succeed");

        assert_eq!(result.num_rows(), 3);
    }
}

mod numbers {
    use super::*;

    fn setup(executor: &mut QueryExecutor) {
        executor
            .execute_sql("DROP TABLE IF EXISTS numbers")
            .unwrap();
        executor
            .execute_sql("CREATE TABLE numbers (value INT64)")
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO numbers VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10)",
            )
            .unwrap();
    }

    #[test]
    fn test_limit() {
        let mut executor = create_executor();
        setup(&mut executor);

        let result = executor
            .execute_sql("SELECT value FROM numbers ORDER BY value LIMIT 5")
            .expect("SELECT with LIMIT should succeed");

        assert_eq!(result.num_rows(), 5, "LIMIT 5 should return 5 rows");
    }
}

mod empty_table {
    use super::*;

    #[test]
    fn test_select_from_empty_table() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS empty_table")
            .unwrap();
        executor
            .execute_sql("CREATE TABLE empty_table (id INT64, name STRING)")
            .unwrap();

        let result = executor
            .execute_sql("SELECT id, name FROM empty_table")
            .expect("SELECT from empty table should succeed");

        assert_eq!(result.num_rows(), 0, "Empty table should return 0 rows");
        assert_eq!(
            result.num_columns(),
            2,
            "Should still have 2 columns in schema"
        );
    }
}

mod null_values {
    use super::*;

    fn setup(executor: &mut QueryExecutor) {
        executor
            .execute_sql("DROP TABLE IF EXISTS nullable_values")
            .unwrap();
        executor
            .execute_sql("CREATE TABLE nullable_values (id INT64, value STRING)")
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO nullable_values VALUES
                (1, 'hello'),
                (2, NULL),
                (3, 'world')",
            )
            .unwrap();
    }

    #[test]
    fn test_select_with_nulls() {
        let mut executor = create_executor();
        setup(&mut executor);

        let result = executor
            .execute_sql("SELECT id, value FROM nullable_values ORDER BY id")
            .expect("SELECT with NULL values should succeed");

        assert_eq!(result.num_rows(), 3);
    }

    #[test]
    fn test_filter_is_null() {
        let mut executor = create_executor();
        setup(&mut executor);

        let result = executor
            .execute_sql("SELECT id, value FROM nullable_values WHERE value IS NULL")
            .expect("SELECT with IS NULL should succeed");

        assert_eq!(result.num_rows(), 1, "Should return 1 row with NULL value");
    }

    #[test]
    fn test_filter_is_not_null() {
        let mut executor = create_executor();
        setup(&mut executor);

        let result = executor
            .execute_sql(
                "SELECT id, value FROM nullable_values WHERE value IS NOT NULL ORDER BY id",
            )
            .expect("SELECT with IS NOT NULL should succeed");

        assert_eq!(
            result.num_rows(),
            2,
            "Should return 2 rows with non-NULL values"
        );
    }
}

mod multiple_conditions {
    use super::*;

    fn setup(executor: &mut QueryExecutor) {
        executor
            .execute_sql("DROP TABLE IF EXISTS products")
            .unwrap();
        executor
            .execute_sql(
                "CREATE TABLE products (id INT64, name STRING, price FLOAT64, category STRING, in_stock BOOL)",
            )
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO products VALUES
                (1, 'Laptop', 999.99, 'Electronics', true),
                (2, 'Mouse', 29.99, 'Electronics', true),
                (3, 'Desk', 199.99, 'Furniture', false),
                (4, 'Chair', 149.99, 'Furniture', true),
                (5, 'Monitor', 299.99, 'Electronics', false)",
            )
            .unwrap();
    }

    #[test]
    fn test_and_condition() {
        let mut executor = create_executor();
        setup(&mut executor);

        let result = executor
            .execute_sql(
                "SELECT id, name FROM products WHERE category = 'Electronics' AND in_stock = true ORDER BY id",
            )
            .expect("SELECT with AND should succeed");

        assert_eq!(result.num_rows(), 2, "Should return Laptop and Mouse");
    }

    #[test]
    fn test_or_condition() {
        let mut executor = create_executor();
        setup(&mut executor);

        let result = executor
            .execute_sql(
                "SELECT id, name FROM products WHERE category = 'Furniture' OR price < 50 ORDER BY id",
            )
            .expect("SELECT with OR should succeed");

        assert_eq!(result.num_rows(), 3, "Should return Mouse, Desk, and Chair");
    }

    #[test]
    fn test_between() {
        let mut executor = create_executor();
        setup(&mut executor);

        let result = executor
            .execute_sql("SELECT id, name, price FROM products WHERE price BETWEEN 100 AND 500 ORDER BY price")
            .expect("SELECT with BETWEEN should succeed");

        assert_eq!(
            result.num_rows(),
            3,
            "Should return Chair, Desk, and Monitor"
        );
    }

    #[test]
    fn test_not_in() {
        let mut executor = create_executor();
        setup(&mut executor);

        let result = executor
            .execute_sql("SELECT id, name FROM products WHERE id NOT IN (1, 3, 5) ORDER BY id")
            .expect("SELECT with NOT IN should succeed");

        assert_eq!(result.num_rows(), 2, "Should return Mouse and Chair");
    }
}

mod string_operations {
    use super::*;

    fn setup(executor: &mut QueryExecutor) {
        executor.execute_sql("DROP TABLE IF EXISTS names").unwrap();
        executor
            .execute_sql("CREATE TABLE names (id INT64, name STRING)")
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO names VALUES
                (1, 'Alice'),
                (2, 'Bob'),
                (3, 'Charlie'),
                (4, 'David'),
                (5, 'Eve')",
            )
            .unwrap();
    }

    #[test]
    fn test_like_prefix() {
        let mut executor = create_executor();
        setup(&mut executor);

        let result = executor
            .execute_sql("SELECT id, name FROM names WHERE name LIKE 'A%' ORDER BY id")
            .expect("SELECT with LIKE prefix should succeed");

        assert_eq!(result.num_rows(), 1, "Should return Alice");
    }

    #[test]
    fn test_like_suffix() {
        let mut executor = create_executor();
        setup(&mut executor);

        let result = executor
            .execute_sql("SELECT id, name FROM names WHERE name LIKE '%e' ORDER BY id")
            .expect("SELECT with LIKE suffix should succeed");

        assert_eq!(result.num_rows(), 3, "Should return Alice, Charlie, Eve");
    }

    #[test]
    fn test_like_contains() {
        let mut executor = create_executor();
        setup(&mut executor);

        let result = executor
            .execute_sql("SELECT id, name FROM names WHERE name LIKE '%a%' ORDER BY id")
            .expect("SELECT with LIKE contains should succeed");

        assert!(result.num_rows() >= 1, "Should return names containing 'a'");
    }
}

mod arithmetic {
    use super::*;

    fn setup(executor: &mut QueryExecutor) {
        executor.execute_sql("DROP TABLE IF EXISTS prices").unwrap();
        executor
            .execute_sql("CREATE TABLE prices (id INT64, base_price FLOAT64, quantity INT64)")
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO prices VALUES
                (1, 10.00, 5),
                (2, 25.50, 2),
                (3, 100.00, 1)",
            )
            .unwrap();
    }

    #[test]
    fn test_multiplication() {
        let mut executor = create_executor();
        setup(&mut executor);

        let result = executor
            .execute_sql("SELECT id, base_price * quantity AS total FROM prices ORDER BY id")
            .expect("SELECT with multiplication should succeed");

        assert_eq!(result.num_rows(), 3);
        assert_eq!(result.num_columns(), 2);
    }

    #[test]
    fn test_addition() {
        let mut executor = create_executor();
        setup(&mut executor);

        let result = executor
            .execute_sql("SELECT id, base_price + 10 AS adjusted_price FROM prices ORDER BY id")
            .expect("SELECT with addition should succeed");

        assert_eq!(result.num_rows(), 3);
    }

    #[test]
    fn test_complex_expression() {
        let mut executor = create_executor();
        setup(&mut executor);

        let result = executor
            .execute_sql(
                "SELECT id, (base_price * quantity) * 1.1 AS total_with_tax FROM prices ORDER BY id",
            )
            .expect("SELECT with complex expression should succeed");

        assert_eq!(result.num_rows(), 3);
    }
}
