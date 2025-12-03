mod common;

use common::{get_i64, get_string, is_null};
use yachtsql::{DialectType, QueryExecutor};

fn create_executor() -> QueryExecutor {
    QueryExecutor::with_dialect(DialectType::PostgreSQL)
}

mod update_returning_old_new {
    use super::*;

    fn setup_test_table(executor: &mut QueryExecutor) {
        executor
            .execute_sql("CREATE TABLE test_update (id INT PRIMARY KEY, value INT, name TEXT)")
            .expect("CREATE TABLE should succeed");
        executor
            .execute_sql("INSERT INTO test_update VALUES (1, 100, 'alice'), (2, 200, 'bob')")
            .expect("INSERT should succeed");
    }

    #[test]
    fn test_update_returning_old_column() {
        let mut executor = create_executor();
        setup_test_table(&mut executor);

        let result = executor
            .execute_sql("UPDATE test_update SET value = 150 WHERE id = 1 RETURNING OLD.value")
            .expect("UPDATE RETURNING OLD.value should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64(&result, 0, 0), 100);
    }

    #[test]
    fn test_update_returning_new_column() {
        let mut executor = create_executor();
        setup_test_table(&mut executor);

        let result = executor
            .execute_sql("UPDATE test_update SET value = 150 WHERE id = 1 RETURNING NEW.value")
            .expect("UPDATE RETURNING NEW.value should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64(&result, 0, 0), 150);
    }

    #[test]
    fn test_update_returning_both_old_and_new() {
        let mut executor = create_executor();
        setup_test_table(&mut executor);

        let result = executor
            .execute_sql(
                "UPDATE test_update SET value = 150 WHERE id = 1 RETURNING OLD.value, NEW.value",
            )
            .expect("UPDATE RETURNING OLD and NEW should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64(&result, 0, 0), 100);
        assert_eq!(get_i64(&result, 1, 0), 150);
    }

    #[test]
    fn test_update_returning_old_star() {
        let mut executor = create_executor();
        setup_test_table(&mut executor);

        let result = executor
            .execute_sql("UPDATE test_update SET value = 150 WHERE id = 1 RETURNING OLD.*")
            .expect("UPDATE RETURNING OLD.* should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64(&result, 0, 0), 1);
        assert_eq!(get_i64(&result, 1, 0), 100);
        assert_eq!(get_string(&result, 2, 0), "alice");
    }

    #[test]
    fn test_update_returning_new_star() {
        let mut executor = create_executor();
        setup_test_table(&mut executor);

        let result = executor
            .execute_sql("UPDATE test_update SET value = 150 WHERE id = 1 RETURNING NEW.*")
            .expect("UPDATE RETURNING NEW.* should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64(&result, 0, 0), 1);
        assert_eq!(get_i64(&result, 1, 0), 150);
        assert_eq!(get_string(&result, 2, 0), "alice");
    }

    #[test]
    fn test_update_returning_old_new_expression() {
        let mut executor = create_executor();
        setup_test_table(&mut executor);

        let result = executor
            .execute_sql(
                "UPDATE test_update SET value = 150 WHERE id = 1 RETURNING NEW.value - OLD.value AS delta",
            )
            .expect("UPDATE RETURNING expression should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64(&result, 0, 0), 50);
    }

    #[test]
    fn test_update_returning_multiple_rows_old_new() {
        let mut executor = create_executor();
        setup_test_table(&mut executor);

        let result = executor
            .execute_sql(
                "UPDATE test_update SET value = value + 10 RETURNING id, OLD.value, NEW.value",
            )
            .expect("UPDATE multiple rows RETURNING should succeed");

        assert_eq!(result.num_rows(), 2);

        assert_eq!(get_i64(&result, 0, 0), 1);
        assert_eq!(get_i64(&result, 1, 0), 100);
        assert_eq!(get_i64(&result, 2, 0), 110);

        assert_eq!(get_i64(&result, 0, 1), 2);
        assert_eq!(get_i64(&result, 1, 1), 200);
        assert_eq!(get_i64(&result, 2, 1), 210);
    }

    #[test]
    fn test_update_returning_old_unchanged_column() {
        let mut executor = create_executor();
        setup_test_table(&mut executor);

        let result = executor
            .execute_sql(
                "UPDATE test_update SET value = 150 WHERE id = 1 RETURNING OLD.name, NEW.name",
            )
            .expect("UPDATE RETURNING unchanged column should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_string(&result, 0, 0), "alice");
        assert_eq!(get_string(&result, 1, 0), "alice");
    }
}

mod delete_returning_old {
    use super::*;

    fn setup_test_table(executor: &mut QueryExecutor) {
        executor
            .execute_sql("CREATE TABLE test_delete (id INT PRIMARY KEY, value INT, name TEXT)")
            .expect("CREATE TABLE should succeed");
        executor
            .execute_sql("INSERT INTO test_delete VALUES (1, 100, 'alice'), (2, 200, 'bob')")
            .expect("INSERT should succeed");
    }

    #[test]
    fn test_delete_returning_old_column() {
        let mut executor = create_executor();
        setup_test_table(&mut executor);

        let result = executor
            .execute_sql("DELETE FROM test_delete WHERE id = 1 RETURNING OLD.value")
            .expect("DELETE RETURNING OLD.value should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64(&result, 0, 0), 100);
    }

    #[test]
    fn test_delete_returning_old_star() {
        let mut executor = create_executor();
        setup_test_table(&mut executor);

        let result = executor
            .execute_sql("DELETE FROM test_delete WHERE id = 1 RETURNING OLD.*")
            .expect("DELETE RETURNING OLD.* should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64(&result, 0, 0), 1);
        assert_eq!(get_i64(&result, 1, 0), 100);
        assert_eq!(get_string(&result, 2, 0), "alice");
    }

    #[test]
    fn test_delete_returning_old_multiple_rows() {
        let mut executor = create_executor();
        setup_test_table(&mut executor);

        let result = executor
            .execute_sql("DELETE FROM test_delete RETURNING OLD.id, OLD.value")
            .expect("DELETE multiple rows RETURNING should succeed");

        assert_eq!(result.num_rows(), 2);
    }

    #[test]
    fn test_delete_returning_old_with_alias() {
        let mut executor = create_executor();
        setup_test_table(&mut executor);

        let result = executor
            .execute_sql(
                "DELETE FROM test_delete WHERE id = 1 RETURNING OLD.value AS deleted_value",
            )
            .expect("DELETE RETURNING with alias should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64(&result, 0, 0), 100);
    }

    #[test]
    fn test_delete_returning_plain_column_same_as_old() {
        let mut executor = create_executor();
        setup_test_table(&mut executor);

        let result = executor
            .execute_sql("DELETE FROM test_delete WHERE id = 1 RETURNING value")
            .expect("DELETE RETURNING plain column should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64(&result, 0, 0), 100);
    }
}

mod insert_returning_new {
    use super::*;

    fn setup_test_table(executor: &mut QueryExecutor) {
        executor
            .execute_sql("CREATE TABLE test_insert (id INT PRIMARY KEY, value INT, name TEXT)")
            .expect("CREATE TABLE should succeed");
    }

    #[test]
    fn test_insert_returning_new_column() {
        let mut executor = create_executor();
        setup_test_table(&mut executor);

        let result = executor
            .execute_sql("INSERT INTO test_insert VALUES (1, 100, 'alice') RETURNING NEW.value")
            .expect("INSERT RETURNING NEW.value should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64(&result, 0, 0), 100);
    }

    #[test]
    fn test_insert_returning_new_star() {
        let mut executor = create_executor();
        setup_test_table(&mut executor);

        let result = executor
            .execute_sql("INSERT INTO test_insert VALUES (1, 100, 'alice') RETURNING NEW.*")
            .expect("INSERT RETURNING NEW.* should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64(&result, 0, 0), 1);
        assert_eq!(get_i64(&result, 1, 0), 100);
        assert_eq!(get_string(&result, 2, 0), "alice");
    }

    #[test]
    fn test_insert_returning_plain_column_same_as_new() {
        let mut executor = create_executor();
        setup_test_table(&mut executor);

        let result = executor
            .execute_sql("INSERT INTO test_insert VALUES (1, 100, 'alice') RETURNING value")
            .expect("INSERT RETURNING plain column should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64(&result, 0, 0), 100);
    }

    #[test]
    fn test_insert_returning_multiple_rows() {
        let mut executor = create_executor();
        setup_test_table(&mut executor);

        let result = executor
            .execute_sql(
                "INSERT INTO test_insert VALUES (1, 100, 'alice'), (2, 200, 'bob') RETURNING NEW.id, NEW.value",
            )
            .expect("INSERT multiple rows RETURNING should succeed");

        assert_eq!(result.num_rows(), 2);
    }
}

mod edge_cases {
    use super::*;

    #[test]
    fn test_update_returning_mixed_old_new_plain() {
        let mut executor = create_executor();
        executor
            .execute_sql("CREATE TABLE test_mixed (id INT, value INT)")
            .expect("CREATE TABLE should succeed");
        executor
            .execute_sql("INSERT INTO test_mixed VALUES (1, 100)")
            .expect("INSERT should succeed");

        let result = executor
            .execute_sql(
                "UPDATE test_mixed SET value = 200 WHERE id = 1 RETURNING id, OLD.value, NEW.value",
            )
            .expect("Mixed RETURNING should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64(&result, 0, 0), 1);
        assert_eq!(get_i64(&result, 1, 0), 100);
        assert_eq!(get_i64(&result, 2, 0), 200);
    }

    #[test]
    fn test_returning_null_values() {
        let mut executor = create_executor();
        executor
            .execute_sql("CREATE TABLE test_null (id INT, value INT)")
            .expect("CREATE TABLE should succeed");
        executor
            .execute_sql("INSERT INTO test_null VALUES (1, NULL)")
            .expect("INSERT should succeed");

        let result = executor
            .execute_sql(
                "UPDATE test_null SET value = 100 WHERE id = 1 RETURNING OLD.value, NEW.value",
            )
            .expect("RETURNING with NULL should succeed");

        assert_eq!(result.num_rows(), 1);
        assert!(is_null(&result, 0, 0));
        assert_eq!(get_i64(&result, 1, 0), 100);
    }

    #[test]
    fn test_delete_returning_new_should_error() {
        let mut executor = create_executor();
        executor
            .execute_sql("CREATE TABLE test_err (id INT, value INT)")
            .expect("CREATE TABLE should succeed");
        executor
            .execute_sql("INSERT INTO test_err VALUES (1, 100)")
            .expect("INSERT should succeed");

        let result = executor.execute_sql("DELETE FROM test_err WHERE id = 1 RETURNING NEW.value");

        assert!(
            result.is_err(),
            "DELETE RETURNING NEW should error - no new row exists"
        );
    }

    #[test]
    fn test_insert_returning_old_should_error() {
        let mut executor = create_executor();
        executor
            .execute_sql("CREATE TABLE test_err2 (id INT, value INT)")
            .expect("CREATE TABLE should succeed");

        let result =
            executor.execute_sql("INSERT INTO test_err2 VALUES (1, 100) RETURNING OLD.value");

        assert!(
            result.is_err(),
            "INSERT RETURNING OLD should error - no old row exists"
        );
    }

    #[test]
    fn test_update_no_rows_affected() {
        let mut executor = create_executor();
        executor
            .execute_sql("CREATE TABLE test_empty (id INT, value INT)")
            .expect("CREATE TABLE should succeed");

        let result = executor
            .execute_sql(
                "UPDATE test_empty SET value = 100 WHERE id = 999 RETURNING OLD.value, NEW.value",
            )
            .expect("UPDATE with no matches should succeed");

        assert_eq!(result.num_rows(), 0);
    }
}
