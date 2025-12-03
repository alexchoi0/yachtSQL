use std::collections::{HashMap, HashSet};

use yachtsql_parser::DialectType;

use super::feature::{Feature, FeatureCategory, FeatureId};
use crate::config::RegistryConfig;
use crate::error::{CapabilityError, Result};
use crate::manifest_loader::{
    load_dialect_manifest_with_config, load_layered_manifest_with_config,
};
use crate::resolver::CapabilityDependencyResolver;
use crate::{default_capabilities, load_dialect_manifest};

#[derive(Debug, Clone)]
pub struct FeatureRegistry {
    features: HashMap<FeatureId, Feature>,

    enabled: HashSet<FeatureId>,

    dialect: DialectType,
}

impl FeatureRegistry {
    pub fn new(dialect: DialectType) -> Self {
        super::feature_registry_builder::FeatureRegistryBuilder::new()
            .with_all_features()
            .build(dialect)
    }

    pub fn with_default_features(dialect: DialectType) -> Self {
        let mut registry = Self::new(dialect);
        if let Err(err) = registry.enable_dialect_features() {
            panic!(
                "failed to initialize capability registry for {:?}: {}",
                dialect, err
            );
        }
        registry
    }

    pub fn with_config(dialect: DialectType, config: RegistryConfig) -> Result<Self> {
        let mut registry = Self::new(dialect);

        if config.auto_enable_dialect() {
            let dialect_name = match dialect {
                DialectType::PostgreSQL => "postgres",
                DialectType::BigQuery => "bigquery",
                DialectType::ClickHouse => "clickhouse",
            };

            let use_layered = !config.feature_overrides().is_empty() || config.profile().is_some();

            let features = if use_layered {
                load_layered_manifest_with_config(dialect_name, &config)?
            } else {
                load_dialect_manifest_with_config(dialect_name, &config)?
            };

            registry.enable_features(features)?;
        }

        Ok(registry)
    }

    pub(super) fn empty(dialect: DialectType) -> Self {
        Self {
            features: HashMap::new(),
            enabled: HashSet::new(),
            dialect,
        }
    }

    pub(super) fn register(&mut self, feature: Feature) {
        if feature.is_supported_by(self.dialect) {
            self.features
                .insert(feature.id, feature.apply_sql_standard_metadata());
        }
    }

    pub fn snapshot_view(&self) -> CapabilitySnapshot {
        CapabilitySnapshot {
            enabled: self.enabled.iter().copied().collect(),
        }
    }

    pub fn enable(&mut self, feature_id: FeatureId) -> Result<()> {
        let feature = self.get_feature_or_err(feature_id)?;

        if !feature.dependencies_satisfied(&self.enabled) {
            let missing: Vec<String> = feature
                .dependencies
                .iter()
                .filter(|dep| !self.enabled.contains(dep))
                .map(|dep| dep.to_string())
                .collect();

            return Err(CapabilityError::UnsatisfiedDependency {
                feature_id: feature_id.to_string(),
                missing_dependencies: missing,
            });
        }

        self.enabled.insert(feature_id);
        Ok(())
    }

    pub fn disable(&mut self, feature_id: FeatureId) -> Result<()> {
        let dependents = self.find_enabled_dependents(feature_id);

        if !dependents.is_empty() {
            return Err(CapabilityError::DependentFeaturesEnabled {
                feature_id: feature_id.to_string(),
                dependents: dependents.iter().map(|f| f.to_string()).collect(),
            });
        }

        self.enabled.remove(&feature_id);
        Ok(())
    }

    pub fn enable_features<I>(&mut self, features: I) -> Result<()>
    where
        I: IntoIterator<Item = FeatureId>,
    {
        let requested: Vec<FeatureId> = features.into_iter().collect();
        let ordered = {
            let resolver = CapabilityDependencyResolver::new(self);
            let mut visited = HashSet::new();
            let mut ordered = Vec::new();

            for feature in &requested {
                let resolved = resolver.resolve(*feature)?;
                for fid in resolved {
                    if visited.insert(fid) {
                        ordered.push(fid);
                    }
                }
            }

            ordered
        };

        for feature_id in ordered {
            self.enable(feature_id)?;
        }

        Ok(())
    }

    pub fn enable_features_strict<I>(&mut self, features: I) -> Result<()>
    where
        I: IntoIterator<Item = FeatureId>,
    {
        let requested: Vec<FeatureId> = features.into_iter().collect();

        for feature_id in &requested {
            if let Some(dependencies) = self.dependencies_of(*feature_id) {
                let missing: Vec<String> = dependencies
                    .iter()
                    .filter(|dep_id| !self.is_enabled(**dep_id))
                    .map(|dep_id| dep_id.to_string())
                    .collect();

                if !missing.is_empty() {
                    return Err(CapabilityError::UnsatisfiedDependency {
                        feature_id: feature_id.to_string(),
                        missing_dependencies: missing,
                    });
                }
            }
        }

        for feature_id in requested {
            self.enable(feature_id)?;
        }

        Ok(())
    }

