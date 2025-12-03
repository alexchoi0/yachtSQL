-- Tuple IN Predicate - SQL:2023 Compliance Suite
-- Description: Extracted SQL scenarios covering Feature F312 (Tuple IN)
-- PostgreSQL: Pending core implementation
-- BigQuery: Pending adaptor normalization
-- SQL Standard: SQL:2023 Feature F312
-- Notes: SQL:2023 core (normalised for PostgreSQL / BigQuery adaptors)

-- ---------------------------------------------------------------------------
-- Source ID: test_tuple_in_int64_vs_float64_coercion
-- **Edge Case:** Tuple IN where left side is INT64 and right side is FLOAT64
-- **SQL:2023:** Section 9.5 - numeric type precedence rules

CREATE TABLE int_table (id INT64, value INT64);

INSERT INTO int_table VALUES (1, 100), (2, 200);

CREATE TABLE float_table (id INT64, value FLOAT64);

INSERT INTO float_table VALUES (1, 100.0), (3, 300.0);

-- Tag: operators_tuple_in_predicate_comprehensive_test_select_001
SELECT id, value FROM int_table
         WHERE (id, value) IN (SELECT id, value FROM float_table)
         ORDER BY id;

-- ---------------------------------------------------------------------------
-- Source ID: test_tuple_in_float64_precision_loss
-- **Corner Case:** FLOAT64 values that cannot be exactly represented
-- **Challenge:** 0.1 + 0.2 ≠ 0.3 in floating point

CREATE TABLE precise (val FLOAT64);

INSERT INTO precise VALUES (0.3);

-- Tag: operators_tuple_in_predicate_comprehensive_test_select_002
SELECT val FROM precise WHERE (val,) IN (SELECT 0.1 + 0.2);

-- ---------------------------------------------------------------------------
-- Source ID: test_tuple_in_int64_overflow_to_float64
-- **Edge Case:** INT64 value near max that loses precision when coerced to FLOAT64
-- **Challenge:** FLOAT64 has only 53 bits of precision, INT64 has 64 bits

CREATE TABLE big_ints (val INT64);

INSERT INTO big_ints VALUES (9007199254740993);

CREATE TABLE floats (val FLOAT64);

INSERT INTO floats VALUES (9007199254740993.0);

-- Tag: operators_tuple_in_predicate_comprehensive_test_select_003
SELECT val FROM big_ints WHERE (val,) IN (SELECT val FROM floats);

-- ---------------------------------------------------------------------------
-- Source ID: test_tuple_in_null_first_component
-- **Edge Case:** NULL in first component of tuple
-- **Three-Valued Logic:**
-- - If (NULL, x) matches any (NULL, x) → NULL (not TRUE!)
-- - If no match exists → FALSE
-- **SQL:2023:** NULL = NULL is UNKNOWN, not TRUE

CREATE TABLE left_nulls (a INT64, b INT64);

INSERT INTO left_nulls VALUES (NULL, 1), (2, 2);

CREATE TABLE right_nulls (a INT64, b INT64);

INSERT INTO right_nulls VALUES (NULL, 1), (3, 3);

-- Tag: operators_tuple_in_predicate_comprehensive_test_select_004
SELECT a, b FROM left_nulls
         WHERE (a, b) IN (SELECT a, b FROM right_nulls)
         ORDER BY a;

-- ---------------------------------------------------------------------------
-- Source ID: test_tuple_in_null_middle_component
-- **Edge Case:** NULL in middle component of 3-tuple
-- **Challenge:** (1, NULL, 3) compared with (1, 2, 3) and (1, NULL, 3)

CREATE TABLE three_cols (a INT64, b INT64, c INT64);

INSERT INTO three_cols VALUES
        (1, NULL, 3),  -- Will compare with set below
        (4, 5, 6)      -- No match;

CREATE TABLE ref_three (a INT64, b INT64, c INT64);

INSERT INTO ref_three VALUES
        (1, 2, 3),      -- Doesn't match (1, NULL, 3) due to NULL
        (1, NULL, 3),   -- NULL = NULL is UNKNOWN
        (4, 5, 6)       -- Exact match for second row;

