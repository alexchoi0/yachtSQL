-- Json - SQL:2023
-- Description: JSON data type and JSON manipulation functions
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (key INT64, value STRING);
INSERT INTO test VALUES (1, 'a'), (2, 'b');
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value FLOAT64);
INSERT INTO test VALUES ('pi', 3.14), ('e', 2.71);

-- Tag: json_json_test_select_001
SELECT JSON_OBJECT_AGG(key) FROM test;
-- Tag: json_json_test_select_002
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: json_json_test_select_003
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (key INT64, value STRING);
INSERT INTO test VALUES (1, 'a'), (2, 'b');
DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value FLOAT64);
INSERT INTO test VALUES ('pi', 3.14), ('e', 2.71);

-- Tag: json_json_test_select_004
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;
-- Tag: json_json_test_select_005
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (key STRING, value FLOAT64);
INSERT INTO test VALUES ('pi', 3.14), ('e', 2.71);

-- Tag: json_json_test_select_006
SELECT JSON_OBJECT_AGG(key, value) as json_obj FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);

EXPLAIN SELECT * FROM test;
EXPLAIN (FORMAT JSON) SELECT * FROM test;
EXPLAIN (FORMAT YAML) SELECT * FROM test;
EXPLAIN SELECT * FROM test;
EXPLAIN SELECT 1 + 1 as result;
EXPLAIN INSERT INTO test SELECT id, id * 2 FROM test WHERE id > 10;
EXPLAIN UPDATE test SET value = value * 2 WHERE id > 100;
EXPLAIN DELETE FROM test WHERE value < 10;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, value INT64);

EXPLAIN (FORMAT JSON) SELECT * FROM test;
EXPLAIN (FORMAT YAML) SELECT * FROM test;
EXPLAIN SELECT * FROM test;
EXPLAIN SELECT 1 + 1 as result;
EXPLAIN INSERT INTO test SELECT id, id * 2 FROM test WHERE id > 10;
EXPLAIN UPDATE test SET value = value * 2 WHERE id > 100;
EXPLAIN DELETE FROM test WHERE value < 10;