    pub fn enable_batch(&mut self, features: &[FeatureId]) -> Result<()> {
        let snapshot = self.enabled.clone();

        match self.enable_features(features.iter().copied()) {
            Ok(()) => Ok(()),
            Err(e) => {
                self.enabled = snapshot;
                Err(e)
            }
        }
    }

    pub fn disable_batch(&mut self, features: &[FeatureId]) -> Result<()> {
        let snapshot = self.enabled.clone();

        for feature_id in features {
            if let Err(e) = self.disable(*feature_id) {
                self.enabled = snapshot;
                return Err(e);
            }
        }

        Ok(())
    }

    pub fn enable_dialect_features(&mut self) -> Result<()> {
        let dialect_name = match self.dialect {
            DialectType::PostgreSQL => "postgres",
            DialectType::BigQuery => "bigquery",
            DialectType::ClickHouse => "clickhouse",
        };

        let features =
            load_dialect_manifest(dialect_name).unwrap_or_else(|_| default_capabilities());

        self.enable_features(features)
    }

    pub fn is_enabled(&self, feature_id: FeatureId) -> bool {
        self.enabled.contains(&feature_id)
    }

    pub fn get_feature(&self, feature_id: FeatureId) -> Option<&Feature> {
        self.features.get(&feature_id)
    }

    pub fn has_feature(&self, feature_id: FeatureId) -> bool {
        self.features.contains_key(&feature_id)
    }

    pub fn dependencies_of(&self, feature_id: FeatureId) -> Option<&[FeatureId]> {
        self.features
            .get(&feature_id)
            .map(|feature| feature.dependencies.as_slice())
    }

    pub fn enabled_features(&self) -> impl Iterator<Item = &Feature> {
        self.enabled.iter().filter_map(|id| self.features.get(id))
    }

    pub fn all_features(&self) -> impl Iterator<Item = &Feature> {
        self.features.values()
    }

    pub fn dialect(&self) -> DialectType {
        self.dialect
    }

    pub fn features_by_category(
        &self,
        category: FeatureCategory,
    ) -> impl Iterator<Item = &Feature> {
        self.features
            .values()
            .filter(move |f| f.category == category)
    }

    pub fn enabled_features_by_category(
        &self,
        category: FeatureCategory,
    ) -> impl Iterator<Item = &Feature> {
        self.enabled
            .iter()
            .filter_map(move |id| self.features.get(id))
            .filter(move |f| f.category == category)
    }

    pub fn is_category_enabled(&self, category: FeatureCategory) -> bool {
        self.enabled
            .iter()
            .filter_map(|id| self.features.get(id))
            .any(|f| f.category == category)
    }

    pub fn enable_category(&mut self, category: FeatureCategory) -> Result<()> {
        let features_in_category: Vec<FeatureId> = self
            .features
            .values()
            .filter(|f| f.category == category)
            .map(|f| f.id)
            .collect();

        self.enable_features(features_in_category)
    }

    pub fn enabled_count_by_category(&self, category: FeatureCategory) -> usize {
        self.enabled_features_by_category(category).count()
    }

    pub fn snapshot(&self) -> Result<String> {
        let enabled_ids: Vec<FeatureId> = self.enabled.iter().copied().collect();
        serde_json::to_string_pretty(&enabled_ids).map_err(|e| CapabilityError::Internal {
            message: format!("Failed to serialize snapshot: {}", e),
        })
    }

    pub fn restore(&mut self, snapshot: &str) -> Result<()> {
        let feature_id_strings: Vec<String> =
            serde_json::from_str(snapshot).map_err(|e| CapabilityError::Internal {
                message: format!("Failed to deserialize snapshot: {}", e),
            })?;

        let feature_ids: Vec<FeatureId> = feature_id_strings
            .iter()
            .filter_map(|s| {
                self.features
                    .iter()
                    .find(|(_, f)| f.id.as_str() == s.as_str())
                    .map(|(id, _)| *id)
            })
            .collect();

        self.enable_batch(&feature_ids)
    }

    pub fn export_state(&self) -> Result<String> {
        #[derive(serde::Serialize)]
        struct RegistryState {
            dialect: String,
            enabled_features: Vec<FeatureId>,
            total_features: usize,
        }

        let dialect_str = match self.dialect {
            DialectType::PostgreSQL => "PostgreSQL",
            DialectType::BigQuery => "BigQuery",
            DialectType::ClickHouse => "ClickHouse",
        };

        let state = RegistryState {
            dialect: dialect_str.to_string(),
            enabled_features: self.enabled.iter().copied().collect(),
            total_features: self.features.len(),
        };

        serde_json::to_string_pretty(&state).map_err(|e| CapabilityError::Internal {
            message: format!("Failed to export state: {}", e),
        })
    }

