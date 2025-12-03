mod common;

use common::{get_bool_by_name, get_i64_by_name, get_string_by_name};
use yachtsql::{DialectType, QueryExecutor};

fn create_executor() -> QueryExecutor {
    QueryExecutor::with_dialect(DialectType::PostgreSQL)
}

mod array_subscript {
    use super::*;

    #[test]
    fn test_array_subscript_first_element() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT ARRAY[10, 20, 30][1] as elem")
            .expect("Array subscript should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64_by_name(&result, 0, "elem"), 10);
    }

    #[test]
    fn test_array_subscript_middle_element() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT ARRAY[10, 20, 30][2] as elem")
            .expect("Array subscript should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64_by_name(&result, 0, "elem"), 20);
    }

    #[test]
    fn test_array_subscript_last_element() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT ARRAY[10, 20, 30][3] as elem")
            .expect("Array subscript should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64_by_name(&result, 0, "elem"), 30);
    }

    #[test]
    fn test_array_subscript_out_of_bounds_returns_null() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT ARRAY[10, 20, 30][10] IS NULL as is_null")
            .expect("Array subscript should succeed");

        assert_eq!(result.num_rows(), 1);
        assert!(get_bool_by_name(&result, 0, "is_null"));
    }

    #[test]
    fn test_array_subscript_zero_index_returns_null() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT ARRAY[10, 20, 30][0] IS NULL as is_null")
            .expect("Array subscript should succeed");

        assert_eq!(result.num_rows(), 1);
        assert!(get_bool_by_name(&result, 0, "is_null"));
    }

    #[test]
    fn test_array_subscript_negative_index_returns_null() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT ARRAY[10, 20, 30][-1] IS NULL as is_null")
            .expect("Array subscript should succeed");

        assert_eq!(result.num_rows(), 1);
        assert!(get_bool_by_name(&result, 0, "is_null"));
    }

    #[test]
    fn test_array_subscript_with_string_array() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT ARRAY['a', 'b', 'c'][2] as elem")
            .expect("Array subscript should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_string_by_name(&result, 0, "elem"), "b");
    }
}

mod array_slice {
    use super::*;

    #[test]
    fn test_array_slice_middle() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT ARRAY_LENGTH(ARRAY[10, 20, 30, 40, 50][2:4]) as len")
            .expect("Array slice should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64_by_name(&result, 0, "len"), 3);
    }

    #[test]
    fn test_array_slice_from_start() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT ARRAY_LENGTH(ARRAY[10, 20, 30, 40, 50][:3]) as len")
            .expect("Array slice should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64_by_name(&result, 0, "len"), 3);
    }

    #[test]
    fn test_array_slice_to_end() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT ARRAY_LENGTH(ARRAY[10, 20, 30, 40, 50][3:]) as len")
            .expect("Array slice should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64_by_name(&result, 0, "len"), 3);
    }

    #[test]
    fn test_array_slice_full() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT ARRAY_LENGTH(ARRAY[10, 20, 30][:]) as len")
            .expect("Array slice should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64_by_name(&result, 0, "len"), 3);
    }

    #[test]
    fn test_array_slice_single_element() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT ARRAY_LENGTH(ARRAY[10, 20, 30][2:2]) as len")
            .expect("Array slice should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64_by_name(&result, 0, "len"), 1);
    }

    #[test]
    fn test_array_slice_element_access() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT (ARRAY[10, 20, 30, 40, 50][2:4])[1] as elem")
            .expect("Array slice element access should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64_by_name(&result, 0, "elem"), 20);
    }

    #[test]
    fn test_array_slice_empty_result() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT ARRAY_LENGTH(ARRAY[10, 20, 30][4:2]) as len")
            .expect("Array slice should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64_by_name(&result, 0, "len"), 0);
    }

    #[test]
    fn test_array_slice_out_of_bounds_clamped() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT ARRAY_LENGTH(ARRAY[10, 20, 30][1:100]) as len")
            .expect("Array slice should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64_by_name(&result, 0, "len"), 3);
    }
}

mod array_contains {
    use super::*;