DROP TABLE IF EXISTS empty_table;
CREATE TABLE empty_table (val INT64);
DROP TABLE IF EXISTS kv;
CREATE TABLE kv (key STRING, value INT64);
INSERT INTO kv VALUES ('a', 1);
INSERT INTO kv VALUES ('b', 2);
INSERT INTO kv VALUES ('c', 3);
DROP TABLE IF EXISTS kv;
CREATE TABLE kv (key STRING, value INT64);
INSERT INTO kv VALUES ('a', 1);
INSERT INTO kv VALUES ('b', NULL);
DROP TABLE IF EXISTS kv;
CREATE TABLE kv (key STRING, value INT64);
INSERT INTO kv VALUES (NULL, 1);
DROP TABLE IF EXISTS kv;
CREATE TABLE kv (key STRING, value INT64);
INSERT INTO kv VALUES ('a', 1);
INSERT INTO kv VALUES ('a', 2);
DROP TABLE IF EXISTS empty_kv;
CREATE TABLE empty_kv (key STRING, value INT64);
DROP TABLE IF EXISTS json_docs;
CREATE TABLE json_docs (id INT64, doc JSON);
DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_007
SELECT JSON_ARRAYAGG(val) as arr FROM empty_table;
-- Tag: json_json_test_select_008
SELECT JSON_OBJECTAGG(key, value) as obj FROM kv;
-- Tag: json_json_test_select_009
SELECT JSON_OBJECTAGG(key, value) as obj FROM kv;
-- Tag: json_json_test_select_010
SELECT JSON_OBJECTAGG(key, value) as obj FROM kv;
-- Tag: json_json_test_select_011
SELECT JSON_OBJECTAGG(key, value) as obj FROM kv;
-- Tag: json_json_test_select_012
SELECT JSON_OBJECTAGG(key, value) as obj FROM empty_kv;
-- Tag: json_json_test_select_013
SELECT doc FROM json_docs WHERE id = 1;
-- Tag: json_json_test_select_014
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_015
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_016
SELECT CAST('{invalid json}' AS JSON) as j;
-- Tag: json_json_test_select_017
SELECT JSON_TYPE('[1, 2, 3]') as t;
-- Tag: json_json_test_select_018
SELECT JSON_TYPE('42') as t;
-- Tag: json_json_test_select_019
SELECT JSON_TYPE('true') as t;
-- Tag: json_json_test_select_020
SELECT JSON_TYPE('null') as t;
-- Tag: json_json_test_select_021
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS kv;
CREATE TABLE kv (key STRING, value INT64);
INSERT INTO kv VALUES ('a', 1);
INSERT INTO kv VALUES ('b', 2);
INSERT INTO kv VALUES ('c', 3);
DROP TABLE IF EXISTS kv;
CREATE TABLE kv (key STRING, value INT64);
INSERT INTO kv VALUES ('a', 1);
INSERT INTO kv VALUES ('b', NULL);
DROP TABLE IF EXISTS kv;
CREATE TABLE kv (key STRING, value INT64);
INSERT INTO kv VALUES (NULL, 1);
DROP TABLE IF EXISTS kv;
CREATE TABLE kv (key STRING, value INT64);
INSERT INTO kv VALUES ('a', 1);
INSERT INTO kv VALUES ('a', 2);
DROP TABLE IF EXISTS empty_kv;
CREATE TABLE empty_kv (key STRING, value INT64);
DROP TABLE IF EXISTS json_docs;
CREATE TABLE json_docs (id INT64, doc JSON);
DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_022
SELECT JSON_OBJECTAGG(key, value) as obj FROM kv;
-- Tag: json_json_test_select_023
SELECT JSON_OBJECTAGG(key, value) as obj FROM kv;
-- Tag: json_json_test_select_024
SELECT JSON_OBJECTAGG(key, value) as obj FROM kv;
-- Tag: json_json_test_select_025
SELECT JSON_OBJECTAGG(key, value) as obj FROM kv;
-- Tag: json_json_test_select_026
SELECT JSON_OBJECTAGG(key, value) as obj FROM empty_kv;
-- Tag: json_json_test_select_027
SELECT doc FROM json_docs WHERE id = 1;
-- Tag: json_json_test_select_028
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_029
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_030
SELECT CAST('{invalid json}' AS JSON) as j;
-- Tag: json_json_test_select_031
SELECT JSON_TYPE('[1, 2, 3]') as t;
-- Tag: json_json_test_select_032
SELECT JSON_TYPE('42') as t;
-- Tag: json_json_test_select_033
SELECT JSON_TYPE('true') as t;
-- Tag: json_json_test_select_034
SELECT JSON_TYPE('null') as t;
-- Tag: json_json_test_select_035
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS kv;
CREATE TABLE kv (key STRING, value INT64);
INSERT INTO kv VALUES ('a', 1);
INSERT INTO kv VALUES ('b', NULL);
DROP TABLE IF EXISTS kv;
CREATE TABLE kv (key STRING, value INT64);
INSERT INTO kv VALUES (NULL, 1);
DROP TABLE IF EXISTS kv;
CREATE TABLE kv (key STRING, value INT64);
INSERT INTO kv VALUES ('a', 1);
INSERT INTO kv VALUES ('a', 2);
DROP TABLE IF EXISTS empty_kv;
CREATE TABLE empty_kv (key STRING, value INT64);
DROP TABLE IF EXISTS json_docs;
CREATE TABLE json_docs (id INT64, doc JSON);
DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_036
SELECT JSON_OBJECTAGG(key, value) as obj FROM kv;
-- Tag: json_json_test_select_037
SELECT JSON_OBJECTAGG(key, value) as obj FROM kv;
-- Tag: json_json_test_select_038
SELECT JSON_OBJECTAGG(key, value) as obj FROM kv;
-- Tag: json_json_test_select_039
SELECT JSON_OBJECTAGG(key, value) as obj FROM empty_kv;
-- Tag: json_json_test_select_040
SELECT doc FROM json_docs WHERE id = 1;
-- Tag: json_json_test_select_041
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_042
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_043
SELECT CAST('{invalid json}' AS JSON) as j;
-- Tag: json_json_test_select_044
SELECT JSON_TYPE('[1, 2, 3]') as t;
-- Tag: json_json_test_select_045
SELECT JSON_TYPE('42') as t;
-- Tag: json_json_test_select_046
SELECT JSON_TYPE('true') as t;
-- Tag: json_json_test_select_047
SELECT JSON_TYPE('null') as t;
-- Tag: json_json_test_select_048
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS kv;
CREATE TABLE kv (key STRING, value INT64);
INSERT INTO kv VALUES (NULL, 1);
DROP TABLE IF EXISTS kv;
CREATE TABLE kv (key STRING, value INT64);
INSERT INTO kv VALUES ('a', 1);
INSERT INTO kv VALUES ('a', 2);
DROP TABLE IF EXISTS empty_kv;
CREATE TABLE empty_kv (key STRING, value INT64);
DROP TABLE IF EXISTS json_docs;
CREATE TABLE json_docs (id INT64, doc JSON);
DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_049
SELECT JSON_OBJECTAGG(key, value) as obj FROM kv;
-- Tag: json_json_test_select_050
SELECT JSON_OBJECTAGG(key, value) as obj FROM kv;
-- Tag: json_json_test_select_051
SELECT JSON_OBJECTAGG(key, value) as obj FROM empty_kv;
-- Tag: json_json_test_select_052
SELECT doc FROM json_docs WHERE id = 1;
-- Tag: json_json_test_select_053
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_054
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_055
SELECT CAST('{invalid json}' AS JSON) as j;
-- Tag: json_json_test_select_056
SELECT JSON_TYPE('[1, 2, 3]') as t;
-- Tag: json_json_test_select_057
SELECT JSON_TYPE('42') as t;
-- Tag: json_json_test_select_058
SELECT JSON_TYPE('true') as t;
-- Tag: json_json_test_select_059
SELECT JSON_TYPE('null') as t;
-- Tag: json_json_test_select_060
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS kv;
CREATE TABLE kv (key STRING, value INT64);
INSERT INTO kv VALUES ('a', 1);
INSERT INTO kv VALUES ('a', 2);
DROP TABLE IF EXISTS empty_kv;
CREATE TABLE empty_kv (key STRING, value INT64);
DROP TABLE IF EXISTS json_docs;
CREATE TABLE json_docs (id INT64, doc JSON);
DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_061
SELECT JSON_OBJECTAGG(key, value) as obj FROM kv;
-- Tag: json_json_test_select_062
SELECT JSON_OBJECTAGG(key, value) as obj FROM empty_kv;
-- Tag: json_json_test_select_063
SELECT doc FROM json_docs WHERE id = 1;
-- Tag: json_json_test_select_064
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_065
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_066
SELECT CAST('{invalid json}' AS JSON) as j;
-- Tag: json_json_test_select_067
SELECT JSON_TYPE('[1, 2, 3]') as t;
-- Tag: json_json_test_select_068
SELECT JSON_TYPE('42') as t;
-- Tag: json_json_test_select_069
SELECT JSON_TYPE('true') as t;
-- Tag: json_json_test_select_070
SELECT JSON_TYPE('null') as t;
-- Tag: json_json_test_select_071
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS empty_kv;
CREATE TABLE empty_kv (key STRING, value INT64);
DROP TABLE IF EXISTS json_docs;
CREATE TABLE json_docs (id INT64, doc JSON);
DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_072
SELECT JSON_OBJECTAGG(key, value) as obj FROM empty_kv;
-- Tag: json_json_test_select_073
SELECT doc FROM json_docs WHERE id = 1;
-- Tag: json_json_test_select_074
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_075
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_076
SELECT CAST('{invalid json}' AS JSON) as j;
-- Tag: json_json_test_select_077
SELECT JSON_TYPE('[1, 2, 3]') as t;
-- Tag: json_json_test_select_078
SELECT JSON_TYPE('42') as t;
-- Tag: json_json_test_select_079
SELECT JSON_TYPE('true') as t;
-- Tag: json_json_test_select_080
SELECT JSON_TYPE('null') as t;
-- Tag: json_json_test_select_081
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS json_docs;
CREATE TABLE json_docs (id INT64, doc JSON);
DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_082
SELECT doc FROM json_docs WHERE id = 1;
-- Tag: json_json_test_select_083
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_084
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_085
SELECT CAST('{invalid json}' AS JSON) as j;
-- Tag: json_json_test_select_086
SELECT JSON_TYPE('[1, 2, 3]') as t;
-- Tag: json_json_test_select_087
SELECT JSON_TYPE('42') as t;
-- Tag: json_json_test_select_088
SELECT JSON_TYPE('true') as t;
-- Tag: json_json_test_select_089
SELECT JSON_TYPE('null') as t;
-- Tag: json_json_test_select_090
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS json_docs;
CREATE TABLE json_docs (id INT64, doc JSON);
DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_091
SELECT doc FROM json_docs WHERE id = 1;
-- Tag: json_json_test_select_092
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_093
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_094
SELECT CAST('{invalid json}' AS JSON) as j;
-- Tag: json_json_test_select_095
SELECT JSON_TYPE('[1, 2, 3]') as t;
-- Tag: json_json_test_select_096
SELECT JSON_TYPE('42') as t;
-- Tag: json_json_test_select_097
SELECT JSON_TYPE('true') as t;
-- Tag: json_json_test_select_098
SELECT JSON_TYPE('null') as t;
-- Tag: json_json_test_select_099
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS json_docs;
CREATE TABLE json_docs (id INT64, doc JSON);
DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_100
SELECT doc FROM json_docs WHERE id = 1;
-- Tag: json_json_test_select_101
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_102
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_103
SELECT CAST('{invalid json}' AS JSON) as j;
-- Tag: json_json_test_select_104
SELECT JSON_TYPE('[1, 2, 3]') as t;
-- Tag: json_json_test_select_105
SELECT JSON_TYPE('42') as t;
-- Tag: json_json_test_select_106
SELECT JSON_TYPE('true') as t;
-- Tag: json_json_test_select_107
SELECT JSON_TYPE('null') as t;
-- Tag: json_json_test_select_108
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS json_docs;
CREATE TABLE json_docs (id INT64, doc JSON);
DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_109
SELECT doc FROM json_docs WHERE id = 1;
-- Tag: json_json_test_select_110
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_111
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_112
SELECT JSON_TYPE('[1, 2, 3]') as t;
-- Tag: json_json_test_select_113
SELECT JSON_TYPE('42') as t;
-- Tag: json_json_test_select_114
SELECT JSON_TYPE('true') as t;
-- Tag: json_json_test_select_115
SELECT JSON_TYPE('null') as t;
-- Tag: json_json_test_select_116
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS json_docs;
CREATE TABLE json_docs (id INT64, doc JSON);
DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_117
SELECT doc FROM json_docs WHERE id = 1;
-- Tag: json_json_test_select_118
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_119
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_120
SELECT JSON_TYPE('[1, 2, 3]') as t;
-- Tag: json_json_test_select_121
SELECT JSON_TYPE('42') as t;
-- Tag: json_json_test_select_122
SELECT JSON_TYPE('true') as t;
-- Tag: json_json_test_select_123
SELECT JSON_TYPE('null') as t;
-- Tag: json_json_test_select_124
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS json_docs;
CREATE TABLE json_docs (id INT64, doc JSON);
DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_125
SELECT doc FROM json_docs WHERE id = 1;
-- Tag: json_json_test_select_126
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_127
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_128
SELECT JSON_TYPE('42') as t;
-- Tag: json_json_test_select_129
SELECT JSON_TYPE('true') as t;
-- Tag: json_json_test_select_130
SELECT JSON_TYPE('null') as t;
-- Tag: json_json_test_select_131
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS json_docs;
CREATE TABLE json_docs (id INT64, doc JSON);
DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_132
SELECT doc FROM json_docs WHERE id = 1;
-- Tag: json_json_test_select_133
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_134
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_135
SELECT JSON_TYPE('42') as t;
-- Tag: json_json_test_select_136
SELECT JSON_TYPE('true') as t;
-- Tag: json_json_test_select_137
SELECT JSON_TYPE('null') as t;
-- Tag: json_json_test_select_138
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS json_docs;
CREATE TABLE json_docs (id INT64, doc JSON);
DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_139
SELECT doc FROM json_docs WHERE id = 1;
-- Tag: json_json_test_select_140
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_141
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_142
SELECT JSON_TYPE('true') as t;
-- Tag: json_json_test_select_143
SELECT JSON_TYPE('null') as t;
-- Tag: json_json_test_select_144
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS json_docs;
CREATE TABLE json_docs (id INT64, doc JSON);
DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_145
SELECT doc FROM json_docs WHERE id = 1;
-- Tag: json_json_test_select_146
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_147
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_148
SELECT JSON_TYPE('null') as t;
-- Tag: json_json_test_select_149
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS json_docs;
CREATE TABLE json_docs (id INT64, doc JSON);
DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_150
SELECT doc FROM json_docs WHERE id = 1;
-- Tag: json_json_test_select_151
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_152
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_153
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_154
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_155
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_156
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_157
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_158
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_159
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_160
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_161
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_162
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_163
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_164
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_165
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_166
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_167
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_168
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_169
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_170
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_171
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_172
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_173
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_174
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_175
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_176
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_177
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_178
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_179
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_180
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_181
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_182
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_183
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_184
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_185
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_186
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_187
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_188
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_189
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_190
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_191
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_192
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_193
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_194
SELECT status FROM parsed_data WHERE id = 1;
-- Tag: json_json_test_select_195
SELECT JSON_OBJECT('inf', CAST('Infinity' AS FLOAT64)) as obj;

