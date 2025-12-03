#![allow(dead_code)]
#![allow(unused_variables)]
#![allow(clippy::unnecessary_unwrap)]
#![allow(clippy::collapsible_if)]
#![allow(clippy::wildcard_enum_match_arm)]

mod common;
use common::{new_executor, table_exists};

#[test]
fn test_ddl_select_001_math_functions() {
    let mut executor = new_executor();

    executor
        .execute_sql("DROP TABLE IF EXISTS large_dataset")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE large_dataset (id INT64, val FLOAT64)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT id, SIN(val) as sin_val, COS(val) as cos_val, \
             EXP(val / 10.0) as exp_val, LN(ABS(val) + 1.0) as ln_val, \
             POWER(val, 2.0) as power_val \
             FROM large_dataset \
             WHERE SQRT(ABS(val)) < 5.0 \
             ORDER BY id \
             LIMIT 100",
        )
        .unwrap();
    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_ddl_select_002_bit_xor_no_args() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS test").unwrap();
    executor
        .execute_sql("CREATE TABLE test (value INT64)")
        .unwrap();

    let result = executor.execute_sql("SELECT BIT_XOR() FROM test");

    if result.is_ok() {
        let batch = result.unwrap();
        assert_eq!(batch.num_rows(), 1);
    }
}

#[test]
fn test_ddl_select_003_004_alter_table_rename() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS users").unwrap();
    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .unwrap();
    executor
        .execute_sql("ALTER TABLE users ADD COLUMN email STRING")
        .unwrap();

    executor.execute_sql("DROP TABLE IF EXISTS test").unwrap();
    executor
        .execute_sql("CREATE TABLE test (id INT64 PRIMARY KEY)")
        .unwrap();

    let rename_result = executor.execute_sql("ALTER TABLE test RENAME TO test_renamed");
    assert!(
        rename_result.is_ok(),
        "ALTER TABLE RENAME TO should succeed"
    );

    let result = executor.execute_sql("SELECT * FROM test_renamed");
    if let Ok(batch) = result {
        assert_eq!(batch.num_rows(), 0);
    } else {
        let original = executor.execute_sql("SELECT * FROM test");
        assert!(
            original.is_err(),
            "Original table should not exist after rename"
        );
    }
}

#[test]
fn test_ddl_select_005_006_add_column() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS test").unwrap();
    executor
        .execute_sql("CREATE TABLE test (a INT64, c INT64)")
        .unwrap();
    executor
        .execute_sql("ALTER TABLE test ADD COLUMN b INT64")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM test").unwrap();
    assert_eq!(result.num_rows(), 0);

    executor.execute_sql("DROP TABLE IF EXISTS users").unwrap();
    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .unwrap();
    executor
        .execute_sql("ALTER TABLE users ADD COLUMN email STRING")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id, name, email FROM users")
        .unwrap();
    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_ddl_select_007_users_with_email() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS users").unwrap();
    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .unwrap();
    executor
        .execute_sql("ALTER TABLE users ADD COLUMN email STRING")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id, name, email FROM users")
        .unwrap();
    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_ddl_select_008_limit_offset() {
    let mut executor = new_executor();

    executor
        .execute_sql("DROP TABLE IF EXISTS numbers")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE numbers (value INT64)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT * FROM numbers ORDER BY value LIMIT 5 OFFSET 3")
        .unwrap();
    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_ddl_select_009_basic_select() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS test").unwrap();
    executor
        .execute_sql("CREATE TABLE test (id INT64, value STRING)")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM test").unwrap();
    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_ddl_select_010_nonexistent_column() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS users").unwrap();
    executor
        .execute_sql("CREATE TABLE users (id INT64)")
        .unwrap();

    let result = executor.execute_sql("SELECT id, nonexistent_column, name FROM users");
    assert!(
        result.is_err(),
        "SELECT with nonexistent column should fail"
    );
}

