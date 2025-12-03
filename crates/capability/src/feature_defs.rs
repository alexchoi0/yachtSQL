use crate::feature::{FeatureCategory, FeatureId};
use crate::feature_ids::*;

#[derive(Clone, Copy)]
pub(crate) struct SimpleFeatureDef {
    pub(crate) id: FeatureId,
    pub(crate) name: &'static str,
    pub(crate) description: &'static str,
    pub(crate) category: FeatureCategory,
}

#[derive(Clone, Copy)]
pub(crate) struct FeatureWithDepsDef {
    pub(crate) id: FeatureId,
    pub(crate) name: &'static str,
    pub(crate) description: &'static str,
    pub(crate) category: FeatureCategory,
    pub(crate) deps: &'static [FeatureId],
}

#[derive(Clone, Copy)]
pub(crate) struct FeatureWithPartDef {
    pub(crate) id: FeatureId,
    pub(crate) name: &'static str,
    pub(crate) description: &'static str,
    pub(crate) category: FeatureCategory,
    pub(crate) part: &'static str,
    pub(crate) deps: &'static [FeatureId],
}

#[derive(Clone, Copy)]
pub(crate) struct DialectFeatureDef {
    pub(crate) id: FeatureId,
    pub(crate) name: &'static str,
    pub(crate) description: &'static str,
    pub(crate) deps: &'static [FeatureId],
}

pub(crate) const EMPTY_SIMPLE_FEATURES: &[SimpleFeatureDef] = &[];

pub(crate) const CORE_FEATURE_DEFS: &[SimpleFeatureDef] = &[
    SimpleFeatureDef {
        id: F001_BASIC_SQL,
        name: "Basic SQL",
        description: "Essential SQL operations (SELECT, FROM, WHERE, JOIN)",
        category: FeatureCategory::Core,
    },
    SimpleFeatureDef {
        id: F031_BASIC_SCHEMA_MANIPULATION,
        name: "Basic schema manipulation",
        description: "CREATE/ALTER/DROP TABLE operations",
        category: FeatureCategory::Core,
    },
    SimpleFeatureDef {
        id: E011_DEFAULT_CLAUSE,
        name: "DEFAULT clause",
        description: "DEFAULT expressions for column definitions",
        category: FeatureCategory::Core,
    },
    SimpleFeatureDef {
        id: F051_BASIC_DATE_TIME,
        name: "Basic date and time",
        description: "DATE, TIME, TIMESTAMP types and operations",
        category: FeatureCategory::Core,
    },
    SimpleFeatureDef {
        id: F052_INTERVALS_DATETIME_ARITHMETIC,
        name: "Intervals and datetime arithmetic",
        description: "INTERVAL type and datetime arithmetic",
        category: FeatureCategory::Core,
    },
    SimpleFeatureDef {
        id: F311_SCHEMA_DEFINITION,
        name: "Schema definition statement",
        description: "CREATE SCHEMA and basic schema manipulation",
        category: FeatureCategory::Core,
    },
    SimpleFeatureDef {
        id: F312_SCALAR_SUBQUERY_AS_EXPRESSION,
        name: "Scalar subquery as expression",
        description: "Use scalar subquery anywhere an expression is valid",
        category: FeatureCategory::Core,
    },
    SimpleFeatureDef {
        id: F471_TUPLE_IN_CLAUSE,
        name: "Tuple IN clause",
        description: "(a,b) IN ((1,2), (3,4)) tuple comparison",
        category: FeatureCategory::Core,
    },
    SimpleFeatureDef {
        id: F781_SELF_REFERENCING_OPERATIONS,
        name: "Self-referencing operations",
        description: "FOREIGN KEY referential integrity",
        category: FeatureCategory::Integrity,
    },
    SimpleFeatureDef {
        id: F782_COMMIT_STATEMENT,
        name: "COMMIT statement",
        description: "COMMIT current transaction",
        category: FeatureCategory::Transaction,
    },
    SimpleFeatureDef {
        id: F783_ROLLBACK_STATEMENT,
        name: "ROLLBACK statement",
        description: "ROLLBACK current transaction",
        category: FeatureCategory::Transaction,
    },
    SimpleFeatureDef {
        id: F784_SAVEPOINT_STATEMENT,
        name: "SAVEPOINT statement",
        description: "Create a transaction savepoint",
        category: FeatureCategory::Transaction,
    },
    SimpleFeatureDef {
        id: F785_ROLLBACK_TO_SAVEPOINT_STATEMENT,
        name: "ROLLBACK TO SAVEPOINT statement",
        description: "Rollback to a previously defined savepoint",
        category: FeatureCategory::Transaction,
    },
    SimpleFeatureDef {
        id: F786_SAVEPOINTS,
        name: "RELEASE SAVEPOINT statement",
        description: "Release an existing transaction savepoint",
        category: FeatureCategory::Transaction,
    },
    SimpleFeatureDef {
        id: F402_TRANSACTION_COMMIT,
        name: "Transaction COMMIT",
        description: "COMMIT statement for transactions",
        category: FeatureCategory::Transaction,
    },
    SimpleFeatureDef {
        id: F403_TRANSACTION_ROLLBACK,
        name: "Transaction ROLLBACK",
        description: "ROLLBACK statement for transactions",
        category: FeatureCategory::Transaction,
    },
];

