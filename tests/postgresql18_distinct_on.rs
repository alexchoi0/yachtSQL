mod common;

use common::{assert_batch_eq, build_batch};
use yachtsql::{DialectType, QueryExecutor, Value};

fn create_executor() -> QueryExecutor {
    QueryExecutor::with_dialect(DialectType::PostgreSQL)
}

mod basic_distinct_on {
    use super::*;

    #[test]
    fn test_simple_distinct_on() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS simple_test")
            .unwrap();
        executor
            .execute_sql("CREATE TABLE simple_test (id INT64, cat STRING)")
            .unwrap();
        executor
            .execute_sql("INSERT INTO simple_test VALUES (1, 'A'), (2, 'A'), (3, 'B')")
            .unwrap();

        let all_rows = executor
            .execute_sql("SELECT id, cat FROM simple_test ORDER BY cat, id")
            .expect("Basic SELECT should succeed");
        assert_eq!(all_rows.num_rows(), 3, "Should have 3 rows total");

        let result = executor
            .execute_sql("SELECT DISTINCT ON (cat) id, cat FROM simple_test ORDER BY cat, id")
            .expect("DISTINCT ON should succeed");

        eprintln!(
            "[test::distinct_on] DISTINCT ON result: {} rows",
            result.num_rows()
        );

        assert_eq!(
            result.num_rows(),
            2,
            "Should return 2 rows (one per category)"
        );
    }

    #[test]
    fn test_single_column_distinct_on() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS events").unwrap();
        executor
            .execute_sql(
                "CREATE TABLE events (id INT64, user_id INT64, action STRING, timestamp INT64)",
            )
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO events VALUES
                (1, 1, 'login', 100),
                (2, 1, 'click', 200),
                (3, 2, 'login', 150),
                (4, 2, 'logout', 300)",
            )
            .unwrap();

        let result = executor
            .execute_sql(
                "SELECT DISTINCT ON (user_id) user_id, action, timestamp
                FROM events
                ORDER BY user_id, timestamp DESC",
            )
            .expect("DISTINCT ON should succeed");

        assert_eq!(result.num_rows(), 2, "Should return 2 rows (one per user)");
    }

    #[test]
    fn test_distinct_on_first_row_per_group() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS prices").unwrap();
        executor
            .execute_sql(
                "CREATE TABLE prices (id INT64, product STRING, date INT64, price FLOAT64)",
            )
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO prices VALUES
                (1, 'widget', 1, 10.0),
                (2, 'widget', 2, 12.0),
                (3, 'widget', 3, 11.0),
                (4, 'gadget', 1, 20.0),
                (5, 'gadget', 2, 18.0)",
            )
            .unwrap();

        let result = executor
            .execute_sql(
                "SELECT DISTINCT ON (product) product, price, date
                FROM prices
                ORDER BY product, date ASC",
            )
            .expect("DISTINCT ON should succeed");

        assert_eq!(
            result.num_rows(),
            2,
            "Should return 2 rows (one per product)"
        );
    }

    #[test]
    fn test_multiple_distinct_on_columns() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS sales").unwrap();
        executor
            .execute_sql(
                "CREATE TABLE sales (id INT64, region STRING, product STRING, amount FLOAT64, date INT64)",
            )
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO sales VALUES
                (1, 'North', 'widget', 100.0, 1),
                (2, 'North', 'widget', 150.0, 2),
                (3, 'North', 'gadget', 200.0, 1),
                (4, 'South', 'widget', 120.0, 1),
                (5, 'South', 'widget', 110.0, 2)",
            )
            .unwrap();

        let result = executor
            .execute_sql(
                "SELECT DISTINCT ON (region, product) region, product, amount, date
                FROM sales
                ORDER BY region, product, date DESC",
            )
            .expect("DISTINCT ON should succeed");

        assert_eq!(
            result.num_rows(),
            3,
            "Should return 3 rows (one per region-product combo)"
        );
    }

    #[test]
    fn test_distinct_on_with_expression() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS users").unwrap();
        executor
            .execute_sql("CREATE TABLE users (id INT64, email STRING, created_at INT64)")
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO users VALUES
                (1, 'alice@example.com', 100),
                (2, 'ALICE@EXAMPLE.COM', 200),
                (3, 'bob@example.com', 150)",
            )
            .unwrap();

        let result = executor
            .execute_sql(
                "SELECT DISTINCT ON (LOWER(email)) id, email, created_at
                FROM users
                ORDER BY LOWER(email), created_at DESC",
            )
            .expect("DISTINCT ON with expression should succeed");

        assert_eq!(
            result.num_rows(),
            2,
            "Should return 2 rows (unique lowercase emails)"
        );
    }
}

