use sqlparser::ast::{
    Expr, FunctionArg, FunctionArgExpr, FunctionArguments, Query, SelectItem, SetExpr,
    Statement as SqlStatement,
};
use yachtsql_capability::{FeatureId, FeatureRegistry};
use yachtsql_core::error::{Error, Result};
use yachtsql_parser::Statement as ParserStatement;

use super::function_validator::validate_function;

const T611_WINDOW_FUNCTIONS: FeatureId = FeatureId("T611");

pub fn validate_statement(stmt: &ParserStatement, registry: &FeatureRegistry) -> Result<()> {
    match stmt {
        ParserStatement::Standard(std_stmt) => {
            StatementValidator { registry }.validate(std_stmt.ast())
        }
        ParserStatement::Custom(_) => Ok(()),
    }
}

struct StatementValidator<'a> {
    registry: &'a FeatureRegistry,
}

impl<'a> StatementValidator<'a> {
    fn validate(&self, stmt: &SqlStatement) -> Result<()> {
        match stmt {
            SqlStatement::Query(query) => self.validate_query(query),
            SqlStatement::Insert(insert) => {
                if let Some(query) = &insert.source {
                    self.validate_set_expr(&query.body)?;
                }
                Ok(())
            }
            SqlStatement::Update {
                selection,
                assignments,
                ..
            } => {
                if let Some(expr) = selection {
                    self.validate_expr(expr)?;
                }
                for assignment in assignments {
                    self.validate_expr(&assignment.value)?;
                }
                Ok(())
            }
            SqlStatement::Delete(delete) => {
                if let Some(expr) = &delete.selection {
                    self.validate_expr(expr)?;
                }
                Ok(())
            }
            SqlStatement::CreateView { query, .. } => self.validate_query(query),
            _ => Ok(()),
        }
    }

    fn validate_query(&self, query: &Query) -> Result<()> {
        self.validate_set_expr(&query.body)?;
        Ok(())
    }

    fn validate_set_expr(&self, set_expr: &SetExpr) -> Result<()> {
        match set_expr {
            SetExpr::Select(select) => {
                for item in &select.projection {
                    match item {
                        SelectItem::UnnamedExpr(expr) | SelectItem::ExprWithAlias { expr, .. } => {
                            self.validate_expr(expr)?;
                        }
                        _ => {}
                    }
                }
                if let Some(selection) = &select.selection {
                    self.validate_expr(selection)?;
                }
                Ok(())
            }
            SetExpr::Query(query) => self.validate_query(query),
            SetExpr::SetOperation { left, right, .. } => {
                self.validate_set_expr(left)?;
                self.validate_set_expr(right)?;
                Ok(())
            }
            _ => Ok(()),
        }
    }