-- Tag: operators_tuple_in_predicate_comprehensive_test_select_005
SELECT a, b, c FROM three_cols
         WHERE (a, b, c) IN (SELECT a, b, c FROM ref_three)
         ORDER BY a;

-- ---------------------------------------------------------------------------
-- Source ID: test_tuple_in_all_nulls
-- **Boundary Case:** Tuple with all NULL components
-- **Rationale:** Cannot match anything due to NULL comparison semantics

CREATE TABLE all_nulls (a INT64, b INT64);

INSERT INTO all_nulls VALUES (NULL, NULL), (1, 2);

-- Tag: operators_tuple_in_predicate_comprehensive_test_select_006
SELECT a, b FROM all_nulls
         WHERE (a, b) IN ((NULL, NULL), (1, 2))
         ORDER BY a;

-- ---------------------------------------------------------------------------
-- Source ID: test_tuple_not_in_with_null
-- **Non-Obvious Case:** NOT IN with NULL in the set
-- **Critical:** (1, 2) NOT IN ((3, 4), (NULL, 5)) → NULL, not TRUE!
-- **Reason:** If (1, 2) might equal (NULL, 5), we can't say it's NOT IN
-- **SQL:2023:** NOT UNKNOWN = UNKNOWN (not TRUE)

CREATE TABLE test_not_in (a INT64, b INT64);

INSERT INTO test_not_in VALUES (1, 2), (3, 4);

CREATE TABLE set_with_null (a INT64, b INT64);

INSERT INTO set_with_null VALUES (3, 4), (NULL, 5);

-- Tag: operators_tuple_in_predicate_comprehensive_test_select_007
SELECT a, b FROM test_not_in
         WHERE (a, b) NOT IN (SELECT a, b FROM set_with_null)
         ORDER BY a;

-- ---------------------------------------------------------------------------
-- Source ID: test_tuple_in_empty_subquery
-- **Edge Case:** Subquery returns no rows

CREATE TABLE data (a INT64, b INT64);

INSERT INTO data VALUES (1, 2), (3, 4);

CREATE TABLE empty_set (a INT64, b INT64);

-- Tag: operators_tuple_in_predicate_comprehensive_test_select_008
SELECT a, b FROM data
         WHERE (a, b) IN (SELECT a, b FROM empty_set);

-- ---------------------------------------------------------------------------
-- Source ID: test_tuple_in_single_element
-- **Sanity Check:** Single tuple in IN list

CREATE TABLE data (a INT64, b INT64);

INSERT INTO data VALUES (1, 2), (3, 4), (5, 6);

-- Tag: operators_tuple_in_predicate_comprehensive_test_select_009
SELECT a, b FROM data WHERE (a, b) IN ((3, 4));

-- ---------------------------------------------------------------------------
-- Source ID: test_tuple_in_arity_mismatch_2vs3
-- **Error Case:** Left tuple has 2 columns, right tuple has 3

CREATE TABLE two_cols (a INT64, b INT64);

INSERT INTO two_cols VALUES (1, 2);

CREATE TABLE three_cols (a INT64, b INT64, c INT64);

INSERT INTO three_cols VALUES (1, 2, 3);

-- Tag: operators_tuple_in_predicate_comprehensive_test_select_010
SELECT a, b FROM two_cols WHERE (a, b) IN (SELECT a, b, c FROM three_cols);

-- ---------------------------------------------------------------------------
-- Source ID: test_tuple_in_arity_mismatch_1vs2
-- **Error Case:** Single-column tuple compared with two-column tuple

CREATE TABLE one_col (val INT64);

INSERT INTO one_col VALUES (1);

-- Tag: operators_tuple_in_predicate_comprehensive_test_select_011
SELECT val FROM one_col WHERE (val) IN (SELECT 1, 2);

-- ---------------------------------------------------------------------------
-- Source ID: test_tuple_in_arity_validated_at_runtime
-- **Non-Obvious Case:** Arity error that cannot be detected at parse/plan time
-- **Challenge:** Subquery structure determines arity dynamically
-- NOTE: Expected to fail with column count mismatch at runtime.

CREATE TABLE dynamic (col_count INT64);

INSERT INTO dynamic VALUES (1);

