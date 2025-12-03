use debug_print::debug_eprintln;
use yachtsql_core::error::Result;
use yachtsql_ir::expr::{BinaryOp, Expr};
use yachtsql_ir::plan::{LogicalPlan, PlanNode};

use crate::rule::OptimizationRule;
use crate::visitor::PlanRewriter;

pub struct IndexSelectionRule {
    enabled: bool,
}

impl IndexSelectionRule {
    pub fn new() -> Self {
        Self { enabled: true }
    }

    #[allow(dead_code)]
    pub fn disabled() -> Self {
        Self { enabled: false }
    }

    fn extract_equality_predicate(&self, predicate: &Expr) -> Option<(String, Expr)> {
        if let Expr::BinaryOp { left, op, right } = predicate {
            if matches!(op, BinaryOp::Equal) {
                if let (Expr::Column { name, .. }, value @ Expr::Literal(_)) =
                    (left.as_ref(), right.as_ref())
                {
                    return Some((name.clone(), value.clone()));
                }

                if let (value @ Expr::Literal(_), Expr::Column { name, .. }) =
                    (left.as_ref(), right.as_ref())
                {
                    return Some((name.clone(), value.clone()));
                }
            }
        }

        None
    }

    fn estimate_selectivity(&self, predicate: &Expr) -> f64 {
        match predicate {
            Expr::BinaryOp {
                op: BinaryOp::Equal,
                ..
            } => 0.1,
            _ => 0.5,
        }
    }

    fn should_use_index(&self, selectivity: f64) -> bool {
        selectivity < 0.2
    }

    fn generate_index_name(&self, table_name: &str, column_name: &str) -> String {
        format!("idx_{}_{}", table_name, column_name)
    }
}

impl Default for IndexSelectionRule {
    fn default() -> Self {
        Self::new()
    }
}

impl PlanRewriter for IndexSelectionRule {
    fn rewrite_node(&mut self, node: &PlanNode) -> Result<Option<PlanNode>> {
        if !self.enabled {
            return Ok(None);
        }

        if let PlanNode::Filter { predicate, input } = node {
            if let PlanNode::Scan {
                table_name,
                alias,
                projection,
            } = input.as_ref()
            {
                if let Some((column_name, _value)) = self.extract_equality_predicate(predicate) {
                    let selectivity = self.estimate_selectivity(predicate);

                    if self.should_use_index(selectivity) {
                        let index_name = self.generate_index_name(table_name, &column_name);

                        let index_scan = PlanNode::IndexScan {
                            table_name: table_name.clone(),
                            alias: alias.clone(),
                            index_name,
                            predicate: predicate.clone(),
                            projection: projection.clone(),
                        };

                        debug_eprintln!(
                            "[optimizer::index_selection] Optimizing Filter(Scan({})) on column '{}' → IndexScan (estimated selectivity: {:.1}%)",
                            table_name,
                            column_name,
                            selectivity * 100.0
                        );

                        return Ok(Some(index_scan));
                    }
                }
            }
        }

        Ok(None)
    }
}

impl OptimizationRule for IndexSelectionRule {
    fn name(&self) -> &'static str {
        "IndexSelection"
    }

    fn optimize(&self, plan: &LogicalPlan) -> Result<Option<LogicalPlan>> {
        let mut rewriter = IndexSelectionRule {
            enabled: self.enabled,
        };
        rewriter.rewrite(plan)
    }
}

#[cfg(test)]
mod tests {
    use yachtsql_ir::expr::LiteralValue;

    use super::*;

    #[test]
    fn test_index_selection_rule_creation() {
        let rule = IndexSelectionRule::new();
        assert_eq!(rule.name(), "IndexSelection");
        assert!(rule.enabled);
    }

    #[test]
    fn test_extract_equality_predicate_column_eq_literal() {
        let rule = IndexSelectionRule::new();

        let predicate = Expr::BinaryOp {
            left: Box::new(Expr::Column {
                name: "id".to_string(),
                table: None,
            }),
            op: BinaryOp::Equal,
            right: Box::new(Expr::Literal(LiteralValue::Int64(42))),
        };

        let result = rule.extract_equality_predicate(&predicate);
        assert!(result.is_some());
        let (column, _value) = result.unwrap();
        assert_eq!(column, "id");
    }

    #[test]
    fn test_extract_equality_predicate_literal_eq_column() {
        let rule = IndexSelectionRule::new();

        let predicate = Expr::BinaryOp {
            left: Box::new(Expr::Literal(LiteralValue::Int64(42))),
            op: BinaryOp::Equal,
            right: Box::new(Expr::Column {
                name: "id".to_string(),
                table: None,
            }),
        };

        let result = rule.extract_equality_predicate(&predicate);
        assert!(result.is_some());
        let (column, _value) = result.unwrap();
        assert_eq!(column, "id");
    }

