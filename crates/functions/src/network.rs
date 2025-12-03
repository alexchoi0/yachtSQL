use std::net::{IpAddr, Ipv4Addr, Ipv6Addr};
use std::sync::LazyLock;

use publicsuffix::{List, Psl};
use url::Url;
use yachtsql_core::error::{Error, Result};
use yachtsql_core::types::Value;

const IPV4_FAMILY: i64 = 4;
const IPV6_FAMILY: i64 = 6;
const IPV4_BYTES: usize = 4;
const IPV6_BYTES: usize = 16;
const IPV4_MAX_PREFIX: i64 = 32;
const IPV6_MAX_PREFIX: i64 = 128;
const IPV4_MAX_VALUE: i64 = 4_294_967_295;

static PSL: LazyLock<List> = LazyLock::new(List::new);

pub fn ip_from_string(addr_str: &str) -> Result<Value> {
    let ip = addr_str
        .parse::<IpAddr>()
        .map_err(|_| Error::invalid_query(format!("Invalid IP address: {}", addr_str)))?;

    let bytes = match ip {
        IpAddr::V4(ipv4) => ipv4.octets().to_vec(),
        IpAddr::V6(ipv6) => ipv6.octets().to_vec(),
    };

    Ok(Value::bytes(bytes))
}

pub fn safe_ip_from_string(addr_str: &str) -> Result<Value> {
    match addr_str.parse::<IpAddr>() {
        Ok(ip) => {
            let bytes = match ip {
                IpAddr::V4(ipv4) => ipv4.octets().to_vec(),
                IpAddr::V6(ipv6) => ipv6.octets().to_vec(),
            };
            Ok(Value::bytes(bytes))
        }
        Err(_) => Ok(Value::null()),
    }
}

pub fn ip_to_string(addr_bin: &[u8]) -> Result<Value> {
    match addr_bin.len() {
        IPV4_BYTES => {
            let ipv4 = Ipv4Addr::new(addr_bin[0], addr_bin[1], addr_bin[2], addr_bin[3]);
            Ok(Value::string(ipv4.to_string()))
        }
        IPV6_BYTES => {
            let mut octets = [0u8; IPV6_BYTES];
            octets.copy_from_slice(addr_bin);
            let ipv6 = Ipv6Addr::from(octets);
            Ok(Value::string(ipv6.to_string()))
        }
        n => Err(Error::invalid_query(format!(
            "Expected {} or {} bytes for IP address, got {}",
            IPV4_BYTES, IPV6_BYTES, n
        ))),
    }
}

pub fn ipv4_to_int64(addr_bin: &[u8]) -> Result<Value> {
    if addr_bin.len() != IPV4_BYTES {
        return Err(Error::invalid_query(format!(
            "Expected {}-byte IPv4 address, got {} bytes",
            IPV4_BYTES,
            addr_bin.len()
        )));
    }

    let ip_int = ((addr_bin[0] as i64) << 24)
        | ((addr_bin[1] as i64) << 16)
        | ((addr_bin[2] as i64) << 8)
        | (addr_bin[3] as i64);

    Ok(Value::int64(ip_int))
}

pub fn ipv4_from_int64(addr_int64: i64) -> Result<Value> {
    if !(0..=IPV4_MAX_VALUE).contains(&addr_int64) {
        return Err(Error::invalid_query(format!(
            "IPv4 address must be in range 0-{}, got {}",
            IPV4_MAX_VALUE, addr_int64
        )));
    }

    let octets = [
        ((addr_int64 >> 24) & 0xFF) as u8,
        ((addr_int64 >> 16) & 0xFF) as u8,
        ((addr_int64 >> 8) & 0xFF) as u8,
        (addr_int64 & 0xFF) as u8,
    ];

    Ok(Value::bytes(octets.to_vec()))
}

pub fn ip_net_mask(num_prefix_bits: i64, addr_family: i64) -> Result<Value> {
    match addr_family {
        IPV4_FAMILY => {
            if !(0..=IPV4_MAX_PREFIX).contains(&num_prefix_bits) {
                return Err(Error::invalid_query(format!(
                    "IPv4 prefix bits must be 0-{}, got {}",
                    IPV4_MAX_PREFIX, num_prefix_bits
                )));
            }
            let mask = if num_prefix_bits == 0 {
                0u32
            } else {
                !0u32 << (32 - num_prefix_bits)
            };
            let octets = mask.to_be_bytes();
            Ok(Value::bytes(octets.to_vec()))
        }
        IPV6_FAMILY => {
            if !(0..=IPV6_MAX_PREFIX).contains(&num_prefix_bits) {
                return Err(Error::invalid_query(format!(
                    "IPv6 prefix bits must be 0-{}, got {}",
                    IPV6_MAX_PREFIX, num_prefix_bits
                )));
            }
            let mut mask = [0u8; IPV6_BYTES];
            let full_bytes = (num_prefix_bits / 8) as usize;
            let remaining_bits = (num_prefix_bits % 8) as u8;

            for item in mask.iter_mut().take(full_bytes) {
                *item = 0xFF;
            }
            if full_bytes < IPV6_BYTES && remaining_bits > 0 {
                mask[full_bytes] = !0u8 << (8 - remaining_bits);
            }
            Ok(Value::bytes(mask.to_vec()))
        }
        _ => Err(Error::invalid_query(format!(
            "Address family must be {} (IPv4) or {} (IPv6), got {}",
            IPV4_FAMILY, IPV6_FAMILY, addr_family
        ))),
    }
}