DROP TABLE IF EXISTS refs;
CREATE TABLE refs (id INT64, data JSON);
DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_196
SELECT data FROM refs WHERE id = 1;
-- Tag: json_json_test_select_197
SELECT status FROM parsed_data WHERE id = 1;

DROP TABLE IF EXISTS json_compare;
CREATE TABLE json_compare (id INT64, data JSON);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_198
SELECT status FROM parsed_data WHERE id = 1;

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, items JSON);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_199
SELECT status FROM parsed_data WHERE id = 1;

DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, data JSON);
DROP TABLE IF EXISTS raw_data;
CREATE TABLE raw_data (id INT64, payload STRING);

-- Tag: json_json_test_select_200
SELECT status FROM parsed_data WHERE id = 1;

DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (a STRING, b INT64, c STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES ('a', 1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, key STRING, value STRING);
INSERT INTO test VALUES (1, 'a', 'apple'), (2, 'b', 'banana'), (3, 'c', 'cherry');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100), ('East', 'Gadget', 200), ('West', 'Widget', 150);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (30), (10), (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10), (20), (10), (30), (20);

-- Tag: json_json_test_select_201
SELECT JSON_OBJECTAGG(k) FROM test;
-- Tag: json_json_test_select_202
SELECT JSON_OBJECTAGG(a, b, c) FROM test;
-- Tag: json_json_test_select_203
SELECT * FROM test WHERE JSON_OBJECTAGG(k, v) IS NOT NULL;
-- Tag: json_json_test_select_204
SELECT JSON_ARRAYAGG(id) as ids, JSON_OBJECTAGG(key, value) as mapping FROM test;
-- Tag: json_json_test_select_205
SELECT JSON_ARRAYAGG(JSON_OBJECTAGG(product, amount)) as nested FROM sales;
-- Tag: json_json_test_select_206
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: json_json_test_select_207
SELECT JSON_ARRAYAGG(value) as arr FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (a STRING, b INT64, c STRING);
DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES ('a', 1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, key STRING, value STRING);
INSERT INTO test VALUES (1, 'a', 'apple'), (2, 'b', 'banana'), (3, 'c', 'cherry');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100), ('East', 'Gadget', 200), ('West', 'Widget', 150);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (30), (10), (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10), (20), (10), (30), (20);

