use std::collections::HashMap;

#[derive(Debug, Clone)]
pub struct MaterializedViewMetadata {
    pub name: String,
    pub query: String,
    pub is_fresh: bool,
}

#[derive(Debug, Clone)]
pub struct MaterializedViewRegistry {
    views: HashMap<String, MaterializedViewMetadata>,
}

impl MaterializedViewRegistry {
    pub fn new() -> Self {
        Self {
            views: HashMap::new(),
        }
    }

    pub fn register(&mut self, metadata: MaterializedViewMetadata) {
        self.views.insert(metadata.name.clone(), metadata);
    }

    pub fn get(&self, name: &str) -> Option<&MaterializedViewMetadata> {
        self.views.get(name)
    }

    pub fn exists(&self, name: &str) -> bool {
        self.views.contains_key(name)
    }

    pub fn remove(&mut self, name: &str) -> Option<MaterializedViewMetadata> {
        self.views.remove(name)
    }

    pub fn list(&self) -> Vec<&str> {
        self.views.keys().map(|s| s.as_str()).collect()
    }
}

impl Default for MaterializedViewRegistry {
    fn default() -> Self {
        Self::new()
    }
}
