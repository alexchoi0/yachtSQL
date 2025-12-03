use std::collections::HashMap;
use std::sync::OnceLock;

use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, Serialize, Deserialize)]
pub struct FeatureId(pub &'static str);

impl FeatureId {
    pub fn as_str(&self) -> &'static str {
        self.0
    }
}

impl From<&'static str> for FeatureId {
    fn from(s: &'static str) -> Self {
        FeatureId(s)
    }
}

impl std::fmt::Display for FeatureId {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{}", self.0)
    }
}

pub const F001_BASIC_SQL: FeatureId = FeatureId("F001");

pub const F031_BASIC_SCHEMA_MANIPULATION: FeatureId = FeatureId("F031");
pub const F051_BASIC_DATE_TIME: FeatureId = FeatureId("F051");
pub const F052_INTERVALS_DATETIME_ARITHMETIC: FeatureId = FeatureId("F052");

pub const F311_SCHEMA_DEFINITION: FeatureId = FeatureId("F311");
pub const F312_SCALAR_SUBQUERY_AS_EXPRESSION: FeatureId = FeatureId("F312");

pub const E011_DEFAULT_CLAUSE: FeatureId = FeatureId("E011");

pub const E141_INTEGRITY_ENHANCEMENT: FeatureId = FeatureId("E141");

pub const F402_TRANSACTION_COMMIT: FeatureId = FeatureId("F402");
pub const F403_TRANSACTION_ROLLBACK: FeatureId = FeatureId("F403");

pub const F441_EXTENDED_SET_FUNCTION_SUPPORT: FeatureId = FeatureId("F441");
pub const F442_MIXED_COLUMN_REFERENCES: FeatureId = FeatureId("F442");
pub const F443_EXPLICIT_DEFAULTS: FeatureId = FeatureId("F443");

pub const F351_MERGE_STATEMENT: FeatureId = FeatureId("F351");

pub const F496_OPTIONAL_TABLE_VERSIONING: FeatureId = FeatureId("F496");

pub const F561_FULL_VALUE_EXPRESSIONS: FeatureId = FeatureId("F561");

pub const F591_DERIVED_TABLES: FeatureId = FeatureId("F591");

pub const F781_SELF_REFERENCING_OPERATIONS: FeatureId = FeatureId("F781");

pub const F782_COMMIT_STATEMENT: FeatureId = FeatureId("F782");

pub const F783_ROLLBACK_STATEMENT: FeatureId = FeatureId("F783");

pub const F784_SAVEPOINT_STATEMENT: FeatureId = FeatureId("F784");

pub const F785_ROLLBACK_TO_SAVEPOINT_STATEMENT: FeatureId = FeatureId("F785");

pub const F786_SAVEPOINTS: FeatureId = FeatureId("F786");

pub const F851_WINDOW_FRAME_EXCLUDE: FeatureId = FeatureId("F851");

pub const T301_SAVEPOINTS: FeatureId = FeatureId("T301");
pub const T321_TRANSACTION_ISOLATION: FeatureId = FeatureId("T321");

pub const T602_ENHANCED_NUMERIC_FUNCTIONS: FeatureId = FeatureId("T602");

pub const T801_MERGE_STATEMENT: FeatureId = FeatureId("T801");
pub const T802_MERGE_WHEN_MATCHED: FeatureId = FeatureId("T802");
pub const T803_MERGE_WHEN_NOT_MATCHED: FeatureId = FeatureId("T803");