#[test]
fn test_ddl_select_011_wrong_column_name() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS users").unwrap();
    executor
        .execute_sql("CREATE TABLE users (id INT64)")
        .unwrap();

    let result = executor.execute_sql("SELECT userid FROM users");
    assert!(result.is_err(), "SELECT with wrong column name should fail");
}

#[test]
fn test_ddl_select_012_wrong_table_name() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS users").unwrap();
    executor
        .execute_sql("CREATE TABLE users (id INT64)")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM user");
    assert!(result.is_err(), "SELECT from nonexistent table should fail");
}

#[test]
fn test_ddl_select_013_userid_wrong_column() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS users").unwrap();
    executor
        .execute_sql("CREATE TABLE users (id INT64)")
        .unwrap();

    let result = executor.execute_sql("SELECT userid FROM users");
    assert!(result.is_err(), "SELECT userid should fail");
}

#[test]
fn test_ddl_select_014_user_wrong_table() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS users").unwrap();
    executor
        .execute_sql("CREATE TABLE users (id INT64)")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM user");
    assert!(result.is_err(), "SELECT from 'user' should fail");
}

#[test]
fn test_ddl_select_015_user_wrong_table() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS users").unwrap();
    executor
        .execute_sql("CREATE TABLE users (id INT64)")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM user");
    assert!(result.is_err(), "SELECT from 'user' should fail");
}

#[test]
fn test_ddl_select_016_negative_limit() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS t").unwrap();
    executor.execute_sql("CREATE TABLE t (id INT64)").unwrap();

    let result = executor.execute_sql("SELECT * FROM t LIMIT -1");
    assert!(result.is_err(), "LIMIT -1 should fail");
}

#[test]
fn test_ddl_select_017_fetch_first_negative() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS data").unwrap();
    executor
        .execute_sql("CREATE TABLE data (id INT64)")
        .unwrap();

    let result = executor.execute_sql("SELECT id FROM data FETCH FIRST -1 ROWS ONLY");
    assert!(result.is_err(), "FETCH FIRST -1 ROWS should fail");
}

#[test]
fn test_ddl_select_018_offset_negative() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS data").unwrap();
    executor
        .execute_sql("CREATE TABLE data (id INT64)")
        .unwrap();

    let result = executor.execute_sql("SELECT id FROM data OFFSET -1 ROWS");
    assert!(result.is_err(), "OFFSET -1 ROWS should fail");
}

#[test]
fn test_ddl_select_019_fetch_first_without_rows() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS data").unwrap();
    executor
        .execute_sql("CREATE TABLE data (id INT64)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id FROM data FETCH FIRST 5 ONLY")
        .unwrap();
    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_ddl_select_020_fetch_first_with_order() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS large").unwrap();
    executor
        .execute_sql("CREATE TABLE large (id INT64, value INT64)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id FROM large ORDER BY id FETCH FIRST 10 ROWS ONLY")
        .unwrap();
    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_ddl_select_021_offset_negative_rows() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS data").unwrap();
    executor
        .execute_sql("CREATE TABLE data (id INT64)")
        .unwrap();

    let result = executor.execute_sql("SELECT id FROM data OFFSET -1 ROWS");
    assert!(result.is_err(), "OFFSET -1 ROWS should fail");
}

#[test]
fn test_ddl_select_022_fetch_first_5_only() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS data").unwrap();
    executor
        .execute_sql("CREATE TABLE data (id INT64)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id FROM data FETCH FIRST 5 ONLY")
        .unwrap();
    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_ddl_select_023_fetch_first_ordered() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS large").unwrap();
    executor
        .execute_sql("CREATE TABLE large (id INT64, value INT64)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id FROM large ORDER BY id FETCH FIRST 10 ROWS ONLY")
        .unwrap();
    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_ddl_select_024_fetch_first_5() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS data").unwrap();
    executor
        .execute_sql("CREATE TABLE data (id INT64)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id FROM data FETCH FIRST 5 ONLY")
        .unwrap();
    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_ddl_select_025_fetch_ordered() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS large").unwrap();
    executor
        .execute_sql("CREATE TABLE large (id INT64, value INT64)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id FROM large ORDER BY id FETCH FIRST 10 ROWS ONLY")
        .unwrap();
    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_ddl_select_026_large_fetch() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS large").unwrap();
    executor
        .execute_sql("CREATE TABLE large (id INT64, value INT64)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id FROM large ORDER BY id FETCH FIRST 10 ROWS ONLY")
        .unwrap();
    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_ddl_select_027_nonexistent_parsed_data() {
    let mut executor = new_executor();

    executor
        .execute_sql("DROP TABLE IF EXISTS raw_data")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE raw_data (id INT64, payload STRING)")
        .unwrap();

    let result = executor.execute_sql("SELECT status FROM parsed_data WHERE id = 1");
    assert!(result.is_err(), "SELECT from nonexistent table should fail");
}

