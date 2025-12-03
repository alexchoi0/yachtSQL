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
    let rows = values
        .into_iter()
        .map(|row_values| Row::from_values(row_values))
        .collect();
    RecordBatch::from_rows(schema, rows).expect("Failed to build RecordBatch")
}

pub fn assert_batch_rows(actual: &RecordBatch, expected_rows: Vec<Vec<Value>>) {

    assert_eq!(
        actual.num_rows(),
        expected_rows.len(),
        "\nRow count mismatch!\nExpected {} rows, got {} rows",
        expected_rows.len(),
        actual.num_rows()
    );


    let actual_rows = actual.rows().expect("Failed to get actual rows");


    for (row_idx, (actual_row, expected_row)) in
        actual_rows.iter().zip(expected_rows.iter()).enumerate()
    {
        let actual_values = actual_row.values();

        assert_eq!(
            actual_values.len(),
            expected_row.len(),
            "Column count mismatch at row {}",
            row_idx
        );

        for (col_idx, (actual_val, expected_val)) in
            actual_values.iter().zip(expected_row.iter()).enumerate()
        {
            assert_eq!(
                actual_val,
                expected_val,
                "\nValue mismatch at row {}, column {}!\n\
                 Expected: {:?}\n\
                 Actual:   {:?}\n\n\
                 Full actual batch:\n{}\n",
                row_idx,
                col_idx,
                expected_val,
                actual_val,
                pretty_print_batch(actual)
            );
        }
    }
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

#[cfg(test)]
mod tests {
    use super::*;
    use yachtsql_core::types::DataType;
    use yachtsql_storage::Field;

    #[test]
    fn test_assert_batch_eq_simple() {
        let schema = Schema::from_fields(vec![
            Field::required("id", DataType::Int64),
            Field::required("name", DataType::String),
        ]);

        let batch1 = build_batch(
            schema.clone(),
            vec![
                vec![Value::int64(1), Value::string("Alice".into())],
                vec![Value::int64(2), Value::string("Bob".into())],
            ],
        );

        let batch2 = build_batch(
            schema,
            vec![
                vec![Value::int64(1), Value::string("Alice".into())],
                vec![Value::int64(2), Value::string("Bob".into())],
            ],
        );

        assert_batch_eq(&batch1, &batch2);
    }

    #[test]
    #[should_panic(expected = "Value mismatch")]
    fn test_assert_batch_eq_value_mismatch() {
        let schema = Schema::from_fields(vec![Field::required("id", DataType::Int64)]);

        let batch1 = build_batch(schema.clone(), vec![vec![Value::int64(1)]]);

        let batch2 = build_batch(schema, vec![vec![Value::int64(2)]]);

        assert_batch_eq(&batch1, &batch2);
    }

    #[test]
    #[should_panic(expected = "Row count mismatch")]
    fn test_assert_batch_eq_row_count_mismatch() {
        let schema = Schema::from_fields(vec![Field::required("id", DataType::Int64)]);

        let batch1 = build_batch(
            schema.clone(),
            vec![vec![Value::int64(1)], vec![Value::int64(2)]],
        );

        let batch2 = build_batch(schema, vec![vec![Value::int64(1)]]);

        assert_batch_eq(&batch1, &batch2);
    }

    #[test]
    fn test_build_batch_creates_valid_batch() {
        let schema = Schema::from_fields(vec![
            Field::required("id", DataType::Int64),
            Field::required("value", DataType::Float64),
        ]);

        let batch = build_batch(
            schema,
            vec![
                vec![Value::int64(1), Value::float64(1.5)],
                vec![Value::int64(2), Value::float64(2.5)],
            ],
        );

        assert_eq!(batch.num_rows(), 2);
        assert_eq!(batch.num_columns(), 2);
    }
}
