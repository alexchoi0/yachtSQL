use std::cell::{Cell, RefCell};
use std::collections::HashMap;
use std::rc::Rc;

use yachtsql_parser::Statement;

pub struct AstCacheConfig {
    pub max_capacity: u64,
}

impl Default for AstCacheConfig {
    fn default() -> Self {
        Self {
            max_capacity: 10_000,
        }
    }
}

pub struct AstCache {
    cache: RefCell<HashMap<u64, Rc<Vec<Statement>>>>,
    insertion_order: RefCell<Vec<u64>>,
    max_capacity: u64,
    hit_count: Cell<u64>,
    miss_count: Cell<u64>,
}

impl AstCache {
    pub fn new() -> Self {
        Self::with_config(AstCacheConfig::default())
    }

    pub fn with_config(config: AstCacheConfig) -> Self {
        Self {
            cache: RefCell::new(HashMap::new()),
            insertion_order: RefCell::new(Vec::new()),
            max_capacity: config.max_capacity,
            hit_count: Cell::new(0),
            miss_count: Cell::new(0),
        }
    }

    pub fn get(&self, sql_hash: u64) -> Option<Rc<Vec<Statement>>> {
        let cache = self.cache.borrow();
        let result = cache.get(&sql_hash).cloned();
        if result.is_some() {
            self.hit_count.set(self.hit_count.get() + 1);
        } else {
            self.miss_count.set(self.miss_count.get() + 1);
        }
        result
    }

    pub fn insert(&self, sql_hash: u64, statements: Vec<Statement>) {
        let mut cache = self.cache.borrow_mut();
        let mut order = self.insertion_order.borrow_mut();

        while cache.len() as u64 >= self.max_capacity && !order.is_empty() {
            if let Some(oldest) = order.first().cloned() {
                cache.remove(&oldest);
                order.remove(0);
            }
        }

        if !cache.contains_key(&sql_hash) {
            order.push(sql_hash);
        }
        cache.insert(sql_hash, Rc::new(statements));
    }

    pub fn clear(&self) {
        self.cache.borrow_mut().clear();
        self.insertion_order.borrow_mut().clear();
        self.hit_count.set(0);
        self.miss_count.set(0);
    }

    pub fn stats(&self) -> CacheStats {
        CacheStats {
            entry_count: self.cache.borrow().len() as u64,
            hit_count: self.hit_count.get(),
            miss_count: self.miss_count.get(),
        }
    }

    pub fn hit_rate(&self) -> f64 {
        let stats = self.stats();
        let total = stats.hit_count + stats.miss_count;
        if total == 0 {
            0.0
        } else {
            stats.hit_count as f64 / total as f64
        }
    }
}

impl Default for AstCache {
    fn default() -> Self {
        Self::new()
    }
}

#[derive(Debug, Clone, Copy)]
pub struct CacheStats {
    pub entry_count: u64,
    pub hit_count: u64,
    pub miss_count: u64,
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_cache_insert_and_get() {
        let cache = AstCache::new();
        let statements = vec![];
        let hash = 12345u64;

        cache.insert(hash, statements.clone());
        let result = cache.get(hash);

        assert!(result.is_some());
    }

    #[test]
    fn test_cache_miss() {
        let cache = AstCache::new();
        let hash = 99999u64;

        let result = cache.get(hash);
        assert!(result.is_none());
    }

    #[test]
    fn test_cache_clear() {
        let cache = AstCache::new();
        let hash = 12345u64;

        cache.insert(hash, vec![]);
        assert!(cache.get(hash).is_some());

        cache.clear();
        assert!(cache.get(hash).is_none());
    }

    #[test]
    fn test_cache_stats() {
        let cache = AstCache::new();
        let hash1 = 11111u64;
        let hash2 = 22222u64;

        cache.insert(hash1, vec![]);

        cache.get(hash1);
        cache.get(hash2);

        let stats = cache.stats();
        assert_eq!(stats.hit_count, 1);
        assert_eq!(stats.miss_count, 1);
        assert_eq!(cache.hit_rate(), 0.5);
    }

    #[test]
    fn test_cache_hit_rate() {
        let cache = AstCache::new();

        assert_eq!(cache.hit_rate(), 0.0);

        let hash = 12345u64;
        cache.insert(hash, vec![]);
        cache.get(hash);
        cache.get(hash);

        let hit_rate = cache.hit_rate();
        assert!(hit_rate > 0.5);
    }

    #[test]
    fn test_cache_eviction() {
        let cache = AstCache::with_config(AstCacheConfig { max_capacity: 3 });

        cache.insert(1, vec![]);
        cache.insert(2, vec![]);
        cache.insert(3, vec![]);

        assert!(cache.get(1).is_some());
        assert!(cache.get(2).is_some());
        assert!(cache.get(3).is_some());

        cache.insert(4, vec![]);

        assert!(cache.get(1).is_none());
        assert!(cache.get(2).is_some());
        assert!(cache.get(3).is_some());
        assert!(cache.get(4).is_some());
    }
}
