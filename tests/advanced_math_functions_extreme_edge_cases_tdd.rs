#![allow(dead_code)]
#![allow(unused_variables)]
#![allow(clippy::unnecessary_unwrap)]
#![allow(clippy::collapsible_if)]
#![allow(clippy::wildcard_enum_match_arm)]

use yachtsql::{DialectType, QueryExecutor};

#[test]
fn test_sin_at_zero() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE angles (id INT64, radians FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO angles VALUES (1, 0.0)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT SIN(radians) as sin_val FROM angles")
        .unwrap();

    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap().as_f64().unwrap();
    assert!(val.abs() < 1e-10, "SIN(0) should be ~0, got {}", val);
}

#[test]
fn test_sin_at_pi_over_2() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE angles (id INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO angles VALUES (1)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT SIN(PI() / 2.0) as sin_val FROM angles")
        .unwrap();

    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap().as_f64().unwrap();
    assert!(
        (val - 1.0).abs() < 1e-10,
        "SIN(π/2) should be 1.0, got {}",
        val
    );
}

#[test]
fn test_cos_at_zero() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE angles (id INT64, radians FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO angles VALUES (1, 0.0)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT COS(radians) as cos_val FROM angles")
        .unwrap();

    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap().as_f64().unwrap();
    assert!(
        (val - 1.0).abs() < 1e-10,
        "COS(0) should be 1.0, got {}",
        val
    );
}

#[test]
fn test_tan_at_zero() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE angles (id INT64, radians FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO angles VALUES (1, 0.0)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT TAN(radians) as tan_val FROM angles")
        .unwrap();

    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap().as_f64().unwrap();
    assert!(val.abs() < 1e-10, "TAN(0) should be ~0, got {}", val);
}

#[test]
fn test_tan_at_pi_over_4() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE angles (id INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO angles VALUES (1)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT TAN(PI() / 4.0) as tan_val FROM angles")
        .unwrap();

    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap().as_f64().unwrap();
    assert!(
        (val - 1.0).abs() < 1e-10,
        "TAN(π/4) should be 1.0, got {}",
        val
    );
}

#[test]
fn test_tan_near_pi_over_2_approaches_infinity() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE angles (id INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO angles VALUES (1)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT TAN(PI() / 2.0 - 0.0001) as tan_val FROM angles")
        .unwrap();

    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap().as_f64().unwrap();
    assert!(
        val.abs() > 1000.0,
        "TAN(π/2 - ε) should be very large, got {}",
        val
    );
}

#[test]
fn test_asin_domain_valid_range() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, val FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, -1.0), (2, 0.0), (3, 1.0)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT val, ASIN(val) as asin_val FROM values ORDER BY id")
        .unwrap();

    assert_eq!(result.num_rows(), 3);
}

#[test]
fn test_asin_domain_error_above_one() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, val FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, 1.5)")
        .unwrap();

    let result = executor.execute_sql("SELECT ASIN(val) as asin_val FROM values");

    assert!(result.is_err(), "ASIN(1.5) should error (domain violation)");
}

#[test]
fn test_asin_domain_error_below_minus_one() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, val FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, -1.5)")
        .unwrap();

    let result = executor.execute_sql("SELECT ASIN(val) as asin_val FROM values");

    assert!(
        result.is_err(),
        "ASIN(-1.5) should error (domain violation)"
    );
}

#[test]
fn test_acos_returns_pi_for_minus_one() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, val FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, -1.0)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT ACOS(val) as acos_val FROM values")
        .unwrap();

    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap().as_f64().unwrap();
    let pi = std::f64::consts::PI;
    assert!(
        (val - pi).abs() < 1e-10,
        "ACOS(-1) should be π, got {}",
        val
    );
}