pub(crate) const OPTIONAL_FEATURE_DEFS: &[SimpleFeatureDef] = &[
    SimpleFeatureDef {
        id: F351_MERGE_STATEMENT,
        name: "MERGE statement (F-series)",
        description: "Core MERGE for conditional INSERT/UPDATE/DELETE",
        category: FeatureCategory::Merge,
    },
    SimpleFeatureDef {
        id: F496_OPTIONAL_TABLE_VERSIONING,
        name: "Optional table versioning clauses",
        description: "ORDER BY NULLS FIRST/LAST",
        category: FeatureCategory::Core,
    },
    SimpleFeatureDef {
        id: F561_FULL_VALUE_EXPRESSIONS,
        name: "Full value expressions",
        description: "Scalar subqueries in all expression contexts",
        category: FeatureCategory::Core,
    },
    SimpleFeatureDef {
        id: F591_DERIVED_TABLES,
        name: "Derived tables",
        description: "Subqueries in FROM clause",
        category: FeatureCategory::Core,
    },
    SimpleFeatureDef {
        id: F851_WINDOW_FRAME_EXCLUDE,
        name: "Window frame EXCLUDE clause",
        description: "EXCLUDE CURRENT ROW/GROUP/TIES/NO OTHERS",
        category: FeatureCategory::Window,
    },
];

pub(crate) const INTEGRITY_CORE_FEATURE_DEFS: &[SimpleFeatureDef] = &[SimpleFeatureDef {
    id: E141_INTEGRITY_ENHANCEMENT,
    name: "CHECK constraints",
    description: "Integrity enhancement facility (CHECK clause)",
    category: FeatureCategory::Integrity,
}];

pub(crate) const SEQUENCE_OPTIONAL_FEATURE_DEFS: &[SimpleFeatureDef] = &[
    SimpleFeatureDef {
        id: T174_IDENTITY_COLUMNS,
        name: "Identity columns",
        description: "GENERATED ALWAYS/DEFAULT AS IDENTITY",
        category: FeatureCategory::Sequence,
    },
    SimpleFeatureDef {
        id: T176_SEQUENCE_GENERATOR,
        name: "Sequence generators",
        description: "CREATE SEQUENCE / NEXT VALUE FOR",
        category: FeatureCategory::Sequence,
    },
];

pub(crate) const TRIGGER_OPTIONAL_FEATURE_DEFS: &[SimpleFeatureDef] = &[SimpleFeatureDef {
    id: T211_BASIC_TRIGGER_CAPABILITY,
    name: "Basic trigger capability",
    description: "Row/statement triggers for INSERT/UPDATE/DELETE",
    category: FeatureCategory::Trigger,
}];

pub(crate) const TRANSACTION_OPTIONAL_FEATURE_DEFS: &[SimpleFeatureDef] = &[SimpleFeatureDef {
    id: T321_TRANSACTION_ISOLATION,
    name: "Transaction isolation levels",
    description: "SET TRANSACTION ISOLATION LEVEL",
    category: FeatureCategory::Transaction,
}];

pub(crate) const NUMERIC_OPTIONAL_FEATURE_DEFS: &[SimpleFeatureDef] = &[SimpleFeatureDef {
    id: T602_ENHANCED_NUMERIC_FUNCTIONS,
    name: "Enhanced numeric functions",
    description: "Additional numeric functions per SQL:2023",
    category: FeatureCategory::Other,
}];