-- Tag: json_json_test_select_208
SELECT JSON_OBJECTAGG(a, b, c) FROM test;
-- Tag: json_json_test_select_209
SELECT * FROM test WHERE JSON_OBJECTAGG(k, v) IS NOT NULL;
-- Tag: json_json_test_select_210
SELECT JSON_ARRAYAGG(id) as ids, JSON_OBJECTAGG(key, value) as mapping FROM test;
-- Tag: json_json_test_select_211
SELECT JSON_ARRAYAGG(JSON_OBJECTAGG(product, amount)) as nested FROM sales;
-- Tag: json_json_test_select_212
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: json_json_test_select_213
SELECT JSON_ARRAYAGG(value) as arr FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (k STRING, v INT64);
INSERT INTO test VALUES ('a', 1);
DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, key STRING, value STRING);
INSERT INTO test VALUES (1, 'a', 'apple'), (2, 'b', 'banana'), (3, 'c', 'cherry');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100), ('East', 'Gadget', 200), ('West', 'Widget', 150);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (30), (10), (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10), (20), (10), (30), (20);

-- Tag: json_json_test_select_214
SELECT * FROM test WHERE JSON_OBJECTAGG(k, v) IS NOT NULL;
-- Tag: json_json_test_select_215
SELECT JSON_ARRAYAGG(id) as ids, JSON_OBJECTAGG(key, value) as mapping FROM test;
-- Tag: json_json_test_select_216
SELECT JSON_ARRAYAGG(JSON_OBJECTAGG(product, amount)) as nested FROM sales;
-- Tag: json_json_test_select_217
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: json_json_test_select_218
SELECT JSON_ARRAYAGG(value) as arr FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (id INT64, key STRING, value STRING);
INSERT INTO test VALUES (1, 'a', 'apple'), (2, 'b', 'banana'), (3, 'c', 'cherry');
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100), ('East', 'Gadget', 200), ('West', 'Widget', 150);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (30), (10), (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10), (20), (10), (30), (20);

