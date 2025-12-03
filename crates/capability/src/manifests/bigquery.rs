use std::collections::HashSet;

use crate::FeatureId;
use crate::feature_ids::*;

pub fn bigquery_capabilities() -> HashSet<FeatureId> {
    let mut features = HashSet::new();

    features.insert(F001_BASIC_SQL);
    features.insert(F051_BASIC_DATE_TIME);
    features.insert(F052_INTERVALS_DATETIME_ARITHMETIC);
    features.insert(F311_SCHEMA_DEFINITION);
    features.insert(F312_SCALAR_SUBQUERY_AS_EXPRESSION);
    features.insert(F351_MERGE_STATEMENT);
    features.insert(F402_TRANSACTION_COMMIT);
    features.insert(F403_TRANSACTION_ROLLBACK);
    features.insert(F471_TUPLE_IN_CLAUSE);
    features.insert(F561_FULL_VALUE_EXPRESSIONS);
    features.insert(F591_DERIVED_TABLES);
    features.insert(F781_SELF_REFERENCING_OPERATIONS);
    features.insert(F782_COMMIT_STATEMENT);
    features.insert(F783_ROLLBACK_STATEMENT);

    features.insert(F851_WINDOW_FRAME_EXCLUDE);

    features.insert(T041_ROW_TYPE);
    features.insert(T042_ROW_CONSTRUCTOR);
    features.insert(T043_ROW_FIELD_ACCESS);
    features.insert(T121_WITH_CLAUSE);
    features.insert(T131_RECURSIVE_QUERY);

    features.insert(T611_WINDOW_FUNCTIONS);
    features.insert(T612_ADVANCED_OLAP_OPERATIONS);
    features.insert(T613_WINDOW_FRAME_CLAUSE);
    features.insert(T614_NTILE_FUNCTION);
    features.insert(T615_LEAD_LAG_FUNCTIONS);
    features.insert(T616_NULL_TREATMENT_WINDOW);
    features.insert(T617_FIRST_VALUE_LAST_VALUE);
    features.insert(T618_NTH_VALUE);
    features.insert(T619_WINDOW_FRAME_GROUPS);
    features.insert(T620_WINDOW_FRAME_EXCLUDE);

    features.insert(T801_MERGE_STATEMENT);
    features.insert(T802_MERGE_WHEN_MATCHED);
    features.insert(T803_MERGE_WHEN_NOT_MATCHED);

    features.insert(T860_JSON_TYPE);
    features.insert(T861_JSON_QUERY);
    features.insert(T862_JSON_VALUE);
    features.insert(T863_JSON_EXISTS);

    features.insert(T865_JSON_OBJECT_CONSTRUCTOR);
    features.insert(T866_JSON_ARRAY_CONSTRUCTOR);
    features.insert(T867_IS_JSON_PREDICATE);
    features.insert(T868_JSON_SIMPLIFIED_ACCESSOR);
    features.insert(T869_JSON_NULL_CLAUSE);
    features.insert(T870_JSON_ARRAYAGG);
    features.insert(T871_JSON_OBJECTAGG);
    features.insert(T872_JSON_PATHS);
    features.insert(T873_JSON_PASSING_CLAUSE);
    features.insert(T874_JSON_RETURNING_CLAUSE);
    features.insert(T875_JSON_ERROR_BEHAVIOR);
    features.insert(T876_JSON_NESTED_PATH);
    features.insert(T877_JSON_WRAPPER_OPTION);
    features.insert(T878_JSON_QUOTES_OPTION);

    features.insert(BQ_BACKTICK_IDENTIFIERS);
    features.insert(BQ_SAFE_FUNCTIONS);
    features.insert(BQ_QUALIFY_CLAUSE);
    features.insert(BQ_STRUCT_CONSTRUCTOR);
    features.insert(BQ_ARRAY_SAFE_OFFSET);
    features.insert(BQ_DATASET_QUALIFIERS);

    features
}
