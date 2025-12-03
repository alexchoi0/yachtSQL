use yachtsql_core::types::{DataType, Value};

#[test]
fn test_inet_type_exists() {
    let inet_type = DataType::Inet;
    assert_eq!(format!("{}", inet_type), "INET");
}

#[test]
fn test_cidr_type_exists() {
    let cidr_type = DataType::Cidr;
    assert_eq!(format!("{}", cidr_type), "CIDR");
}

#[test]
fn test_inet_value_from_ipv4() {
    let inet = Value::inet_from_str("192.168.1.1").expect("valid IPv4");
    assert!(!inet.is_null());
    assert_eq!(inet.data_type(), DataType::Inet);
}

#[test]
fn test_inet_value_from_ipv4_with_prefix() {
    let inet = Value::inet_from_str("192.168.1.1/24").expect("valid IPv4 with prefix");
    assert!(!inet.is_null());
    assert_eq!(inet.data_type(), DataType::Inet);
}

#[test]
fn test_inet_value_from_ipv6() {
    let inet = Value::inet_from_str("::1").expect("valid IPv6");
    assert!(!inet.is_null());
    assert_eq!(inet.data_type(), DataType::Inet);
}

#[test]
fn test_inet_value_from_ipv6_with_prefix() {
    let inet = Value::inet_from_str("2001:db8::1/64").expect("valid IPv6 with prefix");
    assert!(!inet.is_null());
    assert_eq!(inet.data_type(), DataType::Inet);
}

#[test]
fn test_cidr_value_from_ipv4_network() {
    let cidr = Value::cidr_from_str("192.168.1.0/24").expect("valid IPv4 CIDR");
    assert!(!cidr.is_null());
    assert_eq!(cidr.data_type(), DataType::Cidr);
}

#[test]
fn test_cidr_value_from_ipv6_network() {
    let cidr = Value::cidr_from_str("2001:db8::/32").expect("valid IPv6 CIDR");
    assert!(!cidr.is_null());
    assert_eq!(cidr.data_type(), DataType::Cidr);
}

#[test]
fn test_cidr_rejects_non_network_address() {
    let result = Value::cidr_from_str("192.168.1.1/24");
    assert!(result.is_err(), "CIDR should reject non-zero host bits");
}

#[test]
fn test_inet_display_ipv4() {
    let inet = Value::inet_from_str("192.168.1.1").expect("valid IPv4");
    assert_eq!(format!("{}", inet), "192.168.1.1");
}

#[test]
fn test_inet_display_ipv4_with_prefix() {
    let inet = Value::inet_from_str("192.168.1.1/24").expect("valid IPv4 with prefix");
    assert_eq!(format!("{}", inet), "192.168.1.1/24");
}

#[test]
fn test_cidr_display_ipv4() {
    let cidr = Value::cidr_from_str("192.168.0.0/16").expect("valid CIDR");
    assert_eq!(format!("{}", cidr), "192.168.0.0/16");
}

#[test]
fn test_inet_equality() {
    let inet1 = Value::inet_from_str("192.168.1.1").expect("valid IPv4");
    let inet2 = Value::inet_from_str("192.168.1.1").expect("valid IPv4");
    let inet3 = Value::inet_from_str("192.168.1.2").expect("valid IPv4");

    assert_eq!(inet1, inet2);
    assert_ne!(inet1, inet3);
}

#[test]
fn test_cidr_equality() {
    let cidr1 = Value::cidr_from_str("192.168.0.0/24").expect("valid CIDR");
    let cidr2 = Value::cidr_from_str("192.168.0.0/24").expect("valid CIDR");
    let cidr3 = Value::cidr_from_str("192.168.0.0/16").expect("valid CIDR");

    assert_eq!(cidr1, cidr2);
    assert_ne!(cidr1, cidr3);
}

#[test]
fn test_inet_clone() {
    let inet = Value::inet_from_str("192.168.1.1/24").expect("valid IPv4");
    let cloned = inet.clone();
    assert_eq!(inet, cloned);
}

#[test]
fn test_cidr_clone() {
    let cidr = Value::cidr_from_str("10.0.0.0/8").expect("valid CIDR");
    let cloned = cidr.clone();
    assert_eq!(cidr, cloned);
}

#[test]
fn test_as_inet() {
    let inet = Value::inet_from_str("192.168.1.1/24").expect("valid IPv4");
    let inet_addr = inet.as_inet().expect("should be inet");
    assert_eq!(inet_addr.to_string(), "192.168.1.1/24");
}

#[test]
fn test_as_cidr() {
    let cidr = Value::cidr_from_str("10.0.0.0/8").expect("valid CIDR");
    let cidr_addr = cidr.as_cidr().expect("should be cidr");
    assert_eq!(cidr_addr.to_string(), "10.0.0.0/8");
}

#[test]
fn test_as_inet_returns_none_for_non_inet() {
    let string_val = Value::string("not an inet".to_string());
    assert!(string_val.as_inet().is_none());
}

#[test]
fn test_as_cidr_returns_none_for_non_cidr() {
    let string_val = Value::string("not a cidr".to_string());
    assert!(string_val.as_cidr().is_none());
}
