//! SQL parser for BigQuery dialect.

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

pub use ast_visitor::{LogicalPlanBuilder, SessionVariable, UdfDefinition};
pub use parser::{JSON_VALUE_OPTIONS_PREFIX, JsonValueRewriteOptions, Parser, Statement};
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
            | "CORR"
            | "COVAR_POP"
            | "COVAR_SAMP"
            | "BIT_AND"
            | "BIT_OR"
            | "BIT_XOR"
            | "LOGICAL_AND"
            | "LOGICAL_OR"
            | "APPROX_COUNT_DISTINCT"
            | "APPROX_QUANTILES"
            | "APPROX_TOP_COUNT"
            | "APPROX_TOP_SUM"
            | "COUNTIF"
            | "ANY_VALUE"
            | "ARRAY_CONCAT_AGG"
            | "HLL_COUNT.INIT"
            | "HLL_COUNT.MERGE"
            | "HLL_COUNT.MERGE_PARTIAL"
            | "HLL_COUNT.EXTRACT"
            | "FIRST_VALUE"
            | "LAST_VALUE"
    };
}
