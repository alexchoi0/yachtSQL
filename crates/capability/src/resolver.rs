use std::collections::HashSet;

use super::{FeatureId, FeatureRegistry};
use crate::error::{CapabilityError, Result};

pub struct CapabilityDependencyResolver<'a> {
    registry: &'a FeatureRegistry,
}

impl<'a> CapabilityDependencyResolver<'a> {
    pub fn new(registry: &'a FeatureRegistry) -> Self {
        Self { registry }
    }

    pub fn resolve(&self, feature_id: FeatureId) -> Result<Vec<FeatureId>> {
        let mut visited = HashSet::new();
        let mut visiting = HashSet::new();
        let mut ordered = Vec::new();
        self.visit(feature_id, &mut visited, &mut visiting, &mut ordered)?;
        Ok(ordered)
    }

    fn visit(
        &self,
        feature_id: FeatureId,
        visited: &mut HashSet<FeatureId>,
        visiting: &mut HashSet<FeatureId>,
        ordered: &mut Vec<FeatureId>,
    ) -> Result<()> {
        if visited.contains(&feature_id) {
            return Ok(());
        }

        if !self.registry.has_feature(feature_id) {
            return Err(CapabilityError::FeatureNotFound {
                feature_id: feature_id.to_string(),
            });
        }

        if !visiting.insert(feature_id) {
            let cycle_path = vec![feature_id.to_string()];
            return Err(CapabilityError::CircularDependency {
                feature_id: feature_id.to_string(),
                cycle_path,
            });
        }

        if let Some(dependencies) = self.registry.dependencies_of(feature_id) {
            for dependency in dependencies {
                self.visit(*dependency, visited, visiting, ordered)?;
            }
        }

        visiting.remove(&feature_id);
        visited.insert(feature_id);
        ordered.push(feature_id);
        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use yachtsql_parser::DialectType;

    use super::*;
    use crate::feature_ids::*;

    #[test]
    fn resolve_simple_dependency_chain() {
        let registry = FeatureRegistry::new(DialectType::BigQuery);
        let resolver = CapabilityDependencyResolver::new(&registry);
        let resolved = resolver.resolve(T301_SAVEPOINTS).unwrap();
        assert_eq!(resolved.last().copied(), Some(T301_SAVEPOINTS));
        assert!(resolved.contains(&F402_TRANSACTION_COMMIT));
        assert!(resolved.contains(&F403_TRANSACTION_ROLLBACK));
    }

    #[test]
    fn resolve_unknown_feature_returns_error() {
        let registry = FeatureRegistry::new(DialectType::BigQuery);
        let resolver = CapabilityDependencyResolver::new(&registry);
        let err = resolver.resolve(FeatureId("UNKNOWN"));
        assert!(err.is_err());
    }
}