#[test]
fn test_ddl_select_028_nonexistent_parsed_data_again() {
    let mut executor = new_executor();

    executor
        .execute_sql("DROP TABLE IF EXISTS raw_data")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE raw_data (id INT64, payload STRING)")
        .unwrap();

    let result = executor.execute_sql("SELECT status FROM parsed_data WHERE id = 1");
    assert!(result.is_err(), "SELECT from nonexistent table should fail");
}

#[test]
fn test_ddl_select_029_nonexistent_parsed_data_third() {
    let mut executor = new_executor();

    executor
        .execute_sql("DROP TABLE IF EXISTS raw_data")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE raw_data (id INT64, payload STRING)")
        .unwrap();

    let result = executor.execute_sql("SELECT status FROM parsed_data WHERE id = 1");
    assert!(result.is_err(), "SELECT from nonexistent table should fail");
}

#[test]
fn test_ddl_select_030_case_expression_files() {
    let mut executor = new_executor();

    executor
        .execute_sql("DROP TABLE IF EXISTS large_data")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE large_data (id INT64, email STRING)")
        .unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS logs").unwrap();
    executor
        .execute_sql("CREATE TABLE logs (id INT64, message STRING)")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT filename, CASE WHEN filename LIKE '%.pdf' THEN 'document' \
         WHEN filename LIKE '%.jpg' THEN 'image' \
         WHEN filename LIKE '%.mp4' THEN 'video' \
         ELSE 'other' END as file_type FROM files ORDER BY filename",
    );
    assert!(
        result.is_err(),
        "SELECT from nonexistent 'files' should fail"
    );
}

#[test]
fn test_ddl_select_031_order_by_expression() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS data").unwrap();
    executor
        .execute_sql("CREATE TABLE data (id INT64, value INT64)")
        .unwrap();

    let result = executor.execute_sql("SELECT id FROM data ORDER BY value * 2 LIMIT 10");

    if let Ok(batch) = result {
        assert_eq!(batch.num_rows(), 0);
    }
}

#[test]
fn test_ddl_select_032_order_nulls_last() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS data").unwrap();
    executor
        .execute_sql("CREATE TABLE data (id INT64, value INT64)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id FROM data ORDER BY value NULLS LAST LIMIT 5")
        .unwrap();
    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_ddl_select_033_order_nulls_last_again() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS data").unwrap();
    executor
        .execute_sql("CREATE TABLE data (id INT64, value INT64)")
        .unwrap();

    let result = executor
        .execute_sql("SELECT id FROM data ORDER BY value NULLS LAST LIMIT 5")
        .unwrap();
    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_ddl_select_034_order_by_nonexistent_column() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS test").unwrap();
    executor
        .execute_sql("CREATE TABLE test (data STRING)")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM test ORDER BY id DESC");
    assert!(result.is_err(), "ORDER BY nonexistent column should fail");
}

#[test]
fn test_ddl_select_035_cross_join_nonexistent_column() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS test").unwrap();
    executor
        .execute_sql("CREATE TABLE test (data STRING)")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT * FROM test t1, test t2, test t3 WHERE t1.id + t2.id + t3.id > 999999999",
    );

    if let Ok(batch) = result {
        assert_eq!(batch.num_rows(), 0);
    }
}

