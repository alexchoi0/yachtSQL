#![allow(dead_code)]

pub mod assertions;

use yachtsql::{DialectType, QueryExecutor, Result, Value};

pub fn setup_executor() -> QueryExecutor {
    QueryExecutor::with_dialect(DialectType::PostgreSQL)
}

pub fn assert_batch_empty(batch: &yachtsql::RecordBatch) {
    assert_eq!(
        batch.num_rows(),
        0,
        "expected zero rows but found {}",
        batch.num_rows()
    );
    assert!(
        batch.schema().fields().is_empty(),
        "expected zero columns but schema has {} fields",
        batch.schema().fields().len()
    );
    let cols = batch.columns().unwrap_or(&[]);
    assert!(
        cols.is_empty(),
        "expected zero column buffers but found {}",
        cols.len()
    );
}

pub fn assert_float_eq(actual: f64, expected: f64, epsilon: f64) {
    let diff = (actual - expected).abs();
    assert!(
        diff < epsilon,
        "Float values not equal within epsilon: actual={}, expected={}, diff={}, epsilon={}",
        actual,
        expected,
        diff,
        epsilon
    );
}

pub fn assert_error_contains<T>(result: Result<T>, keywords: &[&str]) {
    match result {
        Ok(_) => panic!("Expected error but got Ok result"),
        Err(e) => {
            let error_msg = e.to_string().to_lowercase();
            let found = keywords
                .iter()
                .any(|keyword| error_msg.contains(&keyword.to_lowercase()));
            assert!(
                found,
                "Error message '{}' does not contain any of the expected keywords: {:?}",
                e, keywords
            );
        }
    }
}

pub fn create_table_with_schema(
    executor: &mut QueryExecutor,
    table_name: &str,
    columns: &[(&str, &str)],
) -> Result<()> {
    let columns_def = columns
        .iter()
        .map(|(name, type_)| format!("{} {}", name, type_))
        .collect::<Vec<_>>()
        .join(", ");
    let sql = format!("CREATE TABLE {} ({})", table_name, columns_def);
    executor.execute_sql(&sql)?;
    Ok(())
}

pub fn insert_rows(
    executor: &mut QueryExecutor,
    table_name: &str,
    rows: Vec<Vec<&str>>,
) -> Result<()> {
    for row in rows {
        let values = row.join(", ");
        let sql = format!("INSERT INTO {} VALUES ({})", table_name, values);
        executor.execute_sql(&sql)?;
    }
    Ok(())
}

pub fn setup_table_with_id_values(
    executor: &mut QueryExecutor,
    table_name: &str,
    data: &[(i64, f64)],
) -> Result<()> {
    executor.execute_sql(&format!(
        "CREATE TABLE {} (id INT64, value FLOAT64)",
        table_name
    ))?;
    for (id, value) in data {
        executor.execute_sql(&format!(
            "INSERT INTO {} VALUES ({}, {})",
            table_name, id, value
        ))?;
    }
    Ok(())
}

pub fn assert_query_float_eq(executor: &mut QueryExecutor, sql: &str, expected: f64, epsilon: f64) {
    let batch = executor.execute_sql(sql).unwrap();
    assert_eq!(batch.num_rows(), 1);
    let column = batch.column(0).expect("Column 0 not found");
    let value = column.get(0).unwrap();
    if let Some(f) = value.as_f64() {
        assert_float_eq(f, expected, epsilon);
    } else {
        panic!("Expected Float64, got {:?}", value);
    }
}

pub fn get_string_value(batch: &yachtsql::RecordBatch, row: usize, col: usize) -> Option<String> {
    if let Some(column) = batch.column(col)
        && let Ok(value) = column.get(row)
        && let Some(s) = value.as_str()
    {
        return Some(s.to_string());
    }
    None
}

pub fn build_repeated_expression(expr: &str, count: usize, separator: &str) -> String {
    vec![expr; count].join(separator)
}

pub fn build_nested_expression(wrapper: &str, inner: &str, depth: usize) -> String {
    let mut result = inner.to_string();
    for _ in 0..depth {
        result = format!("{} ({})", wrapper, result);
    }
    result
}

pub fn setup_bool_table() -> QueryExecutor {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);
    executor
        .execute_sql("CREATE TABLE bools (id INT64, val BOOL)")
        .unwrap();
    executor
}

pub fn insert_bool(executor: &mut QueryExecutor, id: i64, val: Option<bool>) {
    let val_str = match val {
        Some(true) => "TRUE",
        Some(false) => "FALSE",
        None => "NULL",
    };
    executor
        .execute_sql(&format!("INSERT INTO bools VALUES ({}, {})", id, val_str))
        .unwrap();
}

