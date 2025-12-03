use serde::{Deserialize, Serialize};

#[derive(Clone, Copy, Debug, Eq, PartialEq, Serialize, Deserialize)]
pub enum FeatureCategory {
    Core,

    Integrity,

    Sequence,

    Trigger,

    Transaction,

    Window,

    Cte,

    Merge,

    Json,

    InformationSchema,

    RowTypes,

    PostgresExtension,

    BigQueryExtension,

    ClickHouseExtension,

    DialectExtension,

    Other,
}

#[derive(Clone, Copy, Debug, Eq, PartialEq, Serialize, Deserialize)]
pub struct FeatureMetadata {
    pub id: &'static str,

    pub feature_code: &'static str,

    pub name: &'static str,

    pub description: &'static str,

    pub iso_reference: &'static str,

    pub category: FeatureCategory,
}

const fn meta(
    feature_code: &'static str,
    name: &'static str,
    description: &'static str,
    iso_reference: &'static str,
    category: FeatureCategory,
) -> FeatureMetadata {
    FeatureMetadata {
        id: feature_code,
        feature_code,
        name,
        description,
        iso_reference,
        category,
    }
}

const FEATURES: &[FeatureMetadata] = &[
    meta(
        "F001",
        "Basic SQL",
        "Essential SQL statements (SELECT, INSERT, UPDATE, DELETE)",
        "ISO/IEC 9075-2:2023 §7",
        FeatureCategory::Core,
    ),
    meta(
        "F031",
        "Basic schema manipulation",
        "CREATE/ALTER/DROP TABLE semantics",
        "ISO/IEC 9075-2:2023 §11",
        FeatureCategory::Core,
    ),
    meta(
        "E011",
        "DEFAULT clause",
        "Column DEFAULT expressions and literals",
        "ISO/IEC 9075-2:2023 §11.4",
        FeatureCategory::Core,
    ),
    meta(
        "F051",
        "Basic date and time",
        "DATE, TIME, TIMESTAMP types and functions",
        "ISO/IEC 9075-2:2023 §6.1",
        FeatureCategory::Core,
    ),
    meta(
        "F052",
        "Intervals and datetime arithmetic",
        "INTERVAL types and temporal arithmetic",
        "ISO/IEC 9075-2:2023 §6.1/§6.29",
        FeatureCategory::Core,
    ),
    meta(
        "F311",
        "Schema definition statement",
        "CREATE SCHEMA and basic schema manipulation",
        "ISO/IEC 9075-2:2023 §4.15",
        FeatureCategory::Core,
    ),
    meta(
        "F312",
        "Scalar subquery as expression",
        "Use scalar subqueries anywhere expressions are valid",
        "ISO/IEC 9075-2:2023 §4.15",
        FeatureCategory::Core,
    ),
    meta(
        "F351",
        "MERGE statement (F-series)",
        "MERGE for conditional DML",
        "ISO/IEC 9075-2:2023 §14",
        FeatureCategory::Merge,
    ),
    meta(
        "F441",
        "Extended set function support",
        "Window functions: ROW_NUMBER, RANK, DENSE_RANK",
        "ISO/IEC 9075-2:2023 §10.9",
        FeatureCategory::Window,
    ),
    meta(
        "F442",
        "Mixed column references in set functions",
        "PARTITION BY and ORDER BY in window functions",
        "ISO/IEC 9075-2:2023 §10.9",
        FeatureCategory::Window,
    ),
    meta(
        "F443",
        "Explicit defaults in set functions",
        "Window function default specifications",
        "ISO/IEC 9075-2:2023 §10.9",
        FeatureCategory::Window,
    ),
    meta(
        "F471",
        "Tuple IN clause",
        "(a,b) IN ((1,2),(3,4)) tuple comparison",
        "ISO/IEC 9075-2:2023 §8.5",
        FeatureCategory::Core,
    ),
    meta(
        "F496",
        "Optional table versioning clauses",
        "NULLS FIRST/NULLS LAST ordering",
        "ISO/IEC 9075-2:2023 §10",
        FeatureCategory::Core,
    ),
    meta(
        "F561",
        "Full value expressions",
        "Scalar expressions everywhere (CASE, subqueries)",
        "ISO/IEC 9075-2:2023 §6",
        FeatureCategory::Core,
    ),
    meta(
        "F591",
        "Derived tables",
        "Subqueries in FROM clauses",
        "ISO/IEC 9075-2:2023 §7.6",
        FeatureCategory::Core,
    ),
    meta(
        "F781",
        "Self-referencing operations",
        "Foreign keys and referential integrity",
        "ISO/IEC 9075-2:2023 §11.8",
        FeatureCategory::Integrity,
    ),
    meta(
        "E141",
        "CHECK constraints",
        "Integrity enhancement facility (CHECK predicates)",
        "ISO/IEC 9075-2:2023 §11.9",
        FeatureCategory::Integrity,
    ),
    meta(
        "T174",
        "Identity columns",
        "GENERATED ALWAYS/DEFAULT AS IDENTITY",
        "ISO/IEC 9075-2:2023 §11.4",
        FeatureCategory::Sequence,
    ),
    meta(
        "T176",
        "Sequence generators",
        "CREATE SEQUENCE / NEXT VALUE FOR",
        "ISO/IEC 9075-2:2023 §9.26",
        FeatureCategory::Sequence,
    ),
    meta(
        "F402",
        "Transaction COMMIT",
        "Transaction COMMIT statement",
        "ISO/IEC 9075-2:2023 §4.43",
        FeatureCategory::Transaction,
    ),
    meta(
        "F403",
        "Transaction ROLLBACK",
        "Transaction ROLLBACK statement",
        "ISO/IEC 9075-2:2023 §4.44",
        FeatureCategory::Transaction,
    ),
    meta(
        "F782",
        "COMMIT statement",
        "Explicit COMMIT",
        "ISO/IEC 9075-2:2023 §4.43",
        FeatureCategory::Transaction,
    ),
    meta(
        "F783",
        "ROLLBACK statement",
        "Explicit ROLLBACK",
        "ISO/IEC 9075-2:2023 §4.44",
        FeatureCategory::Transaction,
    ),
    meta(
        "F784",
        "SAVEPOINT statement",
        "Define savepoints in transactions",
        "ISO/IEC 9075-2:2023 §4.45",
        FeatureCategory::Transaction,
    ),
    meta(
        "F785",
        "ROLLBACK TO SAVEPOINT",
        "Rollback to named savepoints",
        "ISO/IEC 9075-2:2023 §4.45",
        FeatureCategory::Transaction,
    ),
    meta(
        "F786",
        "Savepoints",
        "Release savepoints",
        "ISO/IEC 9075-2:2023 §4.45",
        FeatureCategory::Transaction,
    ),
    meta(
        "F851",
        "Window frame EXCLUDE",
        "EXCLUDE CURRENT ROW/GROUP/TIES/NO OTHERS",
        "ISO/IEC 9075-2:2023 §7.11",
        FeatureCategory::Window,
    ),
    meta(
        "T041",
        "ROW type",
        "Composite ROW/STRUCT types",
        "ISO/IEC 9075-2:2023 §6.3",
        FeatureCategory::RowTypes,
    ),
    meta(
        "T042",
        "ROW constructor",
        "ROW(...) constructor syntax",
        "ISO/IEC 9075-2:2023 §6.3",
        FeatureCategory::RowTypes,
    ),
    meta(
        "T043",
        "ROW field reference",
        "Field access for ROW types",
        "ISO/IEC 9075-2:2023 §6.3",
        FeatureCategory::RowTypes,
    ),
    meta(
        "T121",
        "WITH clause",
        "Common Table Expressions",
        "ISO/IEC 9075-2:2023 §7.8",
        FeatureCategory::Cte,
    ),
    meta(
        "T131",
        "Recursive query",
        "Recursive CTEs",
        "ISO/IEC 9075-2:2023 §7.8",
        FeatureCategory::Cte,
    ),
    meta(
        "T211",
        "Basic trigger capability",
        "Row/statement triggers for DML",
        "ISO/IEC 9075-2:2023 §15",
        FeatureCategory::Trigger,
    ),
    meta(
        "T301",
        "Savepoint management",
        "SAVEPOINT/ROLLBACK/RELEASE",
        "ISO/IEC 9075-2:2023 §4.45",
        FeatureCategory::Transaction,
    ),
    meta(
        "T321",
        "Transaction isolation levels",
        "SET TRANSACTION ISOLATION LEVEL",
        "ISO/IEC 9075-2:2023 §4.34",
        FeatureCategory::Transaction,
    ),
    meta(
        "T611",
        "Window functions",
        "Core window function support",
        "ISO/IEC 9075-2:2023 §7.11",
        FeatureCategory::Window,
    ),
    meta(
        "T612",
        "Advanced OLAP",
        "Advanced window/OLAP clauses",
        "ISO/IEC 9075-2:2023 §7.11",
        FeatureCategory::Window,
    ),
    meta(
        "T613",
        "Window frame clause",
        "ROWS/RANGE/GROUPS frames",
        "ISO/IEC 9075-2:2023 §7.11",
        FeatureCategory::Window,
    ),
    meta(
        "T614",
        "NTILE function",
        "NTILE() window function",
        "ISO/IEC 9075-2:2023 §7.11",
        FeatureCategory::Window,
    ),
    meta(
        "T615",
        "LEAD/LAG",
        "LEAD() and LAG()",
        "ISO/IEC 9075-2:2023 §7.11",
        FeatureCategory::Window,
    ),
    meta(
        "T616",
        "NULL treatment",
        "RESPECT/IGNORE NULLS modifiers",
        "ISO/IEC 9075-2:2023 §7.11",
        FeatureCategory::Window,
    ),
    meta(
        "T617",
        "FIRST_VALUE/LAST_VALUE",
        "FIRST_VALUE and LAST_VALUE",
        "ISO/IEC 9075-2:2023 §7.11",
        FeatureCategory::Window,
    ),
    meta(
        "T618",
        "NTH_VALUE",
        "NTH_VALUE() window function",
        "ISO/IEC 9075-2:2023 §7.11",
        FeatureCategory::Window,
    ),
    meta(
        "T619",
        "Window frame groups",
        "GROUPS framing clause",
        "ISO/IEC 9075-2:2023 §7.11",
        FeatureCategory::Window,
    ),
    meta(
        "T620",
        "Window frame EXCLUDE",
        "EXCLUDE clauses in frames",
        "ISO/IEC 9075-2:2023 §7.11",
        FeatureCategory::Window,
    ),
    meta(
        "T801",
        "MERGE statement (optional)",
        "MERGE INTO ... USING ...",
        "ISO/IEC 9075-2:2023 §14",
        FeatureCategory::Merge,
    ),
    meta(
        "T802",
        "MERGE WHEN MATCHED",
        "Matched branch handling",
        "ISO/IEC 9075-2:2023 §14",
        FeatureCategory::Merge,
    ),
    meta(
        "T803",
        "MERGE WHEN NOT MATCHED",
        "Insert branch for non matches",
        "ISO/IEC 9075-2:2023 §14",
        FeatureCategory::Merge,
    ),
    meta(
        "T860",
        "JSON type",
        "JSON data type core support",
        "ISO/IEC 9075-15:2023",
        FeatureCategory::Json,
    ),
    meta(
        "T861",
        "JSON_QUERY",
        "Extract JSON subtrees",
        "ISO/IEC 9075-15:2023 §9.40",
        FeatureCategory::Json,
    ),
    meta(
        "T862",
        "JSON_VALUE",
        "Extract scalar values",
        "ISO/IEC 9075-15:2023 §9.39",
        FeatureCategory::Json,
    ),
    meta(
        "T863",
        "JSON_EXISTS",
        "Path existence predicate",
        "ISO/IEC 9075-15:2023 §9.38",
        FeatureCategory::Json,
    ),
    meta(
        "T864",
        "JSON_TABLE",
        "Relational projection of JSON",
        "ISO/IEC 9075-15:2023 §9.41",
        FeatureCategory::Json,
    ),
    meta(
        "T865",
        "JSON_OBJECT",
        "JSON object constructor",
        "ISO/IEC 9075-15:2023 §9.41",
        FeatureCategory::Json,
    ),
    meta(
        "T866",
        "JSON_ARRAY",
        "JSON array constructor",
        "ISO/IEC 9075-15:2023 §9.42",
        FeatureCategory::Json,
    ),
    meta(
        "T867",
        "IS JSON predicate",
        "Validate JSON documents",
        "ISO/IEC 9075-15:2023 §9.37",
        FeatureCategory::Json,
    ),
    meta(
        "T868",
        "JSON simplified accessor",
        "col.field / col[idx] syntax",
        "ISO/IEC 9075-15:2023",
        FeatureCategory::Json,
    ),
    meta(
        "T869",
        "JSON NULL clause",
        "NULL/ABSENT ON NULL modifiers",
        "ISO/IEC 9075-15:2023",
        FeatureCategory::Json,
    ),
    meta(
        "T870",
        "JSON_ARRAYAGG",
        "Aggregate to JSON array",
        "ISO/IEC 9075-15:2023",
        FeatureCategory::Json,
    ),
    meta(
        "T871",
        "JSON_OBJECTAGG",
        "Aggregate to JSON object",
        "ISO/IEC 9075-15:2023",
        FeatureCategory::Json,
    ),
    meta(
        "T872",
        "JSON paths",
        "JSONPath navigation",
        "ISO/IEC 9075-15:2023",
        FeatureCategory::Json,
    ),
    meta(
        "T873",
        "JSON PASSING clause",
        "PASSING parameter support",
        "ISO/IEC 9075-15:2023",
        FeatureCategory::Json,
    ),
    meta(
        "T874",
        "JSON RETURNING clause",
        "RETURNING type annotations",
        "ISO/IEC 9075-15:2023",
        FeatureCategory::Json,
    ),
    meta(
        "T875",
        "JSON error behavior",
        "ON ERROR clause",
        "ISO/IEC 9075-15:2023",
        FeatureCategory::Json,
    ),
    meta(
        "T876",
        "JSON nested path",
        "Nested path expressions",
        "ISO/IEC 9075-15:2023",
        FeatureCategory::Json,
    ),
    meta(
        "T877",
        "JSON wrapper option",
        "WITH/WITHOUT WRAPPER",
        "ISO/IEC 9075-15:2023",
        FeatureCategory::Json,
    ),
    meta(
        "T878",
        "JSON quotes option",
        "KEEP/OMIT QUOTES",
        "ISO/IEC 9075-15:2023",
        FeatureCategory::Json,
    ),
    meta(
        "PG_RETURNING",
        "RETURNING clause",
        "PostgreSQL RETURNING extension",
        "PostgreSQL Documentation",
        FeatureCategory::PostgresExtension,
    ),
    meta(
        "PG_SERIAL",
        "SERIAL pseudo-type",
        "SERIAL/BIGSERIAL auto-increment",
        "PostgreSQL Documentation",
        FeatureCategory::PostgresExtension,
    ),
    meta(
        "PG_ILIKE",
        "ILIKE operator",
        "Case-insensitive pattern matching",
        "PostgreSQL Documentation",
        FeatureCategory::PostgresExtension,
    ),
    meta(
        "PG_DOUBLE_COLON_CAST",
        ":: cast operator",
        "PostgreSQL double-colon casting",
        "PostgreSQL Documentation",
        FeatureCategory::PostgresExtension,
    ),
    meta(
        "PG_ARRAY_LITERALS",
        "Array literals",
        "ARRAY[...] and '{...}' literals",
        "PostgreSQL Documentation",
        FeatureCategory::PostgresExtension,
    ),
    meta(
        "PG_JSONB_TYPE",
        "JSONB type",
        "Binary JSON storage",
        "PostgreSQL Documentation",
        FeatureCategory::PostgresExtension,
    ),
    meta(
        "PG_JSONB_OPERATORS",
        "JSONB operators",
        "PostgreSQL JSONB operator set",
        "PostgreSQL Documentation",
        FeatureCategory::PostgresExtension,
    ),
    meta(
        "BQ_QUALIFY_CLAUSE",
        "QUALIFY clause",
        "Filter by window function results",
        "Google BigQuery",
        FeatureCategory::BigQueryExtension,
    ),
    meta(
        "BQ_STRUCT_CONSTRUCTOR",
        "STRUCT constructor",
        "STRUCT(...) syntax",
        "Google BigQuery",
        FeatureCategory::BigQueryExtension,
    ),
    meta(
        "BQ_ARRAY_SAFE_OFFSET",
        "SAFE_OFFSET",
        "NULL-safe array indexing",
        "Google BigQuery",
        FeatureCategory::BigQueryExtension,
    ),
    meta(
        "BQ_SAFE_FUNCTIONS",
        "SAFE_* functions",
        "SAFE_CAST/SAFE_DIVIDE semantics",
        "Google BigQuery",
        FeatureCategory::BigQueryExtension,
    ),
    meta(
        "BQ_BACKTICK_IDENTIFIERS",
        "Backtick identifiers",
        "`identifier` quoting",
        "Google BigQuery",
        FeatureCategory::BigQueryExtension,
    ),
    meta(
        "BQ_DATASET_QUALIFIERS",
        "Dataset qualifiers",
        "project.dataset.table addressing",
        "Google BigQuery",
        FeatureCategory::BigQueryExtension,
    ),
];

pub fn feature_catalog() -> &'static [FeatureMetadata] {
    FEATURES
}

pub fn find_feature(id: &str) -> Option<&'static FeatureMetadata> {
    FEATURES
        .iter()
        .find(|feature| feature.id.eq_ignore_ascii_case(id))
}

#[cfg(test)]
mod tests {
    use super::{FeatureCategory, feature_catalog, find_feature};

    #[test]
    fn catalog_contains_known_features() {
        assert!(
            feature_catalog()
                .iter()
                .any(|feature| feature.id == "E141"
                    && feature.category == FeatureCategory::Integrity)
        );
    }

    #[test]
    fn lookup_is_case_insensitive() {
        let feature = find_feature("t176").expect("feature present");
        assert_eq!(feature.name, "Sequence generators");
    }
}