pub const T860_JSON_TYPE: FeatureId = FeatureId("T860");
pub const T861_JSON_QUERY: FeatureId = FeatureId("T861");
pub const T862_JSON_VALUE: FeatureId = FeatureId("T862");
pub const T863_JSON_EXISTS: FeatureId = FeatureId("T863");
pub const T864_JSON_TABLE: FeatureId = FeatureId("T864");
pub const T865_JSON_OBJECT_CONSTRUCTOR: FeatureId = FeatureId("T865");
pub const T866_JSON_ARRAY_CONSTRUCTOR: FeatureId = FeatureId("T866");
pub const T867_JSON_IS_JSON_PREDICATE: FeatureId = FeatureId("T867");
pub const T867_IS_JSON_PREDICATE: FeatureId = FeatureId("T867");
pub const T868_JSON_SIMPLIFIED_ACCESSOR: FeatureId = FeatureId("T868");
pub const T869_JSON_NULL_CLAUSE: FeatureId = FeatureId("T869");
pub const T870_JSON_ARRAYAGG: FeatureId = FeatureId("T870");
pub const T871_JSON_OBJECTAGG: FeatureId = FeatureId("T871");
pub const T872_JSON_PATHS: FeatureId = FeatureId("T872");
pub const T873_JSON_PASSING_CLAUSE: FeatureId = FeatureId("T873");
pub const T874_JSON_RETURNING_CLAUSE: FeatureId = FeatureId("T874");
pub const T875_JSON_ERROR_BEHAVIOR: FeatureId = FeatureId("T875");
pub const T876_JSON_NESTED_PATH: FeatureId = FeatureId("T876");
pub const T877_JSON_WRAPPER_OPTION: FeatureId = FeatureId("T877");
pub const T878_JSON_QUOTES_OPTION: FeatureId = FeatureId("T878");

pub const T041_ROW_TYPE: FeatureId = FeatureId("T041");
pub const T042_ROW_TYPE_CONSTRUCTOR: FeatureId = FeatureId("T042");
pub const T042_ROW_CONSTRUCTOR: FeatureId = FeatureId("T042");
pub const T043_ROW_TYPE_FIELD_ACCESS: FeatureId = FeatureId("T043");
pub const T043_ROW_FIELD_ACCESS: FeatureId = FeatureId("T043");

pub const T174_IDENTITY_COLUMNS: FeatureId = FeatureId("T174");

pub const T176_SEQUENCE_GENERATOR: FeatureId = FeatureId("T176");

pub const T611_WINDOW_FUNCTIONS: FeatureId = FeatureId("T611");
pub const T612_ADVANCED_OLAP: FeatureId = FeatureId("T612");
pub const T612_ADVANCED_OLAP_OPERATIONS: FeatureId = FeatureId("T612");
pub const T613_WINDOW_FRAME_CLAUSE: FeatureId = FeatureId("T613");
pub const T614_NTILE: FeatureId = FeatureId("T614");
pub const T614_NTILE_FUNCTION: FeatureId = FeatureId("T614");
pub const T615_LEAD_LAG: FeatureId = FeatureId("T615");
pub const T615_LEAD_LAG_FUNCTIONS: FeatureId = FeatureId("T615");
pub const T616_NULL_TREATMENT: FeatureId = FeatureId("T616");
pub const T616_NULL_TREATMENT_WINDOW: FeatureId = FeatureId("T616");
pub const T617_FIRST_LAST_VALUE: FeatureId = FeatureId("T617");
pub const T617_FIRST_VALUE_LAST_VALUE: FeatureId = FeatureId("T617");
pub const T618_NTH_VALUE: FeatureId = FeatureId("T618");
pub const T619_WINDOW_FRAME_GROUPS: FeatureId = FeatureId("T619");
pub const T620_WINDOW_FRAME_EXCLUDE: FeatureId = FeatureId("T620");

pub const T211_BASIC_TRIGGER_CAPABILITY: FeatureId = FeatureId("T211");

pub const T121_WITH_CLAUSE: FeatureId = FeatureId("T121");
pub const T131_RECURSIVE_QUERY: FeatureId = FeatureId("T131");

pub const F471_TUPLE_IN_CLAUSE: FeatureId = FeatureId("F471");

pub const PG_RETURNING: FeatureId = FeatureId("PG_RETURNING");
pub const PG_SERIAL: FeatureId = FeatureId("PG_SERIAL");
pub const PG_ILIKE: FeatureId = FeatureId("PG_ILIKE");
pub const PG_DOUBLE_COLON_CAST: FeatureId = FeatureId("PG_DOUBLE_COLON_CAST");
pub const PG_ARRAY_LITERALS: FeatureId = FeatureId("PG_ARRAY_LITERALS");
pub const PG_JSONB_TYPE: FeatureId = FeatureId("PG_JSONB_TYPE");
pub const PG_JSONB_OPERATORS: FeatureId = FeatureId("PG_JSONB_OPERATORS");
pub const PG_RETURNING_STANDARDIZATION: FeatureId = FeatureId("PG_RETURNING_STANDARDIZATION");

