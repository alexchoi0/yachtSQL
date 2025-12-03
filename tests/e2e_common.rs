use yachtsql::{QueryExecutor, RecordBatch, Result, Value};
use yachtsql_parser::DialectType;

pub struct E2ETestRunner {
    pub pg_executor: QueryExecutor,

    pub ch_executor: QueryExecutor,

    pub bq_executor: QueryExecutor,
}

impl Default for E2ETestRunner {
    fn default() -> Self {
        Self::new()
    }
}

impl E2ETestRunner {
    pub fn new() -> Self {
        Self {
            pg_executor: QueryExecutor::with_dialect(DialectType::PostgreSQL),
            ch_executor: QueryExecutor::with_dialect(DialectType::ClickHouse),
            bq_executor: QueryExecutor::with_dialect(DialectType::BigQuery),
        }
    }

    pub fn postgres_only() -> QueryExecutor {
        QueryExecutor::with_dialect(DialectType::PostgreSQL)
    }

    pub fn clickhouse_only() -> QueryExecutor {
        QueryExecutor::with_dialect(DialectType::ClickHouse)
    }

    pub fn bigquery_only() -> QueryExecutor {
        QueryExecutor::with_dialect(DialectType::BigQuery)
    }

    pub fn execute_pg(&mut self, sql: &str) -> Result<RecordBatch> {
        self.pg_executor.execute_sql(sql)
    }

    pub fn execute_ch(&mut self, sql: &str) -> Result<RecordBatch> {
        self.ch_executor.execute_sql(sql)
    }

    pub fn execute_bq(&mut self, sql: &str) -> Result<RecordBatch> {
        self.bq_executor.execute_sql(sql)
    }

    pub fn execute_and_compare(&mut self, sql: &str) -> Result<RecordBatch> {
        let pg_result = self.execute_pg(sql)?;
        let ch_result = self.execute_ch(sql)?;
        let bq_result = self.execute_bq(sql)?;

        assert_eq!(
            pg_result.num_rows(),
            ch_result.num_rows(),
            "Row count mismatch between PostgreSQL ({}) and ClickHouse ({})",
            pg_result.num_rows(),
            ch_result.num_rows()
        );
        assert_eq!(
            pg_result.num_rows(),
            bq_result.num_rows(),
            "Row count mismatch between PostgreSQL ({}) and BigQuery ({})",
            pg_result.num_rows(),
            bq_result.num_rows()
        );

        assert_eq!(
            pg_result.num_columns(),
            ch_result.num_columns(),
            "Column count mismatch between PostgreSQL ({}) and ClickHouse ({})",
            pg_result.num_columns(),
            ch_result.num_columns()
        );
        assert_eq!(
            pg_result.num_columns(),
            bq_result.num_columns(),
            "Column count mismatch between PostgreSQL ({}) and BigQuery ({})",
            pg_result.num_columns(),
            bq_result.num_columns()
        );

        Ok(pg_result)
    }

    pub fn setup_all(&mut self, sql: &str) -> Result<()> {
        self.execute_pg(sql)?;
        self.execute_ch(sql)?;
        self.execute_bq(sql)?;
        Ok(())
    }
}

pub fn assert_row_count_eq(batch: &RecordBatch, expected: usize) {
    assert_eq!(
        batch.num_rows(),
        expected,
        "Expected {} rows, got {}",
        expected,
        batch.num_rows()
    );
}

pub fn assert_column_count_eq(batch: &RecordBatch, expected: usize) {
    assert_eq!(
        batch.num_columns(),
        expected,
        "Expected {} columns, got {}",
        expected,
        batch.num_columns()
    );
}

pub fn get_value(batch: &RecordBatch, row: usize, col: usize) -> Value {
    batch
        .column(col)
        .unwrap_or_else(|| panic!("Column {} not found", col))
        .get(row)
        .unwrap_or_else(|e| panic!("Failed to get value at row {} col {}: {}", row, col, e))
}

pub fn assert_i64_at(batch: &RecordBatch, row: usize, col: usize, expected: i64) {
    let value = get_value(batch, row, col);
    let actual = value
        .as_i64()
        .unwrap_or_else(|| panic!("Expected INT64 at row {} col {}, got {:?}", row, col, value));
    assert_eq!(
        actual, expected,
        "Value mismatch at row {} col {}: expected {}, got {}",
        row, col, expected, actual
    );
}

pub fn assert_string_at(batch: &RecordBatch, row: usize, col: usize, expected: &str) {
    let value = get_value(batch, row, col);
    let actual = value.as_str().unwrap_or_else(|| {
        panic!(
            "Expected STRING at row {} col {}, got {:?}",
            row, col, value
        )
    });
    assert_eq!(
        actual, expected,
        "Value mismatch at row {} col {}: expected '{}', got '{}'",
        row, col, expected, actual
    );
}

pub fn assert_null_at(batch: &RecordBatch, row: usize, col: usize) {
    let value = get_value(batch, row, col);
    assert!(
        value.is_null(),
        "Expected NULL at row {} col {}, got {:?}",
        row,
        col,
        value
    );
}

pub fn assert_f64_at(batch: &RecordBatch, row: usize, col: usize, expected: f64, epsilon: f64) {
    let value = get_value(batch, row, col);
    let actual = value.as_f64().unwrap_or_else(|| {
        panic!(
            "Expected FLOAT64 at row {} col {}, got {:?}",
            row, col, value
        )
    });
    let diff = (actual - expected).abs();
    assert!(
        diff < epsilon,
        "Float mismatch at row {} col {}: expected {}, got {} (diff: {}, epsilon: {})",
        row,
        col,
        expected,
        actual,
        diff,
        epsilon
    );
}

pub fn assert_bool_at(batch: &RecordBatch, row: usize, col: usize, expected: bool) {
    let value = get_value(batch, row, col);
    let actual = value
        .as_bool()
        .unwrap_or_else(|| panic!("Expected BOOL at row {} col {}, got {:?}", row, col, value));
    assert_eq!(
        actual, expected,
        "Bool mismatch at row {} col {}: expected {}, got {}",
        row, col, expected, actual
    );
}
