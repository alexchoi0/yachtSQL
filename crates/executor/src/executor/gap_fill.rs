use std::collections::HashMap;

use chrono::{DateTime, Duration, Utc};
use yachtsql_common::error::{Error, Result};
use yachtsql_common::types::Value;
use yachtsql_ir::{GapFillConfig, GapFillMethod, PlanSchema};
use yachtsql_storage::Table;

use super::{PlanExecutor, plan_schema_to_schema};
use crate::plan::ExecutorPlan;

impl<'a> PlanExecutor<'a> {
    pub fn execute_gap_fill(
        &mut self,
        input: &ExecutorPlan,
        config: &GapFillConfig,
        schema: &PlanSchema,
    ) -> Result<Table> {
        let input_table = self.execute_plan(input)?;
        let input_schema = input_table.schema().clone();

        let ts_col_idx = input_schema
            .fields()
            .iter()
            .position(|f| f.name.eq_ignore_ascii_case(&config.ts_column))
            .ok_or_else(|| {
                Error::invalid_query(format!(
                    "GAP_FILL: timestamp column '{}' not found",
                    config.ts_column
                ))
            })?;

        let partition_col_indices: Vec<usize> = config
            .partitioning_columns
            .iter()
            .map(|col_name| {
                input_schema
                    .fields()
                    .iter()
                    .position(|f| f.name.eq_ignore_ascii_case(col_name))
                    .ok_or_else(|| {
                        Error::invalid_query(format!(
                            "GAP_FILL: partitioning column '{}' not found",
                            col_name
                        ))
                    })
            })
            .collect::<Result<Vec<_>>>()?;

        let value_col_configs: Vec<(usize, GapFillMethod)> = config
            .value_columns
            .iter()
            .map(|vc| {
                let idx = input_schema
                    .fields()
                    .iter()
                    .position(|f| f.name.eq_ignore_ascii_case(&vc.column_name))
                    .ok_or_else(|| {
                        Error::invalid_query(format!(
                            "GAP_FILL: value column '{}' not found",
                            vc.column_name
                        ))
                    })?;
                Ok((idx, vc.method.clone()))
            })
            .collect::<Result<Vec<_>>>()?;

        let bucket_width = Duration::seconds(config.bucket_width_seconds);

        let result_schema = plan_schema_to_schema(schema);
        let mut result = Table::empty(result_schema);

        let rows = input_table.rows()?;
        if rows.is_empty() {
            return Ok(result);
        }

        let mut partitions: HashMap<Vec<Value>, Vec<(DateTime<Utc>, Vec<Value>)>> = HashMap::new();

        for row in &rows {
            let values = row.values();

            let partition_key: Vec<Value> = partition_col_indices
                .iter()
                .map(|&idx| values[idx].clone())
                .collect();

            let ts = Self::extract_gap_fill_timestamp(&values[ts_col_idx])?;

            partitions
                .entry(partition_key)
                .or_default()
                .push((ts, values.to_vec()));
        }

        for (partition_key, mut partition_rows) in partitions {
            partition_rows.sort_by_key(|(ts, _)| *ts);

            let Some((min_ts, _)) = partition_rows.first() else {
                continue;
            };
            let Some((max_ts, _)) = partition_rows.last() else {
                continue;
            };

            let min_ts = Self::bucket_gap_fill_timestamp(*min_ts, bucket_width);
            let max_ts = Self::bucket_gap_fill_timestamp(*max_ts, bucket_width);

            let mut ts_to_row: HashMap<DateTime<Utc>, Vec<Value>> = HashMap::new();
            for (ts, row) in &partition_rows {
                let bucketed = Self::bucket_gap_fill_timestamp(*ts, bucket_width);
                ts_to_row.insert(bucketed, row.clone());
            }

            let mut current_ts = min_ts;
            let mut last_values: HashMap<usize, Value> = HashMap::new();

            while current_ts <= max_ts {
                let row = if let Some(existing_row) = ts_to_row.get(&current_ts) {
                    for &(idx, _) in &value_col_configs {
                        if !existing_row[idx].is_null() {
                            last_values.insert(idx, existing_row[idx].clone());
                        }
                    }
                    existing_row.clone()
                } else {
                    let template_row = &partition_rows[0].1;
                    let mut new_row = template_row.clone();

                    new_row[ts_col_idx] = Value::timestamp(current_ts);

                    for (idx, partition_val) in partition_col_indices.iter().zip(&partition_key) {
                        new_row[*idx] = partition_val.clone();
                    }

                    for &(idx, ref method) in &value_col_configs {
                        let filled_value =
                            Self::fill_gap_value(idx, method, current_ts, &ts_to_row, &last_values);
                        new_row[idx] = filled_value;
                    }

                    new_row
                };

                result.push_row(row)?;
                current_ts = current_ts + bucket_width;
            }
        }

        Ok(result)
    }

