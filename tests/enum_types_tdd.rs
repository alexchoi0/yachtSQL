mod common;

use yachtsql::{DialectType, QueryExecutor};

fn create_executor() -> QueryExecutor {
    QueryExecutor::with_dialect(DialectType::PostgreSQL)
}

mod create_enum_type {
    use super::*;

    #[test]
    fn test_create_basic_enum_type() {
        let mut executor = create_executor();

        let result = executor.execute_sql("CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy')");
        assert!(
            result.is_ok(),
            "CREATE TYPE AS ENUM should succeed: {:?}",
            result.err()
        );
    }

    #[test]
    fn test_create_enum_type_single_value() {
        let mut executor = create_executor();

        let result = executor.execute_sql("CREATE TYPE single_value AS ENUM ('only')");
        assert!(
            result.is_ok(),
            "CREATE TYPE with single value should succeed: {:?}",
            result.err()
        );
    }

    #[test]
    fn test_create_enum_type_many_values() {
        let mut executor = create_executor();

        let result = executor.execute_sql(
            "CREATE TYPE day_of_week AS ENUM ('monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday')"
        );
        assert!(
            result.is_ok(),
            "CREATE TYPE with many values should succeed: {:?}",
            result.err()
        );
    }

    #[test]
    fn test_create_duplicate_enum_type_fails() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy')")
            .expect("First CREATE TYPE should succeed");

        let result = executor.execute_sql("CREATE TYPE mood AS ENUM ('angry', 'calm')");
        assert!(result.is_err(), "Creating duplicate ENUM type should fail");
    }
}

mod drop_enum_type {
    use super::*;

    #[test]
    fn test_drop_enum_type() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy')")
            .expect("CREATE TYPE should succeed");

        let result = executor.execute_sql("DROP TYPE mood");
        assert!(
            result.is_ok(),
            "DROP TYPE should succeed: {:?}",
            result.err()
        );
    }

    #[test]
    fn test_drop_nonexistent_type_fails() {
        let mut executor = create_executor();

        let result = executor.execute_sql("DROP TYPE nonexistent_type");
        assert!(result.is_err(), "DROP TYPE on nonexistent type should fail");
    }

    #[test]
    fn test_drop_type_if_exists() {
        let mut executor = create_executor();

        let result = executor.execute_sql("DROP TYPE IF EXISTS nonexistent_type");
        assert!(
            result.is_ok(),
            "DROP TYPE IF EXISTS should succeed even for nonexistent type: {:?}",
            result.err()
        );
    }

    #[test]
    fn test_drop_type_cascade() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy')")
            .expect("CREATE TYPE should succeed");

        executor
            .execute_sql("CREATE TABLE person (name TEXT, current_mood mood)")
            .expect("CREATE TABLE should succeed");

        let result = executor.execute_sql("DROP TYPE mood CASCADE");
        assert!(
            result.is_ok(),
            "DROP TYPE CASCADE should succeed: {:?}",
            result.err()
        );
    }
}

mod enum_in_tables {
    use super::*;
    use crate::common::get_string;

    #[test]
    fn test_create_table_with_enum_column() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy')")
            .expect("CREATE TYPE should succeed");

