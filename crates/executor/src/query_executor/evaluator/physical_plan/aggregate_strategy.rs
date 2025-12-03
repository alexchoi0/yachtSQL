#[derive(Debug, Clone, PartialEq, Eq)]
pub enum AggregateStrategy {
    Hash,
    Sort,
}

impl AggregateStrategy {
    pub fn select(input_sorted_on_group_by: bool) -> Self {
        if input_sorted_on_group_by {
            AggregateStrategy::Sort
        } else {
            AggregateStrategy::Hash
        }
    }

    pub fn select_with_columns(
        input_sorted: bool,
        input_sort_columns: &[String],
        group_by_columns: &[String],
    ) -> Self {
        if !input_sorted || group_by_columns.is_empty() {
            return AggregateStrategy::Hash;
        }

        let group_by_prefix_matches = group_by_columns
            .iter()
            .zip(input_sort_columns.iter())
            .all(|(g, s)| g.eq_ignore_ascii_case(s));

        if group_by_prefix_matches && input_sort_columns.len() >= group_by_columns.len() {
            AggregateStrategy::Sort
        } else {
            AggregateStrategy::Hash
        }
    }

    pub fn select_extended(
        input_sorted_on_group_by: bool,
        estimated_groups: Option<usize>,
        memory_budget: Option<usize>,
        output_needs_sort: bool,
    ) -> Self {
        if input_sorted_on_group_by {
            return AggregateStrategy::Sort;
        }

        if output_needs_sort {
            return AggregateStrategy::Sort;
        }

        if let (Some(groups), Some(budget)) = (estimated_groups, memory_budget) {
            let estimated_hash_memory = groups.saturating_mul(200);
            if estimated_hash_memory > budget {
                return AggregateStrategy::Sort;
            }
        }

        AggregateStrategy::Hash
    }

    pub fn describe(&self) -> &'static str {
        match self {
            AggregateStrategy::Hash => "Hash Aggregate",
            AggregateStrategy::Sort => "Sort Aggregate",
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_select_sort_when_sorted() {
        let strategy = AggregateStrategy::select(true);
        assert_eq!(strategy, AggregateStrategy::Sort);
    }

    #[test]
    fn test_select_hash_when_unsorted() {
        let strategy = AggregateStrategy::select(false);
        assert_eq!(strategy, AggregateStrategy::Hash);
    }

    #[test]
    fn test_extended_prefers_sort_when_output_needs_sort() {
        let strategy = AggregateStrategy::select_extended(false, Some(100), Some(1_000_000), true);
        assert_eq!(strategy, AggregateStrategy::Sort);
    }

    #[test]
    fn test_extended_prefers_sort_under_memory_pressure() {
        let strategy =
            AggregateStrategy::select_extended(false, Some(1_000_000), Some(1_000), false);
        assert_eq!(strategy, AggregateStrategy::Sort);
    }

    #[test]
    fn test_extended_prefers_hash_with_adequate_memory() {
        let strategy = AggregateStrategy::select_extended(false, Some(100), Some(1_000_000), false);
        assert_eq!(strategy, AggregateStrategy::Hash);
    }
}