pub(crate) const TRANSACTION_DEP_FEATURE_DEFS: &[FeatureWithDepsDef] = &[FeatureWithDepsDef {
    id: T301_SAVEPOINTS,
    name: "Savepoints",
    description: "SAVEPOINT, ROLLBACK TO SAVEPOINT, RELEASE SAVEPOINT",
    category: FeatureCategory::Transaction,
    deps: &[F402_TRANSACTION_COMMIT, F403_TRANSACTION_ROLLBACK],
}];

pub(crate) const MERGE_DEP_FEATURE_DEFS: &[FeatureWithDepsDef] = &[
    FeatureWithDepsDef {
        id: T801_MERGE_STATEMENT,
        name: "MERGE statement",
        description: "MERGE for conditional INSERT/UPDATE/DELETE",
        category: FeatureCategory::Merge,
        deps: &[F402_TRANSACTION_COMMIT, T321_TRANSACTION_ISOLATION],
    },
    FeatureWithDepsDef {
        id: T802_MERGE_WHEN_MATCHED,
        name: "MERGE WHEN MATCHED",
        description: "UPDATE or DELETE when source matches target",
        category: FeatureCategory::Merge,
        deps: &[T801_MERGE_STATEMENT],
    },
    FeatureWithDepsDef {
        id: T803_MERGE_WHEN_NOT_MATCHED,
        name: "MERGE WHEN NOT MATCHED",
        description: "INSERT when source does not match target",
        category: FeatureCategory::Merge,
        deps: &[T801_MERGE_STATEMENT],
    },
];

pub(crate) const ROW_TYPE_OPTIONAL_FEATURE_DEFS: &[SimpleFeatureDef] = &[SimpleFeatureDef {
    id: T041_ROW_TYPE,
    name: "ROW type",
    description: "Composite ROW/STRUCT data type",
    category: FeatureCategory::RowTypes,
}];

pub(crate) const ROW_TYPE_DEP_FEATURE_DEFS: &[FeatureWithDepsDef] = &[
    FeatureWithDepsDef {
        id: T042_ROW_TYPE_CONSTRUCTOR,
        name: "ROW constructor",
        description: "ROW(...) constructor syntax",
        category: FeatureCategory::RowTypes,
        deps: &[T041_ROW_TYPE],
    },
    FeatureWithDepsDef {
        id: T043_ROW_TYPE_FIELD_ACCESS,
        name: "ROW field access",
        description: "Access fields in ROW types",
        category: FeatureCategory::RowTypes,
        deps: &[T041_ROW_TYPE],
    },
];

pub(crate) const WINDOW_OPTIONAL_FEATURE_DEFS: &[SimpleFeatureDef] = &[
    SimpleFeatureDef {
        id: T611_WINDOW_FUNCTIONS,
        name: "Window functions",
        description: "ROW_NUMBER, RANK, DENSE_RANK, PERCENT_RANK, CUME_DIST",
        category: FeatureCategory::Window,
    },
    SimpleFeatureDef {
        id: F441_EXTENDED_SET_FUNCTION_SUPPORT,
        name: "Extended set function support",
        description: "Window functions: ROW_NUMBER, RANK, DENSE_RANK",
        category: FeatureCategory::Window,
    },
    SimpleFeatureDef {
        id: F442_MIXED_COLUMN_REFERENCES,
        name: "Mixed column references in set functions",
        description: "PARTITION BY and ORDER BY in window functions",
        category: FeatureCategory::Window,
    },
    SimpleFeatureDef {
        id: F443_EXPLICIT_DEFAULTS,
        name: "Explicit defaults in set functions",
        description: "Window function default specifications",
        category: FeatureCategory::Window,
    },
];

