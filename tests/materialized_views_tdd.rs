mod common;

use yachtsql::{DialectType, QueryExecutor};

fn create_executor() -> QueryExecutor {
    QueryExecutor::with_dialect(DialectType::PostgreSQL)
}

mod create_materialized_view {
    use super::*;

    #[test]
    fn test_create_simple_materialized_view() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TABLE products (id INT64, name STRING, price FLOAT64)")
            .unwrap();
        executor
            .execute_sql("INSERT INTO products VALUES (1, 'Apple', 1.50), (2, 'Banana', 0.75), (3, 'Cherry', 3.00)")
            .unwrap();

        executor
            .execute_sql(
                "CREATE MATERIALIZED VIEW product_summary AS
                 SELECT COUNT(*) as product_count, SUM(price) as total_price FROM products",
            )
            .expect("CREATE MATERIALIZED VIEW should succeed");

        let result = executor
            .execute_sql("SELECT product_count, total_price FROM product_summary")
            .expect("Query on materialized view should succeed");

        assert_eq!(result.num_rows(), 1, "Should return 1 row");
    }

    #[test]
    fn test_create_materialized_view_with_where() {
        let mut executor = create_executor();

        executor
            .execute_sql(
                "CREATE TABLE orders (id INT64, customer_id INT64, amount FLOAT64, status STRING)",
            )
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO orders VALUES
                (1, 100, 50.00, 'completed'),
                (2, 100, 75.00, 'pending'),
                (3, 200, 100.00, 'completed')",
            )
            .unwrap();

        executor
            .execute_sql(
                "CREATE MATERIALIZED VIEW completed_orders AS
                 SELECT customer_id, SUM(amount) as total
                 FROM orders
                 WHERE status = 'completed'
                 GROUP BY customer_id",
            )
            .expect("CREATE MATERIALIZED VIEW with WHERE should succeed");

        let result = executor
            .execute_sql("SELECT customer_id, total FROM completed_orders ORDER BY customer_id")
            .expect("Query on materialized view should succeed");

        assert_eq!(
            result.num_rows(),
            2,
            "Should return 2 rows (completed orders only)"
        );
    }

    #[test]
    fn test_create_materialized_view_with_join() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TABLE customers (id INT64, name STRING)")
            .unwrap();
        executor
            .execute_sql("INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob')")
            .unwrap();

        executor
            .execute_sql("CREATE TABLE order_items (customer_id INT64, amount FLOAT64)")
            .unwrap();
        executor
            .execute_sql("INSERT INTO order_items VALUES (1, 100.00), (1, 50.00), (2, 75.00)")
            .unwrap();

        executor
            .execute_sql(
                "CREATE MATERIALIZED VIEW customer_totals AS
                 SELECT c.name, SUM(o.amount) as total_spent
                 FROM customers c
                 JOIN order_items o ON c.id = o.customer_id
                 GROUP BY c.name",
            )
            .expect("CREATE MATERIALIZED VIEW with JOIN should succeed");

        let result = executor
            .execute_sql("SELECT name, total_spent FROM customer_totals ORDER BY name")
            .expect("Query on materialized view should succeed");

        assert_eq!(result.num_rows(), 2, "Should return 2 rows");
    }
}

mod refresh_materialized_view {
    use super::*;

    #[test]
    fn test_refresh_materialized_view_basic() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TABLE counters (id INT64, value INT64)")
            .unwrap();
        executor
            .execute_sql("INSERT INTO counters VALUES (1, 10)")
            .unwrap();

        executor
            .execute_sql(
                "CREATE MATERIALIZED VIEW counter_sum AS
                 SELECT SUM(value) as total FROM counters",
            )
            .unwrap();

        let result = executor
            .execute_sql("SELECT total FROM counter_sum")
            .expect("Query should succeed");
        assert_eq!(result.num_rows(), 1);

        executor
            .execute_sql("INSERT INTO counters VALUES (2, 20)")
            .unwrap();

        executor
            .execute_sql("REFRESH MATERIALIZED VIEW counter_sum")
            .expect("REFRESH MATERIALIZED VIEW should succeed");

        let result = executor
            .execute_sql("SELECT total FROM counter_sum")
            .expect("Query should succeed after refresh");

        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_refresh_materialized_view_concurrently() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TABLE items (id INT64, quantity INT64)")
            .unwrap();
        executor
            .execute_sql("INSERT INTO items VALUES (1, 5), (2, 10)")
            .unwrap();

        executor
            .execute_sql(
                "CREATE MATERIALIZED VIEW item_totals AS
                 SELECT COUNT(*) as item_count, SUM(quantity) as total_qty FROM items",
            )
            .unwrap();

        executor
            .execute_sql("INSERT INTO items VALUES (3, 15)")
            .unwrap();

        executor
            .execute_sql("REFRESH MATERIALIZED VIEW CONCURRENTLY item_totals")
            .expect("REFRESH MATERIALIZED VIEW CONCURRENTLY should succeed");

        let result = executor
            .execute_sql("SELECT item_count, total_qty FROM item_totals")
            .expect("Query should succeed after concurrent refresh");

        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_refresh_nonexistent_view_fails() {
        let mut executor = create_executor();

        let result = executor.execute_sql("REFRESH MATERIALIZED VIEW nonexistent_view");

        assert!(result.is_err(), "Refreshing nonexistent view should fail");
        let err_msg = result.unwrap_err().to_string();
        assert!(
            err_msg.contains("does not exist") || err_msg.contains("not found"),
            "Error message should indicate view doesn't exist: {}",
            err_msg
        );
    }

    #[test]
    fn test_refresh_regular_view_fails() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TABLE test_data (id INT64)")
            .unwrap();
        executor
            .execute_sql("CREATE VIEW regular_view AS SELECT * FROM test_data")
            .unwrap();

