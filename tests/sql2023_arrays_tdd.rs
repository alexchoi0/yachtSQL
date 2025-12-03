#![allow(dead_code)]
#![allow(unused_variables)]

use yachtsql::{DialectType, QueryExecutor};

fn create_executor() -> QueryExecutor {
    QueryExecutor::with_dialect(DialectType::PostgreSQL)
}

fn setup_large_arrays(executor: &mut QueryExecutor) {
    executor
        .execute_sql("DROP TABLE IF EXISTS large_arrays")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE large_arrays (id INT64, values ARRAY<INT64>)")
        .unwrap();
}

fn setup_products(executor: &mut QueryExecutor) {
    executor
        .execute_sql("DROP TABLE IF EXISTS products")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE products (name STRING, tags ARRAY<STRING>)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO products VALUES ('Widget', ['new', 'popular', 'sale'])")
        .unwrap();
    executor
        .execute_sql("INSERT INTO products VALUES ('Gadget', ['new'])")
        .unwrap();
    executor
        .execute_sql("INSERT INTO products VALUES ('Doohickey', [])")
        .unwrap();
}

fn setup_arr_data(executor: &mut QueryExecutor) {
    executor
        .execute_sql("DROP TABLE IF EXISTS arr_data")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE arr_data (id INT64, values ARRAY<INT64>)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO arr_data VALUES (1, NULL)")
        .unwrap();
}

fn setup_sequences(executor: &mut QueryExecutor) {
    executor
        .execute_sql("DROP TABLE IF EXISTS sequences")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE sequences (id INT64, data ARRAY<INT64>)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO sequences VALUES (1, ARRAY[1, 2, 3, 4, 5])")
        .unwrap();
    executor
        .execute_sql("INSERT INTO sequences VALUES (2, ARRAY[10, 20, 30, 40, 50])")
        .unwrap();
}

fn setup_items(executor: &mut QueryExecutor) {
    executor.execute_sql("DROP TABLE IF EXISTS items").unwrap();
    executor
        .execute_sql("CREATE TABLE items (id INT64, tags ARRAY<STRING>)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO items VALUES (1, ARRAY['a', 'b', 'c', 'd', 'e'])")
        .unwrap();
}

fn setup_metrics(executor: &mut QueryExecutor) {
    executor
        .execute_sql("DROP TABLE IF EXISTS metrics")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE metrics (id INT64, values ARRAY<FLOAT64>)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO metrics VALUES (1, ARRAY[1.1, 2.2, 3.3, 4.4, 5.5])")
        .unwrap();
}

fn setup_bounds(executor: &mut QueryExecutor) {
    executor.execute_sql("DROP TABLE IF EXISTS bounds").unwrap();
    executor
        .execute_sql("CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO bounds VALUES (1, 2, 4)")
        .unwrap();
}

#[test]
fn test_array_length_on_table_column() {
    let mut executor = create_executor();
    setup_large_arrays(&mut executor);

    let result = executor
        .execute_sql("SELECT ARRAY_LENGTH(values) FROM large_arrays")
        .unwrap();

    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_array_length_filter() {
    let mut executor = create_executor();
    setup_products(&mut executor);

    let result = executor
        .execute_sql("SELECT name FROM products WHERE ARRAY_LENGTH(tags) > 1")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let name = result.column(0).unwrap().get(0).unwrap();
    assert_eq!(name.as_str().unwrap(), "Widget");
}

#[test]
fn test_array_reverse_basic() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY_REVERSE(ARRAY[1, 2, 3, 4, 5]) as reversed")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let reversed = arr.as_array().unwrap();
    assert_eq!(reversed.len(), 5);
    assert_eq!(reversed[0].as_i64().unwrap(), 5);
    assert_eq!(reversed[1].as_i64().unwrap(), 4);
    assert_eq!(reversed[2].as_i64().unwrap(), 3);
    assert_eq!(reversed[3].as_i64().unwrap(), 2);
    assert_eq!(reversed[4].as_i64().unwrap(), 1);
}