    #[test]
    fn test_extract_equality_predicate_non_eq_returns_none() {
        let rule = IndexSelectionRule::new();

        let predicate = Expr::BinaryOp {
            left: Box::new(Expr::Column {
                name: "id".to_string(),
                table: None,
            }),
            op: BinaryOp::GreaterThan,
            right: Box::new(Expr::Literal(LiteralValue::Int64(42))),
        };

        let result = rule.extract_equality_predicate(&predicate);
        assert!(result.is_none());
    }

    #[test]
    fn test_estimate_selectivity() {
        let rule = IndexSelectionRule::new();

        let eq_predicate = Expr::BinaryOp {
            left: Box::new(Expr::Column {
                name: "id".to_string(),
                table: None,
            }),
            op: BinaryOp::Equal,
            right: Box::new(Expr::Literal(LiteralValue::Int64(42))),
        };

        assert_eq!(rule.estimate_selectivity(&eq_predicate), 0.1);

        let gt_predicate = Expr::BinaryOp {
            left: Box::new(Expr::Column {
                name: "id".to_string(),
                table: None,
            }),
            op: BinaryOp::GreaterThan,
            right: Box::new(Expr::Literal(LiteralValue::Int64(42))),
        };

        assert_eq!(rule.estimate_selectivity(&gt_predicate), 0.5);
    }

    #[test]
    fn test_should_use_index() {
        let rule = IndexSelectionRule::new();

        assert!(rule.should_use_index(0.1));
        assert!(rule.should_use_index(0.19));
        assert!(!rule.should_use_index(0.2));
        assert!(!rule.should_use_index(0.5));
    }

    #[test]
    fn test_generate_index_name() {
        let rule = IndexSelectionRule::new();

        assert_eq!(
            rule.generate_index_name("users", "email"),
            "idx_users_email"
        );
        assert_eq!(rule.generate_index_name("orders", "id"), "idx_orders_id");
    }

    #[test]
    fn test_rewrite_filter_scan_to_index_scan() {
        let mut rule = IndexSelectionRule::new();

        let plan = LogicalPlan::new(PlanNode::Filter {
            predicate: Expr::BinaryOp {
                left: Box::new(Expr::Column {
                    name: "id".to_string(),
                    table: None,
                }),
                op: BinaryOp::Equal,
                right: Box::new(Expr::Literal(LiteralValue::Int64(123))),
            },
            input: Box::new(PlanNode::Scan {
                table_name: "users".to_string(),
                alias: None,
                projection: None,
            }),
        });

        let result = rule.rewrite(&plan).unwrap();
        assert!(result.is_some());

        let optimized = result.unwrap();
        match optimized.root() {
            PlanNode::IndexScan {
                table_name,
                index_name,
                ..
            } => {
                assert_eq!(table_name, "users");
                assert_eq!(index_name, "idx_users_id");
            }
            _ => panic!("Expected IndexScan, got {:?}", optimized.root()),
        }
    }

    #[test]
    fn test_no_rewrite_for_non_equality_predicate() {
        let mut rule = IndexSelectionRule::new();

        let plan = LogicalPlan::new(PlanNode::Filter {
            predicate: Expr::BinaryOp {
                left: Box::new(Expr::Column {
                    name: "age".to_string(),
                    table: None,
                }),
                op: BinaryOp::GreaterThan,
                right: Box::new(Expr::Literal(LiteralValue::Int64(18))),
            },
            input: Box::new(PlanNode::Scan {
                table_name: "users".to_string(),
                alias: None,
                projection: None,
            }),
        });

        let result = rule.rewrite(&plan).unwrap();
        assert!(result.is_none());
    }

    #[test]
    fn test_disabled_rule_does_not_transform() {
        let mut rule = IndexSelectionRule::disabled();

        let plan = LogicalPlan::new(PlanNode::Filter {
            predicate: Expr::BinaryOp {
                left: Box::new(Expr::Column {
                    name: "id".to_string(),
                    table: None,
                }),
                op: BinaryOp::Equal,
                right: Box::new(Expr::Literal(LiteralValue::Int64(42))),
            },
            input: Box::new(PlanNode::Scan {
                table_name: "users".to_string(),
                alias: None,
                projection: None,
            }),
        });

        let result = rule.rewrite(&plan).unwrap();
        assert!(result.is_none());
    }
}