pub(crate) const WINDOW_DEP_FEATURE_DEFS: &[FeatureWithDepsDef] = &[
    FeatureWithDepsDef {
        id: T612_ADVANCED_OLAP,
        name: "Advanced OLAP operations",
        description: "NTILE, FIRST_VALUE, LAST_VALUE, NTH_VALUE",
        category: FeatureCategory::Window,
        deps: &[T611_WINDOW_FUNCTIONS],
    },
    FeatureWithDepsDef {
        id: T613_WINDOW_FRAME_CLAUSE,
        name: "Window frame clause",
        description: "ROWS/RANGE BETWEEN frame specification",
        category: FeatureCategory::Window,
        deps: &[T611_WINDOW_FUNCTIONS],
    },
    FeatureWithDepsDef {
        id: T614_NTILE,
        name: "NTILE window function",
        description: "Divide rows into N buckets",
        category: FeatureCategory::Window,
        deps: &[T611_WINDOW_FUNCTIONS],
    },
    FeatureWithDepsDef {
        id: T615_LEAD_LAG,
        name: "LEAD and LAG window functions",
        description: "Access rows at offset from current row",
        category: FeatureCategory::Window,
        deps: &[T611_WINDOW_FUNCTIONS],
    },
    FeatureWithDepsDef {
        id: T616_NULL_TREATMENT,
        name: "NULL treatment in window functions",
        description: "RESPECT NULLS / IGNORE NULLS",
        category: FeatureCategory::Window,
        deps: &[T611_WINDOW_FUNCTIONS],
    },
    FeatureWithDepsDef {
        id: T617_FIRST_LAST_VALUE,
        name: "FIRST_VALUE and LAST_VALUE",
        description: "Get first or last value in window frame",
        category: FeatureCategory::Window,
        deps: &[T613_WINDOW_FRAME_CLAUSE],
    },
    FeatureWithDepsDef {
        id: T618_NTH_VALUE,
        name: "NTH_VALUE window function",
        description: "Get Nth value in window frame",
        category: FeatureCategory::Window,
        deps: &[T613_WINDOW_FRAME_CLAUSE],
    },
    FeatureWithDepsDef {
        id: T619_WINDOW_FRAME_GROUPS,
        name: "Window frame GROUPS",
        description: "GROUPS frame unit for peer groups",
        category: FeatureCategory::Window,
        deps: &[T613_WINDOW_FRAME_CLAUSE],
    },
    FeatureWithDepsDef {
        id: T620_WINDOW_FRAME_EXCLUDE,
        name: "Window frame EXCLUDE clause",
        description: "EXCLUDE CURRENT ROW/GROUP/TIES/NO OTHERS",
        category: FeatureCategory::Window,
        deps: &[T613_WINDOW_FRAME_CLAUSE],
    },
];

pub(crate) const CTE_OPTIONAL_FEATURE_DEFS: &[SimpleFeatureDef] = &[SimpleFeatureDef {
    id: T121_WITH_CLAUSE,
    name: "WITH clause",
    description: "Common Table Expressions (CTEs)",
    category: FeatureCategory::CTE,
}];

pub(crate) const CTE_DEP_FEATURE_DEFS: &[FeatureWithDepsDef] = &[FeatureWithDepsDef {
    id: T131_RECURSIVE_QUERY,
    name: "Recursive query",
    description: "Recursive CTEs",
    category: FeatureCategory::CTE,
    deps: &[T121_WITH_CLAUSE],
}];