#[test]
fn test_array_reverse_empty() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY_REVERSE(ARRAY[]) as reversed")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let reversed = arr.as_array().unwrap();
    assert_eq!(reversed.len(), 0);
}

#[test]
fn test_array_reverse_single() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY_REVERSE(ARRAY[42]) as reversed")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let reversed = arr.as_array().unwrap();
    assert_eq!(reversed.len(), 1);
    assert_eq!(reversed[0].as_i64().unwrap(), 42);
}

#[test]
fn test_array_distinct_basic() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY_DISTINCT(ARRAY[1, 2, 2, 3, 3, 3, 4]) as distinct_arr")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let distinct = arr.as_array().unwrap();
    assert_eq!(distinct.len(), 4);
}

#[test]
fn test_array_distinct_all_same() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY_DISTINCT(ARRAY[5, 5, 5, 5]) as distinct_arr")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let distinct = arr.as_array().unwrap();
    assert_eq!(distinct.len(), 1);
    assert_eq!(distinct[0].as_i64().unwrap(), 5);
}

#[test]
fn test_array_distinct_empty() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY_DISTINCT(ARRAY[]) as distinct_arr")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let distinct = arr.as_array().unwrap();
    assert_eq!(distinct.len(), 0);
}

#[test]
fn test_array_slice_basic() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY[10, 20, 30, 40, 50][2:4] as slice")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let slice = arr.as_array().unwrap();

    assert_eq!(slice.len(), 3);
    assert_eq!(slice[0].as_i64().unwrap(), 20);
    assert_eq!(slice[1].as_i64().unwrap(), 30);
    assert_eq!(slice[2].as_i64().unwrap(), 40);
}

#[test]
fn test_array_slice_strings_first_two() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY['a', 'b', 'c', 'd'][1:2] as first_two")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let slice = arr.as_array().unwrap();
    assert_eq!(slice.len(), 2);
    assert_eq!(slice[0].as_str().unwrap(), "a");
    assert_eq!(slice[1].as_str().unwrap(), "b");
}

#[test]
fn test_array_slice_last_two() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY[1, 2, 3, 4, 5][4:5] as last_two")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let slice = arr.as_array().unwrap();
    assert_eq!(slice.len(), 2);
    assert_eq!(slice[0].as_i64().unwrap(), 4);
    assert_eq!(slice[1].as_i64().unwrap(), 5);
}

#[test]
fn test_array_slice_single_element() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY[10, 20, 30][2:2] as single")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let slice = arr.as_array().unwrap();
    assert_eq!(slice.len(), 1);
    assert_eq!(slice[0].as_i64().unwrap(), 20);
}

#[test]
fn test_array_slice_full() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY[1, 2, 3, 4][1:4] as full")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let slice = arr.as_array().unwrap();
    assert_eq!(slice.len(), 4);
    assert_eq!(slice[0].as_i64().unwrap(), 1);
    assert_eq!(slice[3].as_i64().unwrap(), 4);
}

#[test]
fn test_array_slice_from_start() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY[10, 20, 30, 40, 50][:3] as from_start")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let slice = arr.as_array().unwrap();

    assert_eq!(slice.len(), 3);
    assert_eq!(slice[0].as_i64().unwrap(), 10);
    assert_eq!(slice[1].as_i64().unwrap(), 20);
    assert_eq!(slice[2].as_i64().unwrap(), 30);
}

#[test]
fn test_array_slice_to_end() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY[10, 20, 30, 40, 50][3:] as to_end")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let slice = arr.as_array().unwrap();

    assert_eq!(slice.len(), 3);
    assert_eq!(slice[0].as_i64().unwrap(), 30);
    assert_eq!(slice[1].as_i64().unwrap(), 40);
    assert_eq!(slice[2].as_i64().unwrap(), 50);
}

