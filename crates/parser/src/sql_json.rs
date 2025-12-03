pub struct Sql2023Json;

impl Sql2023Json {
    pub fn json_value(column: &str, path: &str) -> String {
        format!("JSON_VALUE({}, '{}' RETURNING VARCHAR)", column, path)
    }

    pub fn json_query(column: &str, path: &str) -> String {
        format!("JSON_QUERY({}, '{}')", column, path)
    }

    pub fn json_exists(column: &str, path: &str) -> String {
        format!("JSON_EXISTS({}, '{}')", column, path)
    }

    pub fn json_object(key_values: &[(impl AsRef<str>, impl AsRef<str>)]) -> String {
        let pairs: Vec<String> = key_values
            .iter()
            .map(|(k, v)| format!("KEY '{}' VALUE {}", k.as_ref(), v.as_ref()))
            .collect();
        format!("JSON_OBJECT({})", pairs.join(", "))
    }

    pub fn json_array(values: &[impl AsRef<str>]) -> String {
        let rendered: Vec<&str> = values.iter().map(|v| v.as_ref()).collect();
        format!("JSON_ARRAY({})", rendered.join(", "))
    }

    pub fn json_contains_approx(column: &str, json_literal: &str) -> String {
        format!(
            "JSON_EXISTS({}, '$?(@.type() == \"object\")') /* Approximation of @> {} */",
            column, json_literal
        )
    }
}

#[cfg(test)]
mod tests {
    use super::Sql2023Json;

    #[test]
    fn generates_scalar_helper() {
        assert_eq!(
            Sql2023Json::json_value("payload", "$.user"),
            "JSON_VALUE(payload, '$.user' RETURNING VARCHAR)"
        );
    }

    #[test]
    fn generates_query_helper() {
        assert_eq!(
            Sql2023Json::json_query("payload", "$.address"),
            "JSON_QUERY(payload, '$.address')"
        );
    }

    #[test]
    fn generates_exists_helper() {
        assert_eq!(
            Sql2023Json::json_exists("payload", "$.id"),
            "JSON_EXISTS(payload, '$.id')"
        );
    }

    #[test]
    fn builds_object_helper() {
        let expr = Sql2023Json::json_object(&[("id", "42"), ("name", "'Alice'")]);
        assert_eq!(
            expr,
            "JSON_OBJECT(KEY 'id' VALUE 42, KEY 'name' VALUE 'Alice')"
        );
    }

    #[test]
    fn builds_array_helper() {
        let expr = Sql2023Json::json_array(&["1", "2", "3"]);
        assert_eq!(expr, "JSON_ARRAY(1, 2, 3)");
    }
}
