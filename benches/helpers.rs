#![allow(dead_code)]

use std::time::Duration;

use criterion::BenchmarkGroup;
use criterion::measurement::Measurement;
use yachtsql::QueryExecutor;

pub const fn get_sample_size() -> usize {
    #[cfg(feature = "bench-large-sample")]
    {
        100
    }
    #[cfg(not(feature = "bench-large-sample"))]
    {
        10
    }
}

pub fn configure_standard<M: Measurement>(group: &mut BenchmarkGroup<M>) {
    group.sample_size(get_sample_size());
    group.measurement_time(Duration::from_secs(3));
    group.warm_up_time(Duration::from_secs(1));
}

pub fn configure_heavy<M: Measurement>(group: &mut BenchmarkGroup<M>) {
    group.sample_size(get_sample_size());
    group.measurement_time(Duration::from_secs(3));
    group.warm_up_time(Duration::from_millis(100));
}

pub fn configure_quick<M: Measurement>(group: &mut BenchmarkGroup<M>) {
    group.sample_size(10);
    group.measurement_time(Duration::from_secs(3));
    group.warm_up_time(Duration::from_millis(500));
}

pub fn calculate_basic_row_bytes(row_id: usize) -> u64 {
    8 + format!("name_{}", row_id).len() as u64 + 8 + 8
}

pub fn calculate_sales_bytes(rows: usize, num_products: usize) -> u64 {
    let mut total = 0u64;

    total += (rows * 8 * 3) as u64;

    for product_id in 0..num_products {
        let product_str_len = format!("product_{}", product_id).len();
        let count = rows / num_products
            + if product_id < rows % num_products {
                1
            } else {
                0
            };
        total += (product_str_len * count) as u64;
    }

    for region_id in 0..5 {
        let region_str_len = format!("region_{}", region_id).len();
        let count = rows / 5 + if region_id < rows % 5 { 1 } else { 0 };
        total += (region_str_len * count) as u64;
    }

    total
}

pub fn create_basic_table(executor: &mut QueryExecutor, table_name: &str) {
    executor
        .execute_sql(&format!(
            "CREATE TABLE {} (id INT64, name STRING, value INT64, score FLOAT64)",
            table_name
        ))
        .unwrap();
}

pub fn insert_basic_rows(executor: &mut QueryExecutor, table_name: &str, rows: usize) {
    for i in 0..rows {
        executor
            .execute_sql(&format!(
                "INSERT INTO {} VALUES ({}, 'name_{}', {}, {})",
                table_name,
                i,
                i,
                i * 10,
                i as f64 * 1.5
            ))
            .unwrap();
    }
}

pub fn setup_basic_table(executor: &mut QueryExecutor, table_name: &str, rows: usize) {
    create_basic_table(executor, table_name);
    insert_basic_rows(executor, table_name, rows);
}

pub fn create_sales_table(executor: &mut QueryExecutor) {
    executor
        .execute_sql(
            "CREATE TABLE sales (
                id INT64,
                product STRING,
                region STRING,
                amount INT64,
                quantity INT64
            )",
        )
        .unwrap();
}

pub fn insert_sales_data(executor: &mut QueryExecutor, rows: usize, num_products: usize) {
    for i in 0..rows {
        let product_id = i % num_products;
        let region_id = i % 5;
        executor
            .execute_sql(&format!(
                "INSERT INTO sales VALUES ({}, 'product_{}', 'region_{}', {}, {})",
                i,
                product_id,
                region_id,
                (i * 100) % 10000,
                (i % 50) + 1
            ))
            .unwrap();
    }
}

pub fn setup_sales_table(executor: &mut QueryExecutor, rows: usize, num_products: usize) {
    create_sales_table(executor);
    insert_sales_data(executor, rows, num_products);
}

pub fn setup_join_tables(
    executor: &mut QueryExecutor,
    left_size: usize,
    right_size: usize,
    match_ratio: f64,
) {
    executor
        .execute_sql("CREATE TABLE left_table (id INT64, value STRING, amount INT64)")
        .unwrap();

    executor
        .execute_sql("CREATE TABLE right_table (id INT64, data STRING, score INT64)")
        .unwrap();

    for i in 0..left_size {
        executor
            .execute_sql(&format!(
                "INSERT INTO left_table VALUES ({}, 'left_{}', {})",
                i,
                i,
                i * 10
            ))
            .unwrap();
    }

    for i in 0..right_size {
        let id = if (i as f64 / right_size as f64) < match_ratio {
            i % left_size
        } else {
            left_size + i
        };

        executor
            .execute_sql(&format!(
                "INSERT INTO right_table VALUES ({}, 'right_{}', {})",
                id,
                i,
                i * 5
            ))
            .unwrap();
    }
}

pub fn setup_employees_table(executor: &mut QueryExecutor, rows: usize) {
    executor
        .execute_sql(
            "CREATE TABLE employees (
                id INT64,
                name STRING,
                department STRING,
                salary INT64,
                manager_id INT64
            )",
        )
        .unwrap();

    for i in 0..rows {
        let dept_id = i % 5;
        let manager_id = if i > 0 { i / 10 } else { 0 };
        executor
            .execute_sql(&format!(
                "INSERT INTO employees VALUES ({}, 'emp_{}', 'dept_{}', {}, {})",
                i,
                i,
                dept_id,
                30000 + (i * 1000) % 70000,
                manager_id
            ))
            .unwrap();
    }
}

pub fn bench_with_fresh_executor<S, R, O>(b: &mut criterion::Bencher, setup: S, routine: R)
where
    S: Fn() -> QueryExecutor,
    R: FnMut(QueryExecutor) -> O,
{
    b.iter_batched(setup, routine, criterion::BatchSize::SmallInput);
}

pub fn bench_with_setup_once<S, R, O>(b: &mut criterion::Bencher, mut setup: S, mut routine: R)
where
    S: FnMut() -> QueryExecutor,
    R: FnMut(&mut QueryExecutor) -> O,
{
    let mut executor = setup();
    b.iter(|| criterion::black_box(routine(&mut executor)));
}