#[test]
fn test_array_slice_all() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY['x', 'y', 'z'][:] as all")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let slice = arr.as_array().unwrap();
    assert_eq!(slice.len(), 3);
    assert_eq!(slice[0].as_str().unwrap(), "x");
    assert_eq!(slice[1].as_str().unwrap(), "y");
    assert_eq!(slice[2].as_str().unwrap(), "z");
}

#[test]
fn test_array_slice_reversed_indices() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY[1, 2, 3, 4, 5][4:2] as empty_slice")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let slice = arr.as_array().unwrap();

    assert_eq!(slice.len(), 0);
}

#[test]
fn test_array_slice_empty_array() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY[][1:3] as empty_slice")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let slice = arr.as_array().unwrap();
    assert_eq!(slice.len(), 0);
}

#[test]
fn test_array_slice_clamped_high() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY[1, 2, 3][1:100] as clamped")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let slice = arr.as_array().unwrap();

    assert_eq!(slice.len(), 3);
}

#[test]
fn test_array_slice_clamped_low() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY[10, 20, 30][-100:2] as clamped")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let slice = arr.as_array().unwrap();

    assert_eq!(slice.len(), 2);
    assert_eq!(slice[0].as_i64().unwrap(), 10);
    assert_eq!(slice[1].as_i64().unwrap(), 20);
}

#[test]
fn test_array_slice_null_array() {
    let mut executor = create_executor();
    setup_arr_data(&mut executor);

    let result = executor
        .execute_sql("SELECT values[1:3] as slice FROM arr_data WHERE id = 1")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let value = result.column(0).unwrap().get(0).unwrap();

    assert!(value.is_null());
}

#[test]
fn test_array_slice_with_nulls() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY[1, NULL, 3, NULL, 5][2:4] as with_nulls")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let slice = arr.as_array().unwrap();
    assert_eq!(slice.len(), 3);
    assert!(slice[0].is_null());
    assert_eq!(slice[1].as_i64().unwrap(), 3);
    assert!(slice[2].is_null());
}

#[test]
fn test_array_slice_stepped_via_manual() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY[1, 2, 3, 4, 5, 6][1] as first, ARRAY[1, 2, 3, 4, 5, 6][3] as third, ARRAY[1, 2, 3, 4, 5, 6][5] as fifth")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let first = result.column(0).unwrap().get(0).unwrap().as_i64().unwrap();
    let third = result.column(1).unwrap().get(0).unwrap().as_i64().unwrap();
    let fifth = result.column(2).unwrap().get(0).unwrap().as_i64().unwrap();

    assert_eq!(first, 1);
    assert_eq!(third, 3);
    assert_eq!(fifth, 5);
}

#[test]
fn test_array_reversed_via_function() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY_REVERSE(ARRAY[1, 2, 3, 4, 5]) as reversed")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let slice = arr.as_array().unwrap();

    assert_eq!(slice.len(), 5);
    assert_eq!(slice[0].as_i64().unwrap(), 5);
    assert_eq!(slice[4].as_i64().unwrap(), 1);
}

#[test]
fn test_array_slice_in_where_clause() {
    let mut executor = create_executor();
    setup_sequences(&mut executor);

    let result = executor
        .execute_sql("SELECT id FROM sequences WHERE ARRAY_LENGTH(data[2:4]) = 3")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_array_slice_chained_subscript() {
    let mut executor = create_executor();
    setup_items(&mut executor);

    let result = executor
        .execute_sql("SELECT id FROM items WHERE tags[2:4][1] = 'b'")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let id = result.column(0).unwrap().get(0).unwrap();
    assert_eq!(id.as_i64().unwrap(), 1);
}

#[test]
fn test_array_concat_slices() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql(
            "SELECT ARRAY_CONCAT(ARRAY[1, 2, 3][1:2], ARRAY[4, 5, 6][2:3]) as concat_slices",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let concat = arr.as_array().unwrap();

    assert_eq!(concat.len(), 4);
    assert_eq!(concat[0].as_i64().unwrap(), 1);
    assert_eq!(concat[1].as_i64().unwrap(), 2);
    assert_eq!(concat[2].as_i64().unwrap(), 5);
    assert_eq!(concat[3].as_i64().unwrap(), 6);
}

#[test]
fn test_array_length_of_slice() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4, 5, 6, 7][3:6]) as slice_len")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let len = result.column(0).unwrap().get(0).unwrap();
    assert_eq!(len.as_i64().unwrap(), 4);
}