pub fn assert_query_bool(executor: &mut QueryExecutor, sql: &str, expected: Option<bool>) {
    let batch = executor.execute_sql(sql).unwrap();
    assert_eq!(batch.num_rows(), 1);
    let column = batch.column(0).expect("Column 0 not found");
    let value = column.get(0).unwrap();
    match expected {
        Some(exp) => {
            if let Some(b) = value.as_bool() {
                assert_eq!(b, exp);
            } else {
                panic!("Expected Bool({:?}), got {:?}", exp, value);
            }
        }
        None => {
            if !value.is_null() {
                panic!("Expected NULL, got {:?}", value);
            }
        }
    }
}

pub fn setup_table_with_float_values(
    executor: &mut QueryExecutor,
    table_name: &str,
    values: &[f64],
) -> Result<()> {
    executor.execute_sql(&format!("CREATE TABLE {} (value FLOAT64)", table_name))?;
    for value in values {
        executor.execute_sql(&format!("INSERT INTO {} VALUES ({})", table_name, value))?;
    }
    Ok(())
}

pub fn assert_query_null(executor: &mut QueryExecutor, sql: &str) {
    let batch = executor.execute_sql(sql).unwrap();
    assert_eq!(batch.num_rows(), 1);
    let column = batch.column(0).expect("Column 0 not found");
    let value = column.get(0).unwrap();
    assert!(value.is_null(), "Expected NULL, got {:?}", value);
}

pub fn assert_query_null_simple(executor: &mut QueryExecutor, sql: &str) {
    assert_query_null(executor, sql);
}

pub fn assert_query_error(executor: &mut QueryExecutor, sql: &str, keywords: &[&str]) {
    assert_error_contains(executor.execute_sql(sql), keywords);
}

pub fn assert_row_count(batch: &yachtsql::RecordBatch, expected_count: usize) {
    assert_eq!(
        batch.num_rows(),
        expected_count,
        "Expected {} rows, but got {}",
        expected_count,
        batch.num_rows()
    );
}

pub fn new_executor() -> QueryExecutor {
    setup_executor()
}

pub fn table_exists(executor: &mut QueryExecutor, table_name: &str) -> bool {
    let query = format!("SELECT COUNT(*) FROM {}", table_name);
    executor.execute_sql(&query).is_ok()
}

pub fn assert_error_contains_with_context<T>(result: Result<T>, keywords: &[&str], context: &str) {
    match result {
        Ok(_) => panic!("{}: Expected error but got Ok result", context),
        Err(e) => {
            let error_msg = e.to_string().to_lowercase();
            let found = keywords
                .iter()
                .any(|keyword| error_msg.contains(&keyword.to_lowercase()));
            assert!(
                found,
                "{}: Error '{}' does not contain any of the expected keywords: {:?}",
                context, e, keywords
            );
        }
    }
}

pub fn get_i64(result: &yachtsql::RecordBatch, col: usize, row: usize) -> i64 {
    result
        .column(col)
        .unwrap()
        .get(row)
        .unwrap()
        .as_i64()
        .unwrap()
}

pub fn get_string(result: &yachtsql::RecordBatch, col: usize, row: usize) -> String {
    let value = result.column(col).unwrap().get(row).unwrap();
    value.as_str().unwrap().to_string()
}

pub fn get_f64(result: &yachtsql::RecordBatch, col: usize, row: usize) -> f64 {
    result
        .column(col)
        .unwrap()
        .get(row)
        .unwrap()
        .as_f64()
        .unwrap()
}

pub fn get_bool(result: &yachtsql::RecordBatch, col: usize, row: usize) -> bool {
    result
        .column(col)
        .unwrap()
        .get(row)
        .unwrap()
        .as_bool()
        .unwrap()
}

pub fn is_null(result: &yachtsql::RecordBatch, col: usize, row: usize) -> bool {
    result.column(col).unwrap().get(row).unwrap().is_null()
}

fn find_column_index(result: &yachtsql::RecordBatch, col_name: &str) -> usize {
    result
        .schema()
        .fields()
        .iter()
        .position(|f| f.name == col_name)
        .unwrap_or_else(|| panic!("Column '{}' not found in schema", col_name))
}

pub fn get_i64_by_name(result: &yachtsql::RecordBatch, row: usize, col_name: &str) -> i64 {
    let col = find_column_index(result, col_name);
    get_i64(result, col, row)
}

pub fn get_string_by_name(result: &yachtsql::RecordBatch, row: usize, col_name: &str) -> String {
    let col = find_column_index(result, col_name);
    get_string(result, col, row)
}

pub fn get_f64_by_name(result: &yachtsql::RecordBatch, row: usize, col_name: &str) -> f64 {
    let col = find_column_index(result, col_name);
    get_f64(result, col, row)
}

