use std::collections::HashMap;

pub fn development_profile() -> HashMap<String, bool> {
    let mut overrides = HashMap::new();

    overrides.insert("F001_BASIC_SQL".to_string(), true);
    overrides.insert("F051_BASIC_DATE_TIME".to_string(), true);
    overrides.insert("F052_INTERVALS_DATETIME_ARITHMETIC".to_string(), true);
    overrides.insert("F311_SCHEMA_DEFINITION".to_string(), true);
    overrides.insert("F312_SCALAR_SUBQUERY_AS_EXPRESSION".to_string(), true);

    overrides.insert("T301_SAVEPOINTS".to_string(), true);
    overrides.insert("F784_SAVEPOINT_STATEMENT".to_string(), true);
    overrides.insert("F785_ROLLBACK_TO_SAVEPOINT_STATEMENT".to_string(), true);
    overrides.insert("F786_SAVEPOINTS".to_string(), true);

    overrides.insert("T611_WINDOW_FUNCTIONS".to_string(), true);
    overrides.insert("T612_ADVANCED_OLAP_OPERATIONS".to_string(), true);
    overrides.insert("T613_WINDOW_FRAME_CLAUSE".to_string(), true);

    overrides.insert("T121_WITH_CLAUSE".to_string(), true);
    overrides.insert("T131_RECURSIVE_QUERY".to_string(), true);

    overrides.insert("T860_JSON_TYPE".to_string(), true);
    overrides.insert("T861_JSON_QUERY".to_string(), true);
    overrides.insert("T862_JSON_VALUE".to_string(), true);

    overrides
}

pub fn production_profile() -> HashMap<String, bool> {
    let mut overrides = HashMap::new();

    overrides.insert("F001_BASIC_SQL".to_string(), true);
    overrides.insert("F051_BASIC_DATE_TIME".to_string(), true);
    overrides.insert("F052_INTERVALS_DATETIME_ARITHMETIC".to_string(), true);
    overrides.insert("F311_SCHEMA_DEFINITION".to_string(), true);
    overrides.insert("F312_SCALAR_SUBQUERY_AS_EXPRESSION".to_string(), true);

    overrides.insert("F402_TRANSACTION_COMMIT".to_string(), true);
    overrides.insert("F403_TRANSACTION_ROLLBACK".to_string(), true);
    overrides.insert("T321_TRANSACTION_ISOLATION".to_string(), true);

    overrides.insert("T301_SAVEPOINTS".to_string(), false);
    overrides.insert("F784_SAVEPOINT_STATEMENT".to_string(), false);
    overrides.insert("F785_ROLLBACK_TO_SAVEPOINT_STATEMENT".to_string(), false);
    overrides.insert("F786_SAVEPOINTS".to_string(), false);

    overrides.insert("T611_WINDOW_FUNCTIONS".to_string(), true);

    overrides.insert("T121_WITH_CLAUSE".to_string(), true);
    overrides.insert("T131_RECURSIVE_QUERY".to_string(), true);

    overrides.insert("T860_JSON_TYPE".to_string(), true);
    overrides.insert("T861_JSON_QUERY".to_string(), true);

    overrides
}

pub fn testing_profile() -> HashMap<String, bool> {
    let mut overrides = HashMap::new();

    overrides.insert("F001_BASIC_SQL".to_string(), true);
    overrides.insert("F051_BASIC_DATE_TIME".to_string(), true);
    overrides.insert("F052_INTERVALS_DATETIME_ARITHMETIC".to_string(), true);
    overrides.insert("F311_SCHEMA_DEFINITION".to_string(), true);
    overrides.insert("F312_SCALAR_SUBQUERY_AS_EXPRESSION".to_string(), true);

    overrides.insert("F402_TRANSACTION_COMMIT".to_string(), false);
    overrides.insert("F403_TRANSACTION_ROLLBACK".to_string(), false);
    overrides.insert("T321_TRANSACTION_ISOLATION".to_string(), false);

    overrides.insert("T301_SAVEPOINTS".to_string(), false);
    overrides.insert("F784_SAVEPOINT_STATEMENT".to_string(), false);
    overrides.insert("F785_ROLLBACK_TO_SAVEPOINT_STATEMENT".to_string(), false);
    overrides.insert("F786_SAVEPOINTS".to_string(), false);

    overrides.insert("T611_WINDOW_FUNCTIONS".to_string(), true);

    overrides.insert("T121_WITH_CLAUSE".to_string(), true);
    overrides.insert("T131_RECURSIVE_QUERY".to_string(), false);

    overrides.insert("T860_JSON_TYPE".to_string(), true);
    overrides.insert("T861_JSON_QUERY".to_string(), true);
    overrides.insert("T862_JSON_VALUE".to_string(), false);

    overrides
}

pub fn get_profile(name: &str) -> Option<HashMap<String, bool>> {
    match name {
        "development" => Some(development_profile()),
        "production" => Some(production_profile()),
        "testing" => Some(testing_profile()),
        _ => None,
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_development_profile() {
        let profile = development_profile();
        assert!(!profile.is_empty());
        assert_eq!(profile.get("T301_SAVEPOINTS"), Some(&true));
        assert_eq!(profile.get("T611_WINDOW_FUNCTIONS"), Some(&true));
    }

    #[test]
    fn test_production_profile() {
        let profile = production_profile();
        assert!(!profile.is_empty());
        assert_eq!(profile.get("T301_SAVEPOINTS"), Some(&false));
        assert_eq!(profile.get("T611_WINDOW_FUNCTIONS"), Some(&true));
    }

    #[test]
    fn test_testing_profile() {
        let profile = testing_profile();
        assert!(!profile.is_empty());
        assert_eq!(profile.get("T301_SAVEPOINTS"), Some(&false));
        assert_eq!(profile.get("T131_RECURSIVE_QUERY"), Some(&false));
    }

    #[test]
    fn test_get_profile() {
        assert!(get_profile("development").is_some());
        assert!(get_profile("production").is_some());
        assert!(get_profile("testing").is_some());
        assert!(get_profile("unknown").is_none());
    }
}