-- Tag: operators_tuple_in_predicate_comprehensive_test_select_012
SELECT col_count FROM dynamic WHERE (col_count, col_count) IN (SELECT col_count FROM dynamic);

-- ---------------------------------------------------------------------------
-- Source ID: test_tuple_in_string_numeric_coercion_error
-- **Error Condition:** Cannot coerce STRING to numeric implicitly
-- **SQL:2023:** Implicit coercion only within numeric types
-- NOTE: Expected to fail due to implicit STRING→INT64 coercion error.

CREATE TABLE nums (val INT64);

INSERT INTO nums VALUES (42);

CREATE TABLE strs (val STRING);

INSERT INTO strs VALUES ('42');

-- Tag: operators_tuple_in_predicate_comprehensive_test_select_013
SELECT val FROM nums WHERE (val) IN (SELECT val FROM strs);

-- ---------------------------------------------------------------------------
-- Source ID: test_tuple_in_explicit_cast_string_to_int
-- **Positive Case:** Explicit CAST resolves type mismatch
-- NOTE: Demonstrates explicit CAST to satisfy type rules.

CREATE TABLE nums (val INT64);

INSERT INTO nums VALUES (42), (100);

CREATE TABLE strs (val STRING);

INSERT INTO strs VALUES ('42'), ('99');

-- Tag: operators_tuple_in_predicate_comprehensive_test_select_014
SELECT val FROM nums WHERE (val) IN (SELECT CAST(val AS INT64) FROM strs);

-- ---------------------------------------------------------------------------
-- Source ID: test_tuple_in_cast_left_side
-- **Mixed Types:** Left tuple explicitly cast to FLOAT64
-- NOTE: Demonstrates explicit CAST to satisfy type rules.

CREATE TABLE floats (val FLOAT64);

INSERT INTO floats VALUES (42.7), (100.1);

-- Tag: operators_tuple_in_predicate_comprehensive_test_select_015
SELECT val FROM floats WHERE (CAST(val AS INT64)) IN (42, 99);

-- ---------------------------------------------------------------------------
-- Source ID: test_tuple_in_large_set_performance
-- **Performance Case:** Tuple IN with 1000+ elements
-- **Challenge:** Naive O(N*M) algorithm will be slow
-- NOTE: Test harness inserts 100 probe rows and 1000 build rows via Rust loop (not expanded here).

CREATE TABLE probe (a INT64, b INT64);

CREATE TABLE build (a INT64, b INT64);

-- Tag: operators_tuple_in_predicate_comprehensive_test_select_016
SELECT a, b FROM probe WHERE (a, b) IN (SELECT a, b FROM build);

-- ---------------------------------------------------------------------------
-- Source ID: test_tuple_in_duplicate_values_in_set
-- **Edge Case:** Duplicate values in the IN set
-- **Challenge:** Ensure deduplication happens efficiently

CREATE TABLE data (a INT64, b INT64);

INSERT INTO data VALUES (1, 2), (3, 4);

CREATE TABLE dupe_set (a INT64, b INT64);

INSERT INTO dupe_set VALUES
        (1, 2), (1, 2), (1, 2),  -- Same value 3 times
        (5, 6), (5, 6)            -- Another duplicate;

-- Tag: operators_tuple_in_predicate_comprehensive_test_select_017
SELECT a, b FROM data WHERE (a, b) IN (SELECT a, b FROM dupe_set) ORDER BY a;

-- ---------------------------------------------------------------------------
-- Source ID: test_tuple_in_correlated_subquery
-- **Integration Case:** Tuple IN where subquery references outer query
-- **Challenge:** Correlation requires variable injection into subquery

CREATE TABLE orders (order_id INT64, customer_id INT64, amount INT64);

INSERT INTO orders VALUES
        (1, 100, 500),
        (2, 100, 300),
        (3, 200, 700),
        (4, 200, 200);

CREATE TABLE large_orders (customer_id INT64, threshold INT64);

INSERT INTO large_orders VALUES (100, 400), (200, 600);

-- Tag: operators_tuple_in_predicate_comprehensive_test_select_018
SELECT order_id, customer_id, amount
         FROM orders o
         WHERE (o.customer_id, o.amount) IN (
-- Tag: operators_tuple_in_predicate_comprehensive_test_select_019
             SELECT l.customer_id, l.threshold
             FROM large_orders l
             WHERE l.customer_id = o.customer_id  -- Correlation!
         )
         ORDER BY order_id;

