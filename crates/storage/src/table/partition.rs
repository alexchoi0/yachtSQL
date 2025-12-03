#[derive(Debug, Clone, PartialEq, Eq)]
pub enum PartitionType {
    Date { column: String },
    TimestampTrunc { column: String, unit: String },
    RangeBucket { column: String, buckets: Vec<i64> },
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct PartitionSpec {
    pub partition_type: PartitionType,

    pub expression_sql: String,
}

impl PartitionSpec {
    pub fn new(partition_type: PartitionType, expression_sql: String) -> Self {
        Self {
            partition_type,
            expression_sql,
        }
    }

    pub fn column_name(&self) -> &str {
        match &self.partition_type {
            PartitionType::Date { column } => column,
            PartitionType::TimestampTrunc { column, .. } => column,
            PartitionType::RangeBucket { column, .. } => column,
        }
    }
}