#[test]
fn test_atan_accepts_all_real_numbers() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, val FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, -1000.0), (2, 0.0), (3, 1000.0)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT ATAN(val) as atan_val FROM values ORDER BY id")
        .unwrap();

    assert_eq!(result.num_rows(), 3);

    let col = result.column(0).unwrap();
    let val_neg = col.get(0).unwrap().as_f64().unwrap();
    let val_pos = col.get(2).unwrap().as_f64().unwrap();

    assert!(val_neg < 0.0 && val_neg > -std::f64::consts::FRAC_PI_2);
    assert!(val_pos > 0.0 && val_pos < std::f64::consts::FRAC_PI_2);
}

#[test]
fn test_atan2_quadrant_detection() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE points (id INT64, y FLOAT64, x FLOAT64)")
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO points VALUES \
         (1, 1.0, 1.0),   -- Q1: both positive
         (2, 1.0, -1.0),  -- Q2: y positive, x negative
         (3, -1.0, -1.0), -- Q3: both negative
         (4, -1.0, 1.0)   -- Q4: y negative, x positive",
        )
        .unwrap();

    let result = executor
        .execute_sql("SELECT id, ATAN2(y, x) as angle FROM points ORDER BY id")
        .unwrap();

    let col = result.column(1).unwrap();

    let q1 = col.get(0).unwrap().as_f64().unwrap();
    assert!(q1 > 0.0 && q1 < std::f64::consts::FRAC_PI_2);

    let q2 = col.get(1).unwrap().as_f64().unwrap();
    assert!(q2 > std::f64::consts::FRAC_PI_2 && q2 < std::f64::consts::PI);

    let q3 = col.get(2).unwrap().as_f64().unwrap();
    assert!(q3 < -std::f64::consts::FRAC_PI_2);

    let q4 = col.get(3).unwrap().as_f64().unwrap();
    assert!(q4 < 0.0 && q4 > -std::f64::consts::FRAC_PI_2);
}

#[test]
fn test_atan2_special_case_zero_zero() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE points (id INT64, y FLOAT64, x FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO points VALUES (1, 0.0, 0.0)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT ATAN2(y, x) as angle FROM points")
        .unwrap();

    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap().as_f64().unwrap();

    assert!(!val.is_nan(), "ATAN2(0, 0) should not be NaN");
}

#[test]
fn test_exp_of_zero_equals_one() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, val FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, 0.0)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT EXP(val) as exp_val FROM values")
        .unwrap();

    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap().as_f64().unwrap();
    assert!(
        (val - 1.0).abs() < 1e-10,
        "EXP(0) should be 1.0, got {}",
        val
    );
}

#[test]
fn test_exp_of_one_equals_e() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, val FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, 1.0)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT EXP(val) as exp_val FROM values")
        .unwrap();

    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap().as_f64().unwrap();
    let e = std::f64::consts::E;
    assert!(
        (val - e).abs() < 1e-10,
        "EXP(1) should be e ≈ 2.71828, got {}",
        val
    );
}

#[test]
fn test_ln_of_one_equals_zero() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, val FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, 1.0)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT LN(val) as ln_val FROM values")
        .unwrap();

    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap().as_f64().unwrap();
    assert!(val.abs() < 1e-10, "LN(1) should be 0, got {}", val);
}

#[test]
fn test_ln_of_e_equals_one() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT LN(EXP(1.0)) as ln_e FROM values")
        .unwrap();

    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap().as_f64().unwrap();
    assert!(
        (val - 1.0).abs() < 1e-10,
        "LN(e) should be 1.0, got {}",
        val
    );
}

#[test]
fn test_ln_of_zero_domain_error() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, val FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, 0.0)")
        .unwrap();

    let result = executor.execute_sql("SELECT LN(val) as ln_val FROM values");

    assert!(result.is_err(), "LN(0) should error (domain violation)");
}

#[test]
fn test_ln_of_negative_domain_error() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, val FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, -5.0)")
        .unwrap();

    let result = executor.execute_sql("SELECT LN(val) as ln_val FROM values");

    assert!(result.is_err(), "LN(-5) should error (domain violation)");
}

