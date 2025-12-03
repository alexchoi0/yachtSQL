use std::collections::HashMap;

use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RegistryConfig {
    use_fallback: bool,

    auto_enable_dialect: bool,

    #[serde(default)]
    feature_overrides: HashMap<String, bool>,

    profile: Option<String>,
}

impl Default for RegistryConfig {
    fn default() -> Self {
        Self {
            use_fallback: true,
            auto_enable_dialect: false,
            feature_overrides: HashMap::new(),
            profile: None,
        }
    }
}

impl RegistryConfig {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn with_fallback(mut self, use_fallback: bool) -> Self {
        self.use_fallback = use_fallback;
        self
    }

    pub fn with_auto_enable_dialect(mut self, auto_enable: bool) -> Self {
        self.auto_enable_dialect = auto_enable;
        self
    }

    pub fn use_fallback(&self) -> bool {
        self.use_fallback
    }

    pub fn auto_enable_dialect(&self) -> bool {
        self.auto_enable_dialect
    }

    pub fn with_override(mut self, feature_id: impl Into<String>, enabled: bool) -> Self {
        self.feature_overrides.insert(feature_id.into(), enabled);
        self
    }

    pub fn with_overrides<I, S>(mut self, overrides: I) -> Self
    where
        I: IntoIterator<Item = (S, bool)>,
        S: Into<String>,
    {
        for (feature_id, enabled) in overrides {
            self.feature_overrides.insert(feature_id.into(), enabled);
        }
        self
    }

    pub fn with_profile(mut self, profile: impl Into<String>) -> Self {
        self.profile = Some(profile.into());
        self
    }

    pub fn feature_overrides(&self) -> &HashMap<String, bool> {
        &self.feature_overrides
    }

    pub fn profile(&self) -> Option<&str> {
        self.profile.as_deref()
    }

    pub fn has_override(&self, feature_id: &str) -> bool {
        self.feature_overrides.contains_key(feature_id)
    }

    pub fn get_override(&self, feature_id: &str) -> Option<bool> {
        self.feature_overrides.get(feature_id).copied()
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_default_config() {
        let config = RegistryConfig::default();
        assert!(config.use_fallback());
        assert!(!config.auto_enable_dialect());
        assert_eq!(config.profile(), None);
    }

    #[test]
    fn test_config_builder_pattern() {
        let config = RegistryConfig::new()
            .with_fallback(false)
            .with_auto_enable_dialect(true);

        assert!(!config.use_fallback());
        assert!(config.auto_enable_dialect());
    }

    #[test]
    fn test_runtime_override() {
        let config = RegistryConfig::new().with_override("T301_SAVEPOINTS", false);

        assert!(config.has_override("T301_SAVEPOINTS"));
        assert_eq!(config.get_override("T301_SAVEPOINTS"), Some(false));
        assert!(!config.has_override("F001_BASIC_SQL"));
        assert_eq!(config.get_override("F001_BASIC_SQL"), None);
    }

    #[test]
    fn test_multiple_runtime_overrides() {
        let overrides = vec![
            ("T301_SAVEPOINTS", false),
            ("F051_BASIC_DATE_TIME", true),
            ("BQ_QUALIFY_CLAUSE", true),
        ];

        let config = RegistryConfig::new().with_overrides(overrides);

        assert_eq!(config.feature_overrides().len(), 3);
        assert_eq!(config.get_override("T301_SAVEPOINTS"), Some(false));
        assert_eq!(config.get_override("F051_BASIC_DATE_TIME"), Some(true));
        assert_eq!(config.get_override("BQ_QUALIFY_CLAUSE"), Some(true));
    }

    #[test]
    fn test_profile_configuration() {
        let config = RegistryConfig::new().with_profile("development");

        assert_eq!(config.profile(), Some("development"));
    }

    #[test]
    fn test_complete_config_builder() {
        let config = RegistryConfig::new()
            .with_profile("production")
            .with_override("T301_SAVEPOINTS", false)
            .with_override("F051_BASIC_DATE_TIME", true)
            .with_fallback(false)
            .with_auto_enable_dialect(true);

        assert_eq!(config.profile(), Some("production"));
        assert_eq!(config.feature_overrides().len(), 2);
        assert!(!config.use_fallback());
        assert!(config.auto_enable_dialect());
    }
}