        let result = executor.execute_sql("CREATE TABLE person (name TEXT, current_mood mood)");
        assert!(
            result.is_ok(),
            "CREATE TABLE with ENUM column should succeed: {:?}",
            result.err()
        );
    }

    #[test]
    fn test_insert_valid_enum_value() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy')")
            .expect("CREATE TYPE should succeed");
        executor
            .execute_sql("CREATE TABLE person (name TEXT, current_mood mood)")
            .expect("CREATE TABLE should succeed");

        let result = executor.execute_sql("INSERT INTO person VALUES ('Alice', 'happy')");
        assert!(
            result.is_ok(),
            "INSERT with valid ENUM value should succeed: {:?}",
            result.err()
        );
    }

    #[test]
    fn test_insert_invalid_enum_value_fails() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy')")
            .expect("CREATE TYPE should succeed");
        executor
            .execute_sql("CREATE TABLE person (name TEXT, current_mood mood)")
            .expect("CREATE TABLE should succeed");

        let result = executor.execute_sql("INSERT INTO person VALUES ('Alice', 'angry')");
        assert!(
            result.is_err(),
            "INSERT with invalid ENUM value should fail"
        );
    }

    #[test]
    fn test_select_enum_value() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy')")
            .expect("CREATE TYPE should succeed");
        executor
            .execute_sql("CREATE TABLE person (name TEXT, current_mood mood)")
            .expect("CREATE TABLE should succeed");
        executor
            .execute_sql("INSERT INTO person VALUES ('Alice', 'happy')")
            .expect("INSERT should succeed");

        let result = executor
            .execute_sql("SELECT name, current_mood FROM person")
            .expect("SELECT should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_string(&result, 0, 0), "Alice");
        assert_eq!(get_string(&result, 1, 0), "happy");
    }

    #[test]
    fn test_filter_by_enum_value() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy')")
            .expect("CREATE TYPE should succeed");
        executor
            .execute_sql("CREATE TABLE person (name TEXT, current_mood mood)")
            .expect("CREATE TABLE should succeed");
        executor
            .execute_sql(
                "INSERT INTO person VALUES ('Alice', 'happy'), ('Bob', 'sad'), ('Carol', 'ok')",
            )
            .expect("INSERT should succeed");

        let result = executor
            .execute_sql("SELECT name FROM person WHERE current_mood = 'happy'")
            .expect("SELECT should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_string(&result, 0, 0), "Alice");
    }
}

mod enum_comparison {
    use super::*;
    use crate::common::get_string;

    #[test]
    fn test_enum_equality() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy')")
            .expect("CREATE TYPE should succeed");
        executor
            .execute_sql("CREATE TABLE person (name TEXT, current_mood mood)")
            .expect("CREATE TABLE should succeed");
        executor
            .execute_sql(
                "INSERT INTO person VALUES ('Alice', 'happy'), ('Bob', 'happy'), ('Carol', 'sad')",
            )
            .expect("INSERT should succeed");

        let result = executor
            .execute_sql("SELECT name FROM person WHERE current_mood = 'happy' ORDER BY name")
            .expect("SELECT should succeed");

        assert_eq!(result.num_rows(), 2);
        assert_eq!(get_string(&result, 0, 0), "Alice");
        assert_eq!(get_string(&result, 0, 1), "Bob");
    }

    #[test]
    fn test_enum_greater_than() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy')")
            .expect("CREATE TYPE should succeed");
        executor
            .execute_sql("CREATE TABLE person (name TEXT, current_mood mood)")
            .expect("CREATE TABLE should succeed");
        executor
            .execute_sql(
                "INSERT INTO person VALUES ('Alice', 'happy'), ('Bob', 'sad'), ('Carol', 'ok')",
            )
            .expect("INSERT should succeed");

        let result = executor
            .execute_sql("SELECT name FROM person WHERE current_mood > 'sad' ORDER BY name")
            .expect("SELECT should succeed");

        assert_eq!(result.num_rows(), 2);
        assert_eq!(get_string(&result, 0, 0), "Alice");
        assert_eq!(get_string(&result, 0, 1), "Carol");
    }

    #[test]
    fn test_enum_less_than() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy')")
            .expect("CREATE TYPE should succeed");
        executor
            .execute_sql("CREATE TABLE person (name TEXT, current_mood mood)")
            .expect("CREATE TABLE should succeed");
        executor
            .execute_sql(
                "INSERT INTO person VALUES ('Alice', 'happy'), ('Bob', 'sad'), ('Carol', 'ok')",
            )
            .expect("INSERT should succeed");

        let result = executor
            .execute_sql("SELECT name FROM person WHERE current_mood < 'happy' ORDER BY name")
            .expect("SELECT should succeed");

        assert_eq!(result.num_rows(), 2);
        assert_eq!(get_string(&result, 0, 0), "Bob");
        assert_eq!(get_string(&result, 0, 1), "Carol");
    }

    #[test]
    fn test_enum_order_by() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy')")
            .expect("CREATE TYPE should succeed");
        executor
            .execute_sql("CREATE TABLE person (name TEXT, current_mood mood)")
            .expect("CREATE TABLE should succeed");
        executor
            .execute_sql(
                "INSERT INTO person VALUES ('Alice', 'happy'), ('Bob', 'sad'), ('Carol', 'ok')",
            )
            .expect("INSERT should succeed");

        let result = executor
            .execute_sql("SELECT name, current_mood FROM person ORDER BY current_mood")
            .expect("SELECT should succeed");

        assert_eq!(result.num_rows(), 3);

        assert_eq!(get_string(&result, 0, 0), "Bob");
        assert_eq!(get_string(&result, 1, 0), "sad");
        assert_eq!(get_string(&result, 0, 1), "Carol");
        assert_eq!(get_string(&result, 1, 1), "ok");
        assert_eq!(get_string(&result, 0, 2), "Alice");
        assert_eq!(get_string(&result, 1, 2), "happy");
    }

    #[test]
    fn test_enum_between() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy')")
            .expect("CREATE TYPE should succeed");
        executor
            .execute_sql("CREATE TABLE person (name TEXT, current_mood mood)")
            .expect("CREATE TABLE should succeed");
        executor
            .execute_sql(
                "INSERT INTO person VALUES ('Alice', 'happy'), ('Bob', 'sad'), ('Carol', 'ok')",
            )
            .expect("INSERT should succeed");

        let result = executor
            .execute_sql(
                "SELECT name FROM person WHERE current_mood BETWEEN 'sad' AND 'ok' ORDER BY name",
            )
            .expect("SELECT should succeed");

        assert_eq!(result.num_rows(), 2);
        assert_eq!(get_string(&result, 0, 0), "Bob");
        assert_eq!(get_string(&result, 0, 1), "Carol");
    }
}