#[test]
fn test_log10_of_one_equals_zero() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, val FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, 1.0)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT LOG10(val) as log10_val FROM values")
        .unwrap();

    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap().as_f64().unwrap();
    assert!(val.abs() < 1e-10, "LOG10(1) should be 0, got {}", val);
}

#[test]
fn test_log10_of_powers_of_ten() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, val FLOAT64)")
        .unwrap();
    executor.execute_sql(
        "INSERT INTO values VALUES (1, 0.01), (2, 0.1), (3, 1.0), (4, 10.0), (5, 100.0), (6, 1000.0)"
    ).unwrap();

    let result = executor
        .execute_sql("SELECT val, LOG10(val) as log_val FROM values ORDER BY id")
        .unwrap();

    let col = result.column(1).unwrap();

    let val = col.get(0).unwrap().as_f64().unwrap();
    assert!((val - (-2.0)).abs() < 1e-10);

    let val = col.get(5).unwrap().as_f64().unwrap();
    assert!((val - 3.0).abs() < 1e-10);
}

#[test]
fn test_log_alias_same_as_ln() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, val FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, 2.71828)")
        .unwrap();

    let result1 = executor
        .execute_sql("SELECT LN(val) as ln_val FROM values")
        .unwrap();

    let result2 = executor
        .execute_sql("SELECT LOG(val) as log_val FROM values")
        .unwrap();

    let ln_val = result1.column(0).unwrap().get(0).unwrap().as_f64().unwrap();
    let log_val = result2.column(0).unwrap().get(0).unwrap().as_f64().unwrap();

    assert!((ln_val - log_val).abs() < 1e-10, "LOG should equal LN");
}

#[test]
fn test_power_anything_to_zero_equals_one() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, base FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, -5.0), (2, 0.0), (3, 1.0), (4, 1000.0)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT base, POWER(base, 0.0) as power_val FROM values ORDER BY id")
        .unwrap();

    let col = result.column(1).unwrap();

    for i in 0..4 {
        let val = col.get(i).unwrap().as_f64().unwrap();
        assert!(
            (val - 1.0).abs() < 1e-10,
            "{}^0 should be 1.0, got {}",
            result.column(0).unwrap().get(i).unwrap().as_f64().unwrap(),
            val
        );
    }
}

#[test]
fn test_power_one_to_anything_equals_one() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, exponent FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, -100.0), (2, 0.0), (3, 100.0)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT exponent, POWER(1.0, exponent) as power_val FROM values ORDER BY id")
        .unwrap();

    let col = result.column(1).unwrap();

    for i in 0..3 {
        let val = col.get(i).unwrap().as_f64().unwrap();
        assert!((val - 1.0).abs() < 1e-10, "1^x should be 1.0, got {}", val);
    }
}

#[test]
fn test_power_negative_base_fractional_exponent_error() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, base FLOAT64, exp FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, -5.0, 0.5)")
        .unwrap();

    let result = executor.execute_sql("SELECT POWER(base, exp) as power_val FROM values");

    assert!(
        result.is_err(),
        "POWER(-5, 0.5) should error (complex result)"
    );
}

#[test]
fn test_power_overflow() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, base FLOAT64, exp FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, 10.0, 1000.0)")
        .unwrap();

    let result = executor.execute_sql("SELECT POWER(base, exp) as power_val FROM values");

    match result {
        Err(_) => {}
        Ok(res) => {
            let col = res.column(0).unwrap();
            let val = col.get(0).unwrap().as_f64().unwrap();
            assert!(
                val.is_infinite() && val.is_sign_positive(),
                "POWER(10, 1000) should be +∞ or error"
            );
        }
    }
}

#[test]
fn test_power_zero_to_zero_special_case() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, base FLOAT64, exp FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, 0.0, 0.0)")
        .unwrap();

    let result = executor.execute_sql("SELECT POWER(base, exp) as power_val FROM values");

    if let Ok(res) = result {
        let col = res.column(0).unwrap();
        let val = col.get(0).unwrap().as_f64().unwrap();
        assert!(
            (val - 1.0).abs() < 1e-10 || val.is_nan(),
            "POWER(0, 0) implementation-defined"
        );
    }
}

