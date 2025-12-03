#[derive(Debug, Clone, PartialEq, Eq)]
pub enum JoinStrategy {
    Hash,
    Merge,
    NestedLoop,
    IndexNestedLoop { index_name: String },
}

impl JoinStrategy {
    pub fn select(
        left_sorted: bool,
        right_sorted: bool,
        is_equi_join: bool,
        right_index: Option<&str>,
        left_rows: Option<usize>,
    ) -> Self {
        if is_equi_join && left_sorted && right_sorted {
            return JoinStrategy::Merge;
        }

        if is_equi_join {
            if let Some(idx) = right_index {
                let outer_cardinality = left_rows.unwrap_or(10000);

                if outer_cardinality < 1000 {
                    return JoinStrategy::IndexNestedLoop {
                        index_name: idx.to_string(),
                    };
                }
            }
        }

        if !is_equi_join {
            return JoinStrategy::NestedLoop;
        }

        JoinStrategy::Hash
    }

    pub fn describe(&self) -> &'static str {
        match self {
            JoinStrategy::Hash => "Hash Join",
            JoinStrategy::Merge => "Merge Join",
            JoinStrategy::NestedLoop => "Nested Loop Join",
            JoinStrategy::IndexNestedLoop { .. } => "Index Nested Loop Join",
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_select_merge_when_both_sorted() {
        let strategy = JoinStrategy::select(true, true, true, None, Some(10000));
        assert_eq!(strategy, JoinStrategy::Merge);
    }

    #[test]
    fn test_select_hash_when_unsorted() {
        let strategy = JoinStrategy::select(false, false, true, None, Some(10000));
        assert_eq!(strategy, JoinStrategy::Hash);
    }

    #[test]
    fn test_select_index_nested_loop_when_small_outer() {
        let strategy = JoinStrategy::select(false, false, true, Some("idx_users_id"), Some(100));
        assert_eq!(
            strategy,
            JoinStrategy::IndexNestedLoop {
                index_name: "idx_users_id".to_string()
            }
        );
    }

    #[test]
    fn test_select_hash_when_large_outer_with_index() {
        let strategy = JoinStrategy::select(false, false, true, Some("idx_users_id"), Some(10000));
        assert_eq!(strategy, JoinStrategy::Hash);
    }

    #[test]
    fn test_select_nested_loop_for_non_equi() {
        let strategy = JoinStrategy::select(false, false, false, None, Some(10000));
        assert_eq!(strategy, JoinStrategy::NestedLoop);
    }

    #[test]
    fn test_merge_takes_priority_over_index() {
        let strategy = JoinStrategy::select(true, true, true, Some("idx_users_id"), Some(100));
        assert_eq!(strategy, JoinStrategy::Merge);
    }
}