pub fn get_bool_by_name(result: &yachtsql::RecordBatch, row: usize, col_name: &str) -> bool {
    let col = find_column_index(result, col_name);
    get_bool(result, col, row)
}

pub fn is_null_by_name(result: &yachtsql::RecordBatch, row: usize, col_name: &str) -> bool {
    let col = find_column_index(result, col_name);
    is_null(result, col, row)
}

pub fn assert_error_with_sqlstate<T: std::fmt::Debug>(
    result: Result<T>,
    expected_sqlstate: &str,
    context: &str,
) {
    assert!(result.is_err(), "Expected error for: {}", context);
    let err = result.unwrap_err();
    let err_msg = err.to_string();

    let has_sqlstate = err_msg.contains(expected_sqlstate)
        || err_msg.contains(&format!("[{}]", expected_sqlstate))
        || err_msg.contains(&format!("SQLSTATE[{}]", expected_sqlstate));

    assert!(
        has_sqlstate,
        "Expected SQLSTATE {} in error '{}' (context: {})",
        expected_sqlstate, err_msg, context
    );
}

pub fn assert_result_equals(
    result: yachtsql::Result<yachtsql::RecordBatch>,
    expected_rows: usize,
    context: &str,
) {
    let batch = result.unwrap_or_else(|e| panic!("Query failed for {}: {}", context, e));
    assert_eq!(
        batch.num_rows(),
        expected_rows,
        "Expected {} rows for: {}",
        expected_rows,
        context
    );
}

pub fn column_strings(batch: &yachtsql::RecordBatch, index: usize) -> Vec<String> {
    let column = batch.column(index).expect("missing column");
    (0..batch.num_rows())
        .map(|row| {
            column
                .get(row)
                .unwrap_or_else(|e| panic!("failed to read row {row} from column {index}: {e}"))
                .as_str()
                .unwrap()
                .to_string()
        })
        .collect()
}

pub fn column_i64(batch: &yachtsql::RecordBatch, index: usize) -> Vec<i64> {
    let column = batch.column(index).expect("missing column");
    (0..batch.num_rows())
        .map(|row| {
            column
                .get(row)
                .unwrap_or_else(|e| panic!("failed to read row {row} from column {index}: {e}"))
                .as_i64()
                .unwrap()
        })
        .collect()
}

pub fn column_nullable_i64(batch: &yachtsql::RecordBatch, index: usize) -> Vec<Option<i64>> {
    let column = batch.column(index).expect("missing column");
    (0..batch.num_rows())
        .map(|row| {
            let val = column
                .get(row)
                .unwrap_or_else(|e| panic!("failed to read row {row} from column {index}: {e}"));
            if val.is_null() {
                None
            } else {
                Some(val.as_i64().unwrap())
            }
        })
        .collect()
}

pub fn scalar_value(batch: &yachtsql::RecordBatch, index: usize) -> Value {
    if batch.num_rows() == 0 {
        Value::null()
    } else {
        batch
            .column(index)
            .expect("missing column")
            .get(0)
            .unwrap_or_else(|e| panic!("failed to read scalar column {index}: {e}"))
    }
}

pub fn exec_ok(executor: &mut QueryExecutor, sql: &str) {
    executor.execute_sql(sql).unwrap();
}

pub fn query(executor: &mut QueryExecutor, sql: &str) -> yachtsql::RecordBatch {
    executor.execute_sql(sql).unwrap()
}

pub fn get_rowcount(executor: &mut QueryExecutor) -> i64 {
    let batch = executor
        .execute_sql("GET DIAGNOSTICS :rowcount = ROW_COUNT")
        .unwrap();
    get_i64_by_name(&batch, 0, "rowcount")
}

pub fn get_rowcount_opt(executor: &mut QueryExecutor) -> Option<i64> {
    let batch = executor
        .execute_sql("GET DIAGNOSTICS :rowcount = ROW_COUNT")
        .unwrap();
    if is_null_by_name(&batch, 0, "rowcount") {
        None
    } else {
        Some(get_i64_by_name(&batch, 0, "rowcount"))
    }
}

pub fn get_exception_diag(executor: &mut QueryExecutor, projection: &str) -> yachtsql::RecordBatch {
    executor
        .execute_sql(&format!("GET DIAGNOSTICS EXCEPTION 1 {}", projection))
        .unwrap()
}

pub fn assert_no_exception(executor: &mut QueryExecutor) {
    let err = executor.execute_sql("GET DIAGNOSTICS EXCEPTION 1 :sqlstate = RETURNED_SQLSTATE");
    assert_error_contains(err, &["no exception", "diagnostic"]);
}

pub fn assert_exception_message_contains(diag: &yachtsql::RecordBatch, fragments: &[&str]) {
    let message = get_string_by_name(diag, 0, "message").to_lowercase();
    for fragment in fragments {
        assert!(
            message.contains(&fragment.to_lowercase()),
            "Expected diagnostic message to contain '{fragment}', got '{message}'",
        );
    }
}