mod enum_casting {
    use super::*;
    use crate::common::get_string;

    #[test]
    fn test_enum_to_text_cast() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy')")
            .expect("CREATE TYPE should succeed");
        executor
            .execute_sql("CREATE TABLE person (name TEXT, current_mood mood)")
            .expect("CREATE TABLE should succeed");
        executor
            .execute_sql("INSERT INTO person VALUES ('Alice', 'happy')")
            .expect("INSERT should succeed");

        let result = executor
            .execute_sql("SELECT current_mood::TEXT FROM person")
            .expect("SELECT should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_string(&result, 0, 0), "happy");
    }

    #[test]
    fn test_text_to_enum_cast() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy')")
            .expect("CREATE TYPE should succeed");
        executor
            .execute_sql("CREATE TABLE person (name TEXT, current_mood mood)")
            .expect("CREATE TABLE should succeed");
        executor
            .execute_sql("INSERT INTO person VALUES ('Alice', 'happy'), ('Bob', 'sad')")
            .expect("INSERT should succeed");

        let result = executor
            .execute_sql("SELECT name FROM person WHERE current_mood = 'happy'::mood")
            .expect("SELECT should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_string(&result, 0, 0), "Alice");
    }
}

mod enum_null_handling {
    use super::*;
    use crate::common::{get_string, is_null};

    #[test]
    fn test_enum_null_value() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy')")
            .expect("CREATE TYPE should succeed");
        executor
            .execute_sql("CREATE TABLE person (name TEXT, current_mood mood)")
            .expect("CREATE TABLE should succeed");
        executor
            .execute_sql("INSERT INTO person VALUES ('Alice', NULL)")
            .expect("INSERT should succeed");

        let result = executor
            .execute_sql("SELECT name, current_mood FROM person")
            .expect("SELECT should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_string(&result, 0, 0), "Alice");
        assert!(is_null(&result, 1, 0), "current_mood should be NULL");
    }

    #[test]
    fn test_enum_is_null() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy')")
            .expect("CREATE TYPE should succeed");
        executor
            .execute_sql("CREATE TABLE person (name TEXT, current_mood mood)")
            .expect("CREATE TABLE should succeed");
        executor
            .execute_sql("INSERT INTO person VALUES ('Alice', NULL), ('Bob', 'happy')")
            .expect("INSERT should succeed");

        let result = executor
            .execute_sql("SELECT name FROM person WHERE current_mood IS NULL")
            .expect("SELECT should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_string(&result, 0, 0), "Alice");
    }

    #[test]
    fn test_enum_is_not_null() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy')")
            .expect("CREATE TYPE should succeed");
        executor
            .execute_sql("CREATE TABLE person (name TEXT, current_mood mood)")
            .expect("CREATE TABLE should succeed");
        executor
            .execute_sql("INSERT INTO person VALUES ('Alice', NULL), ('Bob', 'happy')")
            .expect("INSERT should succeed");

        let result = executor
            .execute_sql("SELECT name FROM person WHERE current_mood IS NOT NULL")
            .expect("SELECT should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_string(&result, 0, 0), "Bob");
    }
}