    fn get_feature_or_err(&self, feature_id: FeatureId) -> Result<&Feature> {
        self.features
            .get(&feature_id)
            .ok_or_else(|| CapabilityError::FeatureNotFound {
                feature_id: feature_id.to_string(),
            })
    }

    pub fn find_enabled_dependents(&self, feature_id: FeatureId) -> Vec<FeatureId> {
        self.features
            .values()
            .filter(|f| self.enabled.contains(&f.id))
            .filter(|f| f.dependencies.contains(&feature_id))
            .map(|f| f.id)
            .collect()
    }
}

#[derive(Debug, Clone, Default)]
pub struct CapabilitySnapshot {
    enabled: HashSet<FeatureId>,
}

impl CapabilitySnapshot {
    pub fn from_features<I>(features: I) -> Self
    where
        I: IntoIterator<Item = FeatureId>,
    {
        Self {
            enabled: features.into_iter().collect(),
        }
    }

    pub fn contains(&self, feature_id: &FeatureId) -> bool {
        self.enabled.contains(feature_id)
    }

    pub fn supports_feature(&self, feature_name: &str) -> bool {
        self.enabled
            .iter()
            .any(|id| id.as_str().eq_ignore_ascii_case(feature_name))
    }

    pub fn iter(&self) -> impl Iterator<Item = &FeatureId> {
        self.enabled.iter()
    }

    pub fn len(&self) -> usize {
        self.enabled.len()
    }

    pub fn is_empty(&self) -> bool {
        self.enabled.is_empty()
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::feature_ids::*;

    #[test]
    fn test_registry_creation() {
        let registry = FeatureRegistry::new(DialectType::PostgreSQL);
        assert_eq!(registry.dialect(), DialectType::PostgreSQL);
        assert!(!registry.features.is_empty());
    }

    #[test]
    fn test_enable_feature_without_dependencies() {
        let mut registry = FeatureRegistry::new(DialectType::PostgreSQL);
        assert!(registry.enable(F051_BASIC_DATE_TIME).is_ok());
        assert!(registry.is_enabled(F051_BASIC_DATE_TIME));
    }

    #[test]
    fn test_enable_feature_with_dependencies() {
        let mut registry = FeatureRegistry::new(DialectType::PostgreSQL);

        let result = registry.enable(T301_SAVEPOINTS);
        assert!(result.is_err());

        assert!(registry.enable(F402_TRANSACTION_COMMIT).is_ok());
        assert!(registry.enable(F403_TRANSACTION_ROLLBACK).is_ok());

        assert!(registry.enable(T301_SAVEPOINTS).is_ok());
        assert!(registry.is_enabled(T301_SAVEPOINTS));
    }

    #[test]
    fn test_disable_with_dependents() {
        let mut registry = FeatureRegistry::new(DialectType::PostgreSQL);

        registry.enable(F402_TRANSACTION_COMMIT).unwrap();
        registry.enable(F403_TRANSACTION_ROLLBACK).unwrap();
        registry.enable(T301_SAVEPOINTS).unwrap();

        let result = registry.disable(F402_TRANSACTION_COMMIT);
        assert!(result.is_err());

        assert!(registry.disable(T301_SAVEPOINTS).is_ok());

        assert!(registry.disable(F402_TRANSACTION_COMMIT).is_ok());
    }

    #[test]
    fn test_enable_features_resolves_dependencies() {
        let mut registry = FeatureRegistry::new(DialectType::PostgreSQL);
        registry
            .enable_features([PG_JSONB_OPERATORS])
            .expect("dependency resolution should succeed");
        assert!(registry.is_enabled(PG_JSONB_OPERATORS));
        assert!(registry.is_enabled(PG_JSONB_TYPE));
        assert!(registry.is_enabled(T860_JSON_TYPE));
    }

    #[test]
    fn test_enable_dialect_features_loads_manifest() {
        let mut registry = FeatureRegistry::new(DialectType::PostgreSQL);
        registry
            .enable_dialect_features()
            .expect("dialect feature load should succeed");

        assert!(
            registry.is_enabled(PG_SERIAL),
            "postgres manifest should enable PG_SERIAL"
        );
        assert!(
            !registry.is_enabled(BQ_SAFE_FUNCTIONS),
            "postgres manifest should not enable BigQuery features"
        );
    }

    #[test]
    fn test_get_feature() {
        let registry = FeatureRegistry::new(DialectType::PostgreSQL);
        let feature = registry.get_feature(F311_SCHEMA_DEFINITION);
        assert!(feature.is_some());
        assert_eq!(feature.unwrap().id, F311_SCHEMA_DEFINITION);
    }

    #[test]
    fn test_enabled_features_iteration() {
        let mut registry = FeatureRegistry::new(DialectType::PostgreSQL);
        registry.enable(F051_BASIC_DATE_TIME).unwrap();
        registry.enable(F052_INTERVALS_DATETIME_ARITHMETIC).unwrap();

        let count = registry.enabled_features().count();
        assert_eq!(count, 2);
    }
}