-- Tag: json_json_test_select_219
SELECT JSON_ARRAYAGG(id) as ids, JSON_OBJECTAGG(key, value) as mapping FROM test;
-- Tag: json_json_test_select_220
SELECT JSON_ARRAYAGG(JSON_OBJECTAGG(product, amount)) as nested FROM sales;
-- Tag: json_json_test_select_221
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: json_json_test_select_222
SELECT JSON_ARRAYAGG(value) as arr FROM test;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (region STRING, product STRING, amount INT64);
INSERT INTO sales VALUES ('East', 'Widget', 100), ('East', 'Gadget', 200), ('West', 'Widget', 150);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (30), (10), (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10), (20), (10), (30), (20);

-- Tag: json_json_test_select_223
SELECT JSON_ARRAYAGG(JSON_OBJECTAGG(product, amount)) as nested FROM sales;
-- Tag: json_json_test_select_224
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: json_json_test_select_225
SELECT JSON_ARRAYAGG(value) as arr FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (30), (10), (20);
DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10), (20), (10), (30), (20);

-- Tag: json_json_test_select_226
SELECT JSON_ARRAYAGG(value) as arr FROM test;
-- Tag: json_json_test_select_227
SELECT JSON_ARRAYAGG(value) as arr FROM test;

DROP TABLE IF EXISTS test;
CREATE TABLE test (value INT64);
INSERT INTO test VALUES (10), (20), (10), (30), (20);

