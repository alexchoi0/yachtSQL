use std::collections::HashSet;

use serde::{Deserialize, Serialize};
use yachtsql_parser::DialectType;

pub use super::feature_ids::FeatureId;
use crate::sql_features::{self, FeatureMetadata as SqlFeatureMetadata};

type DepSet<T> = HashSet<T>;

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, Serialize, Deserialize)]
pub enum FeatureCategory {
    Core,
    Json,
    Transaction,
    Window,
    CTE,
    Merge,
    RowTypes,
    InformationSchema,
    Integrity,
    Sequence,
    Trigger,
    DialectExtension,
    PostgreSQLExtension,
    BigQueryExtension,
    ClickHouseExtension,
    Other,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Feature {
    pub id: FeatureId,

    pub name: &'static str,

    pub description: &'static str,

    pub is_core: bool,

    pub category: FeatureCategory,

    pub dependencies: Vec<FeatureId>,

    pub standard_part: Option<&'static str>,

    supported_dialects: Option<HashSet<DialectType>>,
}

impl Feature {
    pub fn new(
        id: FeatureId,
        name: &'static str,
        description: &'static str,
        is_core: bool,
    ) -> Self {
        Self {
            id,
            name,
            description,
            is_core,
            category: FeatureCategory::Other,
            dependencies: Vec::new(),
            standard_part: None,
            supported_dialects: None,
        }
    }

    pub fn with_category(mut self, category: FeatureCategory) -> Self {
        self.category = category;
        self
    }

    pub fn with_dependency(mut self, dep: FeatureId) -> Self {
        self.dependencies.push(dep);
        self
    }

    pub fn with_dependencies(mut self, deps: &[FeatureId]) -> Self {
        self.dependencies.extend_from_slice(deps);
        self
    }

    pub fn with_standard_part(mut self, part: &'static str) -> Self {
        self.standard_part = Some(part);
        self
    }

    pub fn with_dialect(mut self, dialect: DialectType) -> Self {
        self.supported_dialects
            .get_or_insert_with(HashSet::new)
            .insert(dialect);
        self
    }

    pub fn with_dialects(mut self, dialects: &[DialectType]) -> Self {
        let set = self.supported_dialects.get_or_insert_with(HashSet::new);
        set.extend(dialects.iter().copied());
        self
    }

    pub fn apply_sql_standard_metadata(mut self) -> Self {
        if let Some(metadata) = sql_features::find_feature(self.id.as_str()) {
            self.name = metadata.name;
            self.description = metadata.description;
            self.standard_part = Some(metadata.iso_reference);
            if let Some(category) = map_metadata_category(metadata) {
                self.category = category;
            }
        }
        self
    }

    pub fn is_supported_by(&self, dialect: DialectType) -> bool {
        match &self.supported_dialects {
            Some(dialects) => dialects.contains(&dialect),
            None => true,
        }
    }

    pub fn dependencies_satisfied(&self, enabled: &DepSet<FeatureId>) -> bool {
        self.dependencies.iter().all(|dep| enabled.contains(dep))
    }
}

fn map_metadata_category(metadata: &SqlFeatureMetadata) -> Option<FeatureCategory> {
    use crate::sql_features::FeatureCategory as MetaCategory;

    let category = match metadata.category {
        MetaCategory::Core => FeatureCategory::Core,
        MetaCategory::Json => FeatureCategory::Json,
        MetaCategory::Transaction => FeatureCategory::Transaction,
        MetaCategory::Window => FeatureCategory::Window,
        MetaCategory::Cte => FeatureCategory::CTE,
        MetaCategory::Merge => FeatureCategory::Merge,
        MetaCategory::InformationSchema => FeatureCategory::InformationSchema,
        MetaCategory::RowTypes => FeatureCategory::RowTypes,
        MetaCategory::Integrity => FeatureCategory::Integrity,
        MetaCategory::Sequence => FeatureCategory::Sequence,
        MetaCategory::Trigger => FeatureCategory::Trigger,
        MetaCategory::DialectExtension => FeatureCategory::DialectExtension,
        MetaCategory::PostgresExtension => FeatureCategory::PostgreSQLExtension,
        MetaCategory::BigQueryExtension => FeatureCategory::BigQueryExtension,
        MetaCategory::ClickHouseExtension => FeatureCategory::ClickHouseExtension,
        MetaCategory::Other => FeatureCategory::Other,
    };

    Some(category)
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::feature_ids::*;

    #[test]
    fn test_feature_creation() {
        let feature = Feature::new(
            F311_SCHEMA_DEFINITION,
            "Schema definition statement",
            "CREATE SCHEMA and basic schema manipulation",
            false,
        );

        assert_eq!(feature.id, F311_SCHEMA_DEFINITION);
        assert_eq!(feature.name, "Schema definition statement");
        assert!(!feature.is_core);
        assert!(feature.dependencies.is_empty());
    }

    #[test]
    fn test_feature_with_dependencies() {
        let feature = Feature::new(
            T801_MERGE_STATEMENT,
            "MERGE statement",
            "MERGE for conditional INSERT/UPDATE/DELETE",
            false,
        )
        .with_dependency(F402_TRANSACTION_COMMIT)
        .with_dependency(T321_TRANSACTION_ISOLATION);

        assert_eq!(feature.dependencies.len(), 2);
        assert!(feature.dependencies.contains(&F402_TRANSACTION_COMMIT));
        assert!(feature.dependencies.contains(&T321_TRANSACTION_ISOLATION));
    }

    #[test]
    fn test_dependencies_satisfied() {
        let feature = Feature::new(T801_MERGE_STATEMENT, "MERGE", "MERGE statement", false)
            .with_dependencies(&[F402_TRANSACTION_COMMIT, T321_TRANSACTION_ISOLATION]);

        let mut enabled = DepSet::new();
        assert!(!feature.dependencies_satisfied(&enabled));

        enabled.insert(F402_TRANSACTION_COMMIT);
        assert!(!feature.dependencies_satisfied(&enabled));

        enabled.insert(T321_TRANSACTION_ISOLATION);
        assert!(feature.dependencies_satisfied(&enabled));
    }

    #[test]
    fn test_dialect_restrictions() {
        let feature = Feature::new(T801_MERGE_STATEMENT, "MERGE", "MERGE statement", false)
            .with_dialect(DialectType::PostgreSQL);

        assert!(feature.is_supported_by(DialectType::PostgreSQL));
        assert!(!feature.is_supported_by(DialectType::BigQuery));
    }
}
