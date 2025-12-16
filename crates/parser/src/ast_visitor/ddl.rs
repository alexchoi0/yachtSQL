use sqlparser::ast;
use yachtsql_common::error::{Error, Result};
use yachtsql_common::types::DataType;

use super::LogicalPlanBuilder;
use crate::Sql2023Types;

impl LogicalPlanBuilder {
    pub(super) fn sql_datatype_to_datatype(data_type: &ast::DataType) -> Result<DataType> {
        match data_type {
            ast::DataType::Int(_) | ast::DataType::Integer(_) => Ok(DataType::Int64),
            ast::DataType::BigInt(_) => Ok(DataType::Int64),
            ast::DataType::SmallInt(_) => Ok(DataType::Int64),
            ast::DataType::TinyInt(_) => Ok(DataType::Int64),
            ast::DataType::Float(_) => Ok(DataType::Float64),
            ast::DataType::Double(_) | ast::DataType::Real => Ok(DataType::Float64),
            ast::DataType::Decimal(precision_info)
            | ast::DataType::Dec(precision_info)
            | ast::DataType::Numeric(precision_info) => {
                let precision_scale = match precision_info {
                    sqlparser::ast::ExactNumberInfo::PrecisionAndScale(p, s) => {
                        Some(((*p) as u8, (*s) as u8))
                    }
                    sqlparser::ast::ExactNumberInfo::Precision(p) => Some(((*p) as u8, 0)),
                    sqlparser::ast::ExactNumberInfo::None => None,
                };
                Ok(DataType::Numeric(precision_scale))
            }
            ast::DataType::String(_) | ast::DataType::Text => Ok(DataType::String),
            ast::DataType::Varchar(_) | ast::DataType::Char(_) => Ok(DataType::String),
            ast::DataType::Bit(_) | ast::DataType::BitVarying(_) => Ok(DataType::Bytes),
            ast::DataType::Boolean => Ok(DataType::Bool),
            ast::DataType::Date => Ok(DataType::Date),
            ast::DataType::Timestamp(_, _) => Ok(DataType::Timestamp),
            ast::DataType::Time(_, _) => Ok(DataType::Time),
            ast::DataType::Datetime(_) => Ok(DataType::DateTime),
            ast::DataType::JSON | ast::DataType::JSONB => Ok(DataType::Json),
            ast::DataType::Array(inner_def) => {
                use sqlparser::ast::ArrayElemTypeDef;
                let inner_type = match inner_def {
                    ArrayElemTypeDef::AngleBracket(dt) | ArrayElemTypeDef::SquareBracket(dt, _) => {
                        Self::sql_datatype_to_datatype(dt)?
                    }
                    ArrayElemTypeDef::Parenthesis(dt) => Self::sql_datatype_to_datatype(dt)?,
                    ArrayElemTypeDef::None => DataType::String,
                };
                Ok(DataType::Array(Box::new(inner_type)))
            }
            ast::DataType::Custom(name, _modifiers) => {
                let type_name = name
                    .0
                    .last()
                    .and_then(|part| part.as_ident())
                    .map(|ident| ident.value.clone())
                    .unwrap_or_default();
                let canonical = Sql2023Types::normalize_type_name(&type_name);

                match canonical.as_str() {
                    "BIGINT" | "INT64" => Ok(DataType::Int64),
                    "DOUBLE PRECISION" | "FLOAT64" => Ok(DataType::Float64),
                    "VARCHAR" | "CHAR" | "STRING" => Ok(DataType::String),
                    "BOOLEAN" | "BOOL" => Ok(DataType::Bool),
                    "VARBINARY" | "BINARY" | "BYTES" => Ok(DataType::Bytes),
                    "NUMERIC" | "BIGNUMERIC" => Ok(DataType::Numeric(None)),
                    "JSON" => Ok(DataType::Json),
                    "GEOGRAPHY" => Ok(DataType::Geography),
                    "INTERVAL" => Ok(DataType::Interval),
                    _ => Err(Error::unsupported_feature(format!(
                        "Data type not supported: {}",
                        type_name
                    ))),
                }
            }
            _ => Err(Error::unsupported_feature(format!(
                "Data type not supported: {:?}",
                data_type
            ))),
        }
    }
}