mod edge_cases {
    use super::*;

    #[test]
    fn test_empty_result_set() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS data_empty")
            .unwrap();
        executor
            .execute_sql("CREATE TABLE data_empty (id INT64, category STRING)")
            .unwrap();

        let result = executor
            .execute_sql(
                "SELECT DISTINCT ON (category) category, id
                FROM data_empty
                ORDER BY category, id",
            )
            .expect("DISTINCT ON on empty table should succeed");

        assert_eq!(result.num_rows(), 0, "Empty table should return 0 rows");
    }

    #[test]
    fn test_single_row() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS data_single")
            .unwrap();
        executor
            .execute_sql("CREATE TABLE data_single (id INT64, category STRING)")
            .unwrap();
        executor
            .execute_sql("INSERT INTO data_single VALUES (1, 'A')")
            .unwrap();

        let result = executor
            .execute_sql(
                "SELECT DISTINCT ON (category) category, id
                FROM data_single
                ORDER BY category",
            )
            .expect("DISTINCT ON on single row should succeed");

        assert_eq!(result.num_rows(), 1, "Single row should return 1 row");
    }

    #[test]
    fn test_all_unique_values() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS data_unique")
            .unwrap();
        executor
            .execute_sql("CREATE TABLE data_unique (id INT64, value STRING)")
            .unwrap();
        executor
            .execute_sql("INSERT INTO data_unique VALUES (1, 'A'), (2, 'B'), (3, 'C')")
            .unwrap();

        let result = executor
            .execute_sql(
                "SELECT DISTINCT ON (value) value, id
                FROM data_unique
                ORDER BY value",
            )
            .expect("DISTINCT ON with all unique values should succeed");

        assert_eq!(
            result.num_rows(),
            3,
            "All unique values should return all rows"
        );
    }

    #[test]
    fn test_all_same_value() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS data_same")
            .unwrap();
        executor
            .execute_sql("CREATE TABLE data_same (id INT64, category STRING, value STRING)")
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO data_same VALUES
                (1, 'A', 'first'),
                (2, 'A', 'second'),
                (3, 'A', 'third')",
            )
            .unwrap();

        let result = executor
            .execute_sql(
                "SELECT DISTINCT ON (category) id, category, value
                FROM data_same
                ORDER BY category, id ASC",
            )
            .expect("DISTINCT ON with all same values should succeed");

        assert_eq!(
            result.num_rows(),
            1,
            "All same category should return 1 row"
        );

        let expected = build_batch(
            result.schema().clone(),
            vec![vec![
                Value::int64(1),
                Value::string("A".into()),
                Value::string("first".into()),
            ]],
        );
        assert_batch_eq(&result, &expected);
    }

    #[test]
    fn test_null_values_in_distinct_on() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS data_null")
            .unwrap();
        executor
            .execute_sql("CREATE TABLE data_null (id INT64, category STRING, value INT64)")
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO data_null VALUES
                (1, NULL, 10),
                (2, NULL, 20),
                (3, 'A', 30),
                (4, 'A', 40)",
            )
            .unwrap();

        let result = executor
            .execute_sql(
                "SELECT DISTINCT ON (category) category, value
                FROM data_null
                ORDER BY category, value ASC",
            )
            .expect("DISTINCT ON with NULLs should succeed");

        assert_eq!(
            result.num_rows(),
            2,
            "Should return 2 rows (one for NULL, one for 'A')"
        );
    }
}

mod order_by_interaction {
    use super::*;

