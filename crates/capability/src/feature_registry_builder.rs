use yachtsql_parser::DialectType;

use super::feature::{Feature, FeatureCategory, FeatureId};
use super::registry::FeatureRegistry;
use crate::feature_defs::*;

pub struct FeatureRegistryBuilder {
    features: Vec<Feature>,
}

impl FeatureRegistryBuilder {
    pub fn new() -> Self {
        Self {
            features: Vec::new(),
        }
    }

    fn register_feature_sets(
        &mut self,
        core_features: &[SimpleFeatureDef],
        optional_features: &[SimpleFeatureDef],
    ) {
        for feature in core_features {
            self.features.push(
                Feature::new(feature.id, feature.name, feature.description, true)
                    .with_category(feature.category),
            );
        }
        for feature in optional_features {
            self.features.push(
                Feature::new(feature.id, feature.name, feature.description, false)
                    .with_category(feature.category),
            );
        }
    }

    fn register_feature_with_dependencies(
        &mut self,
        id: FeatureId,
        name: &'static str,
        description: &'static str,
        category: FeatureCategory,
        deps: &[FeatureId],
    ) {
        self.features.push(
            Feature::new(id, name, description, false)
                .with_category(category)
                .with_dependencies(deps),
        );
    }

    fn register_postgres_feature(
        &mut self,
        id: FeatureId,
        name: &'static str,
        description: &'static str,
        deps: &[FeatureId],
    ) {
        let mut feature = Feature::new(id, name, description, false)
            .with_category(FeatureCategory::PostgreSQLExtension);
        if !deps.is_empty() {
            feature = feature.with_dependencies(deps);
        }
        self.features
            .push(feature.with_dialect(DialectType::PostgreSQL));
    }

    fn register_bigquery_feature(
        &mut self,
        id: FeatureId,
        name: &'static str,
        description: &'static str,
        deps: &[FeatureId],
    ) {
        let mut feature = Feature::new(id, name, description, false)
            .with_category(FeatureCategory::BigQueryExtension);
        if !deps.is_empty() {
            feature = feature.with_dependencies(deps);
        }
        self.features
            .push(feature.with_dialect(DialectType::BigQuery));
    }

    fn register_clickhouse_feature(
        &mut self,
        id: FeatureId,
        name: &'static str,
        description: &'static str,
        deps: &[FeatureId],
    ) {
        let mut feature = Feature::new(id, name, description, false)
            .with_category(FeatureCategory::ClickHouseExtension);
        if !deps.is_empty() {
            feature = feature.with_dependencies(deps);
        }
        self.features
            .push(feature.with_dialect(DialectType::ClickHouse));
    }

    fn register_feature_with_part(
        &mut self,
        id: FeatureId,
        name: &'static str,
        description: &'static str,
        category: FeatureCategory,
        part: &'static str,
        deps: &[FeatureId],
    ) {
        let mut feature = Feature::new(id, name, description, false)
            .with_category(category)
            .with_standard_part(part);
        if !deps.is_empty() {
            feature = feature.with_dependencies(deps);
        }
        self.features.push(feature);
    }

    pub fn with_all_features(mut self) -> Self {
        self.register_core_features();
        self.register_integrity_features();
        self.register_sequence_features();
        self.register_trigger_features();

        self.register_transaction_features();

        self.register_merge_features();

        self.register_numeric_features();

        self.register_json_features();

        self.register_row_type_features();

        self.register_window_features();

        self.register_cte_features();

        self.register_postgresql_extensions();

        self.register_bigquery_extensions();

        self.register_clickhouse_extensions();

        self
    }

    pub fn build(self, dialect: DialectType) -> FeatureRegistry {
        let mut registry = FeatureRegistry::empty(dialect);
        for feature in self.features {
            registry.register(feature);
        }
        registry
    }