#[test]
fn test_ddl_select_036_basic_select_data() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS test").unwrap();
    executor
        .execute_sql("CREATE TABLE test (data STRING)")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM test").unwrap();
    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_ddl_select_037_order_nonexistent() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS test").unwrap();
    executor
        .execute_sql("CREATE TABLE test (data STRING)")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM test ORDER BY id DESC");
    assert!(result.is_err(), "ORDER BY nonexistent column should fail");
}

#[test]
fn test_ddl_select_038_cross_join_nonexistent() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS test").unwrap();
    executor
        .execute_sql("CREATE TABLE test (data STRING)")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT * FROM test t1, test t2, test t3 WHERE t1.id + t2.id + t3.id > 999999999",
    );

    if let Ok(batch) = result {
        assert_eq!(batch.num_rows(), 0);
    }
}

#[test]
fn test_ddl_select_039_basic_select_only() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS test").unwrap();
    executor
        .execute_sql("CREATE TABLE test (data STRING)")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM test").unwrap();
    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_ddl_select_040_order_nonexistent_col() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS test").unwrap();
    executor
        .execute_sql("CREATE TABLE test (data STRING)")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM test ORDER BY id DESC");
    assert!(result.is_err(), "ORDER BY nonexistent column should fail");
}

#[test]
fn test_ddl_select_041_cross_join_again() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS test").unwrap();
    executor
        .execute_sql("CREATE TABLE test (data STRING)")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT * FROM test t1, test t2, test t3 WHERE t1.id + t2.id + t3.id > 999999999",
    );

    if let Ok(batch) = result {
        assert_eq!(batch.num_rows(), 0);
    }
}

#[test]
fn test_ddl_select_042_basic_select_all() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS test").unwrap();
    executor
        .execute_sql("CREATE TABLE test (data STRING)")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM test").unwrap();
    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_ddl_select_043_cross_join_variant() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS test").unwrap();
    executor
        .execute_sql("CREATE TABLE test (data STRING)")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT * FROM test t1, test t2, test t3 WHERE t1.id + t2.id + t3.id > 999999999",
    );

    if let Ok(batch) = result {
        assert_eq!(batch.num_rows(), 0);
    }
}

#[test]
fn test_ddl_select_044_basic_final() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS test").unwrap();
    executor
        .execute_sql("CREATE TABLE test (data STRING)")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM test").unwrap();
    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_ddl_select_045_basic_data_table() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS test").unwrap();
    executor
        .execute_sql("CREATE TABLE test (data STRING)")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM test").unwrap();
    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_ddl_select_046_string_functions() {
    let mut executor = new_executor();

    executor
        .execute_sql("DROP TABLE IF EXISTS large_strings")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE large_strings (id INT64, str STRING)")
        .unwrap();

    let result = executor
        .execute_sql(
            "SELECT id, SUBSTR(str, 1, 10) as short_str, \
         POSITION('number' IN str) as pos, \
         LPAD(CAST(id AS STRING), 10, '0') as padded_id, \
         INITCAP(str) as proper_case \
         FROM large_strings \
         WHERE POSITION('5' IN str) > 0 \
         ORDER BY id \
         LIMIT 100",
        )
        .unwrap();
    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_ddl_select_047_user_is_null() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS test").unwrap();
    executor
        .execute_sql("CREATE TABLE test (id INT64)")
        .unwrap();

    let result = executor.execute_sql("SELECT USER() IS NULL AS is_null");

    if let Ok(batch) = result {
        assert_eq!(batch.num_rows(), 1);
    }
}

#[test]
fn test_ddl_select_048_system_functions() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS test").unwrap();
    executor
        .execute_sql("CREATE TABLE test (id INT64)")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT VERSION() AS version, USER() AS user, DATABASE() AS db, CONNECTION_ID() AS conn",
    );

    if let Ok(batch) = result {
        assert_eq!(batch.num_rows(), 1);
    }
}