    #[test]
    fn test_order_by_same_column_as_distinct_on() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS data_order")
            .unwrap();
        executor
            .execute_sql("CREATE TABLE data_order (id INT64, category STRING, value INT64)")
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO data_order VALUES
                (1, 'A', 100),
                (2, 'A', 200),
                (3, 'B', 150)",
            )
            .unwrap();

        let result = executor
            .execute_sql(
                "SELECT DISTINCT ON (category) category, value
                FROM data_order
                ORDER BY category, value DESC",
            )
            .expect("DISTINCT ON with matching ORDER BY should succeed");

        assert_eq!(result.num_rows(), 2, "Should return 2 categories");
    }

    #[test]
    fn test_order_by_with_additional_columns() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS events_complex")
            .unwrap();
        executor
            .execute_sql(
                "CREATE TABLE events_complex (id INT64, user_id INT64, type STRING, priority INT64, timestamp INT64)",
            )
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO events_complex VALUES
                (1, 1, 'alert', 1, 100),
                (2, 1, 'info', 3, 200),
                (3, 1, 'alert', 2, 150)",
            )
            .unwrap();

        let result = executor
            .execute_sql(
                "SELECT DISTINCT ON (user_id) user_id, type, priority, timestamp
                FROM events_complex
                ORDER BY user_id, priority ASC, timestamp DESC",
            )
            .expect("DISTINCT ON with complex ORDER BY should succeed");

        assert_eq!(result.num_rows(), 1, "Should return 1 row for user");
    }

    #[test]
    fn test_order_by_desc_on_distinct_column() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS scores").unwrap();
        executor
            .execute_sql("CREATE TABLE scores (id INT64, player STRING, score INT64)")
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO scores VALUES
                (1, 'Alice', 100),
                (2, 'Alice', 150),
                (3, 'Bob', 200)",
            )
            .unwrap();

        let result = executor
            .execute_sql(
                "SELECT DISTINCT ON (player) player, score
                FROM scores
                ORDER BY player ASC, score DESC",
            )
            .expect("DISTINCT ON with DESC sort should succeed");

        assert_eq!(
            result.num_rows(),
            2,
            "Should return highest score per player"
        );
    }
}

mod integration {
    use super::*;

    #[test]
    fn test_distinct_on_with_where() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS logs").unwrap();
        executor
            .execute_sql(
                "CREATE TABLE logs (id INT64, level STRING, user_id INT64, message STRING)",
            )
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO logs VALUES
                (1, 'ERROR', 1, 'msg1'),
                (2, 'INFO', 1, 'msg2'),
                (3, 'ERROR', 2, 'msg3'),
                (4, 'WARN', 2, 'msg4')",
            )
            .unwrap();

        let result = executor
            .execute_sql(
                "SELECT DISTINCT ON (user_id) id, user_id, message
                FROM logs
                WHERE level = 'ERROR'
                ORDER BY user_id, id ASC",
            )
            .expect("DISTINCT ON with WHERE should succeed");

        assert_eq!(
            result.num_rows(),
            2,
            "Should return first ERROR log per user"
        );

        let expected = build_batch(
            result.schema().clone(),
            vec![
                vec![
                    Value::int64(1),
                    Value::int64(1),
                    Value::string("msg1".into()),
                ],
                vec![
                    Value::int64(3),
                    Value::int64(2),
                    Value::string("msg3".into()),
                ],
            ],
        );
        assert_batch_eq(&result, &expected);
    }

    #[test]
    fn test_distinct_on_with_join() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS orders").unwrap();
        executor
            .execute_sql("DROP TABLE IF EXISTS users_join")
            .unwrap();
        executor
            .execute_sql("CREATE TABLE orders (order_id INT64, user_id INT64, total FLOAT64, order_date INT64)")
            .unwrap();

        executor
            .execute_sql("CREATE TABLE users_join (uid INT64, name STRING)")
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO orders VALUES
                (1, 1, 100.0, 1),
                (2, 1, 200.0, 2),
                (3, 2, 150.0, 1)",
            )
            .unwrap();
        executor
            .execute_sql("INSERT INTO users_join VALUES (1, 'Alice'), (2, 'Bob')")
            .unwrap();

        let result = executor
            .execute_sql(
                "SELECT DISTINCT ON (uid) uid, name, total, order_date
                FROM orders
                JOIN users_join ON orders.user_id = users_join.uid
                ORDER BY uid, order_date DESC",
            )
            .expect("DISTINCT ON with JOIN should succeed");

        assert_eq!(result.num_rows(), 2, "Should return latest order per user");

        let expected = build_batch(
            result.schema().clone(),
            vec![
                vec![
                    Value::int64(1),
                    Value::string("Alice".into()),
                    Value::float64(200.0),
                    Value::int64(2),
                ],
                vec![
                    Value::int64(2),
                    Value::string("Bob".into()),
                    Value::float64(150.0),
                    Value::int64(1),
                ],
            ],
        );
        assert_batch_eq(&result, &expected);
    }

    #[test]
    fn test_distinct_on_in_subquery() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS events").unwrap();
        executor
            .execute_sql(
                "CREATE TABLE events (id INT64, user_id INT64, action STRING, timestamp INT64)",
            )
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO events VALUES
                (1, 1, 'login', 100),
                (2, 1, 'click', 200),
                (3, 2, 'login', 150)",
            )
            .unwrap();

        let result = executor
            .execute_sql(
                "SELECT user_id, timestamp
                FROM (
                    SELECT DISTINCT ON (user_id) user_id, timestamp
                    FROM events
                    ORDER BY user_id, timestamp DESC
                ) AS latest
                ORDER BY user_id",
            )
            .expect("DISTINCT ON in subquery should succeed");

        assert_eq!(result.num_rows(), 2, "Should return latest events per user");
    }

    #[test]
    fn test_distinct_on_with_cte() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS sales").unwrap();
        executor
            .execute_sql(
                "CREATE TABLE sales (id INT64, product STRING, amount FLOAT64, date INT64)",
            )
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO sales VALUES
                (1, 'widget', 100.0, 1),
                (2, 'widget', 150.0, 2),
                (3, 'gadget', 200.0, 1)",
            )
            .unwrap();

        let result = executor
            .execute_sql(
                "WITH latest_sales AS (
                    SELECT DISTINCT ON (product) product, amount, date
                    FROM sales
                    ORDER BY product, date DESC
                )
                SELECT * FROM latest_sales ORDER BY product",
            )
            .expect("DISTINCT ON with CTE should succeed");

        assert_eq!(
            result.num_rows(),
            2,
            "Should return latest sale for each product"
        );
    }
}

