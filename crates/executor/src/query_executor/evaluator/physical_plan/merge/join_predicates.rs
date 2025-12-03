use yachtsql_optimizer::BinaryOp;
use yachtsql_optimizer::expr::Expr;

use super::types::EquijoinPredicate;

pub(super) fn extract_equijoin_predicates(
    expr: &Expr,
    target_alias: Option<&str>,
    source_alias: Option<&str>,
) -> Option<Vec<EquijoinPredicate>> {
    let mut predicates = Vec::new();
    extract_from_expr(expr, &mut predicates, target_alias, source_alias)?;

    if predicates.is_empty() {
        None
    } else {
        Some(predicates)
    }
}

fn extract_from_expr(
    expr: &Expr,
    predicates: &mut Vec<EquijoinPredicate>,
    target_alias: Option<&str>,
    source_alias: Option<&str>,
) -> Option<()> {
    match expr {
        Expr::BinaryOp {
            left,
            op: BinaryOp::Equal,
            right,
        } => {
            if let ((Some(left_col), Some(left_table)), (Some(right_col), Some(right_table))) =
                (get_column_and_table(left), get_column_and_table(right))
            {
                let is_left_target = Some(left_table.as_str()) == target_alias;
                let is_right_target = Some(right_table.as_str()) == target_alias;
                let is_left_source = Some(left_table.as_str()) == source_alias;
                let is_right_source = Some(right_table.as_str()) == source_alias;

                if is_left_target && is_right_source {
                    predicates.push(EquijoinPredicate {
                        target_column: left_col,
                        source_column: right_col,
                    });
                    return Some(());
                } else if is_left_source && is_right_target {
                    predicates.push(EquijoinPredicate {
                        target_column: right_col,
                        source_column: left_col,
                    });
                    return Some(());
                }
            }
            None
        }

        Expr::BinaryOp {
            left,
            op: BinaryOp::And,
            right,
        } => {
            extract_from_expr(left, predicates, target_alias, source_alias)?;
            extract_from_expr(right, predicates, target_alias, source_alias)
        }
        _ => None,
    }
}

fn get_column_and_table(expr: &Expr) -> (Option<String>, Option<String>) {
    match expr {
        Expr::Column { name, table } => (Some(name.clone()), table.clone()),
        _ => (None, None),
    }
}