    fn extract_gap_fill_timestamp(value: &Value) -> Result<DateTime<Utc>> {
        match value {
            Value::Timestamp(ts) => Ok(*ts),
            _ => Err(Error::invalid_query(
                "GAP_FILL: timestamp column must contain timestamp values",
            )),
        }
    }

    fn bucket_gap_fill_timestamp(ts: DateTime<Utc>, bucket_width: Duration) -> DateTime<Utc> {
        let epoch = DateTime::<Utc>::from_timestamp(0, 0).unwrap();
        let since_epoch = ts.signed_duration_since(epoch);
        let bucket_seconds = bucket_width.num_seconds();
        let bucket_num = since_epoch.num_seconds() / bucket_seconds;
        epoch + Duration::seconds(bucket_num * bucket_seconds)
    }

    fn fill_gap_value(
        col_idx: usize,
        method: &GapFillMethod,
        current_ts: DateTime<Utc>,
        ts_to_row: &HashMap<DateTime<Utc>, Vec<Value>>,
        last_values: &HashMap<usize, Value>,
    ) -> Value {
        match method {
            GapFillMethod::Null => Value::null(),
            GapFillMethod::Locf => last_values.get(&col_idx).cloned().unwrap_or(Value::null()),
            GapFillMethod::Linear => {
                let mut prev_ts: Option<DateTime<Utc>> = None;
                let mut prev_val: Option<f64> = None;
                let mut next_ts: Option<DateTime<Utc>> = None;
                let mut next_val: Option<f64> = None;

                for (ts, row) in ts_to_row {
                    if *ts < current_ts {
                        if let Some(v) = Self::gap_fill_value_to_f64(&row[col_idx]) {
                            if prev_ts.is_none() || *ts > prev_ts.unwrap() {
                                prev_ts = Some(*ts);
                                prev_val = Some(v);
                            }
                        }
                    } else if *ts > current_ts {
                        if let Some(v) = Self::gap_fill_value_to_f64(&row[col_idx]) {
                            if next_ts.is_none() || *ts < next_ts.unwrap() {
                                next_ts = Some(*ts);
                                next_val = Some(v);
                            }
                        }
                    }
                }

                match (prev_ts, prev_val, next_ts, next_val) {
                    (Some(pt), Some(pv), Some(nt), Some(nv)) => {
                        let total_span = (nt - pt).num_milliseconds() as f64;
                        let current_offset = (current_ts - pt).num_milliseconds() as f64;
                        let ratio = current_offset / total_span;
                        let interpolated = pv + (nv - pv) * ratio;
                        Value::float64(interpolated)
                    }
                    _ => Value::null(),
                }
            }
        }
    }

    fn gap_fill_value_to_f64(value: &Value) -> Option<f64> {
        match value {
            Value::Float64(f) => Some(f.0),
            Value::Int64(i) => Some(*i as f64),
            Value::Numeric(n) => n.to_string().parse().ok(),
            _ => None,
        }
    }
}
