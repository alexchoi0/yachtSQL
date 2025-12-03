#![warn(missing_docs)]
#![warn(rustdoc::missing_crate_level_docs)]
#![warn(rustdoc::broken_intra_doc_links)]
#![allow(missing_docs)]

pub mod ast_visitor;
pub mod parser;
pub mod pattern_matcher;
pub mod sql_context;
pub mod sql_json;
pub mod sql_types;
pub mod validator;

pub use ast_visitor::LogicalPlanBuilder;
pub use parser::{
    DialectType, JSON_VALUE_OPTIONS_PREFIX, JsonValueRewriteOptions, Parser, Statement,
};
pub use sql_json::Sql2023Json;
pub use sql_types::Sql2023Types;
pub use validator::CustomStatement;

#[macro_export]
macro_rules! aggregate_function_names {
    () => {
        "COUNT"
            | "SUM"
            | "AVG"
            | "MIN"
            | "MAX"
            | "STRING_AGG"
            | "ARRAY_AGG"
            | "STDDEV"
            | "STDDEV_POP"
            | "STDDEV_SAMP"
            | "VARIANCE"
            | "VAR_POP"
            | "VAR_SAMP"
            | "MEDIAN"
            | "MODE"
            | "PERCENTILE_CONT"
            | "PERCENTILE_DISC"
            | "CORR"
            | "COVAR_POP"
            | "COVAR_SAMP"
            | "JSON_AGG"
            | "JSON_ARRAYAGG"
            | "JSON_OBJECT_AGG"
            | "JSON_OBJECTAGG"
            | "BIT_AND"
            | "BIT_OR"
            | "BIT_XOR"
            | "BOOL_AND"
            | "BOOL_OR"
            | "EVERY"
            | "APPROX_COUNT_DISTINCT"
            | "APPROX_QUANTILES"
            | "APPROX_TOP_COUNT"
            | "APPROX_TOP_SUM"
            | "LISTAGG"
    };
}