#[test]
fn test_array_slice_length_in_where() {
    let mut executor = create_executor();
    setup_metrics(&mut executor);

    let result = executor
        .execute_sql("SELECT id FROM metrics WHERE ARRAY_LENGTH(values[2:4]) > 0")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
}

#[test]
fn test_nested_array_outer_slice() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql(
            "SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6], ARRAY[7, 8]][2:3] as outer_slice",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let slice = arr.as_array().unwrap();

    assert_eq!(slice.len(), 2);
    let inner1 = slice[0].as_array().unwrap();
    assert_eq!(inner1[0].as_i64().unwrap(), 3);
    assert_eq!(inner1[1].as_i64().unwrap(), 4);
}

#[test]
fn test_nested_array_inner_slice() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql(
            "SELECT ARRAY[ARRAY[1, 2, 3, 4, 5], ARRAY[6, 7, 8, 9, 10]][1][2:4] as inner_slice",
        )
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let slice = arr.as_array().unwrap();

    assert_eq!(slice.len(), 3);
    assert_eq!(slice[0].as_i64().unwrap(), 2);
    assert_eq!(slice[1].as_i64().unwrap(), 3);
    assert_eq!(slice[2].as_i64().unwrap(), 4);
}

#[test]
fn test_nested_array_double_slice() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let slice = arr.as_array().unwrap();

    assert_eq!(slice.len(), 2);
    assert_eq!(slice[0].as_i64().unwrap(), 2);
    assert_eq!(slice[1].as_i64().unwrap(), 3);
}

#[test]
fn test_array_slice_float_indices_error() {
    let mut executor = create_executor();

    let result = executor.execute_sql("SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice");

    assert!(result.is_err());
}

#[test]
fn test_array_slice_string_indices_error() {
    let mut executor = create_executor();

    let result = executor.execute_sql("SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice");

    assert!(result.is_err());
}

#[test]
fn test_string_slice_error() {
    let mut executor = create_executor();

    let result = executor.execute_sql("SELECT 'not_an_array'[1:3] as bad_slice");

    assert!(result.is_err());
}

#[test]
fn test_multiple_slices_in_select() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third")
        .unwrap();

    assert_eq!(result.num_rows(), 1);

    let first = result.column(0).unwrap().get(0).unwrap();
    let first_arr = first.as_array().unwrap();
    assert_eq!(first_arr.len(), 3);
    assert_eq!(first_arr[0].as_i64().unwrap(), 1);

    let second = result.column(1).unwrap().get(0).unwrap();
    let second_arr = second.as_array().unwrap();
    assert_eq!(second_arr.len(), 3);
    assert_eq!(second_arr[0].as_i64().unwrap(), 4);

    let third = result.column(2).unwrap().get(0).unwrap();
    let third_arr = third.as_array().unwrap();
    assert_eq!(third_arr.len(), 4);
    assert_eq!(third_arr[0].as_i64().unwrap(), 7);
}

#[test]
fn test_array_slice_computed_indices() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let slice = arr.as_array().unwrap();

    assert_eq!(slice.len(), 3);
    assert_eq!(slice[0].as_i64().unwrap(), 20);
    assert_eq!(slice[1].as_i64().unwrap(), 30);
    assert_eq!(slice[2].as_i64().unwrap(), 40);
}