-- Tag: json_json_test_select_228
SELECT JSON_ARRAYAGG(value) as arr FROM test;

DROP TABLE IF EXISTS test_json_distinct;
CREATE TABLE test_json_distinct (data STRING);
DROP TABLE IF EXISTS test_numbers;
CREATE TABLE test_numbers (n INT64);

-- Tag: json_json_test_select_229
SELECT DISTINCT JSON_VALUE(data, '$.x') as x FROM test_json_distinct ORDER BY x;
-- Tag: json_json_test_select_230
SELECT JSON_OBJECT('number', n) as obj FROM test_numbers WHERE n < 10;

DROP TABLE IF EXISTS test_numbers;
CREATE TABLE test_numbers (n INT64);

-- Tag: json_json_test_select_231
SELECT JSON_OBJECT('number', n) as obj FROM test_numbers WHERE n < 10;

DROP TABLE IF EXISTS test_numbers;
CREATE TABLE test_numbers (n INT64);

-- Tag: json_json_test_select_232
SELECT JSON_OBJECT('number', n) as obj FROM test_numbers WHERE n < 10;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_233
SELECT CAST(data AS JSON) as json_data FROM arr_test;
-- Tag: json_json_test_select_234
SELECT JSON_QUERY('[0,1,2,3,4,5,6,7,8,9]', '$[2:7:2]') as slice;
-- Tag: json_json_test_select_235
SELECT JSON_REMOVE('[10, 20, 30, 40]', '$[1]') as result;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_236
SELECT CAST(data AS JSON) as json_data FROM arr_test;
-- Tag: json_json_test_select_237
SELECT JSON_QUERY('[0,1,2,3,4,5,6,7,8,9]', '$[2:7:2]') as slice;
-- Tag: json_json_test_select_238
SELECT JSON_REMOVE('[10, 20, 30, 40]', '$[1]') as result;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_239
SELECT CAST(data AS JSON) as json_data FROM arr_test;
-- Tag: json_json_test_select_240
SELECT JSON_QUERY('[0,1,2,3,4,5,6,7,8,9]', '$[2:7:2]') as slice;
-- Tag: json_json_test_select_241
SELECT JSON_REMOVE('[10, 20, 30, 40]', '$[1]') as result;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_242
SELECT CAST(data AS JSON) as json_data FROM arr_test;
-- Tag: json_json_test_select_243
SELECT JSON_QUERY('[0,1,2,3,4,5,6,7,8,9]', '$[2:7:2]') as slice;
-- Tag: json_json_test_select_244
SELECT JSON_REMOVE('[10, 20, 30, 40]', '$[1]') as result;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_245
SELECT CAST(data AS JSON) as json_data FROM arr_test;
-- Tag: json_json_test_select_246
SELECT JSON_QUERY('[0,1,2,3,4,5,6,7,8,9]', '$[2:7:2]') as slice;
-- Tag: json_json_test_select_247
SELECT JSON_REMOVE('[10, 20, 30, 40]', '$[1]') as result;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_248
SELECT CAST(data AS JSON) as json_data FROM arr_test;
-- Tag: json_json_test_select_249
SELECT JSON_QUERY('[0,1,2,3,4,5,6,7,8,9]', '$[2:7:2]') as slice;
-- Tag: json_json_test_select_250
SELECT JSON_REMOVE('[10, 20, 30, 40]', '$[1]') as result;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_251
SELECT CAST(data AS JSON) as json_data FROM arr_test;
-- Tag: json_json_test_select_252
SELECT JSON_QUERY('[0,1,2,3,4,5,6,7,8,9]', '$[2:7:2]') as slice;
-- Tag: json_json_test_select_253
SELECT JSON_REMOVE('[10, 20, 30, 40]', '$[1]') as result;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_254
SELECT CAST(data AS JSON) as json_data FROM arr_test;
-- Tag: json_json_test_select_255
SELECT JSON_QUERY('[0,1,2,3,4,5,6,7,8,9]', '$[2:7:2]') as slice;
-- Tag: json_json_test_select_256
SELECT JSON_REMOVE('[10, 20, 30, 40]', '$[1]') as result;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_257
SELECT CAST(data AS JSON) as json_data FROM arr_test;
-- Tag: json_json_test_select_258
SELECT JSON_QUERY('[0,1,2,3,4,5,6,7,8,9]', '$[2:7:2]') as slice;
-- Tag: json_json_test_select_259
SELECT JSON_REMOVE('[10, 20, 30, 40]', '$[1]') as result;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_260
SELECT CAST(data AS JSON) as json_data FROM arr_test;
-- Tag: json_json_test_select_261
SELECT JSON_QUERY('[0,1,2,3,4,5,6,7,8,9]', '$[2:7:2]') as slice;
-- Tag: json_json_test_select_262
SELECT JSON_REMOVE('[10, 20, 30, 40]', '$[1]') as result;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_263
SELECT CAST(data AS JSON) as json_data FROM arr_test;
-- Tag: json_json_test_select_264
SELECT JSON_QUERY('[0,1,2,3,4,5,6,7,8,9]', '$[2:7:2]') as slice;
-- Tag: json_json_test_select_265
SELECT JSON_REMOVE('[10, 20, 30, 40]', '$[1]') as result;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_266
SELECT CAST(data AS JSON) as json_data FROM arr_test;
-- Tag: json_json_test_select_267
SELECT JSON_QUERY('[0,1,2,3,4,5,6,7,8,9]', '$[2:7:2]') as slice;
-- Tag: json_json_test_select_268
SELECT JSON_REMOVE('[10, 20, 30, 40]', '$[1]') as result;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_269
SELECT CAST(data AS JSON) as json_data FROM arr_test;
-- Tag: json_json_test_select_270
SELECT JSON_QUERY('[0,1,2,3,4,5,6,7,8,9]', '$[2:7:2]') as slice;
-- Tag: json_json_test_select_271
SELECT JSON_REMOVE('[10, 20, 30, 40]', '$[1]') as result;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_272
SELECT CAST(data AS JSON) as json_data FROM arr_test;
-- Tag: json_json_test_select_273
SELECT JSON_QUERY('[0,1,2,3,4,5,6,7,8,9]', '$[2:7:2]') as slice;
-- Tag: json_json_test_select_274
SELECT JSON_REMOVE('[10, 20, 30, 40]', '$[1]') as result;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_275
SELECT CAST(data AS JSON) as json_data FROM arr_test;
-- Tag: json_json_test_select_276
SELECT JSON_QUERY('[0,1,2,3,4,5,6,7,8,9]', '$[2:7:2]') as slice;
-- Tag: json_json_test_select_277
SELECT JSON_REMOVE('[10, 20, 30, 40]', '$[1]') as result;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_278
SELECT CAST(data AS JSON) as json_data FROM arr_test;
-- Tag: json_json_test_select_279
SELECT JSON_REMOVE('[10, 20, 30, 40]', '$[1]') as result;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_280
SELECT CAST(data AS JSON) as json_data FROM arr_test;
-- Tag: json_json_test_select_281
SELECT JSON_REMOVE('[10, 20, 30, 40]', '$[1]') as result;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_282
SELECT CAST(data AS JSON) as json_data FROM arr_test;
-- Tag: json_json_test_select_283
SELECT JSON_REMOVE('[10, 20, 30, 40]', '$[1]') as result;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_284
SELECT CAST(data AS JSON) as json_data FROM arr_test;
-- Tag: json_json_test_select_285
SELECT JSON_REMOVE('[10, 20, 30, 40]', '$[1]') as result;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_286
SELECT CAST(data AS JSON) as json_data FROM arr_test;
-- Tag: json_json_test_select_287
SELECT JSON_REMOVE('[10, 20, 30, 40]', '$[1]') as result;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_288
SELECT CAST(data AS JSON) as json_data FROM arr_test;
-- Tag: json_json_test_select_289
SELECT JSON_REMOVE('[10, 20, 30, 40]', '$[1]') as result;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_290
SELECT CAST(data AS JSON) as json_data FROM arr_test;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_291
SELECT CAST(data AS JSON) as json_data FROM arr_test;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_292
SELECT CAST(data AS JSON) as json_data FROM arr_test;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_293
SELECT CAST(data AS JSON) as json_data FROM arr_test;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_294
SELECT CAST(data AS JSON) as json_data FROM arr_test;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_295
SELECT CAST(data AS JSON) as json_data FROM arr_test;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_296
SELECT CAST(data AS JSON) as json_data FROM arr_test;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_297
SELECT CAST(data AS JSON) as json_data FROM arr_test;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_298
SELECT CAST(data AS JSON) as json_data FROM arr_test;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_299
SELECT CAST(data AS JSON) as json_data FROM arr_test;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_300
SELECT CAST(data AS JSON) as json_data FROM arr_test;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_301
SELECT CAST(data AS JSON) as json_data FROM arr_test;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_302
SELECT CAST(data AS JSON) as json_data FROM arr_test;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_303
SELECT CAST(data AS JSON) as json_data FROM arr_test;