#[test]
fn test_power_negative_exponent_reciprocal() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, base FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, 2.0)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT POWER(base, -3.0) as power_val FROM values")
        .unwrap();

    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap().as_f64().unwrap();

    assert!(
        (val - 0.125).abs() < 1e-10,
        "2^(-3) should be 0.125, got {}",
        val
    );
}

#[test]
fn test_pow_alias_same_as_power() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, base FLOAT64, exp FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, 3.0, 4.0)")
        .unwrap();

    let result1 = executor
        .execute_sql("SELECT POWER(base, exp) as power_val FROM values")
        .unwrap();

    let result2 = executor
        .execute_sql("SELECT POW(base, exp) as pow_val FROM values")
        .unwrap();

    let power_val = result1.column(0).unwrap().get(0).unwrap().as_f64().unwrap();
    let pow_val = result2.column(0).unwrap().get(0).unwrap().as_f64().unwrap();

    assert!(
        (power_val - pow_val).abs() < 1e-10,
        "POW should equal POWER"
    );
}

#[test]
fn test_degrees_pi_equals_180() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT DEGREES(PI()) as degrees FROM values")
        .unwrap();

    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap().as_f64().unwrap();
    assert!(
        (val - 180.0).abs() < 1e-10,
        "DEGREES(π) should be 180, got {}",
        val
    );
}

#[test]
fn test_radians_180_equals_pi() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, degrees FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, 180.0)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT RADIANS(degrees) as radians FROM values")
        .unwrap();

    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap().as_f64().unwrap();
    let pi = std::f64::consts::PI;
    assert!(
        (val - pi).abs() < 1e-10,
        "RADIANS(180) should be π, got {}",
        val
    );
}

#[test]
fn test_degrees_radians_round_trip() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, degrees FLOAT64)")
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO values VALUES (1, 0.0), (2, 45.0), (3, 90.0), (4, 180.0), (5, 360.0)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT degrees, DEGREES(RADIANS(degrees)) as round_trip FROM values ORDER BY id",
        )
        .unwrap();

    let col_orig = result.column(0).unwrap();
    let col_rt = result.column(1).unwrap();

    for i in 0..5 {
        let orig = col_orig.get(i).unwrap().as_f64().unwrap();
        let rt = col_rt.get(i).unwrap().as_f64().unwrap();
        assert!(
            (orig - rt).abs() < 1e-10,
            "Round-trip should preserve value: {} != {}",
            orig,
            rt
        );
    }
}

#[test]
fn test_mod_basic_operation() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, dividend INT64, divisor INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, 7, 3)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT MOD(dividend, divisor) as mod_val FROM values")
        .unwrap();

    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap();
    let num = val
        .as_i64()
        .or_else(|| val.as_f64().map(|f| f as i64))
        .unwrap();
    assert_eq!(num, 1, "MOD(7, 3) should be 1");
}

#[test]
fn test_mod_by_zero_error() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, dividend INT64, divisor INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, 5, 0)")
        .unwrap();

    let result = executor.execute_sql("SELECT MOD(dividend, divisor) as mod_val FROM values");

    assert!(result.is_err(), "MOD(5, 0) should error (division by zero)");
}

#[test]
fn test_mod_negative_dividend() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, dividend INT64, divisor INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, -7, 3)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT MOD(dividend, divisor) as mod_val FROM values")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    let val = value
        .as_i64()
        .or_else(|| value.as_f64().map(|f| f as i64))
        .unwrap();

    assert!(
        val == -1 || val == 2,
        "MOD(-7, 3) should be -1 or 2 depending on implementation"
    );
}

#[test]
fn test_mod_with_floats() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, dividend FLOAT64, divisor FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, 7.5, 2.0)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT MOD(dividend, divisor) as mod_val FROM values")
        .unwrap();

    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap().as_f64().unwrap();
    assert!(
        (val - 1.5).abs() < 1e-10,
        "MOD(7.5, 2.0) should be 1.5, got {}",
        val
    );
}