mod real_world {
    use super::*;

    #[test]
    fn test_deduplication_keep_latest() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS user_snapshots")
            .unwrap();
        executor
            .execute_sql(
                "CREATE TABLE user_snapshots (id INT64, email STRING, name STRING, updated_at INT64)",
            )
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO user_snapshots VALUES
                (1, 'alice@example.com', 'Alice A', 1),
                (2, 'alice@example.com', 'Alice B', 2),
                (3, 'bob@example.com', 'Bob', 1),
                (4, 'alice@example.com', 'Alice C', 3)",
            )
            .unwrap();

        let result = executor
            .execute_sql(
                "SELECT DISTINCT ON (email) email, name, updated_at
                FROM user_snapshots
                ORDER BY email, updated_at DESC",
            )
            .expect("Deduplication should succeed");

        assert_eq!(
            result.num_rows(),
            2,
            "Should return latest snapshot per email"
        );
    }

    #[test]
    fn test_top_per_group() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS equipment")
            .unwrap();
        executor
            .execute_sql("CREATE TABLE equipment (id INT64, category STRING, sales INT64)")
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO equipment VALUES
                (1, 'electronics', 1000),
                (2, 'electronics', 1500),
                (3, 'books', 500),
                (4, 'books', 800)",
            )
            .unwrap();

        let result = executor
            .execute_sql(
                "SELECT DISTINCT ON (category) category, id, sales
                FROM equipment
                ORDER BY category, sales DESC",
            )
            .expect("Top per group should succeed");

        assert_eq!(
            result.num_rows(),
            2,
            "Should return top selling item per category"
        );
    }

    #[test]
    fn test_distinct_on_with_limit() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS items").unwrap();
        executor
            .execute_sql("CREATE TABLE items (id INT64, category STRING, value INT64)")
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO items VALUES
                (1, 'A', 10),
                (2, 'A', 20),
                (3, 'B', 30),
                (4, 'C', 40)",
            )
            .unwrap();

        let result = executor
            .execute_sql(
                "SELECT DISTINCT ON (category) category, value
                FROM items
                ORDER BY category, value DESC
                LIMIT 2",
            )
            .expect("DISTINCT ON with LIMIT should succeed");

        assert_eq!(
            result.num_rows(),
            2,
            "LIMIT 2 should return only 2 categories"
        );
    }

    #[test]
    fn test_distinct_on_with_offset() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS items").unwrap();
        executor
            .execute_sql("CREATE TABLE items (id INT64, category STRING, value INT64)")
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO items VALUES
                (1, 'A', 10),
                (2, 'B', 20),
                (3, 'C', 30)",
            )
            .unwrap();

        let result = executor
            .execute_sql(
                "SELECT DISTINCT ON (category) category, value
                FROM items
                ORDER BY category
                OFFSET 1",
            )
            .expect("DISTINCT ON with OFFSET should succeed");

        assert_eq!(result.num_rows(), 2, "OFFSET 1 should skip first category");
    }
}