DROP TABLE IF EXISTS arr_test;
CREATE TABLE arr_test (data ARRAY<INT64>);
INSERT INTO arr_test VALUES ([1, 2, 3, 4, 5]);

-- Tag: json_json_test_select_304
SELECT CAST(data AS JSON) as json_data FROM arr_test;

DROP TABLE IF EXISTS products;
CREATE TABLE products (id INT64, details STRING);

-- Tag: json_json_test_select_305
SELECT JSON_EXTRACT(NULL, '$.x') as x;

-- Tag: json_json_test_select_306
SELECT JSON_EXTRACT(NULL, '$.x') as x;

-- Tag: json_json_test_select_307
SELECT JSON_EXTRACT(NULL, '$.x') as x;

DROP TABLE IF EXISTS perf;
CREATE TABLE perf (id INT64, data JSON);
DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);

-- Tag: json_json_test_select_308
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

DROP TABLE IF EXISTS extract_perf;
CREATE TABLE extract_perf (id INT64, data JSON);

-- Tag: json_json_test_select_309
SELECT JSON_EXTRACT(data, '$.nested.value') FROM extract_perf;

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (id INT64, data STRING);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (user_id INT64, name STRING);
INSERT INTO customers VALUES (100, 'Alice');
DROP TABLE IF EXISTS json_data;
CREATE TABLE json_data (id INT64, payload STRING);