#[test]
fn test_array_slice_with_variable_expressions() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY['a', 'b', 'c', 'd', 'e'][CASE WHEN 1=1 THEN 2 ELSE 1 END:CASE WHEN 1=1 THEN 4 ELSE 3 END] as dynamic_slice")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let slice = arr.as_array().unwrap();

    assert_eq!(slice.len(), 3);
    assert_eq!(slice[0].as_str().unwrap(), "b");
    assert_eq!(slice[1].as_str().unwrap(), "c");
    assert_eq!(slice[2].as_str().unwrap(), "d");
}

#[test]
fn test_deep_nested_array_access() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY[ARRAY[ARRAY[ARRAY[ARRAY[1, 2], ARRAY[3, 4]], ARRAY[ARRAY[5, 6], ARRAY[7, 8]]], ARRAY[ARRAY[ARRAY[9, 10], ARRAY[11, 12]], ARRAY[ARRAY[13, 14], ARRAY[15, 16]]]]][1][1][1][1][1] as deep")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let value = result.column(0).unwrap().get(0).unwrap();

    assert_eq!(value.as_i64().unwrap(), 1);
}

#[test]
fn test_array_subscript_cast_index() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY[10, 20, 30][CAST('2' AS INT64)] as casted")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let value = result.column(0).unwrap().get(0).unwrap();
    assert_eq!(value.as_i64().unwrap(), 20);
}

#[test]
fn test_array_subscript_multiple_types() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY[1, 2, 3][1] as int_elem, ARRAY['a', 'b', 'c'][1] as str_elem, ARRAY[1.1, 2.2, 3.3][1] as float_elem")
        .unwrap();

    assert_eq!(result.num_rows(), 1);

    let int_elem = result.column(0).unwrap().get(0).unwrap();
    assert_eq!(int_elem.as_i64().unwrap(), 1);

    let str_elem = result.column(1).unwrap().get(0).unwrap();
    assert_eq!(str_elem.as_str().unwrap(), "a");

    let float_elem = result.column(2).unwrap().get(0).unwrap();
    assert!((float_elem.as_f64().unwrap() - 1.1).abs() < 0.001);
}

#[test]
fn test_array_slice_strings() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY['hello', 'world', 'test'][1:2] as str_slice")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let slice = arr.as_array().unwrap();
    assert_eq!(slice.len(), 2);
    assert_eq!(slice[0].as_str().unwrap(), "hello");
    assert_eq!(slice[1].as_str().unwrap(), "world");
}

#[test]
fn test_array_length_with_slice() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4, 5][2:4]) as len")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let len = result.column(0).unwrap().get(0).unwrap();
    assert_eq!(len.as_i64().unwrap(), 3);
}

#[test]
fn test_array_concat_basic() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY_CONCAT(ARRAY[1, 2], ARRAY[3, 4]) as concat")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let concat = arr.as_array().unwrap();
    assert_eq!(concat.len(), 4);
    assert_eq!(concat[0].as_i64().unwrap(), 1);
    assert_eq!(concat[3].as_i64().unwrap(), 4);
}

#[test]
fn test_array_reverse_strings() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY_REVERSE(ARRAY['a', 'b', 'c']) as reversed")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let reversed = arr.as_array().unwrap();
    assert_eq!(reversed.len(), 3);
    assert_eq!(reversed[0].as_str().unwrap(), "c");
    assert_eq!(reversed[1].as_str().unwrap(), "b");
    assert_eq!(reversed[2].as_str().unwrap(), "a");
}

#[test]
fn test_array_distinct_strings() {
    let mut executor = create_executor();

    let result = executor
        .execute_sql("SELECT ARRAY_DISTINCT(ARRAY['a', 'b', 'a', 'c', 'b']) as distinct_arr")
        .unwrap();

    assert_eq!(result.num_rows(), 1);
    let arr = result.column(0).unwrap().get(0).unwrap();
    let distinct = arr.as_array().unwrap();
    assert_eq!(distinct.len(), 3);
}