    fn register_core_features(&mut self) {
        self.register_feature_sets(CORE_FEATURE_DEFS, OPTIONAL_FEATURE_DEFS);
    }

    fn register_transaction_features(&mut self) {
        self.register_feature_sets(EMPTY_SIMPLE_FEATURES, TRANSACTION_OPTIONAL_FEATURE_DEFS);

        for feature in TRANSACTION_DEP_FEATURE_DEFS {
            self.register_feature_with_dependencies(
                feature.id,
                feature.name,
                feature.description,
                feature.category,
                feature.deps,
            );
        }
    }

    fn register_merge_features(&mut self) {
        for feature in MERGE_DEP_FEATURE_DEFS {
            self.register_feature_with_dependencies(
                feature.id,
                feature.name,
                feature.description,
                feature.category,
                feature.deps,
            );
        }
    }

    fn register_numeric_features(&mut self) {
        self.register_feature_sets(EMPTY_SIMPLE_FEATURES, NUMERIC_OPTIONAL_FEATURE_DEFS);
    }

    fn register_json_features(&mut self) {
        for feature in JSON_FEATURE_DEFS {
            self.register_feature_with_part(
                feature.id,
                feature.name,
                feature.description,
                feature.category,
                feature.part,
                feature.deps,
            );
        }
    }

    fn register_row_type_features(&mut self) {
        self.register_feature_sets(EMPTY_SIMPLE_FEATURES, ROW_TYPE_OPTIONAL_FEATURE_DEFS);

        for feature in ROW_TYPE_DEP_FEATURE_DEFS {
            self.register_feature_with_dependencies(
                feature.id,
                feature.name,
                feature.description,
                feature.category,
                feature.deps,
            );
        }
    }

    fn register_window_features(&mut self) {
        self.register_feature_sets(EMPTY_SIMPLE_FEATURES, WINDOW_OPTIONAL_FEATURE_DEFS);

        for feature in WINDOW_DEP_FEATURE_DEFS {
            self.register_feature_with_dependencies(
                feature.id,
                feature.name,
                feature.description,
                feature.category,
                feature.deps,
            );
        }
    }

    fn register_cte_features(&mut self) {
        self.register_feature_sets(EMPTY_SIMPLE_FEATURES, CTE_OPTIONAL_FEATURE_DEFS);

        for feature in CTE_DEP_FEATURE_DEFS {
            self.register_feature_with_dependencies(
                feature.id,
                feature.name,
                feature.description,
                feature.category,
                feature.deps,
            );
        }
    }

    fn register_postgresql_extensions(&mut self) {
        for feature in POSTGRES_FEATURE_DEFS {
            self.register_postgres_feature(
                feature.id,
                feature.name,
                feature.description,
                feature.deps,
            );
        }
    }

    fn register_bigquery_extensions(&mut self) {
        for feature in BIGQUERY_FEATURE_DEFS {
            self.register_bigquery_feature(
                feature.id,
                feature.name,
                feature.description,
                feature.deps,
            );
        }
    }

    fn register_clickhouse_extensions(&mut self) {
        for feature in CLICKHOUSE_FEATURE_DEFS {
            self.register_clickhouse_feature(
                feature.id,
                feature.name,
                feature.description,
                feature.deps,
            );
        }
    }

    fn register_integrity_features(&mut self) {
        self.register_feature_sets(INTEGRITY_CORE_FEATURE_DEFS, EMPTY_SIMPLE_FEATURES);
    }

    fn register_sequence_features(&mut self) {
        self.register_feature_sets(EMPTY_SIMPLE_FEATURES, SEQUENCE_OPTIONAL_FEATURE_DEFS);
    }

    fn register_trigger_features(&mut self) {
        self.register_feature_sets(EMPTY_SIMPLE_FEATURES, TRIGGER_OPTIONAL_FEATURE_DEFS);
    }
}

impl Default for FeatureRegistryBuilder {
    fn default() -> Self {
        Self::new()
    }
}