    #[test]
    fn test_array_contains_true() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT ARRAY[1, 2, 3, 4] @> ARRAY[2, 3] as contains")
            .expect("Array contains should succeed");

        assert_eq!(result.num_rows(), 1);
        assert!(get_bool_by_name(&result, 0, "contains"));
    }

    #[test]
    fn test_array_contains_false() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT ARRAY[1, 2, 3] @> ARRAY[2, 5] as contains")
            .expect("Array contains should succeed");

        assert_eq!(result.num_rows(), 1);
        assert!(!get_bool_by_name(&result, 0, "contains"));
    }

    #[test]
    fn test_array_contains_superset() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT ARRAY[1, 2, 3, 4, 5] @> ARRAY[1] as contains")
            .expect("Array contains should succeed");

        assert_eq!(result.num_rows(), 1);
        assert!(get_bool_by_name(&result, 0, "contains"));
    }

    #[test]
    fn test_array_contains_same_array() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT ARRAY[1, 2, 3] @> ARRAY[1, 2, 3] as contains")
            .expect("Array contains should succeed");

        assert_eq!(result.num_rows(), 1);
        assert!(get_bool_by_name(&result, 0, "contains"));
    }

    #[test]
    fn test_array_contains_with_duplicates() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT ARRAY[1, 2, 2, 3] @> ARRAY[2] as contains")
            .expect("Array contains should succeed");

        assert_eq!(result.num_rows(), 1);
        assert!(get_bool_by_name(&result, 0, "contains"));
    }
}

mod array_contained_by {
    use super::*;

    #[test]
    fn test_array_contained_by_true() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT ARRAY[2, 3] <@ ARRAY[1, 2, 3, 4] as contained")
            .expect("Array contained by should succeed");

        assert_eq!(result.num_rows(), 1);
        assert!(get_bool_by_name(&result, 0, "contained"));
    }

    #[test]
    fn test_array_contained_by_false() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT ARRAY[2, 5] <@ ARRAY[1, 2, 3] as contained")
            .expect("Array contained by should succeed");

        assert_eq!(result.num_rows(), 1);
        assert!(!get_bool_by_name(&result, 0, "contained"));
    }

    #[test]
    fn test_array_contained_by_subset() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT ARRAY[1] <@ ARRAY[1, 2, 3, 4, 5] as contained")
            .expect("Array contained by should succeed");

        assert_eq!(result.num_rows(), 1);
        assert!(get_bool_by_name(&result, 0, "contained"));
    }
}

mod array_overlap {
    use super::*;

    #[test]
    fn test_array_overlap_true() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT ARRAY[1, 2, 3] && ARRAY[3, 4, 5] as overlaps")
            .expect("Array overlap should succeed");

        assert_eq!(result.num_rows(), 1);
        assert!(get_bool_by_name(&result, 0, "overlaps"));
    }

    #[test]
    fn test_array_overlap_false() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT ARRAY[1, 2, 3] && ARRAY[4, 5, 6] as overlaps")
            .expect("Array overlap should succeed");

        assert_eq!(result.num_rows(), 1);
        assert!(!get_bool_by_name(&result, 0, "overlaps"));
    }

    #[test]
    fn test_array_overlap_no_common() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT ARRAY[1, 2, 3] && ARRAY[10, 20, 30] as overlaps")
            .expect("Array overlap should succeed");

        assert_eq!(result.num_rows(), 1);
        assert!(!get_bool_by_name(&result, 0, "overlaps"));
    }

    #[test]
    fn test_array_overlap_single_common_element() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT ARRAY[1, 100, 200] && ARRAY[2, 100, 300] as overlaps")
            .expect("Array overlap should succeed");

        assert_eq!(result.num_rows(), 1);
        assert!(get_bool_by_name(&result, 0, "overlaps"));
    }

    #[test]
    fn test_array_overlap_identical_arrays() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT ARRAY[1, 2, 3] && ARRAY[1, 2, 3] as overlaps")
            .expect("Array overlap should succeed");

        assert_eq!(result.num_rows(), 1);
        assert!(get_bool_by_name(&result, 0, "overlaps"));
    }
}

mod array_operators_null {
    use super::*;