-- ---------------------------------------------------------------------------
-- Source ID: test_tuple_in_nested_correlation
-- **Complex Integration:** Nested correlation with tuple IN
-- **Challenge:** Multiple correlation levels, type coercion across levels

CREATE TABLE departments (dept_id INT64, dept_name STRING);

INSERT INTO departments VALUES (1, 'Engineering'), (2, 'Sales');

CREATE TABLE employees (emp_id INT64, dept_id INT64, salary INT64);

INSERT INTO employees VALUES
        (1, 1, 100000),
        (2, 1, 120000),
        (3, 2, 80000),
        (4, 2, 90000);

CREATE TABLE bonuses (dept_id INT64, min_salary INT64, bonus_pct FLOAT64);

INSERT INTO bonuses VALUES (1, 110000, 0.10), (2, 85000, 0.05);

-- Tag: operators_tuple_in_predicate_comprehensive_test_select_020
SELECT d.dept_name, e.emp_id, e.salary
         FROM departments d
         JOIN employees e ON e.dept_id = d.dept_id
         WHERE (e.dept_id, e.salary) IN (
-- Tag: operators_tuple_in_predicate_comprehensive_test_select_021
             SELECT b.dept_id, b.min_salary
             FROM bonuses b
             WHERE b.dept_id = d.dept_id  -- Outer correlation
               AND b.min_salary <= (
-- Tag: operators_tuple_in_predicate_comprehensive_test_select_022
                   SELECT AVG(e2.salary)
                   FROM employees e2
                   WHERE e2.dept_id = e.dept_id  -- Middle correlation
               )
         )
         ORDER BY d.dept_name, e.emp_id;

-- ---------------------------------------------------------------------------
-- Source ID: test_tuple_in_coercion_with_null
-- **Non-Obvious Case:** Type coercion interacts with NULL
-- **Challenge:** (INT64, NULL) compared with (FLOAT64, INT64)

CREATE TABLE mixed_nulls (a INT64, b INT64);

INSERT INTO mixed_nulls VALUES (1, NULL), (2, 2);

CREATE TABLE float_set (a FLOAT64, b INT64);

INSERT INTO float_set VALUES (1.0, 100), (2.0, 2);

-- Tag: operators_tuple_in_predicate_comprehensive_test_select_023
SELECT a, b FROM mixed_nulls
         WHERE (a, b) IN (SELECT a, b FROM float_set)
         ORDER BY a;

-- ---------------------------------------------------------------------------
-- Source ID: test_tuple_in_literal_list
-- **Baseline Case:** Tuple IN with hardcoded literal list
-- NOTE: Equivalent to row value equality checks.

CREATE TABLE data (a INT64, b INT64);

INSERT INTO data VALUES (1, 2), (3, 4), (5, 6);

-- Tag: operators_tuple_in_predicate_comprehensive_test_select_024
SELECT a, b FROM data WHERE (a, b) IN ((1, 2), (5, 6)) ORDER BY a;

-- ---------------------------------------------------------------------------
-- Source ID: test_tuple_in_mixed_literals_subquery
-- **Corner Case:** IN predicate with both literals and subquery (if syntax allows)
-- **Note:** Standard SQL might not allow this, test parser behavior
-- NOTE: Mixed literal/subquery form included for parser coverage; standard SQL may reject.

CREATE TABLE data (a INT64, b INT64);

INSERT INTO data VALUES (1, 2), (3, 4);

-- Tag: operators_tuple_in_predicate_comprehensive_test_select_025
SELECT a, b FROM data WHERE (a, b) IN ((1, 2), (SELECT 3, 4));

-- ---------------------------------------------------------------------------
-- Source ID: test_tuple_in_very_wide_tuple
-- **Boundary Case:** Tuple with many columns (stress test)
-- **Challenge:** Arity validation, memory allocation, comparison overhead
-- NOTE: SQL constructed dynamically for 50-column tuple via format! macro.

-- SQL: constructed dynamically in Rust test harness; see source for details.