DROP TABLE IF EXISTS json_data;
CREATE TABLE json_data (id INT64, payload STRING);

DROP TABLE IF EXISTS json_data;
CREATE TABLE json_data (id INT64, payload STRING);

DROP TABLE IF EXISTS json_data;
CREATE TABLE json_data (id INT64, payload STRING);

DROP TABLE IF EXISTS json_data;
CREATE TABLE json_data (id INT64, payload STRING);

-- Tag: json_json_test_select_310
SELECT JSON 'null' as json_null, NULL as sql_null;
-- Tag: json_json_test_select_311
SELECT JSON '{}' as empty_obj, JSON 'null' as json_null;
-- Tag: json_json_test_select_312
SELECT JSON '{\;
-- Tag: json_json_test_select_313
SELECT JSON '{\;
-- Tag: json_json_test_select_314
SELECT JSON_EXTRACT('{\;

-- Tag: json_json_test_select_315
SELECT JSON '{}' as empty_obj, JSON 'null' as json_null;
-- Tag: json_json_test_select_316
SELECT JSON '{\;
-- Tag: json_json_test_select_317
SELECT JSON '{\;
-- Tag: json_json_test_select_318
SELECT JSON_EXTRACT('{\;

-- Tag: json_json_test_select_319
SELECT JSON '{\;
-- Tag: json_json_test_select_320
SELECT JSON '{\;
-- Tag: json_json_test_select_321
SELECT JSON_EXTRACT('{\;

-- Tag: json_json_test_select_322
SELECT JSON '{\;
-- Tag: json_json_test_select_323
SELECT JSON_EXTRACT('{\;

-- Tag: json_json_test_select_324
SELECT JSON_EXTRACT('{\;

-- Tag: json_json_test_select_325
SELECT JSON_EXTRACT('{\;
-- Tag: json_json_test_select_326
SELECT JSON_VALUE('{\;
-- Tag: json_json_test_select_327
SELECT JSON_ARRAY(1, 2, 3) as arr;
-- Tag: json_json_test_select_328
SELECT JSON_OBJECT('name', 'Alice', 'age', 30) as obj;

-- Tag: json_json_test_select_329
SELECT JSON_VALUE('{\;
-- Tag: json_json_test_select_330
SELECT JSON_ARRAY(1, 2, 3) as arr;
-- Tag: json_json_test_select_331
SELECT JSON_OBJECT('name', 'Alice', 'age', 30) as obj;

-- Tag: json_json_test_select_332
SELECT JSON_ARRAY(1, 2, 3) as arr;
-- Tag: json_json_test_select_333
SELECT JSON_OBJECT('name', 'Alice', 'age', 30) as obj;

-- Tag: json_json_test_select_334
SELECT JSON_OBJECT('name', 'Alice', 'age', 30) as obj;