pub(crate) const JSON_FEATURE_DEFS: &[FeatureWithPartDef] = &[
    FeatureWithPartDef {
        id: T860_JSON_TYPE,
        name: "JSON type",
        description: "JSON data type",
        category: FeatureCategory::Json,
        part: "Part 2",
        deps: &[],
    },
    FeatureWithPartDef {
        id: T861_JSON_QUERY,
        name: "JSON_QUERY",
        description: "Extract JSON subtree as JSON",
        category: FeatureCategory::Json,
        part: "Part 2",
        deps: &[T860_JSON_TYPE],
    },
    FeatureWithPartDef {
        id: T862_JSON_VALUE,
        name: "JSON_VALUE",
        description: "Extract scalar value from JSON",
        category: FeatureCategory::Json,
        part: "Part 2",
        deps: &[T860_JSON_TYPE],
    },
    FeatureWithPartDef {
        id: T863_JSON_EXISTS,
        name: "JSON_EXISTS",
        description: "Test if JSON path exists",
        category: FeatureCategory::Json,
        part: "Part 2",
        deps: &[T860_JSON_TYPE],
    },
    FeatureWithPartDef {
        id: T864_JSON_TABLE,
        name: "JSON_TABLE",
        description: "Convert JSON to relational table",
        category: FeatureCategory::Json,
        part: "Part 2",
        deps: &[T860_JSON_TYPE],
    },
    FeatureWithPartDef {
        id: T865_JSON_OBJECT_CONSTRUCTOR,
        name: "JSON_OBJECT",
        description: "Construct JSON object",
        category: FeatureCategory::Json,
        part: "Part 2",
        deps: &[T860_JSON_TYPE],
    },
    FeatureWithPartDef {
        id: T866_JSON_ARRAY_CONSTRUCTOR,
        name: "JSON_ARRAY",
        description: "Construct JSON array",
        category: FeatureCategory::Json,
        part: "Part 2",
        deps: &[T860_JSON_TYPE],
    },
    FeatureWithPartDef {
        id: T867_JSON_IS_JSON_PREDICATE,
        name: "IS JSON predicate",
        description: "Test if value is valid JSON",
        category: FeatureCategory::Json,
        part: "Part 2",
        deps: &[T860_JSON_TYPE],
    },
    FeatureWithPartDef {
        id: T868_JSON_SIMPLIFIED_ACCESSOR,
        name: "JSON simplified accessor",
        description: "col.field and col[idx] syntax for JSON navigation",
        category: FeatureCategory::Json,
        part: "Part 2",
        deps: &[T860_JSON_TYPE],
    },
    FeatureWithPartDef {
        id: T869_JSON_NULL_CLAUSE,
        name: "JSON NULL clause",
        description: "NULL ON NULL / ABSENT ON NULL",
        category: FeatureCategory::Json,
        part: "Part 2",
        deps: &[T860_JSON_TYPE],
    },
    FeatureWithPartDef {
        id: T870_JSON_ARRAYAGG,
        name: "JSON_ARRAYAGG",
        description: "Aggregate values into JSON array",
        category: FeatureCategory::Json,
        part: "Part 2",
        deps: &[T860_JSON_TYPE],
    },
    FeatureWithPartDef {
        id: T871_JSON_OBJECTAGG,
        name: "JSON_OBJECTAGG",
        description: "Aggregate key-value pairs into JSON object",
        category: FeatureCategory::Json,
        part: "Part 2",
        deps: &[T860_JSON_TYPE],
    },
    FeatureWithPartDef {
        id: T872_JSON_PATHS,
        name: "JSON paths",
        description: "JSONPath syntax for navigation",
        category: FeatureCategory::Json,
        part: "Part 2",
        deps: &[T860_JSON_TYPE],
    },
    FeatureWithPartDef {
        id: T873_JSON_PASSING_CLAUSE,
        name: "JSON PASSING clause",
        description: "Pass parameters to JSON functions",
        category: FeatureCategory::Json,
        part: "Part 2",
        deps: &[T860_JSON_TYPE],
    },
    FeatureWithPartDef {
        id: T874_JSON_RETURNING_CLAUSE,
        name: "JSON RETURNING clause",
        description: "Specify return type for JSON functions",
        category: FeatureCategory::Json,
        part: "Part 2",
        deps: &[T860_JSON_TYPE],
    },
    FeatureWithPartDef {
        id: T875_JSON_ERROR_BEHAVIOR,
        name: "JSON error behavior",
        description: "ERROR/NULL/DEFAULT ON ERROR",
        category: FeatureCategory::Json,
        part: "Part 2",
        deps: &[T860_JSON_TYPE],
    },
    FeatureWithPartDef {
        id: T876_JSON_NESTED_PATH,
        name: "JSON nested path",
        description: "Nested path expressions in JSON",
        category: FeatureCategory::Json,
        part: "Part 2",
        deps: &[T860_JSON_TYPE],
    },
    FeatureWithPartDef {
        id: T877_JSON_WRAPPER_OPTION,
        name: "JSON wrapper option",
        description: "WITH/WITHOUT WRAPPER",
        category: FeatureCategory::Json,
        part: "Part 2",
        deps: &[T860_JSON_TYPE],
    },
    FeatureWithPartDef {
        id: T878_JSON_QUOTES_OPTION,
        name: "JSON quotes option",
        description: "KEEP/OMIT QUOTES",
        category: FeatureCategory::Json,
        part: "Part 2",
        deps: &[T860_JSON_TYPE],
    },
];