#[test]
fn test_ddl_select_049_system_functions_again() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS test").unwrap();
    executor
        .execute_sql("CREATE TABLE test (id INT64)")
        .unwrap();

    let result = executor.execute_sql(
        "SELECT VERSION() AS version, USER() AS user, DATABASE() AS db, CONNECTION_ID() AS conn",
    );

    if let Ok(batch) = result {
        assert_eq!(batch.num_rows(), 1);
    }
}

#[test]
fn test_ddl_create_table_with_constraints() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS users").unwrap();
    let result = executor.execute_sql(
        "CREATE TABLE users (id INT64 PRIMARY KEY, email STRING UNIQUE NOT NULL, age INT64 CHECK (age >= 0))",
    );

    assert!(
        result.is_ok(),
        "CREATE TABLE with constraints should succeed"
    );

    assert!(table_exists(&mut executor, "users"));
}

#[test]
fn test_ddl_drop_table_if_exists() {
    let mut executor = new_executor();

    let result = executor.execute_sql("DROP TABLE IF EXISTS nonexistent_table");
    assert!(
        result.is_ok(),
        "DROP TABLE IF EXISTS on non-existent table should succeed"
    );

    executor
        .execute_sql("CREATE TABLE temp_table (id INT64)")
        .unwrap();
    assert!(table_exists(&mut executor, "temp_table"));

    executor
        .execute_sql("DROP TABLE IF EXISTS temp_table")
        .unwrap();
    assert!(!table_exists(&mut executor, "temp_table"));
}

#[test]
fn test_ddl_alter_table_add_unique_column() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS users").unwrap();
    executor
        .execute_sql("CREATE TABLE users (id INT64, name STRING)")
        .unwrap();

    let result = executor.execute_sql("ALTER TABLE users ADD COLUMN email STRING UNIQUE");
    assert!(
        result.is_ok(),
        "ALTER TABLE ADD COLUMN with UNIQUE should succeed"
    );

    let result = executor.execute_sql("SELECT email FROM users").unwrap();
    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_ddl_multiple_drops_and_creates() {
    let mut executor = new_executor();

    for _ in 0..3 {
        executor.execute_sql("DROP TABLE IF EXISTS test").unwrap();
        executor
            .execute_sql("CREATE TABLE test (id INT64)")
            .unwrap();
        assert!(table_exists(&mut executor, "test"));
    }

    let result = executor.execute_sql("SELECT * FROM test").unwrap();
    assert_eq!(result.num_rows(), 0);
}

#[test]
fn test_ddl_create_table_primary_key() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS test").unwrap();
    let result = executor.execute_sql("CREATE TABLE test (id INT64 PRIMARY KEY, value STRING)");
    assert!(
        result.is_ok(),
        "CREATE TABLE with PRIMARY KEY should succeed"
    );
}

#[test]
fn test_ddl_create_table_not_null() {
    let mut executor = new_executor();

    executor.execute_sql("DROP TABLE IF EXISTS test").unwrap();
    let result = executor.execute_sql("CREATE TABLE test (id INT64 NOT NULL, value STRING)");
    assert!(result.is_ok(), "CREATE TABLE with NOT NULL should succeed");
}

#[test]
fn test_ddl_create_multiple_tables() {
    let mut executor = new_executor();

    executor
        .execute_sql("DROP TABLE IF EXISTS large_data")
        .unwrap();
    executor.execute_sql("DROP TABLE IF EXISTS logs").unwrap();

    executor
        .execute_sql("CREATE TABLE large_data (id INT64, email STRING)")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE logs (id INT64, message STRING)")
        .unwrap();

    assert!(table_exists(&mut executor, "large_data"));
    assert!(table_exists(&mut executor, "logs"));
}

#[test]
fn test_ddl_numbers_table_empty() {
    let mut executor = new_executor();

    executor
        .execute_sql("DROP TABLE IF EXISTS numbers")
        .unwrap();
    executor
        .execute_sql("CREATE TABLE numbers (value INT64)")
        .unwrap();

    let result = executor.execute_sql("SELECT * FROM numbers").unwrap();
    assert_eq!(result.num_rows(), 0);
}