pub const BQ_QUALIFY_CLAUSE: FeatureId = FeatureId("BQ_QUALIFY_CLAUSE");
pub const BQ_STRUCT_CONSTRUCTOR: FeatureId = FeatureId("BQ_STRUCT_CONSTRUCTOR");
pub const BQ_ARRAY_SAFE_OFFSET: FeatureId = FeatureId("BQ_ARRAY_SAFE_OFFSET");
pub const BQ_SAFE_FUNCTIONS: FeatureId = FeatureId("BQ_SAFE_FUNCTIONS");
pub const BQ_BACKTICK_IDENTIFIERS: FeatureId = FeatureId("BQ_BACKTICK_IDENTIFIERS");
pub const BQ_DATASET_QUALIFIERS: FeatureId = FeatureId("BQ_DATASET_QUALIFIERS");
pub const BQ_OPTIONS_CLAUSE: FeatureId = FeatureId("BQ_OPTIONS_CLAUSE");

pub const CH_ARRAY_JOIN: FeatureId = FeatureId("CH_ARRAY_JOIN");
pub const CH_LEFT_ARRAY_JOIN: FeatureId = FeatureId("CH_LEFT_ARRAY_JOIN");
pub const CH_UNALIGNED_ARRAY_JOIN: FeatureId = FeatureId("CH_UNALIGNED_ARRAY_JOIN");
pub const CH_ARRAY_FUNCTIONS: FeatureId = FeatureId("CH_ARRAY_FUNCTIONS");
pub const CH_HIGHER_ORDER_ARRAY_FUNCS: FeatureId = FeatureId("CH_HIGHER_ORDER_ARRAY_FUNCS");
pub const CH_ARRAY_ELEMENT_ACCESS: FeatureId = FeatureId("CH_ARRAY_ELEMENT_ACCESS");
pub const CH_SETTINGS_CLAUSE: FeatureId = FeatureId("CH_SETTINGS_CLAUSE");
pub const CH_LIMIT_BY: FeatureId = FeatureId("CH_LIMIT_BY");
pub const CH_SAMPLE: FeatureId = FeatureId("CH_SAMPLE");
pub const CH_PREWHERE: FeatureId = FeatureId("CH_PREWHERE");
pub const CH_FINAL_MODIFIER: FeatureId = FeatureId("CH_FINAL_MODIFIER");
pub const CH_GLOBAL_JOIN: FeatureId = FeatureId("CH_GLOBAL_JOIN");
pub const CH_JOIN_STRICTNESS: FeatureId = FeatureId("CH_JOIN_STRICTNESS");
pub const CH_ASOF_JOIN: FeatureId = FeatureId("CH_ASOF_JOIN");
pub const CH_GROUP_BY_CUBE: FeatureId = FeatureId("CH_GROUP_BY_CUBE");
pub const CH_GROUP_BY_ROLLUP: FeatureId = FeatureId("CH_GROUP_BY_ROLLUP");
pub const CH_GROUP_BY_TOTALS: FeatureId = FeatureId("CH_GROUP_BY_TOTALS");
pub const CH_AGGREGATE_COMBINATORS: FeatureId = FeatureId("CH_AGGREGATE_COMBINATORS");
pub const CH_LAMBDA_FUNCTIONS: FeatureId = FeatureId("CH_LAMBDA_FUNCTIONS");
pub const CH_DATE_TIME_FUNCTIONS: FeatureId = FeatureId("CH_DATE_TIME_FUNCTIONS");
pub const CH_TIME_INTERVALS: FeatureId = FeatureId("CH_TIME_INTERVALS");
pub const CH_NULLABLE_TYPE: FeatureId = FeatureId("CH_NULLABLE_TYPE");
pub const CH_LOWCARDINALITY: FeatureId = FeatureId("CH_LOWCARDINALITY");
pub const CH_TUPLE_TYPE: FeatureId = FeatureId("CH_TUPLE_TYPE");
pub const CH_MAP_TYPE: FeatureId = FeatureId("CH_MAP_TYPE");
pub const CH_TUPLE_ELEMENT_ACCESS: FeatureId = FeatureId("CH_TUPLE_ELEMENT_ACCESS");
pub const CH_PARAMETERIZED_VIEWS: FeatureId = FeatureId("CH_PARAMETERIZED_VIEWS");
pub const CH_DISTRIBUTED_SUBQUERIES: FeatureId = FeatureId("CH_DISTRIBUTED_SUBQUERIES");
pub const CH_LIMIT_BY_NORMALIZATION: FeatureId = FeatureId("CH_LIMIT_BY_NORMALIZATION");