pub(crate) const POSTGRES_FEATURE_DEFS: &[DialectFeatureDef] = &[
    DialectFeatureDef {
        id: PG_RETURNING,
        name: "RETURNING clause",
        description: "PostgreSQL RETURNING clause",
        deps: &[],
    },
    DialectFeatureDef {
        id: PG_SERIAL,
        name: "SERIAL type",
        description: "PostgreSQL SERIAL/BIGSERIAL auto-increment",
        deps: &[],
    },
    DialectFeatureDef {
        id: PG_ILIKE,
        name: "ILIKE operator",
        description: "Case-insensitive LIKE",
        deps: &[],
    },
    DialectFeatureDef {
        id: PG_DOUBLE_COLON_CAST,
        name: ":: cast operator",
        description: "PostgreSQL :: type cast syntax",
        deps: &[],
    },
    DialectFeatureDef {
        id: PG_ARRAY_LITERALS,
        name: "Array literals",
        description: "PostgreSQL ARRAY[...] and {...} syntax",
        deps: &[],
    },
    DialectFeatureDef {
        id: PG_JSONB_TYPE,
        name: "JSONB type",
        description: "PostgreSQL binary JSON type",
        deps: &[T860_JSON_TYPE],
    },
    DialectFeatureDef {
        id: PG_JSONB_OPERATORS,
        name: "JSONB operators",
        description: "PostgreSQL ->, ->>, #>, #>>, @>, <@, ?, ?|, ?&",
        deps: &[PG_JSONB_TYPE],
    },
];

pub(crate) const BIGQUERY_FEATURE_DEFS: &[DialectFeatureDef] = &[
    DialectFeatureDef {
        id: BQ_QUALIFY_CLAUSE,
        name: "QUALIFY clause",
        description: "Filter on window function results",
        deps: &[T611_WINDOW_FUNCTIONS],
    },
    DialectFeatureDef {
        id: BQ_STRUCT_CONSTRUCTOR,
        name: "STRUCT constructor",
        description: "BigQuery STRUCT(...) syntax",
        deps: &[T041_ROW_TYPE],
    },
    DialectFeatureDef {
        id: BQ_ARRAY_SAFE_OFFSET,
        name: "SAFE_OFFSET",
        description: "Safe array indexing with SAFE_OFFSET",
        deps: &[],
    },
    DialectFeatureDef {
        id: BQ_SAFE_FUNCTIONS,
        name: "SAFE functions",
        description: "SAFE_CAST, SAFE_DIVIDE, etc.",
        deps: &[],
    },
    DialectFeatureDef {
        id: BQ_BACKTICK_IDENTIFIERS,
        name: "Backtick identifiers",
        description: "BigQuery `identifier` quoting",
        deps: &[],
    },
    DialectFeatureDef {
        id: BQ_DATASET_QUALIFIERS,
        name: "Dataset qualifiers",
        description: "project.dataset.table three-part names",
        deps: &[],
    },
];

