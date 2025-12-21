use serde::{Deserialize, Serialize};
use serde_json::Value as JsonValue;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ColumnInfo {
    pub name: String,
    #[serde(rename = "type")]
    pub data_type: String,
}

impl ColumnInfo {
    pub fn new(name: impl Into<String>, data_type: impl Into<String>) -> Self {
        Self {
            name: name.into(),
            data_type: data_type.into(),
        }
    }
}

#[derive(Debug, Clone, Default)]
pub struct QueryResult {
    pub columns: Vec<ColumnInfo>,
    pub rows: Vec<Vec<JsonValue>>,
}

impl QueryResult {
    pub fn new(columns: Vec<ColumnInfo>, rows: Vec<Vec<JsonValue>>) -> Self {
        Self { columns, rows }
    }

    pub fn empty() -> Self {
        Self::default()
    }

    pub fn with_columns(columns: Vec<ColumnInfo>) -> Self {
        Self {
            columns,
            rows: Vec::new(),
        }
    }

    pub fn row_count(&self) -> usize {
        self.rows.len()
    }

    pub fn column_count(&self) -> usize {
        self.columns.len()
    }

    pub fn is_empty(&self) -> bool {
        self.rows.is_empty()
    }

    pub fn column_names(&self) -> Vec<&str> {
        self.columns.iter().map(|c| c.name.as_str()).collect()
    }

    pub fn get(&self, row: usize, col: usize) -> Option<&JsonValue> {
        self.rows.get(row).and_then(|r| r.get(col))
    }

    pub fn get_by_name(&self, row: usize, col_name: &str) -> Option<&JsonValue> {
        let col_idx = self.columns.iter().position(|c| c.name == col_name)?;
        self.get(row, col_idx)
    }

    pub fn first_row(&self) -> Option<&Vec<JsonValue>> {
        self.rows.first()
    }

    pub fn first_value(&self) -> Option<&JsonValue> {
        self.rows.first().and_then(|r| r.first())
    }

    pub fn to_bq_response(&self) -> JsonValue {
        let schema_fields: Vec<JsonValue> = self
            .columns
            .iter()
            .map(|col| serde_json::json!({ "name": col.name, "type": col.data_type }))
            .collect();

        let rows: Vec<JsonValue> = self
            .rows
            .iter()
            .map(|row| {
                let fields: Vec<JsonValue> = row
                    .iter()
                    .map(|v| serde_json::json!({ "v": v }))
                    .collect();
                serde_json::json!({ "f": fields })
            })
            .collect();

        serde_json::json!({
            "kind": "bigquery#queryResponse",
            "schema": { "fields": schema_fields },
            "rows": rows,
            "totalRows": self.rows.len().to_string(),
            "jobComplete": true
        })
    }
}