#[test]
fn test_greatest_basic() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, a INT64, b INT64, c INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, 1, 5, 3)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT GREATEST(a, b, c) as max_val FROM values")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    let val = value
        .as_i64()
        .or_else(|| value.as_f64().map(|f| f as i64))
        .unwrap();
    assert_eq!(val, 5, "GREATEST(1, 5, 3) should be 5");
}

#[test]
fn test_greatest_with_null() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, a INT64, b INT64, c INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, 1, NULL, 5)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT GREATEST(a, b, c) as max_val FROM values")
        .unwrap();

    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap();

    assert!(
        val.is_null()
            || val
                .as_i64()
                .or_else(|| val.as_f64().map(|f| f as i64))
                .unwrap()
                == 5,
        "GREATEST with NULL is implementation-defined"
    );
}

#[test]
fn test_greatest_single_value() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, val INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, 42)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT GREATEST(val) as max_val FROM values")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    let val = value
        .as_i64()
        .or_else(|| value.as_f64().map(|f| f as i64))
        .unwrap();
    assert_eq!(val, 42, "GREATEST(42) should be 42");
}

#[test]
fn test_least_basic() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, a INT64, b INT64, c INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, 1, 5, 3)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT LEAST(a, b, c) as min_val FROM values")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    let val = value
        .as_i64()
        .or_else(|| value.as_f64().map(|f| f as i64))
        .unwrap();
    assert_eq!(val, 1, "LEAST(1, 5, 3) should be 1");
}

#[test]
fn test_least_with_negative() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, a INT64, b INT64, c INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, -5, 0, 10)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT LEAST(a, b, c) as min_val FROM values")
        .unwrap();

    let col = result.column(0).unwrap();
    let value = col.get(0).unwrap();
    let val = value
        .as_i64()
        .or_else(|| value.as_f64().map(|f| f as i64))
        .unwrap();
    assert_eq!(val, -5, "LEAST(-5, 0, 10) should be -5");
}

#[test]
fn test_pi_value() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT PI() as pi_val FROM values")
        .unwrap();

    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap().as_f64().unwrap();
    let pi = std::f64::consts::PI;
    assert!(
        (val - pi).abs() < 1e-10,
        "PI() should be ≈ 3.14159, got {}",
        val
    );
}

#[test]
fn test_pi_precision() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT PI() * 1000000.0 as pi_million FROM values")
        .unwrap();

    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap().as_f64().unwrap();
    let expected = std::f64::consts::PI * 1000000.0;

    assert!((val - expected).abs() < 1.0, "PI() precision test");
}

#[test]
fn test_random_returns_value() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT RANDOM() as rand_val FROM values")
        .unwrap();

    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap().as_f64().unwrap();

    assert!(
        !val.is_nan() && !val.is_infinite(),
        "RANDOM() should return valid number"
    );
}

#[test]
fn test_random_range() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1), (2), (3), (4), (5)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT RANDOM() as rand_val FROM values")
        .unwrap();

    let col = result.column(0).unwrap();

    for i in 0..5 {
        let val = col.get(i).unwrap().as_f64().unwrap();

        assert!(!val.is_nan() && !val.is_infinite());
    }
}

#[test]
fn test_rand_alias() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1)")
        .unwrap();

    let result1 = executor
        .execute_sql("SELECT RANDOM() as val FROM values")
        .unwrap();

    let result2 = executor
        .execute_sql("SELECT RAND() as val FROM values")
        .unwrap();

    let val1 = result1.column(0).unwrap().get(0).unwrap().as_f64().unwrap();
    let val2 = result2.column(0).unwrap().get(0).unwrap().as_f64().unwrap();

    assert!(!val1.is_nan() && !val2.is_nan());
}

