use sqlparser::ast;
use yachtsql_core::error::{Error, Result};
use yachtsql_ir::expr::{BinaryOp, Expr};

use super::super::LogicalPlanBuilder;

impl LogicalPlanBuilder {
    pub(super) fn convert_in_list(
        &self,
        expr: &ast::Expr,
        list: &[ast::Expr],
        negated: bool,
    ) -> Result<Expr> {
        let inner_expr = self.sql_expr_to_expr(expr)?;
        let list_exprs = list
            .iter()
            .map(|e| self.sql_expr_to_expr(e))
            .collect::<Result<Vec<_>>>()?;

        if let Expr::Tuple(tuple_exprs) = &inner_expr {
            let tuple_arity = tuple_exprs.len();
            if tuple_arity < 2 {
                return Err(Error::invalid_query(format!(
                    "Tuple IN predicate requires at least 2 columns, got {}",
                    tuple_arity
                )));
            }

            let mut tuple_list = Vec::new();
            for list_item in &list_exprs {
                if let Expr::Tuple(item_tuple) = list_item {
                    if item_tuple.len() != tuple_arity {
                        return Err(Error::invalid_query(format!(
                            "Tuple IN arity mismatch: expected {}, got {}",
                            tuple_arity,
                            item_tuple.len()
                        )));
                    }
                    tuple_list.push(item_tuple.clone());
                } else {
                    return Err(Error::invalid_query(
                        "Tuple IN predicate requires all list items to be tuples".to_string(),
                    ));
                }
            }

            Ok(Expr::TupleInList {
                tuple: tuple_exprs.clone(),
                list: tuple_list,
                negated,
            })
        } else {
            Ok(Expr::InList {
                expr: Box::new(inner_expr),
                list: list_exprs,
                negated,
            })
        }
    }

    pub(super) fn convert_between(
        &self,
        expr: &ast::Expr,
        low: &ast::Expr,
        high: &ast::Expr,
        negated: bool,
    ) -> Result<Expr> {
        let inner_expr = self.sql_expr_to_expr(expr)?;
        let low_expr = self.sql_expr_to_expr(low)?;
        let high_expr = self.sql_expr_to_expr(high)?;
        Ok(Expr::Between {
            expr: Box::new(inner_expr),
            low: Box::new(low_expr),
            high: Box::new(high_expr),
            negated,
        })
    }

    pub(super) fn convert_like_expr(
        &self,
        expr: &ast::Expr,
        pattern: &ast::Expr,
        negated: bool,
        base_op: BinaryOp,
        negated_op: BinaryOp,
    ) -> Result<Expr> {
        let left_expr = self.sql_expr_to_expr(expr)?;
        let right_expr = self.sql_expr_to_expr(pattern)?;
        let op = if negated { negated_op } else { base_op };
        Ok(Expr::binary_op(left_expr, op, right_expr))
    }
}