pub fn build_batch(schema: yachtsql::Schema, rows: Vec<Vec<Value>>) -> yachtsql::RecordBatch {
    use yachtsql_storage::Row;

    let storage_rows: Vec<Row> = rows.into_iter().map(Row::from_values).collect();

    yachtsql::RecordBatch::from_rows(schema, storage_rows)
        .expect("Failed to build RecordBatch from rows")
}

pub fn assert_batch_eq(actual: &yachtsql::RecordBatch, expected: &yachtsql::RecordBatch) {
    assert_eq!(
        actual.num_columns(),
        expected.num_columns(),
        "Column count mismatch: actual {} vs expected {}",
        actual.num_columns(),
        expected.num_columns()
    );

    assert_eq!(
        actual.num_rows(),
        expected.num_rows(),
        "Row count mismatch: actual {} vs expected {}",
        actual.num_rows(),
        expected.num_rows()
    );

    let actual_cols = actual
        .to_column_format()
        .expect("Failed to convert actual to column format");
    let expected_cols = expected
        .to_column_format()
        .expect("Failed to convert expected to column format");

    for col_idx in 0..actual_cols.num_columns() {
        let actual_col = actual_cols
            .column(col_idx)
            .expect("Failed to get actual column");
        let expected_col = expected_cols
            .column(col_idx)
            .expect("Failed to get expected column");

        for row_idx in 0..actual.num_rows() {
            let actual_val = actual_col.get(row_idx).expect("Failed to get actual value");
            let expected_val = expected_col
                .get(row_idx)
                .expect("Failed to get expected value");

            let values_match =
                if let (Some(a), Some(b)) = (actual_val.as_f64(), expected_val.as_f64()) {
                    if a.is_nan() && b.is_nan() {
                        true
                    } else if a.is_infinite() && b.is_infinite() {
                        a.signum() == b.signum()
                    } else {
                        (a - b).abs() < 1e-9
                    }
                } else {
                    actual_val == expected_val
                };

            assert!(
                values_match,
                "Value mismatch at row {} col {}: actual {:?} vs expected {:?}",
                row_idx, col_idx, actual_val, expected_val
            );
        }
    }
}

fn assert_values_eq(actual: &Value, expected: &Value, context: &str) {
    if actual.is_null() && expected.is_null() {
        return;
    }
    if actual.is_null() || expected.is_null() {
        panic!(
            "Value mismatch at {}: actual={:?}, expected={:?}",
            context, actual, expected
        );
    }

    if let (Some(a), Some(e)) = (actual.as_f64(), expected.as_f64()) {
        let epsilon = 1e-9;
        let diff = (a - e).abs();
        assert!(
            diff < epsilon,
            "Float value mismatch at {}: actual={}, expected={}, diff={}",
            context,
            a,
            e,
            diff
        );
        return;
    }

    assert_eq!(
        actual, expected,
        "Value mismatch at {}: actual={:?}, expected={:?}",
        context, actual, expected
    );
}

pub fn assert_batch_rows(actual: &yachtsql::RecordBatch, expected_rows: Vec<Vec<Value>>) {
    let expected = build_batch(actual.schema().clone(), expected_rows);
    assert_batch_eq(actual, &expected);
}

pub fn assert_batch_eq_with_tolerance(
    actual: &yachtsql::RecordBatch,
    expected: &yachtsql::RecordBatch,
    epsilon: f64,
) {
    assert_eq!(
        actual.num_columns(),
        expected.num_columns(),
        "Column count mismatch"
    );
    assert_eq!(actual.num_rows(), expected.num_rows(), "Row count mismatch");

    for col_idx in 0..actual.num_columns() {
        let actual_col = actual.column(col_idx).expect("Failed to get actual column");
        let expected_col = expected
            .column(col_idx)
            .expect("Failed to get expected column");

        for row_idx in 0..actual.num_rows() {
            let actual_val = actual_col.get(row_idx).expect("Failed to get actual value");
            let expected_val = expected_col
                .get(row_idx)
                .expect("Failed to get expected value");

            let values_match =
                if let (Some(a), Some(b)) = (actual_val.as_f64(), expected_val.as_f64()) {
                    if a.is_nan() && b.is_nan() {
                        true
                    } else if a.is_infinite() && b.is_infinite() {
                        a.signum() == b.signum()
                    } else {
                        (a - b).abs() < epsilon
                    }
                } else {
                    actual_val == expected_val
                };

            assert!(
                values_match,
                "Value mismatch at row {} col {}: actual {:?} vs expected {:?} (epsilon: {})",
                row_idx, col_idx, actual_val, expected_val, epsilon
            );
        }
    }
}