    fn validate_expr(&self, expr: &Expr) -> Result<()> {
        match expr {
            Expr::Function(func) => {
                if func.over.is_some() && !self.registry.is_enabled(T611_WINDOW_FUNCTIONS) {
                    return Err(Error::unsupported_feature(
                            "Window functions (T611) are not enabled. Use CALL enable_feature('T611') to enable them.".to_string()
                        ));
                }

                let func_name = func.name.to_string();
                validate_function(&func_name, self.registry)?;

                if let FunctionArguments::List(list) = &func.args {
                    for arg in &list.args {
                        match arg {
                            FunctionArg::Unnamed(arg_expr)
                            | FunctionArg::Named { arg: arg_expr, .. }
                            | FunctionArg::ExprNamed { arg: arg_expr, .. } => match arg_expr {
                                FunctionArgExpr::Expr(e) => {
                                    self.validate_expr(e)?;
                                }
                                FunctionArgExpr::Wildcard
                                | FunctionArgExpr::QualifiedWildcard(_) => {}
                            },
                        }
                    }
                }
                Ok(())
            }
            Expr::BinaryOp { left, right, .. } => {
                self.validate_expr(left)?;
                self.validate_expr(right)?;
                Ok(())
            }
            Expr::UnaryOp { expr, .. } => self.validate_expr(expr),
            Expr::Cast { expr, .. } => self.validate_expr(expr),
            Expr::Case {
                operand,
                conditions,
                else_result,
                ..
            } => {
                if let Some(op) = operand {
                    self.validate_expr(op)?;
                }
                for case_when in conditions {
                    self.validate_expr(&case_when.condition)?;
                    self.validate_expr(&case_when.result)?;
                }
                if let Some(else_res) = else_result {
                    self.validate_expr(else_res)?;
                }
                Ok(())
            }
            Expr::Nested(inner) => self.validate_expr(inner),
            Expr::Subquery(query) => self.validate_query(query),
            Expr::InSubquery { expr, subquery, .. } => {
                self.validate_expr(expr)?;
                self.validate_query(subquery)?;
                Ok(())
            }
            Expr::Between {
                expr, low, high, ..
            } => {
                self.validate_expr(expr)?;
                self.validate_expr(low)?;
                self.validate_expr(high)?;
                Ok(())
            }
            Expr::InList { expr, list, .. } => {
                self.validate_expr(expr)?;
                for item in list {
                    self.validate_expr(item)?;
                }
                Ok(())
            }
            Expr::Ceil { expr, .. } => self.validate_expr(expr),
            Expr::Floor { expr, .. } => self.validate_expr(expr),
            Expr::Position { expr, r#in } => {
                self.validate_expr(expr)?;
                self.validate_expr(r#in)?;
                Ok(())
            }
            Expr::Overlay {
                expr,
                overlay_what,
                overlay_from,
                overlay_for,
            } => {
                self.validate_expr(expr)?;
                self.validate_expr(overlay_what)?;
                self.validate_expr(overlay_from)?;
                if let Some(for_expr) = overlay_for {
                    self.validate_expr(for_expr)?;
                }
                Ok(())
            }
            Expr::Substring {
                expr,
                substring_from,
                substring_for,
                ..
            } => {
                self.validate_expr(expr)?;
                if let Some(from) = substring_from {
                    self.validate_expr(from)?;
                }
                if let Some(for_expr) = substring_for {
                    self.validate_expr(for_expr)?;
                }
                Ok(())
            }
            Expr::Trim {
                expr, trim_what, ..
            } => {
                self.validate_expr(expr)?;
                if let Some(what) = trim_what {
                    self.validate_expr(what)?;
                }
                Ok(())
            }
            Expr::Extract { expr, .. } => self.validate_expr(expr),
            Expr::Array(array) => {
                for elem in &array.elem {
                    self.validate_expr(elem)?;
                }
                Ok(())
            }
            Expr::Tuple(exprs) => {
                for expr in exprs {
                    self.validate_expr(expr)?;
                }
                Ok(())
            }

            Expr::Like { expr, pattern, .. }
            | Expr::ILike { expr, pattern, .. }
            | Expr::SimilarTo { expr, pattern, .. } => {
                self.validate_expr(expr)?;
                self.validate_expr(pattern)?;
                Ok(())
            }
            Expr::IsNull(expr)
            | Expr::IsNotNull(expr)
            | Expr::IsTrue(expr)
            | Expr::IsNotTrue(expr)
            | Expr::IsFalse(expr)
            | Expr::IsNotFalse(expr)
            | Expr::IsUnknown(expr)
            | Expr::IsNotUnknown(expr) => self.validate_expr(expr),
            Expr::IsDistinctFrom(left, right) | Expr::IsNotDistinctFrom(left, right) => {
                self.validate_expr(left)?;
                self.validate_expr(right)?;
                Ok(())
            }
            Expr::Exists { subquery, .. } => self.validate_query(subquery),
            Expr::AnyOp { left, right, .. } | Expr::AllOp { left, right, .. } => {
                self.validate_expr(left)?;
                self.validate_expr(right)?;
                Ok(())
            }
            _ => Ok(()),
        }
    }
}

#[cfg(test)]
mod tests {
    use yachtsql_capability::FeatureRegistry;
    use yachtsql_parser::{DialectType, Parser, Statement};

    use super::*;

    fn parse_statement(sql: &str, dialect: DialectType) -> Statement {
        let parser = Parser::with_dialect(dialect);
        let stmts = parser.parse_sql(sql).expect("Failed to parse SQL");
        stmts.into_iter().next().expect("No statement parsed")
    }

    #[test]
    fn test_validate_core_functions() {
        let registry = FeatureRegistry::new(DialectType::PostgreSQL);
        let stmt = parse_statement(
            "SELECT UPPER(name), COUNT(*) FROM users",
            DialectType::PostgreSQL,
        );

        assert!(validate_statement(&stmt, &registry).is_ok());
    }

    #[test]
    fn test_validate_postgres_specific_function() {
        let pg_registry = FeatureRegistry::new(DialectType::PostgreSQL);
        let bq_registry = FeatureRegistry::new(DialectType::BigQuery);

        let stmt = parse_statement("SELECT JSONB(data) FROM table1", DialectType::PostgreSQL);

        assert!(validate_statement(&stmt, &pg_registry).is_ok());
        assert!(validate_statement(&stmt, &bq_registry).is_err());
    }

    #[test]
    fn test_validate_nested_functions() {
        let registry = FeatureRegistry::new(DialectType::PostgreSQL);
        let stmt = parse_statement(
            "SELECT UPPER(CONCAT(first, last)) FROM users WHERE LENGTH(name) > 5",
            DialectType::PostgreSQL,
        );

        assert!(validate_statement(&stmt, &registry).is_ok());
    }

    #[test]
    fn test_validate_update_statement() {
        let pg_registry = FeatureRegistry::new(DialectType::PostgreSQL);

        let stmt = parse_statement(
            "UPDATE users SET name = UPPER(name) WHERE id > 0",
            DialectType::PostgreSQL,
        );

        assert!(validate_statement(&stmt, &pg_registry).is_ok());
    }
}
