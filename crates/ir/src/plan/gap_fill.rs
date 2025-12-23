use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub enum GapFillMethod {
    Null,
    Locf,
    Linear,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct GapFillValueColumn {
    pub column_name: String,
    pub method: GapFillMethod,
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct GapFillConfig {
    pub ts_column: String,
    pub bucket_width_seconds: i64,
    pub partitioning_columns: Vec<String>,
    pub value_columns: Vec<GapFillValueColumn>,
}