pub(crate) const CLICKHOUSE_FEATURE_DEFS: &[DialectFeatureDef] = &[
    DialectFeatureDef {
        id: CH_ARRAY_JOIN,
        name: "ARRAY JOIN",
        description: "ClickHouse ARRAY JOIN clause",
        deps: &[],
    },
    DialectFeatureDef {
        id: CH_LEFT_ARRAY_JOIN,
        name: "LEFT ARRAY JOIN",
        description: "ClickHouse LEFT ARRAY JOIN clause",
        deps: &[CH_ARRAY_JOIN],
    },
    DialectFeatureDef {
        id: CH_UNALIGNED_ARRAY_JOIN,
        name: "Unaligned ARRAY JOIN",
        description: "ClickHouse unaligned ARRAY JOIN",
        deps: &[CH_ARRAY_JOIN],
    },
    DialectFeatureDef {
        id: CH_ARRAY_FUNCTIONS,
        name: "Array functions",
        description: "ClickHouse array manipulation functions",
        deps: &[],
    },
    DialectFeatureDef {
        id: CH_HIGHER_ORDER_ARRAY_FUNCS,
        name: "Higher-order array functions",
        description: "ClickHouse arrayMap, arrayFilter, etc.",
        deps: &[CH_ARRAY_FUNCTIONS, CH_LAMBDA_FUNCTIONS],
    },
    DialectFeatureDef {
        id: CH_ARRAY_ELEMENT_ACCESS,
        name: "Array element access",
        description: "ClickHouse array[index] syntax",
        deps: &[],
    },
    DialectFeatureDef {
        id: CH_SETTINGS_CLAUSE,
        name: "SETTINGS clause",
        description: "ClickHouse query-level settings",
        deps: &[],
    },
    DialectFeatureDef {
        id: CH_LIMIT_BY,
        name: "LIMIT BY clause",
        description: "ClickHouse LIMIT BY for per-group limiting",
        deps: &[],
    },
    DialectFeatureDef {
        id: CH_LIMIT_BY_NORMALIZATION,
        name: "LIMIT BY normalization",
        description: "ClickHouse LIMIT BY normalization",
        deps: &[CH_LIMIT_BY],
    },
    DialectFeatureDef {
        id: CH_SAMPLE,
        name: "SAMPLE clause",
        description: "ClickHouse SAMPLE for data sampling",
        deps: &[],
    },
    DialectFeatureDef {
        id: CH_PREWHERE,
        name: "PREWHERE clause",
        description: "ClickHouse PREWHERE optimization hint",
        deps: &[],
    },
    DialectFeatureDef {
        id: CH_FINAL_MODIFIER,
        name: "FINAL modifier",
        description: "ClickHouse FINAL for collapsing tables",
        deps: &[],
    },
    DialectFeatureDef {
        id: CH_GLOBAL_JOIN,
        name: "GLOBAL JOIN",
        description: "ClickHouse distributed GLOBAL JOIN",
        deps: &[],
    },
    DialectFeatureDef {
        id: CH_JOIN_STRICTNESS,
        name: "JOIN strictness",
        description: "ClickHouse ANY/ALL join strictness",
        deps: &[],
    },
    DialectFeatureDef {
        id: CH_ASOF_JOIN,
        name: "ASOF JOIN",
        description: "ClickHouse ASOF join for time-series",
        deps: &[],
    },
    DialectFeatureDef {
        id: CH_GROUP_BY_CUBE,
        name: "GROUP BY CUBE",
        description: "ClickHouse GROUP BY CUBE",
        deps: &[],
    },
    DialectFeatureDef {
        id: CH_GROUP_BY_ROLLUP,
        name: "GROUP BY ROLLUP",
        description: "ClickHouse GROUP BY ROLLUP",
        deps: &[],
    },
    DialectFeatureDef {
        id: CH_GROUP_BY_TOTALS,
        name: "GROUP BY WITH TOTALS",
        description: "ClickHouse WITH TOTALS modifier",
        deps: &[],
    },
    DialectFeatureDef {
        id: CH_AGGREGATE_COMBINATORS,
        name: "Aggregate combinators",
        description: "ClickHouse -If, -Array, -State, -Merge combinators",
        deps: &[],
    },
    DialectFeatureDef {
        id: CH_LAMBDA_FUNCTIONS,
        name: "Lambda functions",
        description: "ClickHouse lambda expressions",
        deps: &[],
    },
    DialectFeatureDef {
        id: CH_DATE_TIME_FUNCTIONS,
        name: "DateTime functions",
        description: "ClickHouse date and time functions",
        deps: &[],
    },
    DialectFeatureDef {
        id: CH_TIME_INTERVALS,
        name: "Time intervals",
        description: "ClickHouse time interval types",
        deps: &[],
    },
    DialectFeatureDef {
        id: CH_NULLABLE_TYPE,
        name: "Nullable type",
        description: "ClickHouse Nullable(T) type wrapper",
        deps: &[],
    },
    DialectFeatureDef {
        id: CH_LOWCARDINALITY,
        name: "LowCardinality type",
        description: "ClickHouse LowCardinality(T) optimization",
        deps: &[],
    },
    DialectFeatureDef {
        id: CH_TUPLE_TYPE,
        name: "Tuple type",
        description: "ClickHouse Tuple type",
        deps: &[],
    },
    DialectFeatureDef {
        id: CH_MAP_TYPE,
        name: "Map type",
        description: "ClickHouse Map(K, V) type",
        deps: &[],
    },
    DialectFeatureDef {
        id: CH_TUPLE_ELEMENT_ACCESS,
        name: "Tuple element access",
        description: "ClickHouse tuple.N syntax",
        deps: &[CH_TUPLE_TYPE],
    },
    DialectFeatureDef {
        id: CH_PARAMETERIZED_VIEWS,
        name: "Parameterized views",
        description: "ClickHouse parameterized views",
        deps: &[],
    },
    DialectFeatureDef {
        id: CH_DISTRIBUTED_SUBQUERIES,
        name: "Distributed subqueries",
        description: "ClickHouse distributed query execution",
        deps: &[],
    },
];
