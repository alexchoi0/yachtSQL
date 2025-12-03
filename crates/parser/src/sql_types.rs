pub struct Sql2023Types;

impl Sql2023Types {
    pub fn normalize_type_name(dialect_type: &str) -> String {
        let upper = dialect_type.trim_matches('"').to_uppercase();
        match upper.as_str() {
            "INT64" | "BIGINT" => "BIGINT".into(),
            "INTEGER" | "INT" => "INTEGER".into(),
            "SMALLINT" => "SMALLINT".into(),
            "TINYINT" => "SMALLINT".into(),

            "FLOAT64" | "DOUBLE" | "DOUBLE PRECISION" => "DOUBLE PRECISION".into(),
            "FLOAT" | "REAL" => "REAL".into(),

            "NUMERIC" | "DECIMAL" | "BIGNUMERIC" => "NUMERIC".into(),

            "STRING" | "TEXT" => "VARCHAR".into(),
            "CHAR" | "CHARACTER" => "CHAR".into(),
            "VARCHAR" | "CHARACTER VARYING" => "VARCHAR".into(),

            "BYTES" | "BYTEA" => "VARBINARY".into(),
            "BINARY" => "BINARY".into(),
            "VARBINARY" | "BINARY VARYING" => "VARBINARY".into(),

            "BOOL" | "BOOLEAN" => "BOOLEAN".into(),

            "DATE" => "DATE".into(),
            "TIME" | "TIME WITHOUT TIME ZONE" => "TIME".into(),
            "TIME WITH TIME ZONE" => "TIME WITH TIME ZONE".into(),
            "TIMESTAMP" | "DATETIME" => "TIMESTAMP".into(),
            "TIMESTAMPTZ" | "TIMESTAMP WITH TIME ZONE" => "TIMESTAMP WITH TIME ZONE".into(),

            "JSON" | "JSONB" => "JSON".into(),

            "STRUCT" | "ROW" => "ROW".into(),
            "ARRAY" => "ARRAY".into(),

            "INET" => "INET".into(),
            "CIDR" => "CIDR".into(),

            "POINT" => "POINT".into(),
            "BOX" | "PGBOX" => "BOX".into(),
            "CIRCLE" => "CIRCLE".into(),

            "HSTORE" => "HSTORE".into(),

            _ => dialect_type.to_string(),
        }
    }
}

#[cfg(test)]
mod tests {
    use super::Sql2023Types;

    #[test]
    fn normalizes_known_types() {
        assert_eq!(Sql2023Types::normalize_type_name("int64"), "BIGINT");
        assert_eq!(Sql2023Types::normalize_type_name("String"), "VARCHAR");
        assert_eq!(Sql2023Types::normalize_type_name("bytes"), "VARBINARY");
        assert_eq!(Sql2023Types::normalize_type_name("float"), "REAL");
        assert_eq!(Sql2023Types::normalize_type_name("timestamp"), "TIMESTAMP");
        assert_eq!(
            Sql2023Types::normalize_type_name("timestamp with time zone"),
            "TIMESTAMP WITH TIME ZONE"
        );
    }

    #[test]
    fn normalizes_network_types() {
        assert_eq!(Sql2023Types::normalize_type_name("inet"), "INET");
        assert_eq!(Sql2023Types::normalize_type_name("INET"), "INET");
        assert_eq!(Sql2023Types::normalize_type_name("cidr"), "CIDR");
        assert_eq!(Sql2023Types::normalize_type_name("CIDR"), "CIDR");
    }

    #[test]
    fn leaves_unknown_types_intact() {
        assert_eq!(Sql2023Types::normalize_type_name("GEOGRAPHY"), "GEOGRAPHY");
        assert_eq!(
            Sql2023Types::normalize_type_name("CustomType"),
            "CustomType"
        );
    }
}
