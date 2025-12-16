use indexmap::IndexMap;
use yachtsql_common::error::Result;
use yachtsql_common::types::Value;

use crate::storage_backend::ColumnarStorage;
use crate::{Column, Record, Schema};

#[derive(Debug, Clone, PartialEq, Eq, Default)]
pub enum TableEngine {
    #[default]
    Memory,
}

#[derive(Debug, Clone)]
pub struct Table {
    pub(super) schema: Schema,
    pub(super) storage: ColumnarStorage,
    pub(super) engine: TableEngine,
    pub(super) comment: Option<String>,
}

impl Table {
    pub fn new(schema: Schema) -> Self {
        let storage = ColumnarStorage::new(&schema);
        Self {
            schema,
            storage,
            engine: TableEngine::default(),
            comment: None,
        }
    }

    pub fn engine(&self) -> &TableEngine {
        &self.engine
    }

    pub fn set_engine(&mut self, engine: TableEngine) {
        self.engine = engine;
    }

    pub fn comment(&self) -> Option<&str> {
        self.comment.as_deref()
    }

    pub fn set_comment(&mut self, comment: Option<String>) {
        self.comment = comment;
    }

    pub fn schema(&self) -> &Schema {
        &self.schema
    }

    pub fn row_count(&self) -> usize {
        self.storage.row_count()
    }

    pub fn is_empty(&self) -> bool {
        self.storage.is_empty()
    }

    pub fn column(&self, name: &str) -> Option<&Column> {
        self.storage.columns().get(name)
    }

    pub fn columns(&self) -> &IndexMap<String, Column> {
        self.storage.columns()
    }

    pub fn storage(&self) -> &ColumnarStorage {
        &self.storage
    }

    pub fn storage_mut(&mut self) -> &mut ColumnarStorage {
        &mut self.storage
    }

    pub fn clone_with(
        &self,
        schema: Schema,
        columns: IndexMap<String, Column>,
        row_count: usize,
    ) -> Table {
        Table {
            schema,
            storage: ColumnarStorage::from_columns(columns, row_count),
            engine: self.engine.clone(),
            comment: self.comment.clone(),
        }
    }

    pub fn push_row(&mut self, values: Vec<Value>) -> Result<()> {
        self.storage.push_row_values(&values, &self.schema)
    }

    pub fn get_row(&self, index: usize) -> Result<Record> {
        let columns: Vec<Column> = self.storage.columns().values().cloned().collect();
        Record::from_columns(&columns, index)
    }

    pub fn to_records(&self) -> Result<Vec<Record>> {
        let num_rows = self.row_count();
        let mut records = Vec::with_capacity(num_rows);
        for i in 0..num_rows {
            records.push(self.get_row(i)?);
        }
        Ok(records)
    }

    pub fn clear(&mut self) {
        self.storage.clear_data();
    }

    pub fn remove_row(&mut self, index: usize) {
        for col in self.storage.columns_mut().values_mut() {
            col.remove(index);
        }
    }

    pub fn update_row(&mut self, index: usize, values: Vec<Value>) -> Result<()> {
        for (col, value) in self
            .storage
            .columns_mut()
            .values_mut()
            .zip(values.into_iter())
        {
            col.set(index, value)?;
        }
        Ok(())
    }

    pub fn remove_column(&mut self, index: usize) {
        if index < self.storage.columns().len() {
            let key = self.storage.columns().keys().nth(index).cloned();
            if let Some(key) = key {
                self.storage.columns_mut().shift_remove(&key);
            }
        }
    }
}