pub const KNOWN_FEATURE_IDS: &[(&str, FeatureId)] = &[
    ("E011", E011_DEFAULT_CLAUSE),
    ("E141", E141_INTEGRITY_ENHANCEMENT),
    ("F001", F001_BASIC_SQL),
    ("F031", F031_BASIC_SCHEMA_MANIPULATION),
    ("F051", F051_BASIC_DATE_TIME),
    ("F052", F052_INTERVALS_DATETIME_ARITHMETIC),
    ("F311", F311_SCHEMA_DEFINITION),
    ("F312", F312_SCALAR_SUBQUERY_AS_EXPRESSION),
    ("F351", F351_MERGE_STATEMENT),
    ("F402", F402_TRANSACTION_COMMIT),
    ("F403", F403_TRANSACTION_ROLLBACK),
    ("F441", F441_EXTENDED_SET_FUNCTION_SUPPORT),
    ("F442", F442_MIXED_COLUMN_REFERENCES),
    ("F443", F443_EXPLICIT_DEFAULTS),
    ("F471", F471_TUPLE_IN_CLAUSE),
    ("F496", F496_OPTIONAL_TABLE_VERSIONING),
    ("F561", F561_FULL_VALUE_EXPRESSIONS),
    ("F591", F591_DERIVED_TABLES),
    ("F781", F781_SELF_REFERENCING_OPERATIONS),
    ("F782", F782_COMMIT_STATEMENT),
    ("F783", F783_ROLLBACK_STATEMENT),
    ("F784", F784_SAVEPOINT_STATEMENT),
    ("F785", F785_ROLLBACK_TO_SAVEPOINT_STATEMENT),
    ("F786", F786_SAVEPOINTS),
    ("F851", F851_WINDOW_FRAME_EXCLUDE),
    ("T041", T041_ROW_TYPE),
    ("T042", T042_ROW_TYPE_CONSTRUCTOR),
    ("T043", T043_ROW_TYPE_FIELD_ACCESS),
    ("T121", T121_WITH_CLAUSE),
    ("T131", T131_RECURSIVE_QUERY),
    ("T174", T174_IDENTITY_COLUMNS),
    ("T176", T176_SEQUENCE_GENERATOR),
    ("T211", T211_BASIC_TRIGGER_CAPABILITY),
    ("T301", T301_SAVEPOINTS),
    ("T321", T321_TRANSACTION_ISOLATION),
    ("T611", T611_WINDOW_FUNCTIONS),
    ("T612", T612_ADVANCED_OLAP),
    ("T613", T613_WINDOW_FRAME_CLAUSE),
    ("T614", T614_NTILE),
    ("T615", T615_LEAD_LAG),
    ("T616", T616_NULL_TREATMENT),
    ("T617", T617_FIRST_LAST_VALUE),
    ("T618", T618_NTH_VALUE),
    ("T619", T619_WINDOW_FRAME_GROUPS),
    ("T620", T620_WINDOW_FRAME_EXCLUDE),
    ("T801", T801_MERGE_STATEMENT),
    ("T802", T802_MERGE_WHEN_MATCHED),
    ("T803", T803_MERGE_WHEN_NOT_MATCHED),
    ("T860", T860_JSON_TYPE),
    ("T861", T861_JSON_QUERY),
    ("T862", T862_JSON_VALUE),
    ("T863", T863_JSON_EXISTS),
    ("T864", T864_JSON_TABLE),
    ("T865", T865_JSON_OBJECT_CONSTRUCTOR),
    ("T866", T866_JSON_ARRAY_CONSTRUCTOR),
    ("T867", T867_JSON_IS_JSON_PREDICATE),
    ("T868", T868_JSON_SIMPLIFIED_ACCESSOR),
    ("T869", T869_JSON_NULL_CLAUSE),
    ("T870", T870_JSON_ARRAYAGG),
    ("T871", T871_JSON_OBJECTAGG),
    ("T872", T872_JSON_PATHS),
    ("T873", T873_JSON_PASSING_CLAUSE),
    ("T874", T874_JSON_RETURNING_CLAUSE),
    ("T875", T875_JSON_ERROR_BEHAVIOR),
    ("T876", T876_JSON_NESTED_PATH),
    ("T877", T877_JSON_WRAPPER_OPTION),
    ("T878", T878_JSON_QUOTES_OPTION),
    ("PG_RETURNING", PG_RETURNING),
    ("PG_SERIAL", PG_SERIAL),
    ("PG_ILIKE", PG_ILIKE),
    ("PG_DOUBLE_COLON_CAST", PG_DOUBLE_COLON_CAST),
    ("PG_ARRAY_LITERALS", PG_ARRAY_LITERALS),
    ("PG_JSONB_TYPE", PG_JSONB_TYPE),
    ("PG_JSONB_OPERATORS", PG_JSONB_OPERATORS),
    ("PG_RETURNING_STANDARDIZATION", PG_RETURNING_STANDARDIZATION),
    ("BQ_QUALIFY_CLAUSE", BQ_QUALIFY_CLAUSE),
    ("BQ_STRUCT_CONSTRUCTOR", BQ_STRUCT_CONSTRUCTOR),
    ("BQ_ARRAY_SAFE_OFFSET", BQ_ARRAY_SAFE_OFFSET),
    ("BQ_SAFE_FUNCTIONS", BQ_SAFE_FUNCTIONS),
    ("BQ_BACKTICK_IDENTIFIERS", BQ_BACKTICK_IDENTIFIERS),
    ("BQ_DATASET_QUALIFIERS", BQ_DATASET_QUALIFIERS),
    ("BQ_OPTIONS_CLAUSE", BQ_OPTIONS_CLAUSE),
    ("CH_ARRAY_JOIN", CH_ARRAY_JOIN),
    ("CH_LEFT_ARRAY_JOIN", CH_LEFT_ARRAY_JOIN),
    ("CH_UNALIGNED_ARRAY_JOIN", CH_UNALIGNED_ARRAY_JOIN),
    ("CH_ARRAY_FUNCTIONS", CH_ARRAY_FUNCTIONS),
    ("CH_HIGHER_ORDER_ARRAY_FUNCS", CH_HIGHER_ORDER_ARRAY_FUNCS),
    ("CH_ARRAY_ELEMENT_ACCESS", CH_ARRAY_ELEMENT_ACCESS),
    ("CH_SETTINGS_CLAUSE", CH_SETTINGS_CLAUSE),
    ("CH_LIMIT_BY", CH_LIMIT_BY),
    ("CH_SAMPLE", CH_SAMPLE),
    ("CH_PREWHERE", CH_PREWHERE),
    ("CH_FINAL_MODIFIER", CH_FINAL_MODIFIER),
    ("CH_GLOBAL_JOIN", CH_GLOBAL_JOIN),
    ("CH_JOIN_STRICTNESS", CH_JOIN_STRICTNESS),
    ("CH_ASOF_JOIN", CH_ASOF_JOIN),
    ("CH_GROUP_BY_CUBE", CH_GROUP_BY_CUBE),
    ("CH_GROUP_BY_ROLLUP", CH_GROUP_BY_ROLLUP),
    ("CH_GROUP_BY_TOTALS", CH_GROUP_BY_TOTALS),
    ("CH_AGGREGATE_COMBINATORS", CH_AGGREGATE_COMBINATORS),
    ("CH_LAMBDA_FUNCTIONS", CH_LAMBDA_FUNCTIONS),
    ("CH_DATE_TIME_FUNCTIONS", CH_DATE_TIME_FUNCTIONS),
    ("CH_TIME_INTERVALS", CH_TIME_INTERVALS),
    ("CH_NULLABLE_TYPE", CH_NULLABLE_TYPE),
    ("CH_LOWCARDINALITY", CH_LOWCARDINALITY),
    ("CH_TUPLE_TYPE", CH_TUPLE_TYPE),
    ("CH_MAP_TYPE", CH_MAP_TYPE),
    ("CH_TUPLE_ELEMENT_ACCESS", CH_TUPLE_ELEMENT_ACCESS),
    ("CH_PARAMETERIZED_VIEWS", CH_PARAMETERIZED_VIEWS),
    ("CH_DISTRIBUTED_SUBQUERIES", CH_DISTRIBUTED_SUBQUERIES),
    ("CH_LIMIT_BY_NORMALIZATION", CH_LIMIT_BY_NORMALIZATION),
];