    #[test]
    fn test_array_contains_null_left() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT (NULL @> ARRAY[1, 2]) IS NULL as is_null")
            .expect("Array contains with NULL should succeed");

        assert_eq!(result.num_rows(), 1);
        assert!(get_bool_by_name(&result, 0, "is_null"));
    }

    #[test]
    fn test_array_contains_null_right() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT (ARRAY[1, 2, 3] @> NULL) IS NULL as is_null")
            .expect("Array contains with NULL should succeed");

        assert_eq!(result.num_rows(), 1);
        assert!(get_bool_by_name(&result, 0, "is_null"));
    }

    #[test]
    fn test_array_overlap_null() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT (ARRAY[1, 2, 3] && NULL) IS NULL as is_null")
            .expect("Array overlap with NULL should succeed");

        assert_eq!(result.num_rows(), 1);
        assert!(get_bool_by_name(&result, 0, "is_null"));
    }
}

mod array_operators_where {
    use super::*;

    #[test]
    fn test_array_contains_in_where() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS products")
            .unwrap();
        executor
            .execute_sql("CREATE TABLE products (id INT64, name STRING, tags ARRAY<STRING>)")
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO products VALUES
                (1, 'Laptop', ARRAY['electronics', 'computers']),
                (2, 'Book', ARRAY['books', 'education']),
                (3, 'Phone', ARRAY['electronics', 'mobile'])",
            )
            .unwrap();

        let result = executor
            .execute_sql("SELECT name FROM products WHERE tags @> ARRAY['electronics'] ORDER BY id")
            .expect("Array contains in WHERE should succeed");

        assert_eq!(result.num_rows(), 2);
        assert_eq!(get_string_by_name(&result, 0, "name"), "Laptop");
        assert_eq!(get_string_by_name(&result, 1, "name"), "Phone");
    }

    #[test]
    fn test_array_overlap_in_where() {
        let mut executor = create_executor();

        executor.execute_sql("DROP TABLE IF EXISTS items").unwrap();
        executor
            .execute_sql("CREATE TABLE items (id INT64, categories ARRAY<INT64>)")
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO items VALUES
                (1, ARRAY[1, 2, 3]),
                (2, ARRAY[7, 8, 9]),
                (3, ARRAY[2, 4, 6])",
            )
            .unwrap();

        let result = executor
            .execute_sql("SELECT id FROM items WHERE categories && ARRAY[2, 4] ORDER BY id")
            .expect("Array overlap in WHERE should succeed");

        assert_eq!(result.num_rows(), 2);
        assert_eq!(get_i64_by_name(&result, 0, "id"), 1);
        assert_eq!(get_i64_by_name(&result, 1, "id"), 3);
    }
}

mod combined_array_ops {
    use super::*;

    #[test]
    fn test_subscript_after_slice() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT (ARRAY[10, 20, 30, 40, 50][2:4])[2] as elem")
            .expect("Subscript after slice should succeed");

        assert_eq!(result.num_rows(), 1);
        assert_eq!(get_i64_by_name(&result, 0, "elem"), 30);
    }

    #[test]
    fn test_array_operations_with_column() {
        let mut executor = create_executor();

        executor
            .execute_sql("DROP TABLE IF EXISTS arr_test")
            .unwrap();
        executor
            .execute_sql("CREATE TABLE arr_test (id INT64, nums ARRAY<INT64>)")
            .unwrap();
        executor
            .execute_sql(
                "INSERT INTO arr_test VALUES
                (1, ARRAY[10, 20, 30]),
                (2, ARRAY[100, 200, 300])",
            )
            .unwrap();

        let result = executor
            .execute_sql("SELECT id, nums[2] as second FROM arr_test ORDER BY id")
            .expect("Column subscript should succeed");

        assert_eq!(result.num_rows(), 2);
        assert_eq!(get_i64_by_name(&result, 0, "id"), 1);
        assert_eq!(get_i64_by_name(&result, 0, "second"), 20);
        assert_eq!(get_i64_by_name(&result, 1, "id"), 2);
        assert_eq!(get_i64_by_name(&result, 1, "second"), 200);
    }
}