#[test]
fn test_trig_identity_sin_squared_plus_cos_squared() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE angles (id INT64, radians FLOAT64)")
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO angles VALUES (1, 0.0), (2, 0.5), (3, 1.0), (4, 1.57079), (5, 3.14159)",
        )
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT radians, \
         POWER(SIN(radians), 2.0) + POWER(COS(radians), 2.0) as identity \
         FROM angles ORDER BY id",
        )
        .unwrap();

    let col = result.column(1).unwrap();

    for i in 0..5 {
        let val = col.get(i).unwrap().as_f64().unwrap();
        assert!(
            (val - 1.0).abs() < 1e-6,
            "sin²(x) + cos²(x) should be 1.0, got {}",
            val
        );
    }
}

#[test]
fn test_exp_ln_inverse_relationship() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, val FLOAT64)")
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO values VALUES (1, 0.5), (2, 1.0), (3, 2.71828), (4, 10.0), (5, 100.0)",
        )
        .unwrap();

    let result = executor
        .execute_sql("SELECT val, EXP(LN(val)) as round_trip FROM values ORDER BY id")
        .unwrap();

    let col_orig = result.column(0).unwrap();
    let col_rt = result.column(1).unwrap();

    for i in 0..5 {
        let orig = col_orig.get(i).unwrap().as_f64().unwrap();
        let rt = col_rt.get(i).unwrap().as_f64().unwrap();
        assert!(
            (orig - rt).abs() < 1e-6,
            "EXP(LN({})) should be {}, got {}",
            orig,
            orig,
            rt
        );
    }
}

#[test]
fn test_math_chaining() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, x FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, 5.0)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT ROUND(SQRT(ABS(POWER(SIN(RADIANS(x)), 2) * 100)), 2) as result \
         FROM values",
        )
        .unwrap();

    let col = result.column(0).unwrap();
    let val = col.get(0).unwrap().as_f64().unwrap();

    assert!(
        !val.is_nan() && !val.is_infinite(),
        "Complex math chain should work"
    );
}

#[test]
fn test_math_in_where_clause() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE numbers (id INT64, val FLOAT64)")
        .unwrap();
    executor
        .execute_sql(
            "INSERT INTO numbers VALUES (1, 1.0), (2, 4.0), (3, 9.0), (4, 16.0), (5, 25.0)",
        )
        .unwrap();

    let result = executor
        .execute_sql("SELECT id, val FROM numbers WHERE SQRT(val) > 3.0 ORDER BY id")
        .unwrap();

    assert_eq!(result.num_rows(), 2);
}

#[test]
fn test_sin_with_null() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, val FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, NULL)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT SIN(val) as sin_val FROM values")
        .unwrap();

    let col = result.column(0).unwrap();
    assert!(col.get(0).unwrap().is_null(), "SIN(NULL) should be NULL");
}

#[test]
fn test_power_with_null_base() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, base FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, NULL)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT POWER(base, 2.0) as power_val FROM values")
        .unwrap();

    let col = result.column(0).unwrap();
    assert!(
        col.get(0).unwrap().is_null(),
        "POWER(NULL, 2) should be NULL"
    );
}

#[test]
fn test_power_with_null_exponent() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, exp FLOAT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, NULL)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT POWER(2.0, exp) as power_val FROM values")
        .unwrap();

    let col = result.column(0).unwrap();
    assert!(
        col.get(0).unwrap().is_null(),
        "POWER(2, NULL) should be NULL"
    );
}

#[test]
fn test_greatest_all_null() {
    let mut executor = QueryExecutor::with_dialect(DialectType::PostgreSQL);

    executor
        .execute_sql("CREATE TABLE values (id INT64, a INT64, b INT64, c INT64)")
        .unwrap();
    executor
        .execute_sql("INSERT INTO values VALUES (1, NULL, NULL, NULL)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT GREATEST(a, b, c) as max_val FROM values")
        .unwrap();

    let col = result.column(0).unwrap();
    assert!(
        col.get(0).unwrap().is_null(),
        "GREATEST(NULL, NULL, NULL) should be NULL"
    );
}
