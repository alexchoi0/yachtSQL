use yachtsql::RecordBatch;
use yachtsql_core::types::Value;
use yachtsql_storage::{Row, Schema};

pub fn assert_batch_eq(actual: &RecordBatch, expected: &RecordBatch) {
    assert_eq!(
        actual.schema(),
        expected.schema(),
        "\nSchema mismatch!\nExpected:\n{:#?}\n\nActual:\n{:#?}",
        expected.schema(),
        actual.schema()
    );

    assert_eq!(
        actual.num_rows(),
        expected.num_rows(),
        "\nRow count mismatch!\nExpected {} rows, got {} rows",
        expected.num_rows(),
        actual.num_rows()
    );

    let actual_rows = actual.rows().expect("Failed to get actual rows");
    let expected_rows = expected.rows().expect("Failed to get expected rows");

    for (row_idx, (actual_row, expected_row)) in
        actual_rows.iter().zip(expected_rows.iter()).enumerate()
    {
        let actual_values = actual_row.values();
        let expected_values = expected_row.values();

        assert_eq!(
            actual_values.len(),
            expected_values.len(),
            "Column count mismatch at row {}",
            row_idx
        );

        for (col_idx, (actual_val, expected_val)) in
            actual_values.iter().zip(expected_values.iter()).enumerate()
        {
            assert_eq!(
                actual_val,
                expected_val,
                "\nValue mismatch at row {}, column {}!\n\
                 Expected: {:?}\n\
                 Actual:   {:?}\n\n\
                 Full expected batch:\n{}\n\n\
                 Full actual batch:\n{}\n",
                row_idx,
                col_idx,
                expected_val,
                actual_val,
                pretty_print_batch(expected),
                pretty_print_batch(actual)
            );
        }
    }
}

pub fn build_batch(schema: Schema, values: Vec<Vec<Value>>) -> RecordBatch {
    let rows = values.into_iter().map(Row::from_values).collect();
    RecordBatch::from_rows(schema, rows).expect("Failed to build RecordBatch")
}

fn pretty_print_batch(batch: &RecordBatch) -> String {
    let mut s = String::new();

    s.push_str("  ");
    for field in batch.schema().fields() {
        s.push_str(&format!("{:20} | ", field.name));
    }
    s.push('\n');

    s.push_str("  ");
    s.push_str(&"-".repeat(batch.schema().fields().len() * 23));
    s.push('\n');

    if let Ok(rows) = batch.rows() {
        for row in rows {
            s.push_str("  ");
            for value in row.values() {
                s.push_str(&format!("{:20?} | ", value));
            }
            s.push('\n');
        }
    }

    s
}