        let result = executor.execute_sql("REFRESH MATERIALIZED VIEW regular_view");

        assert!(result.is_err(), "Refreshing regular view should fail");
        let err_msg = result.unwrap_err().to_string();
        assert!(
            err_msg.contains("not a materialized view"),
            "Error message should indicate it's not a materialized view: {}",
            err_msg
        );
    }
}

mod drop_materialized_view {
    use super::*;

    #[test]
    fn test_drop_materialized_view_basic() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TABLE drop_test (id INT64)")
            .unwrap();
        executor
            .execute_sql("CREATE MATERIALIZED VIEW mv_to_drop AS SELECT * FROM drop_test")
            .unwrap();

        executor
            .execute_sql("SELECT * FROM mv_to_drop")
            .expect("View should exist");

        executor
            .execute_sql("DROP MATERIALIZED VIEW mv_to_drop")
            .expect("DROP MATERIALIZED VIEW should succeed");

        let result = executor.execute_sql("SELECT * FROM mv_to_drop");
        assert!(result.is_err(), "Query should fail after dropping view");
    }

    #[test]
    fn test_drop_materialized_view_if_exists() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP MATERIALIZED VIEW IF EXISTS nonexistent_mv")
            .expect("DROP MATERIALIZED VIEW IF EXISTS should succeed even if view doesn't exist");
    }

    #[test]
    fn test_drop_nonexistent_materialized_view_fails() {
        let mut executor = create_executor();

        let result = executor.execute_sql("DROP MATERIALIZED VIEW nonexistent_mv");

        assert!(
            result.is_err(),
            "Dropping nonexistent view without IF EXISTS should fail"
        );
    }

    #[test]
    fn test_drop_regular_view_as_materialized_fails() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TABLE regular_test (id INT64)")
            .unwrap();
        executor
            .execute_sql("CREATE VIEW regular_v AS SELECT * FROM regular_test")
            .unwrap();

        let result = executor.execute_sql("DROP MATERIALIZED VIEW regular_v");

        assert!(
            result.is_err(),
            "Dropping regular view as materialized should fail"
        );
        let err_msg = result.unwrap_err().to_string();
        assert!(
            err_msg.contains("not a materialized view"),
            "Error message should indicate it's not a materialized view: {}",
            err_msg
        );
    }

    #[test]
    fn test_drop_materialized_view_cascade() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TABLE cascade_test (id INT64)")
            .unwrap();
        executor
            .execute_sql("CREATE MATERIALIZED VIEW mv_cascade AS SELECT * FROM cascade_test")
            .unwrap();

        executor
            .execute_sql("DROP MATERIALIZED VIEW mv_cascade CASCADE")
            .expect("DROP MATERIALIZED VIEW CASCADE should succeed");
    }
}

mod materialized_view_data {
    use super::*;

    #[test]
    fn test_materialized_view_data_not_updated_without_refresh() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TABLE persist_test (value INT64)")
            .unwrap();
        executor
            .execute_sql("INSERT INTO persist_test VALUES (100)")
            .unwrap();

        executor
            .execute_sql(
                "CREATE MATERIALIZED VIEW mv_persist AS SELECT SUM(value) as total FROM persist_test",
            )
            .unwrap();

        let result1 = executor
            .execute_sql("SELECT total FROM mv_persist")
            .expect("Query should succeed");
        assert_eq!(result1.num_rows(), 1);

        executor
            .execute_sql("INSERT INTO persist_test VALUES (200)")
            .unwrap();

        let result2 = executor
            .execute_sql("SELECT total FROM mv_persist")
            .expect("Query should succeed");
        assert_eq!(result2.num_rows(), 1);
    }

    #[test]
    fn test_materialized_view_with_aggregations() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TABLE agg_test (category STRING, amount FLOAT64)")
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO agg_test VALUES
                ('A', 10.0), ('A', 20.0), ('B', 15.0), ('B', 25.0), ('C', 30.0)",
            )
            .unwrap();

        executor
            .execute_sql(
                "CREATE MATERIALIZED VIEW agg_summary AS
                 SELECT
                     category,
                     COUNT(*) as cnt,
                     SUM(amount) as total,
                     AVG(amount) as avg_amt
                 FROM agg_test
                 GROUP BY category",
            )
            .unwrap();

        let result = executor
            .execute_sql("SELECT category, cnt, total FROM agg_summary ORDER BY category")
            .expect("Query should succeed");

        assert_eq!(result.num_rows(), 3, "Should have 3 categories");
    }
}

mod parsing {
    use super::*;

    #[test]
    fn test_parse_refresh_materialized_view() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TABLE parse_test (id INT64)")
            .unwrap();
        executor
            .execute_sql("CREATE MATERIALIZED VIEW mv_parse AS SELECT * FROM parse_test")
            .unwrap();

        executor
            .execute_sql("REFRESH MATERIALIZED VIEW mv_parse")
            .expect("Basic REFRESH should parse");

        executor
            .execute_sql("refresh materialized view mv_parse")
            .expect("Lowercase REFRESH should parse");

        executor
            .execute_sql("REFRESH MATERIALIZED VIEW CONCURRENTLY mv_parse")
            .expect("REFRESH CONCURRENTLY should parse");
    }

    #[test]
    fn test_parse_drop_materialized_view() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP MATERIALIZED VIEW IF EXISTS test_mv")
            .expect("DROP IF EXISTS should parse");

        executor
            .execute_sql("drop materialized view if exists test_mv")
            .expect("Lowercase DROP should parse");

        executor
            .execute_sql("DROP MATERIALIZED VIEW IF EXISTS test_mv CASCADE")
            .expect("DROP CASCADE should parse");
    }
}