pub fn ip_trunc(addr_bin: &[u8], num_prefix_bits: i64) -> Result<Value> {
    let addr_family = match addr_bin.len() {
        IPV4_BYTES => IPV4_FAMILY,
        IPV6_BYTES => IPV6_FAMILY,
        n => {
            return Err(Error::invalid_query(format!(
                "Expected {} or {} bytes for IP address, got {}",
                IPV4_BYTES, IPV6_BYTES, n
            )));
        }
    };

    let mask_value = ip_net_mask(num_prefix_bits, addr_family)?;
    let mask = mask_value
        .as_bytes()
        .ok_or_else(|| Error::invalid_query("Expected bytes from ip_net_mask".to_string()))?;

    let truncated: Vec<u8> = addr_bin
        .iter()
        .zip(mask.iter())
        .map(|(a, m)| a & m)
        .collect();

    Ok(Value::bytes(truncated))
}

pub fn host(url_str: &str) -> Result<Value> {
    match Url::parse(url_str) {
        Ok(url) => match url.host_str() {
            Some(host) => Ok(Value::string(host.to_string())),
            None => Ok(Value::null()),
        },
        Err(_) => Ok(Value::null()),
    }
}

pub fn public_suffix(url_str: &str) -> Result<Value> {
    match Url::parse(url_str) {
        Ok(url) => match url.host_str() {
            Some(host) => {
                let domain = host.trim_start_matches("www.");
                match PSL.suffix(domain.as_bytes()) {
                    Some(suffix) => {
                        let suffix_str = std::str::from_utf8(suffix.as_bytes())
                            .unwrap_or("")
                            .to_string();
                        Ok(Value::string(suffix_str))
                    }
                    None => Ok(Value::null()),
                }
            }
            None => Ok(Value::null()),
        },
        Err(_) => Ok(Value::null()),
    }
}

pub fn reg_domain(url_str: &str) -> Result<Value> {
    match Url::parse(url_str) {
        Ok(url) => match url.host_str() {
            Some(host) => {
                let domain = host.trim_start_matches("www.");
                match PSL.domain(domain.as_bytes()) {
                    Some(reg_domain) => {
                        let reg_domain_str = std::str::from_utf8(reg_domain.as_bytes())
                            .unwrap_or("")
                            .to_string();
                        Ok(Value::string(reg_domain_str))
                    }
                    None => Ok(Value::null()),
                }
            }
            None => Ok(Value::null()),
        },
        Err(_) => Ok(Value::null()),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_ip_from_string_ipv4() {
        let result = ip_from_string("192.168.1.1").unwrap();
        let bytes = result.as_bytes().expect("Expected bytes");
        assert_eq!(bytes, &[192, 168, 1, 1]);
    }

    #[test]
    fn test_ip_from_string_ipv6() {
        let result = ip_from_string("::1").unwrap();
        let bytes = result.as_bytes().expect("Expected bytes");
        assert_eq!(bytes.len(), 16);
        assert_eq!(bytes[15], 1);
    }

    #[test]
    fn test_safe_ip_from_string_invalid() {
        let result = safe_ip_from_string("not-an-ip").unwrap();
        assert_eq!(result, Value::null());
    }

    #[test]
    fn test_ipv4_to_int64() {
        let result = ipv4_to_int64(&[192, 168, 1, 1]).unwrap();
        assert_eq!(result, Value::int64(3232235777));
    }

    #[test]
    fn test_ipv4_from_int64() {
        let result = ipv4_from_int64(3232235777).unwrap();
        let bytes = result.as_bytes().expect("Expected bytes");
        assert_eq!(bytes, &[192, 168, 1, 1]);
    }

    #[test]
    fn test_ip_net_mask_ipv4() {
        let result = ip_net_mask(24, 4).unwrap();
        let bytes = result.as_bytes().expect("Expected bytes");
        assert_eq!(bytes, &[255, 255, 255, 0]);
    }

    #[test]
    fn test_ip_trunc() {
        let result = ip_trunc(&[192, 168, 1, 100], 24).unwrap();
        let bytes = result.as_bytes().expect("Expected bytes");
        assert_eq!(bytes, &[192, 168, 1, 0]);
    }

    #[test]
    fn test_host() {
        let result = host("https://www.google.com/search?q=bigquery").unwrap();
        let s = result.as_str().expect("Expected string");
        assert_eq!(s, "www.google.com");
    }
}
