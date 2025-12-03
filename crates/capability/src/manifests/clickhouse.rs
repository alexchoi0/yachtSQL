use std::collections::HashSet;

use crate::FeatureId;
use crate::feature_ids::*;

pub fn clickhouse_capabilities() -> HashSet<FeatureId> {
    let mut features = HashSet::new();

    features.insert(F001_BASIC_SQL);
    features.insert(F051_BASIC_DATE_TIME);
    features.insert(F052_INTERVALS_DATETIME_ARITHMETIC);
    features.insert(F311_SCHEMA_DEFINITION);
    features.insert(F312_SCALAR_SUBQUERY_AS_EXPRESSION);
    features.insert(F402_TRANSACTION_COMMIT);
    features.insert(F403_TRANSACTION_ROLLBACK);
    features.insert(F471_TUPLE_IN_CLAUSE);
    features.insert(F561_FULL_VALUE_EXPRESSIONS);
    features.insert(F591_DERIVED_TABLES);
    features.insert(F782_COMMIT_STATEMENT);
    features.insert(F783_ROLLBACK_STATEMENT);

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

    features.insert(T860_JSON_TYPE);
    features.insert(T865_JSON_OBJECT_CONSTRUCTOR);
    features.insert(T866_JSON_ARRAY_CONSTRUCTOR);

    features.insert(CH_ARRAY_JOIN);
    features.insert(CH_LEFT_ARRAY_JOIN);
    features.insert(CH_UNALIGNED_ARRAY_JOIN);
    features.insert(CH_ARRAY_FUNCTIONS);
    features.insert(CH_HIGHER_ORDER_ARRAY_FUNCS);
    features.insert(CH_ARRAY_ELEMENT_ACCESS);

    features.insert(CH_SETTINGS_CLAUSE);
    features.insert(CH_LIMIT_BY);
    features.insert(CH_SAMPLE);
    features.insert(CH_PREWHERE);
    features.insert(CH_FINAL_MODIFIER);

    features.insert(CH_GLOBAL_JOIN);
    features.insert(CH_JOIN_STRICTNESS);
    features.insert(CH_ASOF_JOIN);

    features.insert(CH_GROUP_BY_CUBE);
    features.insert(CH_GROUP_BY_ROLLUP);
    features.insert(CH_GROUP_BY_TOTALS);

    features.insert(CH_AGGREGATE_COMBINATORS);
    features.insert(CH_LAMBDA_FUNCTIONS);
    features.insert(CH_DATE_TIME_FUNCTIONS);
    features.insert(CH_TIME_INTERVALS);

    features.insert(CH_NULLABLE_TYPE);
    features.insert(CH_LOWCARDINALITY);
    features.insert(CH_TUPLE_TYPE);
    features.insert(CH_MAP_TYPE);
    features.insert(CH_TUPLE_ELEMENT_ACCESS);

    features.insert(CH_PARAMETERIZED_VIEWS);
    features.insert(CH_DISTRIBUTED_SUBQUERIES);

    features
}