static FEATURE_MAP: OnceLock<HashMap<&'static str, FeatureId>> = OnceLock::new();

fn get_feature_map() -> &'static HashMap<&'static str, FeatureId> {
    FEATURE_MAP.get_or_init(|| KNOWN_FEATURE_IDS.iter().copied().collect())
}

pub fn lookup_feature_id(name: &str) -> Option<FeatureId> {
    get_feature_map().get(name).copied()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_lookup_core_features() {
        assert_eq!(lookup_feature_id("F001"), Some(F001_BASIC_SQL));
        assert_eq!(lookup_feature_id("F051"), Some(F051_BASIC_DATE_TIME));
        assert_eq!(lookup_feature_id("F471"), Some(F471_TUPLE_IN_CLAUSE));
    }

    #[test]
    fn test_lookup_optional_features() {
        assert_eq!(lookup_feature_id("T801"), Some(T801_MERGE_STATEMENT));
        assert_eq!(lookup_feature_id("T860"), Some(T860_JSON_TYPE));
        assert_eq!(lookup_feature_id("T611"), Some(T611_WINDOW_FUNCTIONS));
    }

    #[test]
    fn test_lookup_dialect_features() {
        assert_eq!(lookup_feature_id("PG_RETURNING"), Some(PG_RETURNING));
        assert_eq!(lookup_feature_id("PG_JSONB_TYPE"), Some(PG_JSONB_TYPE));
        assert_eq!(
            lookup_feature_id("BQ_QUALIFY_CLAUSE"),
            Some(BQ_QUALIFY_CLAUSE)
        );
        assert_eq!(
            lookup_feature_id("BQ_SAFE_FUNCTIONS"),
            Some(BQ_SAFE_FUNCTIONS)
        );
    }

    #[test]
    fn test_lookup_unknown_feature() {
        assert_eq!(lookup_feature_id("UNKNOWN_FEATURE"), None);
        assert_eq!(lookup_feature_id("F999"), None);
        assert_eq!(lookup_feature_id(""), None);
    }

    #[test]
    fn test_feature_id_display() {
        assert_eq!(F001_BASIC_SQL.to_string(), "F001");
        assert_eq!(T860_JSON_TYPE.to_string(), "T860");
        assert_eq!(PG_RETURNING.to_string(), "PG_RETURNING");
    }

    #[test]
    fn test_feature_id_as_str() {
        assert_eq!(F001_BASIC_SQL.as_str(), "F001");
        assert_eq!(T860_JSON_TYPE.as_str(), "T860");
    }

    #[test]
    fn test_feature_map_initialized_once() {
        let _ = lookup_feature_id("F001");

        let result = lookup_feature_id("F001");
        assert_eq!(result, Some(F001_BASIC_SQL));
    }

    #[test]
    fn test_all_known_features_are_findable() {
        for (name, expected) in KNOWN_FEATURE_IDS {
            let found = lookup_feature_id(name);
            assert_eq!(
                found,
                Some(*expected),
                "Feature {} should be findable",
                name
            );
        }
    }
}
