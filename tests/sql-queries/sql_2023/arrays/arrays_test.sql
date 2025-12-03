-- Arrays - SQL:2023
-- Description: ARRAY data type and array manipulation functions
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

DROP TABLE IF EXISTS large_arrays;
CREATE TABLE large_arrays (id INT64, values ARRAY<INT64>);
DROP TABLE IF EXISTS products;
CREATE TABLE products (name STRING, tags ARRAY<STRING>);
INSERT INTO products VALUES ('Widget', ['new', 'popular', 'sale']);
INSERT INTO products VALUES ('Gadget', ['new']);
INSERT INTO products VALUES ('Doohickey', []);

-- Tag: arrays_arrays_test_select_001
SELECT ARRAY_LENGTH(values) FROM large_arrays;
-- Tag: arrays_arrays_test_select_002
SELECT ARRAY_REVERSE(values) FROM large_arrays;
-- Tag: arrays_arrays_test_select_003
SELECT ARRAY_DISTINCT(values) FROM large_arrays;
-- Tag: arrays_arrays_test_select_004
SELECT name FROM products WHERE ARRAY_LENGTH(tags) > 1;

DROP TABLE IF EXISTS products;
CREATE TABLE products (name STRING, tags ARRAY<STRING>);
INSERT INTO products VALUES ('Widget', ['new', 'popular', 'sale']);
INSERT INTO products VALUES ('Gadget', ['new']);
INSERT INTO products VALUES ('Doohickey', []);

-- Tag: arrays_arrays_test_select_005
SELECT name FROM products WHERE ARRAY_LENGTH(tags) > 1;

DROP TABLE IF EXISTS arr_data;
CREATE TABLE arr_data (id INT64, values ARRAY<INT64>);
INSERT INTO arr_data VALUES (1, NULL);
DROP TABLE IF EXISTS sequences;
CREATE TABLE sequences (id INT64, data ARRAY<INT64>);
INSERT INTO sequences VALUES (1, ARRAY[1, 2, 3, 4, 5]);
INSERT INTO sequences VALUES (2, ARRAY[10, 20, 30, 40, 50]);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, tags ARRAY<STRING>);
INSERT INTO items VALUES (1, ARRAY['a', 'b', 'c', 'd', 'e']);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, values ARRAY<FLOAT64>);
INSERT INTO metrics VALUES (1, ARRAY[1.1, 2.2, 3.3, 4.4, 5.5]);
DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_006
SELECT ARRAY[10, 20, 30, 40, 50][2:4] as slice;
-- Tag: arrays_arrays_test_select_007
SELECT ARRAY['a', 'b', 'c', 'd'][1:2] as first_two;
-- Tag: arrays_arrays_test_select_008
SELECT ARRAY[1, 2, 3, 4, 5][4:5] as last_two;
-- Tag: arrays_arrays_test_select_009
SELECT ARRAY[10, 20, 30][2:2] as single;
-- Tag: arrays_arrays_test_select_010
SELECT ARRAY[1, 2, 3, 4][1:4] as full;
-- Tag: arrays_arrays_test_select_011
SELECT ARRAY[10, 20, 30, 40, 50][:3] as from_start;
-- Tag: arrays_arrays_test_select_012
SELECT ARRAY[10, 20, 30, 40, 50][3:] as to_end;
-- Tag: arrays_arrays_test_select_013
SELECT ARRAY['x', 'y', 'z'][:] as all;
-- Tag: arrays_arrays_test_select_014
SELECT ARRAY[1, 2, 3, 4, 5][-3:-1] as negative_slice;
-- Tag: arrays_arrays_test_select_015
SELECT ARRAY[10, 20, 30, 40, 50][1:-1] as to_second_last;
-- Tag: arrays_arrays_test_select_016
SELECT ARRAY['a', 'b', 'c', 'd', 'e', 'f'][2:-2] as mixed;
-- Tag: arrays_arrays_test_select_017
SELECT ARRAY[1, 2, 3, 4, 5][-2:] as last_two;
-- Tag: arrays_arrays_test_select_018
SELECT ARRAY[1, 2, 3, 4, 5][4:2] as empty_slice;
-- Tag: arrays_arrays_test_select_019
SELECT ARRAY<INT64>[][1:3] as empty_slice;
-- Tag: arrays_arrays_test_select_020
SELECT ARRAY[1, 2, 3][1:100] as clamped;
-- Tag: arrays_arrays_test_select_021
SELECT ARRAY[10, 20, 30][-100:2] as clamped;
-- Tag: arrays_arrays_test_select_022
SELECT values[1:3] as slice FROM arr_data WHERE id = 1;
-- Tag: arrays_arrays_test_select_023
SELECT ARRAY[1, NULL, 3, NULL, 5][2:4] as with_nulls;
-- Tag: arrays_arrays_test_select_024
SELECT ARRAY[1, 2, 3, 4, 5, 6][1:6:2] as stepped;
-- Tag: arrays_arrays_test_select_025
SELECT ARRAY[1, 2, 3, 4, 5][::-1] as reversed;
-- Tag: arrays_arrays_test_select_026
SELECT id FROM sequences WHERE ARRAY_LENGTH(data[2:4]) = 3;
-- Tag: arrays_arrays_test_select_027
SELECT id FROM items WHERE tags[2:4][1] = 'b';
-- Tag: arrays_arrays_test_select_028
SELECT ARRAY_CONCAT(ARRAY[1, 2, 3][1:2], ARRAY[4, 5, 6][2:3]) as concat_slices;
-- Tag: arrays_arrays_test_select_029
SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4, 5, 6, 7][3:6]) as slice_len;
-- Tag: arrays_arrays_test_select_030
SELECT id FROM metrics WHERE ARRAY_LENGTH(values[2:4]) > 0;
-- Tag: arrays_arrays_test_select_031
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6], ARRAY[7, 8]][2:3] as outer_slice;
-- Tag: arrays_arrays_test_select_032
SELECT ARRAY[ARRAY[1, 2, 3, 4, 5], ARRAY[6, 7, 8, 9, 10]][1][2:4] as inner_slice;
-- Tag: arrays_arrays_test_select_033
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice;
-- Tag: arrays_arrays_test_select_034
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_035
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_036
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_037
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_038
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_039
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS arr_data;
CREATE TABLE arr_data (id INT64, values ARRAY<INT64>);
INSERT INTO arr_data VALUES (1, NULL);
DROP TABLE IF EXISTS sequences;
CREATE TABLE sequences (id INT64, data ARRAY<INT64>);
INSERT INTO sequences VALUES (1, ARRAY[1, 2, 3, 4, 5]);
INSERT INTO sequences VALUES (2, ARRAY[10, 20, 30, 40, 50]);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, tags ARRAY<STRING>);
INSERT INTO items VALUES (1, ARRAY['a', 'b', 'c', 'd', 'e']);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, values ARRAY<FLOAT64>);
INSERT INTO metrics VALUES (1, ARRAY[1.1, 2.2, 3.3, 4.4, 5.5]);
DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_040
SELECT ARRAY['a', 'b', 'c', 'd'][1:2] as first_two;
-- Tag: arrays_arrays_test_select_041
SELECT ARRAY[1, 2, 3, 4, 5][4:5] as last_two;
-- Tag: arrays_arrays_test_select_042
SELECT ARRAY[10, 20, 30][2:2] as single;
-- Tag: arrays_arrays_test_select_043
SELECT ARRAY[1, 2, 3, 4][1:4] as full;
-- Tag: arrays_arrays_test_select_044
SELECT ARRAY[10, 20, 30, 40, 50][:3] as from_start;
-- Tag: arrays_arrays_test_select_045
SELECT ARRAY[10, 20, 30, 40, 50][3:] as to_end;
-- Tag: arrays_arrays_test_select_046
SELECT ARRAY['x', 'y', 'z'][:] as all;
-- Tag: arrays_arrays_test_select_047
SELECT ARRAY[1, 2, 3, 4, 5][-3:-1] as negative_slice;
-- Tag: arrays_arrays_test_select_048
SELECT ARRAY[10, 20, 30, 40, 50][1:-1] as to_second_last;
-- Tag: arrays_arrays_test_select_049
SELECT ARRAY['a', 'b', 'c', 'd', 'e', 'f'][2:-2] as mixed;
-- Tag: arrays_arrays_test_select_050
SELECT ARRAY[1, 2, 3, 4, 5][-2:] as last_two;
-- Tag: arrays_arrays_test_select_051
SELECT ARRAY[1, 2, 3, 4, 5][4:2] as empty_slice;
-- Tag: arrays_arrays_test_select_052
SELECT ARRAY<INT64>[][1:3] as empty_slice;
-- Tag: arrays_arrays_test_select_053
SELECT ARRAY[1, 2, 3][1:100] as clamped;
-- Tag: arrays_arrays_test_select_054
SELECT ARRAY[10, 20, 30][-100:2] as clamped;
-- Tag: arrays_arrays_test_select_055
SELECT values[1:3] as slice FROM arr_data WHERE id = 1;
-- Tag: arrays_arrays_test_select_056
SELECT ARRAY[1, NULL, 3, NULL, 5][2:4] as with_nulls;
-- Tag: arrays_arrays_test_select_057
SELECT ARRAY[1, 2, 3, 4, 5, 6][1:6:2] as stepped;
-- Tag: arrays_arrays_test_select_058
SELECT ARRAY[1, 2, 3, 4, 5][::-1] as reversed;
-- Tag: arrays_arrays_test_select_059
SELECT id FROM sequences WHERE ARRAY_LENGTH(data[2:4]) = 3;
-- Tag: arrays_arrays_test_select_060
SELECT id FROM items WHERE tags[2:4][1] = 'b';
-- Tag: arrays_arrays_test_select_061
SELECT ARRAY_CONCAT(ARRAY[1, 2, 3][1:2], ARRAY[4, 5, 6][2:3]) as concat_slices;
-- Tag: arrays_arrays_test_select_062
SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4, 5, 6, 7][3:6]) as slice_len;
-- Tag: arrays_arrays_test_select_063
SELECT id FROM metrics WHERE ARRAY_LENGTH(values[2:4]) > 0;
-- Tag: arrays_arrays_test_select_064
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6], ARRAY[7, 8]][2:3] as outer_slice;
-- Tag: arrays_arrays_test_select_065
SELECT ARRAY[ARRAY[1, 2, 3, 4, 5], ARRAY[6, 7, 8, 9, 10]][1][2:4] as inner_slice;
-- Tag: arrays_arrays_test_select_066
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice;
-- Tag: arrays_arrays_test_select_067
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_068
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_069
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_070
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_071
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_072
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS arr_data;
CREATE TABLE arr_data (id INT64, values ARRAY<INT64>);
INSERT INTO arr_data VALUES (1, NULL);
DROP TABLE IF EXISTS sequences;
CREATE TABLE sequences (id INT64, data ARRAY<INT64>);
INSERT INTO sequences VALUES (1, ARRAY[1, 2, 3, 4, 5]);
INSERT INTO sequences VALUES (2, ARRAY[10, 20, 30, 40, 50]);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, tags ARRAY<STRING>);
INSERT INTO items VALUES (1, ARRAY['a', 'b', 'c', 'd', 'e']);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, values ARRAY<FLOAT64>);
INSERT INTO metrics VALUES (1, ARRAY[1.1, 2.2, 3.3, 4.4, 5.5]);
DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_073
SELECT ARRAY[1, 2, 3, 4, 5][4:5] as last_two;
-- Tag: arrays_arrays_test_select_074
SELECT ARRAY[10, 20, 30][2:2] as single;
-- Tag: arrays_arrays_test_select_075
SELECT ARRAY[1, 2, 3, 4][1:4] as full;
-- Tag: arrays_arrays_test_select_076
SELECT ARRAY[10, 20, 30, 40, 50][:3] as from_start;
-- Tag: arrays_arrays_test_select_077
SELECT ARRAY[10, 20, 30, 40, 50][3:] as to_end;
-- Tag: arrays_arrays_test_select_078
SELECT ARRAY['x', 'y', 'z'][:] as all;
-- Tag: arrays_arrays_test_select_079
SELECT ARRAY[1, 2, 3, 4, 5][-3:-1] as negative_slice;
-- Tag: arrays_arrays_test_select_080
SELECT ARRAY[10, 20, 30, 40, 50][1:-1] as to_second_last;
-- Tag: arrays_arrays_test_select_081
SELECT ARRAY['a', 'b', 'c', 'd', 'e', 'f'][2:-2] as mixed;
-- Tag: arrays_arrays_test_select_082
SELECT ARRAY[1, 2, 3, 4, 5][-2:] as last_two;
-- Tag: arrays_arrays_test_select_083
SELECT ARRAY[1, 2, 3, 4, 5][4:2] as empty_slice;
-- Tag: arrays_arrays_test_select_084
SELECT ARRAY<INT64>[][1:3] as empty_slice;
-- Tag: arrays_arrays_test_select_085
SELECT ARRAY[1, 2, 3][1:100] as clamped;
-- Tag: arrays_arrays_test_select_086
SELECT ARRAY[10, 20, 30][-100:2] as clamped;
-- Tag: arrays_arrays_test_select_087
SELECT values[1:3] as slice FROM arr_data WHERE id = 1;
-- Tag: arrays_arrays_test_select_088
SELECT ARRAY[1, NULL, 3, NULL, 5][2:4] as with_nulls;
-- Tag: arrays_arrays_test_select_089
SELECT ARRAY[1, 2, 3, 4, 5, 6][1:6:2] as stepped;
-- Tag: arrays_arrays_test_select_090
SELECT ARRAY[1, 2, 3, 4, 5][::-1] as reversed;
-- Tag: arrays_arrays_test_select_091
SELECT id FROM sequences WHERE ARRAY_LENGTH(data[2:4]) = 3;
-- Tag: arrays_arrays_test_select_092
SELECT id FROM items WHERE tags[2:4][1] = 'b';
-- Tag: arrays_arrays_test_select_093
SELECT ARRAY_CONCAT(ARRAY[1, 2, 3][1:2], ARRAY[4, 5, 6][2:3]) as concat_slices;
-- Tag: arrays_arrays_test_select_094
SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4, 5, 6, 7][3:6]) as slice_len;
-- Tag: arrays_arrays_test_select_095
SELECT id FROM metrics WHERE ARRAY_LENGTH(values[2:4]) > 0;
-- Tag: arrays_arrays_test_select_096
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6], ARRAY[7, 8]][2:3] as outer_slice;
-- Tag: arrays_arrays_test_select_097
SELECT ARRAY[ARRAY[1, 2, 3, 4, 5], ARRAY[6, 7, 8, 9, 10]][1][2:4] as inner_slice;
-- Tag: arrays_arrays_test_select_098
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice;
-- Tag: arrays_arrays_test_select_099
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_100
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_101
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_102
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_103
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_104
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS arr_data;
CREATE TABLE arr_data (id INT64, values ARRAY<INT64>);
INSERT INTO arr_data VALUES (1, NULL);
DROP TABLE IF EXISTS sequences;
CREATE TABLE sequences (id INT64, data ARRAY<INT64>);
INSERT INTO sequences VALUES (1, ARRAY[1, 2, 3, 4, 5]);
INSERT INTO sequences VALUES (2, ARRAY[10, 20, 30, 40, 50]);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, tags ARRAY<STRING>);
INSERT INTO items VALUES (1, ARRAY['a', 'b', 'c', 'd', 'e']);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, values ARRAY<FLOAT64>);
INSERT INTO metrics VALUES (1, ARRAY[1.1, 2.2, 3.3, 4.4, 5.5]);
DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_105
SELECT ARRAY[10, 20, 30][2:2] as single;
-- Tag: arrays_arrays_test_select_106
SELECT ARRAY[1, 2, 3, 4][1:4] as full;
-- Tag: arrays_arrays_test_select_107
SELECT ARRAY[10, 20, 30, 40, 50][:3] as from_start;
-- Tag: arrays_arrays_test_select_108
SELECT ARRAY[10, 20, 30, 40, 50][3:] as to_end;
-- Tag: arrays_arrays_test_select_109
SELECT ARRAY['x', 'y', 'z'][:] as all;
-- Tag: arrays_arrays_test_select_110
SELECT ARRAY[1, 2, 3, 4, 5][-3:-1] as negative_slice;
-- Tag: arrays_arrays_test_select_111
SELECT ARRAY[10, 20, 30, 40, 50][1:-1] as to_second_last;
-- Tag: arrays_arrays_test_select_112
SELECT ARRAY['a', 'b', 'c', 'd', 'e', 'f'][2:-2] as mixed;
-- Tag: arrays_arrays_test_select_113
SELECT ARRAY[1, 2, 3, 4, 5][-2:] as last_two;
-- Tag: arrays_arrays_test_select_114
SELECT ARRAY[1, 2, 3, 4, 5][4:2] as empty_slice;
-- Tag: arrays_arrays_test_select_115
SELECT ARRAY<INT64>[][1:3] as empty_slice;
-- Tag: arrays_arrays_test_select_116
SELECT ARRAY[1, 2, 3][1:100] as clamped;
-- Tag: arrays_arrays_test_select_117
SELECT ARRAY[10, 20, 30][-100:2] as clamped;
-- Tag: arrays_arrays_test_select_118
SELECT values[1:3] as slice FROM arr_data WHERE id = 1;
-- Tag: arrays_arrays_test_select_119
SELECT ARRAY[1, NULL, 3, NULL, 5][2:4] as with_nulls;
-- Tag: arrays_arrays_test_select_120
SELECT ARRAY[1, 2, 3, 4, 5, 6][1:6:2] as stepped;
-- Tag: arrays_arrays_test_select_121
SELECT ARRAY[1, 2, 3, 4, 5][::-1] as reversed;
-- Tag: arrays_arrays_test_select_122
SELECT id FROM sequences WHERE ARRAY_LENGTH(data[2:4]) = 3;
-- Tag: arrays_arrays_test_select_123
SELECT id FROM items WHERE tags[2:4][1] = 'b';
-- Tag: arrays_arrays_test_select_124
SELECT ARRAY_CONCAT(ARRAY[1, 2, 3][1:2], ARRAY[4, 5, 6][2:3]) as concat_slices;
-- Tag: arrays_arrays_test_select_125
SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4, 5, 6, 7][3:6]) as slice_len;
-- Tag: arrays_arrays_test_select_126
SELECT id FROM metrics WHERE ARRAY_LENGTH(values[2:4]) > 0;
-- Tag: arrays_arrays_test_select_127
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6], ARRAY[7, 8]][2:3] as outer_slice;
-- Tag: arrays_arrays_test_select_128
SELECT ARRAY[ARRAY[1, 2, 3, 4, 5], ARRAY[6, 7, 8, 9, 10]][1][2:4] as inner_slice;
-- Tag: arrays_arrays_test_select_129
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice;
-- Tag: arrays_arrays_test_select_130
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_131
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_132
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_133
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_134
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_135
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS arr_data;
CREATE TABLE arr_data (id INT64, values ARRAY<INT64>);
INSERT INTO arr_data VALUES (1, NULL);
DROP TABLE IF EXISTS sequences;
CREATE TABLE sequences (id INT64, data ARRAY<INT64>);
INSERT INTO sequences VALUES (1, ARRAY[1, 2, 3, 4, 5]);
INSERT INTO sequences VALUES (2, ARRAY[10, 20, 30, 40, 50]);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, tags ARRAY<STRING>);
INSERT INTO items VALUES (1, ARRAY['a', 'b', 'c', 'd', 'e']);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, values ARRAY<FLOAT64>);
INSERT INTO metrics VALUES (1, ARRAY[1.1, 2.2, 3.3, 4.4, 5.5]);
DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_136
SELECT ARRAY[1, 2, 3, 4][1:4] as full;
-- Tag: arrays_arrays_test_select_137
SELECT ARRAY[10, 20, 30, 40, 50][:3] as from_start;
-- Tag: arrays_arrays_test_select_138
SELECT ARRAY[10, 20, 30, 40, 50][3:] as to_end;
-- Tag: arrays_arrays_test_select_139
SELECT ARRAY['x', 'y', 'z'][:] as all;
-- Tag: arrays_arrays_test_select_140
SELECT ARRAY[1, 2, 3, 4, 5][-3:-1] as negative_slice;
-- Tag: arrays_arrays_test_select_141
SELECT ARRAY[10, 20, 30, 40, 50][1:-1] as to_second_last;
-- Tag: arrays_arrays_test_select_142
SELECT ARRAY['a', 'b', 'c', 'd', 'e', 'f'][2:-2] as mixed;
-- Tag: arrays_arrays_test_select_143
SELECT ARRAY[1, 2, 3, 4, 5][-2:] as last_two;
-- Tag: arrays_arrays_test_select_144
SELECT ARRAY[1, 2, 3, 4, 5][4:2] as empty_slice;
-- Tag: arrays_arrays_test_select_145
SELECT ARRAY<INT64>[][1:3] as empty_slice;
-- Tag: arrays_arrays_test_select_146
SELECT ARRAY[1, 2, 3][1:100] as clamped;
-- Tag: arrays_arrays_test_select_147
SELECT ARRAY[10, 20, 30][-100:2] as clamped;
-- Tag: arrays_arrays_test_select_148
SELECT values[1:3] as slice FROM arr_data WHERE id = 1;
-- Tag: arrays_arrays_test_select_149
SELECT ARRAY[1, NULL, 3, NULL, 5][2:4] as with_nulls;
-- Tag: arrays_arrays_test_select_150
SELECT ARRAY[1, 2, 3, 4, 5, 6][1:6:2] as stepped;
-- Tag: arrays_arrays_test_select_151
SELECT ARRAY[1, 2, 3, 4, 5][::-1] as reversed;
-- Tag: arrays_arrays_test_select_152
SELECT id FROM sequences WHERE ARRAY_LENGTH(data[2:4]) = 3;
-- Tag: arrays_arrays_test_select_153
SELECT id FROM items WHERE tags[2:4][1] = 'b';
-- Tag: arrays_arrays_test_select_154
SELECT ARRAY_CONCAT(ARRAY[1, 2, 3][1:2], ARRAY[4, 5, 6][2:3]) as concat_slices;
-- Tag: arrays_arrays_test_select_155
SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4, 5, 6, 7][3:6]) as slice_len;
-- Tag: arrays_arrays_test_select_156
SELECT id FROM metrics WHERE ARRAY_LENGTH(values[2:4]) > 0;
-- Tag: arrays_arrays_test_select_157
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6], ARRAY[7, 8]][2:3] as outer_slice;
-- Tag: arrays_arrays_test_select_158
SELECT ARRAY[ARRAY[1, 2, 3, 4, 5], ARRAY[6, 7, 8, 9, 10]][1][2:4] as inner_slice;
-- Tag: arrays_arrays_test_select_159
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice;
-- Tag: arrays_arrays_test_select_160
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_161
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_162
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_163
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_164
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_165
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS arr_data;
CREATE TABLE arr_data (id INT64, values ARRAY<INT64>);
INSERT INTO arr_data VALUES (1, NULL);
DROP TABLE IF EXISTS sequences;
CREATE TABLE sequences (id INT64, data ARRAY<INT64>);
INSERT INTO sequences VALUES (1, ARRAY[1, 2, 3, 4, 5]);
INSERT INTO sequences VALUES (2, ARRAY[10, 20, 30, 40, 50]);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, tags ARRAY<STRING>);
INSERT INTO items VALUES (1, ARRAY['a', 'b', 'c', 'd', 'e']);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, values ARRAY<FLOAT64>);
INSERT INTO metrics VALUES (1, ARRAY[1.1, 2.2, 3.3, 4.4, 5.5]);
DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_166
SELECT ARRAY[10, 20, 30, 40, 50][:3] as from_start;
-- Tag: arrays_arrays_test_select_167
SELECT ARRAY[10, 20, 30, 40, 50][3:] as to_end;
-- Tag: arrays_arrays_test_select_168
SELECT ARRAY['x', 'y', 'z'][:] as all;
-- Tag: arrays_arrays_test_select_169
SELECT ARRAY[1, 2, 3, 4, 5][-3:-1] as negative_slice;
-- Tag: arrays_arrays_test_select_170
SELECT ARRAY[10, 20, 30, 40, 50][1:-1] as to_second_last;
-- Tag: arrays_arrays_test_select_171
SELECT ARRAY['a', 'b', 'c', 'd', 'e', 'f'][2:-2] as mixed;
-- Tag: arrays_arrays_test_select_172
SELECT ARRAY[1, 2, 3, 4, 5][-2:] as last_two;
-- Tag: arrays_arrays_test_select_173
SELECT ARRAY[1, 2, 3, 4, 5][4:2] as empty_slice;
-- Tag: arrays_arrays_test_select_174
SELECT ARRAY<INT64>[][1:3] as empty_slice;
-- Tag: arrays_arrays_test_select_175
SELECT ARRAY[1, 2, 3][1:100] as clamped;
-- Tag: arrays_arrays_test_select_176
SELECT ARRAY[10, 20, 30][-100:2] as clamped;
-- Tag: arrays_arrays_test_select_177
SELECT values[1:3] as slice FROM arr_data WHERE id = 1;
-- Tag: arrays_arrays_test_select_178
SELECT ARRAY[1, NULL, 3, NULL, 5][2:4] as with_nulls;
-- Tag: arrays_arrays_test_select_179
SELECT ARRAY[1, 2, 3, 4, 5, 6][1:6:2] as stepped;
-- Tag: arrays_arrays_test_select_180
SELECT ARRAY[1, 2, 3, 4, 5][::-1] as reversed;
-- Tag: arrays_arrays_test_select_181
SELECT id FROM sequences WHERE ARRAY_LENGTH(data[2:4]) = 3;
-- Tag: arrays_arrays_test_select_182
SELECT id FROM items WHERE tags[2:4][1] = 'b';
-- Tag: arrays_arrays_test_select_183
SELECT ARRAY_CONCAT(ARRAY[1, 2, 3][1:2], ARRAY[4, 5, 6][2:3]) as concat_slices;
-- Tag: arrays_arrays_test_select_184
SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4, 5, 6, 7][3:6]) as slice_len;
-- Tag: arrays_arrays_test_select_185
SELECT id FROM metrics WHERE ARRAY_LENGTH(values[2:4]) > 0;
-- Tag: arrays_arrays_test_select_186
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6], ARRAY[7, 8]][2:3] as outer_slice;
-- Tag: arrays_arrays_test_select_187
SELECT ARRAY[ARRAY[1, 2, 3, 4, 5], ARRAY[6, 7, 8, 9, 10]][1][2:4] as inner_slice;
-- Tag: arrays_arrays_test_select_188
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice;
-- Tag: arrays_arrays_test_select_189
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_190
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_191
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_192
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_193
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_194
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS arr_data;
CREATE TABLE arr_data (id INT64, values ARRAY<INT64>);
INSERT INTO arr_data VALUES (1, NULL);
DROP TABLE IF EXISTS sequences;
CREATE TABLE sequences (id INT64, data ARRAY<INT64>);
INSERT INTO sequences VALUES (1, ARRAY[1, 2, 3, 4, 5]);
INSERT INTO sequences VALUES (2, ARRAY[10, 20, 30, 40, 50]);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, tags ARRAY<STRING>);
INSERT INTO items VALUES (1, ARRAY['a', 'b', 'c', 'd', 'e']);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, values ARRAY<FLOAT64>);
INSERT INTO metrics VALUES (1, ARRAY[1.1, 2.2, 3.3, 4.4, 5.5]);
DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_195
SELECT ARRAY[10, 20, 30, 40, 50][3:] as to_end;
-- Tag: arrays_arrays_test_select_196
SELECT ARRAY['x', 'y', 'z'][:] as all;
-- Tag: arrays_arrays_test_select_197
SELECT ARRAY[1, 2, 3, 4, 5][-3:-1] as negative_slice;
-- Tag: arrays_arrays_test_select_198
SELECT ARRAY[10, 20, 30, 40, 50][1:-1] as to_second_last;
-- Tag: arrays_arrays_test_select_199
SELECT ARRAY['a', 'b', 'c', 'd', 'e', 'f'][2:-2] as mixed;
-- Tag: arrays_arrays_test_select_200
SELECT ARRAY[1, 2, 3, 4, 5][-2:] as last_two;
-- Tag: arrays_arrays_test_select_201
SELECT ARRAY[1, 2, 3, 4, 5][4:2] as empty_slice;
-- Tag: arrays_arrays_test_select_202
SELECT ARRAY<INT64>[][1:3] as empty_slice;
-- Tag: arrays_arrays_test_select_203
SELECT ARRAY[1, 2, 3][1:100] as clamped;
-- Tag: arrays_arrays_test_select_204
SELECT ARRAY[10, 20, 30][-100:2] as clamped;
-- Tag: arrays_arrays_test_select_205
SELECT values[1:3] as slice FROM arr_data WHERE id = 1;
-- Tag: arrays_arrays_test_select_206
SELECT ARRAY[1, NULL, 3, NULL, 5][2:4] as with_nulls;
-- Tag: arrays_arrays_test_select_207
SELECT ARRAY[1, 2, 3, 4, 5, 6][1:6:2] as stepped;
-- Tag: arrays_arrays_test_select_208
SELECT ARRAY[1, 2, 3, 4, 5][::-1] as reversed;
-- Tag: arrays_arrays_test_select_209
SELECT id FROM sequences WHERE ARRAY_LENGTH(data[2:4]) = 3;
-- Tag: arrays_arrays_test_select_210
SELECT id FROM items WHERE tags[2:4][1] = 'b';
-- Tag: arrays_arrays_test_select_211
SELECT ARRAY_CONCAT(ARRAY[1, 2, 3][1:2], ARRAY[4, 5, 6][2:3]) as concat_slices;
-- Tag: arrays_arrays_test_select_212
SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4, 5, 6, 7][3:6]) as slice_len;
-- Tag: arrays_arrays_test_select_213
SELECT id FROM metrics WHERE ARRAY_LENGTH(values[2:4]) > 0;
-- Tag: arrays_arrays_test_select_214
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6], ARRAY[7, 8]][2:3] as outer_slice;
-- Tag: arrays_arrays_test_select_215
SELECT ARRAY[ARRAY[1, 2, 3, 4, 5], ARRAY[6, 7, 8, 9, 10]][1][2:4] as inner_slice;
-- Tag: arrays_arrays_test_select_216
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice;
-- Tag: arrays_arrays_test_select_217
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_218
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_219
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_220
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_221
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_222
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS arr_data;
CREATE TABLE arr_data (id INT64, values ARRAY<INT64>);
INSERT INTO arr_data VALUES (1, NULL);
DROP TABLE IF EXISTS sequences;
CREATE TABLE sequences (id INT64, data ARRAY<INT64>);
INSERT INTO sequences VALUES (1, ARRAY[1, 2, 3, 4, 5]);
INSERT INTO sequences VALUES (2, ARRAY[10, 20, 30, 40, 50]);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, tags ARRAY<STRING>);
INSERT INTO items VALUES (1, ARRAY['a', 'b', 'c', 'd', 'e']);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, values ARRAY<FLOAT64>);
INSERT INTO metrics VALUES (1, ARRAY[1.1, 2.2, 3.3, 4.4, 5.5]);
DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_223
SELECT ARRAY['x', 'y', 'z'][:] as all;
-- Tag: arrays_arrays_test_select_224
SELECT ARRAY[1, 2, 3, 4, 5][-3:-1] as negative_slice;
-- Tag: arrays_arrays_test_select_225
SELECT ARRAY[10, 20, 30, 40, 50][1:-1] as to_second_last;
-- Tag: arrays_arrays_test_select_226
SELECT ARRAY['a', 'b', 'c', 'd', 'e', 'f'][2:-2] as mixed;
-- Tag: arrays_arrays_test_select_227
SELECT ARRAY[1, 2, 3, 4, 5][-2:] as last_two;
-- Tag: arrays_arrays_test_select_228
SELECT ARRAY[1, 2, 3, 4, 5][4:2] as empty_slice;
-- Tag: arrays_arrays_test_select_229
SELECT ARRAY<INT64>[][1:3] as empty_slice;
-- Tag: arrays_arrays_test_select_230
SELECT ARRAY[1, 2, 3][1:100] as clamped;
-- Tag: arrays_arrays_test_select_231
SELECT ARRAY[10, 20, 30][-100:2] as clamped;
-- Tag: arrays_arrays_test_select_232
SELECT values[1:3] as slice FROM arr_data WHERE id = 1;
-- Tag: arrays_arrays_test_select_233
SELECT ARRAY[1, NULL, 3, NULL, 5][2:4] as with_nulls;
-- Tag: arrays_arrays_test_select_234
SELECT ARRAY[1, 2, 3, 4, 5, 6][1:6:2] as stepped;
-- Tag: arrays_arrays_test_select_235
SELECT ARRAY[1, 2, 3, 4, 5][::-1] as reversed;
-- Tag: arrays_arrays_test_select_236
SELECT id FROM sequences WHERE ARRAY_LENGTH(data[2:4]) = 3;
-- Tag: arrays_arrays_test_select_237
SELECT id FROM items WHERE tags[2:4][1] = 'b';
-- Tag: arrays_arrays_test_select_238
SELECT ARRAY_CONCAT(ARRAY[1, 2, 3][1:2], ARRAY[4, 5, 6][2:3]) as concat_slices;
-- Tag: arrays_arrays_test_select_239
SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4, 5, 6, 7][3:6]) as slice_len;
-- Tag: arrays_arrays_test_select_240
SELECT id FROM metrics WHERE ARRAY_LENGTH(values[2:4]) > 0;
-- Tag: arrays_arrays_test_select_241
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6], ARRAY[7, 8]][2:3] as outer_slice;
-- Tag: arrays_arrays_test_select_242
SELECT ARRAY[ARRAY[1, 2, 3, 4, 5], ARRAY[6, 7, 8, 9, 10]][1][2:4] as inner_slice;
-- Tag: arrays_arrays_test_select_243
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice;
-- Tag: arrays_arrays_test_select_244
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_245
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_246
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_247
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_248
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_249
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS arr_data;
CREATE TABLE arr_data (id INT64, values ARRAY<INT64>);
INSERT INTO arr_data VALUES (1, NULL);
DROP TABLE IF EXISTS sequences;
CREATE TABLE sequences (id INT64, data ARRAY<INT64>);
INSERT INTO sequences VALUES (1, ARRAY[1, 2, 3, 4, 5]);
INSERT INTO sequences VALUES (2, ARRAY[10, 20, 30, 40, 50]);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, tags ARRAY<STRING>);
INSERT INTO items VALUES (1, ARRAY['a', 'b', 'c', 'd', 'e']);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, values ARRAY<FLOAT64>);
INSERT INTO metrics VALUES (1, ARRAY[1.1, 2.2, 3.3, 4.4, 5.5]);
DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_250
SELECT ARRAY[1, 2, 3, 4, 5][-3:-1] as negative_slice;
-- Tag: arrays_arrays_test_select_251
SELECT ARRAY[10, 20, 30, 40, 50][1:-1] as to_second_last;
-- Tag: arrays_arrays_test_select_252
SELECT ARRAY['a', 'b', 'c', 'd', 'e', 'f'][2:-2] as mixed;
-- Tag: arrays_arrays_test_select_253
SELECT ARRAY[1, 2, 3, 4, 5][-2:] as last_two;
-- Tag: arrays_arrays_test_select_254
SELECT ARRAY[1, 2, 3, 4, 5][4:2] as empty_slice;
-- Tag: arrays_arrays_test_select_255
SELECT ARRAY<INT64>[][1:3] as empty_slice;
-- Tag: arrays_arrays_test_select_256
SELECT ARRAY[1, 2, 3][1:100] as clamped;
-- Tag: arrays_arrays_test_select_257
SELECT ARRAY[10, 20, 30][-100:2] as clamped;
-- Tag: arrays_arrays_test_select_258
SELECT values[1:3] as slice FROM arr_data WHERE id = 1;
-- Tag: arrays_arrays_test_select_259
SELECT ARRAY[1, NULL, 3, NULL, 5][2:4] as with_nulls;
-- Tag: arrays_arrays_test_select_260
SELECT ARRAY[1, 2, 3, 4, 5, 6][1:6:2] as stepped;
-- Tag: arrays_arrays_test_select_261
SELECT ARRAY[1, 2, 3, 4, 5][::-1] as reversed;
-- Tag: arrays_arrays_test_select_262
SELECT id FROM sequences WHERE ARRAY_LENGTH(data[2:4]) = 3;
-- Tag: arrays_arrays_test_select_263
SELECT id FROM items WHERE tags[2:4][1] = 'b';
-- Tag: arrays_arrays_test_select_264
SELECT ARRAY_CONCAT(ARRAY[1, 2, 3][1:2], ARRAY[4, 5, 6][2:3]) as concat_slices;
-- Tag: arrays_arrays_test_select_265
SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4, 5, 6, 7][3:6]) as slice_len;
-- Tag: arrays_arrays_test_select_266
SELECT id FROM metrics WHERE ARRAY_LENGTH(values[2:4]) > 0;
-- Tag: arrays_arrays_test_select_267
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6], ARRAY[7, 8]][2:3] as outer_slice;
-- Tag: arrays_arrays_test_select_268
SELECT ARRAY[ARRAY[1, 2, 3, 4, 5], ARRAY[6, 7, 8, 9, 10]][1][2:4] as inner_slice;
-- Tag: arrays_arrays_test_select_269
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice;
-- Tag: arrays_arrays_test_select_270
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_271
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_272
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_273
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_274
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_275
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS arr_data;
CREATE TABLE arr_data (id INT64, values ARRAY<INT64>);
INSERT INTO arr_data VALUES (1, NULL);
DROP TABLE IF EXISTS sequences;
CREATE TABLE sequences (id INT64, data ARRAY<INT64>);
INSERT INTO sequences VALUES (1, ARRAY[1, 2, 3, 4, 5]);
INSERT INTO sequences VALUES (2, ARRAY[10, 20, 30, 40, 50]);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, tags ARRAY<STRING>);
INSERT INTO items VALUES (1, ARRAY['a', 'b', 'c', 'd', 'e']);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, values ARRAY<FLOAT64>);
INSERT INTO metrics VALUES (1, ARRAY[1.1, 2.2, 3.3, 4.4, 5.5]);
DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_276
SELECT ARRAY[10, 20, 30, 40, 50][1:-1] as to_second_last;
-- Tag: arrays_arrays_test_select_277
SELECT ARRAY['a', 'b', 'c', 'd', 'e', 'f'][2:-2] as mixed;
-- Tag: arrays_arrays_test_select_278
SELECT ARRAY[1, 2, 3, 4, 5][-2:] as last_two;
-- Tag: arrays_arrays_test_select_279
SELECT ARRAY[1, 2, 3, 4, 5][4:2] as empty_slice;
-- Tag: arrays_arrays_test_select_280
SELECT ARRAY<INT64>[][1:3] as empty_slice;
-- Tag: arrays_arrays_test_select_281
SELECT ARRAY[1, 2, 3][1:100] as clamped;
-- Tag: arrays_arrays_test_select_282
SELECT ARRAY[10, 20, 30][-100:2] as clamped;
-- Tag: arrays_arrays_test_select_283
SELECT values[1:3] as slice FROM arr_data WHERE id = 1;
-- Tag: arrays_arrays_test_select_284
SELECT ARRAY[1, NULL, 3, NULL, 5][2:4] as with_nulls;
-- Tag: arrays_arrays_test_select_285
SELECT ARRAY[1, 2, 3, 4, 5, 6][1:6:2] as stepped;
-- Tag: arrays_arrays_test_select_286
SELECT ARRAY[1, 2, 3, 4, 5][::-1] as reversed;
-- Tag: arrays_arrays_test_select_287
SELECT id FROM sequences WHERE ARRAY_LENGTH(data[2:4]) = 3;
-- Tag: arrays_arrays_test_select_288
SELECT id FROM items WHERE tags[2:4][1] = 'b';
-- Tag: arrays_arrays_test_select_289
SELECT ARRAY_CONCAT(ARRAY[1, 2, 3][1:2], ARRAY[4, 5, 6][2:3]) as concat_slices;
-- Tag: arrays_arrays_test_select_290
SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4, 5, 6, 7][3:6]) as slice_len;
-- Tag: arrays_arrays_test_select_291
SELECT id FROM metrics WHERE ARRAY_LENGTH(values[2:4]) > 0;
-- Tag: arrays_arrays_test_select_292
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6], ARRAY[7, 8]][2:3] as outer_slice;
-- Tag: arrays_arrays_test_select_293
SELECT ARRAY[ARRAY[1, 2, 3, 4, 5], ARRAY[6, 7, 8, 9, 10]][1][2:4] as inner_slice;
-- Tag: arrays_arrays_test_select_294
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice;
-- Tag: arrays_arrays_test_select_295
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_296
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_297
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_298
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_299
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_300
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS arr_data;
CREATE TABLE arr_data (id INT64, values ARRAY<INT64>);
INSERT INTO arr_data VALUES (1, NULL);
DROP TABLE IF EXISTS sequences;
CREATE TABLE sequences (id INT64, data ARRAY<INT64>);
INSERT INTO sequences VALUES (1, ARRAY[1, 2, 3, 4, 5]);
INSERT INTO sequences VALUES (2, ARRAY[10, 20, 30, 40, 50]);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, tags ARRAY<STRING>);
INSERT INTO items VALUES (1, ARRAY['a', 'b', 'c', 'd', 'e']);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, values ARRAY<FLOAT64>);
INSERT INTO metrics VALUES (1, ARRAY[1.1, 2.2, 3.3, 4.4, 5.5]);
DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_301
SELECT ARRAY['a', 'b', 'c', 'd', 'e', 'f'][2:-2] as mixed;
-- Tag: arrays_arrays_test_select_302
SELECT ARRAY[1, 2, 3, 4, 5][-2:] as last_two;
-- Tag: arrays_arrays_test_select_303
SELECT ARRAY[1, 2, 3, 4, 5][4:2] as empty_slice;
-- Tag: arrays_arrays_test_select_304
SELECT ARRAY<INT64>[][1:3] as empty_slice;
-- Tag: arrays_arrays_test_select_305
SELECT ARRAY[1, 2, 3][1:100] as clamped;
-- Tag: arrays_arrays_test_select_306
SELECT ARRAY[10, 20, 30][-100:2] as clamped;
-- Tag: arrays_arrays_test_select_307
SELECT values[1:3] as slice FROM arr_data WHERE id = 1;
-- Tag: arrays_arrays_test_select_308
SELECT ARRAY[1, NULL, 3, NULL, 5][2:4] as with_nulls;
-- Tag: arrays_arrays_test_select_309
SELECT ARRAY[1, 2, 3, 4, 5, 6][1:6:2] as stepped;
-- Tag: arrays_arrays_test_select_310
SELECT ARRAY[1, 2, 3, 4, 5][::-1] as reversed;
-- Tag: arrays_arrays_test_select_311
SELECT id FROM sequences WHERE ARRAY_LENGTH(data[2:4]) = 3;
-- Tag: arrays_arrays_test_select_312
SELECT id FROM items WHERE tags[2:4][1] = 'b';
-- Tag: arrays_arrays_test_select_313
SELECT ARRAY_CONCAT(ARRAY[1, 2, 3][1:2], ARRAY[4, 5, 6][2:3]) as concat_slices;
-- Tag: arrays_arrays_test_select_314
SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4, 5, 6, 7][3:6]) as slice_len;
-- Tag: arrays_arrays_test_select_315
SELECT id FROM metrics WHERE ARRAY_LENGTH(values[2:4]) > 0;
-- Tag: arrays_arrays_test_select_316
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6], ARRAY[7, 8]][2:3] as outer_slice;
-- Tag: arrays_arrays_test_select_317
SELECT ARRAY[ARRAY[1, 2, 3, 4, 5], ARRAY[6, 7, 8, 9, 10]][1][2:4] as inner_slice;
-- Tag: arrays_arrays_test_select_318
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice;
-- Tag: arrays_arrays_test_select_319
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_320
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_321
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_322
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_323
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_324
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS arr_data;
CREATE TABLE arr_data (id INT64, values ARRAY<INT64>);
INSERT INTO arr_data VALUES (1, NULL);
DROP TABLE IF EXISTS sequences;
CREATE TABLE sequences (id INT64, data ARRAY<INT64>);
INSERT INTO sequences VALUES (1, ARRAY[1, 2, 3, 4, 5]);
INSERT INTO sequences VALUES (2, ARRAY[10, 20, 30, 40, 50]);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, tags ARRAY<STRING>);
INSERT INTO items VALUES (1, ARRAY['a', 'b', 'c', 'd', 'e']);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, values ARRAY<FLOAT64>);
INSERT INTO metrics VALUES (1, ARRAY[1.1, 2.2, 3.3, 4.4, 5.5]);
DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_325
SELECT ARRAY[1, 2, 3, 4, 5][-2:] as last_two;
-- Tag: arrays_arrays_test_select_326
SELECT ARRAY[1, 2, 3, 4, 5][4:2] as empty_slice;
-- Tag: arrays_arrays_test_select_327
SELECT ARRAY<INT64>[][1:3] as empty_slice;
-- Tag: arrays_arrays_test_select_328
SELECT ARRAY[1, 2, 3][1:100] as clamped;
-- Tag: arrays_arrays_test_select_329
SELECT ARRAY[10, 20, 30][-100:2] as clamped;
-- Tag: arrays_arrays_test_select_330
SELECT values[1:3] as slice FROM arr_data WHERE id = 1;
-- Tag: arrays_arrays_test_select_331
SELECT ARRAY[1, NULL, 3, NULL, 5][2:4] as with_nulls;
-- Tag: arrays_arrays_test_select_332
SELECT ARRAY[1, 2, 3, 4, 5, 6][1:6:2] as stepped;
-- Tag: arrays_arrays_test_select_333
SELECT ARRAY[1, 2, 3, 4, 5][::-1] as reversed;
-- Tag: arrays_arrays_test_select_334
SELECT id FROM sequences WHERE ARRAY_LENGTH(data[2:4]) = 3;
-- Tag: arrays_arrays_test_select_335
SELECT id FROM items WHERE tags[2:4][1] = 'b';
-- Tag: arrays_arrays_test_select_336
SELECT ARRAY_CONCAT(ARRAY[1, 2, 3][1:2], ARRAY[4, 5, 6][2:3]) as concat_slices;
-- Tag: arrays_arrays_test_select_337
SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4, 5, 6, 7][3:6]) as slice_len;
-- Tag: arrays_arrays_test_select_338
SELECT id FROM metrics WHERE ARRAY_LENGTH(values[2:4]) > 0;
-- Tag: arrays_arrays_test_select_339
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6], ARRAY[7, 8]][2:3] as outer_slice;
-- Tag: arrays_arrays_test_select_340
SELECT ARRAY[ARRAY[1, 2, 3, 4, 5], ARRAY[6, 7, 8, 9, 10]][1][2:4] as inner_slice;
-- Tag: arrays_arrays_test_select_341
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice;
-- Tag: arrays_arrays_test_select_342
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_343
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_344
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_345
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_346
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_347
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS arr_data;
CREATE TABLE arr_data (id INT64, values ARRAY<INT64>);
INSERT INTO arr_data VALUES (1, NULL);
DROP TABLE IF EXISTS sequences;
CREATE TABLE sequences (id INT64, data ARRAY<INT64>);
INSERT INTO sequences VALUES (1, ARRAY[1, 2, 3, 4, 5]);
INSERT INTO sequences VALUES (2, ARRAY[10, 20, 30, 40, 50]);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, tags ARRAY<STRING>);
INSERT INTO items VALUES (1, ARRAY['a', 'b', 'c', 'd', 'e']);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, values ARRAY<FLOAT64>);
INSERT INTO metrics VALUES (1, ARRAY[1.1, 2.2, 3.3, 4.4, 5.5]);
DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_348
SELECT ARRAY[1, 2, 3, 4, 5][4:2] as empty_slice;
-- Tag: arrays_arrays_test_select_349
SELECT ARRAY<INT64>[][1:3] as empty_slice;
-- Tag: arrays_arrays_test_select_350
SELECT ARRAY[1, 2, 3][1:100] as clamped;
-- Tag: arrays_arrays_test_select_351
SELECT ARRAY[10, 20, 30][-100:2] as clamped;
-- Tag: arrays_arrays_test_select_352
SELECT values[1:3] as slice FROM arr_data WHERE id = 1;
-- Tag: arrays_arrays_test_select_353
SELECT ARRAY[1, NULL, 3, NULL, 5][2:4] as with_nulls;
-- Tag: arrays_arrays_test_select_354
SELECT ARRAY[1, 2, 3, 4, 5, 6][1:6:2] as stepped;
-- Tag: arrays_arrays_test_select_355
SELECT ARRAY[1, 2, 3, 4, 5][::-1] as reversed;
-- Tag: arrays_arrays_test_select_356
SELECT id FROM sequences WHERE ARRAY_LENGTH(data[2:4]) = 3;
-- Tag: arrays_arrays_test_select_357
SELECT id FROM items WHERE tags[2:4][1] = 'b';
-- Tag: arrays_arrays_test_select_358
SELECT ARRAY_CONCAT(ARRAY[1, 2, 3][1:2], ARRAY[4, 5, 6][2:3]) as concat_slices;
-- Tag: arrays_arrays_test_select_359
SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4, 5, 6, 7][3:6]) as slice_len;
-- Tag: arrays_arrays_test_select_360
SELECT id FROM metrics WHERE ARRAY_LENGTH(values[2:4]) > 0;
-- Tag: arrays_arrays_test_select_361
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6], ARRAY[7, 8]][2:3] as outer_slice;
-- Tag: arrays_arrays_test_select_362
SELECT ARRAY[ARRAY[1, 2, 3, 4, 5], ARRAY[6, 7, 8, 9, 10]][1][2:4] as inner_slice;
-- Tag: arrays_arrays_test_select_363
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice;
-- Tag: arrays_arrays_test_select_364
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_365
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_366
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_367
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_368
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_369
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS arr_data;
CREATE TABLE arr_data (id INT64, values ARRAY<INT64>);
INSERT INTO arr_data VALUES (1, NULL);
DROP TABLE IF EXISTS sequences;
CREATE TABLE sequences (id INT64, data ARRAY<INT64>);
INSERT INTO sequences VALUES (1, ARRAY[1, 2, 3, 4, 5]);
INSERT INTO sequences VALUES (2, ARRAY[10, 20, 30, 40, 50]);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, tags ARRAY<STRING>);
INSERT INTO items VALUES (1, ARRAY['a', 'b', 'c', 'd', 'e']);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, values ARRAY<FLOAT64>);
INSERT INTO metrics VALUES (1, ARRAY[1.1, 2.2, 3.3, 4.4, 5.5]);
DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_370
SELECT ARRAY<INT64>[][1:3] as empty_slice;
-- Tag: arrays_arrays_test_select_371
SELECT ARRAY[1, 2, 3][1:100] as clamped;
-- Tag: arrays_arrays_test_select_372
SELECT ARRAY[10, 20, 30][-100:2] as clamped;
-- Tag: arrays_arrays_test_select_373
SELECT values[1:3] as slice FROM arr_data WHERE id = 1;
-- Tag: arrays_arrays_test_select_374
SELECT ARRAY[1, NULL, 3, NULL, 5][2:4] as with_nulls;
-- Tag: arrays_arrays_test_select_375
SELECT ARRAY[1, 2, 3, 4, 5, 6][1:6:2] as stepped;
-- Tag: arrays_arrays_test_select_376
SELECT ARRAY[1, 2, 3, 4, 5][::-1] as reversed;
-- Tag: arrays_arrays_test_select_377
SELECT id FROM sequences WHERE ARRAY_LENGTH(data[2:4]) = 3;
-- Tag: arrays_arrays_test_select_378
SELECT id FROM items WHERE tags[2:4][1] = 'b';
-- Tag: arrays_arrays_test_select_379
SELECT ARRAY_CONCAT(ARRAY[1, 2, 3][1:2], ARRAY[4, 5, 6][2:3]) as concat_slices;
-- Tag: arrays_arrays_test_select_380
SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4, 5, 6, 7][3:6]) as slice_len;
-- Tag: arrays_arrays_test_select_381
SELECT id FROM metrics WHERE ARRAY_LENGTH(values[2:4]) > 0;
-- Tag: arrays_arrays_test_select_382
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6], ARRAY[7, 8]][2:3] as outer_slice;
-- Tag: arrays_arrays_test_select_383
SELECT ARRAY[ARRAY[1, 2, 3, 4, 5], ARRAY[6, 7, 8, 9, 10]][1][2:4] as inner_slice;
-- Tag: arrays_arrays_test_select_384
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice;
-- Tag: arrays_arrays_test_select_385
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_386
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_387
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_388
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_389
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_390
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS arr_data;
CREATE TABLE arr_data (id INT64, values ARRAY<INT64>);
INSERT INTO arr_data VALUES (1, NULL);
DROP TABLE IF EXISTS sequences;
CREATE TABLE sequences (id INT64, data ARRAY<INT64>);
INSERT INTO sequences VALUES (1, ARRAY[1, 2, 3, 4, 5]);
INSERT INTO sequences VALUES (2, ARRAY[10, 20, 30, 40, 50]);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, tags ARRAY<STRING>);
INSERT INTO items VALUES (1, ARRAY['a', 'b', 'c', 'd', 'e']);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, values ARRAY<FLOAT64>);
INSERT INTO metrics VALUES (1, ARRAY[1.1, 2.2, 3.3, 4.4, 5.5]);
DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_391
SELECT ARRAY[1, 2, 3][1:100] as clamped;
-- Tag: arrays_arrays_test_select_392
SELECT ARRAY[10, 20, 30][-100:2] as clamped;
-- Tag: arrays_arrays_test_select_393
SELECT values[1:3] as slice FROM arr_data WHERE id = 1;
-- Tag: arrays_arrays_test_select_394
SELECT ARRAY[1, NULL, 3, NULL, 5][2:4] as with_nulls;
-- Tag: arrays_arrays_test_select_395
SELECT ARRAY[1, 2, 3, 4, 5, 6][1:6:2] as stepped;
-- Tag: arrays_arrays_test_select_396
SELECT ARRAY[1, 2, 3, 4, 5][::-1] as reversed;
-- Tag: arrays_arrays_test_select_397
SELECT id FROM sequences WHERE ARRAY_LENGTH(data[2:4]) = 3;
-- Tag: arrays_arrays_test_select_398
SELECT id FROM items WHERE tags[2:4][1] = 'b';
-- Tag: arrays_arrays_test_select_399
SELECT ARRAY_CONCAT(ARRAY[1, 2, 3][1:2], ARRAY[4, 5, 6][2:3]) as concat_slices;
-- Tag: arrays_arrays_test_select_400
SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4, 5, 6, 7][3:6]) as slice_len;
-- Tag: arrays_arrays_test_select_401
SELECT id FROM metrics WHERE ARRAY_LENGTH(values[2:4]) > 0;
-- Tag: arrays_arrays_test_select_402
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6], ARRAY[7, 8]][2:3] as outer_slice;
-- Tag: arrays_arrays_test_select_403
SELECT ARRAY[ARRAY[1, 2, 3, 4, 5], ARRAY[6, 7, 8, 9, 10]][1][2:4] as inner_slice;
-- Tag: arrays_arrays_test_select_404
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice;
-- Tag: arrays_arrays_test_select_405
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_406
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_407
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_408
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_409
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_410
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS arr_data;
CREATE TABLE arr_data (id INT64, values ARRAY<INT64>);
INSERT INTO arr_data VALUES (1, NULL);
DROP TABLE IF EXISTS sequences;
CREATE TABLE sequences (id INT64, data ARRAY<INT64>);
INSERT INTO sequences VALUES (1, ARRAY[1, 2, 3, 4, 5]);
INSERT INTO sequences VALUES (2, ARRAY[10, 20, 30, 40, 50]);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, tags ARRAY<STRING>);
INSERT INTO items VALUES (1, ARRAY['a', 'b', 'c', 'd', 'e']);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, values ARRAY<FLOAT64>);
INSERT INTO metrics VALUES (1, ARRAY[1.1, 2.2, 3.3, 4.4, 5.5]);
DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_411
SELECT ARRAY[10, 20, 30][-100:2] as clamped;
-- Tag: arrays_arrays_test_select_412
SELECT values[1:3] as slice FROM arr_data WHERE id = 1;
-- Tag: arrays_arrays_test_select_413
SELECT ARRAY[1, NULL, 3, NULL, 5][2:4] as with_nulls;
-- Tag: arrays_arrays_test_select_414
SELECT ARRAY[1, 2, 3, 4, 5, 6][1:6:2] as stepped;
-- Tag: arrays_arrays_test_select_415
SELECT ARRAY[1, 2, 3, 4, 5][::-1] as reversed;
-- Tag: arrays_arrays_test_select_416
SELECT id FROM sequences WHERE ARRAY_LENGTH(data[2:4]) = 3;
-- Tag: arrays_arrays_test_select_417
SELECT id FROM items WHERE tags[2:4][1] = 'b';
-- Tag: arrays_arrays_test_select_418
SELECT ARRAY_CONCAT(ARRAY[1, 2, 3][1:2], ARRAY[4, 5, 6][2:3]) as concat_slices;
-- Tag: arrays_arrays_test_select_419
SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4, 5, 6, 7][3:6]) as slice_len;
-- Tag: arrays_arrays_test_select_420
SELECT id FROM metrics WHERE ARRAY_LENGTH(values[2:4]) > 0;
-- Tag: arrays_arrays_test_select_421
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6], ARRAY[7, 8]][2:3] as outer_slice;
-- Tag: arrays_arrays_test_select_422
SELECT ARRAY[ARRAY[1, 2, 3, 4, 5], ARRAY[6, 7, 8, 9, 10]][1][2:4] as inner_slice;
-- Tag: arrays_arrays_test_select_423
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice;
-- Tag: arrays_arrays_test_select_424
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_425
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_426
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_427
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_428
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_429
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS arr_data;
CREATE TABLE arr_data (id INT64, values ARRAY<INT64>);
INSERT INTO arr_data VALUES (1, NULL);
DROP TABLE IF EXISTS sequences;
CREATE TABLE sequences (id INT64, data ARRAY<INT64>);
INSERT INTO sequences VALUES (1, ARRAY[1, 2, 3, 4, 5]);
INSERT INTO sequences VALUES (2, ARRAY[10, 20, 30, 40, 50]);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, tags ARRAY<STRING>);
INSERT INTO items VALUES (1, ARRAY['a', 'b', 'c', 'd', 'e']);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, values ARRAY<FLOAT64>);
INSERT INTO metrics VALUES (1, ARRAY[1.1, 2.2, 3.3, 4.4, 5.5]);
DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_430
SELECT values[1:3] as slice FROM arr_data WHERE id = 1;
-- Tag: arrays_arrays_test_select_431
SELECT ARRAY[1, NULL, 3, NULL, 5][2:4] as with_nulls;
-- Tag: arrays_arrays_test_select_432
SELECT ARRAY[1, 2, 3, 4, 5, 6][1:6:2] as stepped;
-- Tag: arrays_arrays_test_select_433
SELECT ARRAY[1, 2, 3, 4, 5][::-1] as reversed;
-- Tag: arrays_arrays_test_select_434
SELECT id FROM sequences WHERE ARRAY_LENGTH(data[2:4]) = 3;
-- Tag: arrays_arrays_test_select_435
SELECT id FROM items WHERE tags[2:4][1] = 'b';
-- Tag: arrays_arrays_test_select_436
SELECT ARRAY_CONCAT(ARRAY[1, 2, 3][1:2], ARRAY[4, 5, 6][2:3]) as concat_slices;
-- Tag: arrays_arrays_test_select_437
SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4, 5, 6, 7][3:6]) as slice_len;
-- Tag: arrays_arrays_test_select_438
SELECT id FROM metrics WHERE ARRAY_LENGTH(values[2:4]) > 0;
-- Tag: arrays_arrays_test_select_439
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6], ARRAY[7, 8]][2:3] as outer_slice;
-- Tag: arrays_arrays_test_select_440
SELECT ARRAY[ARRAY[1, 2, 3, 4, 5], ARRAY[6, 7, 8, 9, 10]][1][2:4] as inner_slice;
-- Tag: arrays_arrays_test_select_441
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice;
-- Tag: arrays_arrays_test_select_442
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_443
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_444
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_445
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_446
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_447
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS sequences;
CREATE TABLE sequences (id INT64, data ARRAY<INT64>);
INSERT INTO sequences VALUES (1, ARRAY[1, 2, 3, 4, 5]);
INSERT INTO sequences VALUES (2, ARRAY[10, 20, 30, 40, 50]);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, tags ARRAY<STRING>);
INSERT INTO items VALUES (1, ARRAY['a', 'b', 'c', 'd', 'e']);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, values ARRAY<FLOAT64>);
INSERT INTO metrics VALUES (1, ARRAY[1.1, 2.2, 3.3, 4.4, 5.5]);
DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_448
SELECT ARRAY[1, NULL, 3, NULL, 5][2:4] as with_nulls;
-- Tag: arrays_arrays_test_select_449
SELECT ARRAY[1, 2, 3, 4, 5, 6][1:6:2] as stepped;
-- Tag: arrays_arrays_test_select_450
SELECT ARRAY[1, 2, 3, 4, 5][::-1] as reversed;
-- Tag: arrays_arrays_test_select_451
SELECT id FROM sequences WHERE ARRAY_LENGTH(data[2:4]) = 3;
-- Tag: arrays_arrays_test_select_452
SELECT id FROM items WHERE tags[2:4][1] = 'b';
-- Tag: arrays_arrays_test_select_453
SELECT ARRAY_CONCAT(ARRAY[1, 2, 3][1:2], ARRAY[4, 5, 6][2:3]) as concat_slices;
-- Tag: arrays_arrays_test_select_454
SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4, 5, 6, 7][3:6]) as slice_len;
-- Tag: arrays_arrays_test_select_455
SELECT id FROM metrics WHERE ARRAY_LENGTH(values[2:4]) > 0;
-- Tag: arrays_arrays_test_select_456
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6], ARRAY[7, 8]][2:3] as outer_slice;
-- Tag: arrays_arrays_test_select_457
SELECT ARRAY[ARRAY[1, 2, 3, 4, 5], ARRAY[6, 7, 8, 9, 10]][1][2:4] as inner_slice;
-- Tag: arrays_arrays_test_select_458
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice;
-- Tag: arrays_arrays_test_select_459
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_460
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_461
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_462
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_463
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_464
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS sequences;
CREATE TABLE sequences (id INT64, data ARRAY<INT64>);
INSERT INTO sequences VALUES (1, ARRAY[1, 2, 3, 4, 5]);
INSERT INTO sequences VALUES (2, ARRAY[10, 20, 30, 40, 50]);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, tags ARRAY<STRING>);
INSERT INTO items VALUES (1, ARRAY['a', 'b', 'c', 'd', 'e']);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, values ARRAY<FLOAT64>);
INSERT INTO metrics VALUES (1, ARRAY[1.1, 2.2, 3.3, 4.4, 5.5]);
DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_465
SELECT ARRAY[1, 2, 3, 4, 5, 6][1:6:2] as stepped;
-- Tag: arrays_arrays_test_select_466
SELECT ARRAY[1, 2, 3, 4, 5][::-1] as reversed;
-- Tag: arrays_arrays_test_select_467
SELECT id FROM sequences WHERE ARRAY_LENGTH(data[2:4]) = 3;
-- Tag: arrays_arrays_test_select_468
SELECT id FROM items WHERE tags[2:4][1] = 'b';
-- Tag: arrays_arrays_test_select_469
SELECT ARRAY_CONCAT(ARRAY[1, 2, 3][1:2], ARRAY[4, 5, 6][2:3]) as concat_slices;
-- Tag: arrays_arrays_test_select_470
SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4, 5, 6, 7][3:6]) as slice_len;
-- Tag: arrays_arrays_test_select_471
SELECT id FROM metrics WHERE ARRAY_LENGTH(values[2:4]) > 0;
-- Tag: arrays_arrays_test_select_472
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6], ARRAY[7, 8]][2:3] as outer_slice;
-- Tag: arrays_arrays_test_select_473
SELECT ARRAY[ARRAY[1, 2, 3, 4, 5], ARRAY[6, 7, 8, 9, 10]][1][2:4] as inner_slice;
-- Tag: arrays_arrays_test_select_474
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice;
-- Tag: arrays_arrays_test_select_475
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_476
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_477
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_478
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_479
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_480
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS sequences;
CREATE TABLE sequences (id INT64, data ARRAY<INT64>);
INSERT INTO sequences VALUES (1, ARRAY[1, 2, 3, 4, 5]);
INSERT INTO sequences VALUES (2, ARRAY[10, 20, 30, 40, 50]);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, tags ARRAY<STRING>);
INSERT INTO items VALUES (1, ARRAY['a', 'b', 'c', 'd', 'e']);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, values ARRAY<FLOAT64>);
INSERT INTO metrics VALUES (1, ARRAY[1.1, 2.2, 3.3, 4.4, 5.5]);
DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_481
SELECT ARRAY[1, 2, 3, 4, 5][::-1] as reversed;
-- Tag: arrays_arrays_test_select_482
SELECT id FROM sequences WHERE ARRAY_LENGTH(data[2:4]) = 3;
-- Tag: arrays_arrays_test_select_483
SELECT id FROM items WHERE tags[2:4][1] = 'b';
-- Tag: arrays_arrays_test_select_484
SELECT ARRAY_CONCAT(ARRAY[1, 2, 3][1:2], ARRAY[4, 5, 6][2:3]) as concat_slices;
-- Tag: arrays_arrays_test_select_485
SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4, 5, 6, 7][3:6]) as slice_len;
-- Tag: arrays_arrays_test_select_486
SELECT id FROM metrics WHERE ARRAY_LENGTH(values[2:4]) > 0;
-- Tag: arrays_arrays_test_select_487
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6], ARRAY[7, 8]][2:3] as outer_slice;
-- Tag: arrays_arrays_test_select_488
SELECT ARRAY[ARRAY[1, 2, 3, 4, 5], ARRAY[6, 7, 8, 9, 10]][1][2:4] as inner_slice;
-- Tag: arrays_arrays_test_select_489
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice;
-- Tag: arrays_arrays_test_select_490
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_491
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_492
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_493
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_494
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_495
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS sequences;
CREATE TABLE sequences (id INT64, data ARRAY<INT64>);
INSERT INTO sequences VALUES (1, ARRAY[1, 2, 3, 4, 5]);
INSERT INTO sequences VALUES (2, ARRAY[10, 20, 30, 40, 50]);
DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, tags ARRAY<STRING>);
INSERT INTO items VALUES (1, ARRAY['a', 'b', 'c', 'd', 'e']);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, values ARRAY<FLOAT64>);
INSERT INTO metrics VALUES (1, ARRAY[1.1, 2.2, 3.3, 4.4, 5.5]);
DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_496
SELECT id FROM sequences WHERE ARRAY_LENGTH(data[2:4]) = 3;
-- Tag: arrays_arrays_test_select_497
SELECT id FROM items WHERE tags[2:4][1] = 'b';
-- Tag: arrays_arrays_test_select_498
SELECT ARRAY_CONCAT(ARRAY[1, 2, 3][1:2], ARRAY[4, 5, 6][2:3]) as concat_slices;
-- Tag: arrays_arrays_test_select_499
SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4, 5, 6, 7][3:6]) as slice_len;
-- Tag: arrays_arrays_test_select_500
SELECT id FROM metrics WHERE ARRAY_LENGTH(values[2:4]) > 0;
-- Tag: arrays_arrays_test_select_501
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6], ARRAY[7, 8]][2:3] as outer_slice;
-- Tag: arrays_arrays_test_select_502
SELECT ARRAY[ARRAY[1, 2, 3, 4, 5], ARRAY[6, 7, 8, 9, 10]][1][2:4] as inner_slice;
-- Tag: arrays_arrays_test_select_503
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice;
-- Tag: arrays_arrays_test_select_504
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_505
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_506
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_507
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_508
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_509
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS items;
CREATE TABLE items (id INT64, tags ARRAY<STRING>);
INSERT INTO items VALUES (1, ARRAY['a', 'b', 'c', 'd', 'e']);
DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, values ARRAY<FLOAT64>);
INSERT INTO metrics VALUES (1, ARRAY[1.1, 2.2, 3.3, 4.4, 5.5]);
DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_510
SELECT id FROM items WHERE tags[2:4][1] = 'b';
-- Tag: arrays_arrays_test_select_511
SELECT ARRAY_CONCAT(ARRAY[1, 2, 3][1:2], ARRAY[4, 5, 6][2:3]) as concat_slices;
-- Tag: arrays_arrays_test_select_512
SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4, 5, 6, 7][3:6]) as slice_len;
-- Tag: arrays_arrays_test_select_513
SELECT id FROM metrics WHERE ARRAY_LENGTH(values[2:4]) > 0;
-- Tag: arrays_arrays_test_select_514
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6], ARRAY[7, 8]][2:3] as outer_slice;
-- Tag: arrays_arrays_test_select_515
SELECT ARRAY[ARRAY[1, 2, 3, 4, 5], ARRAY[6, 7, 8, 9, 10]][1][2:4] as inner_slice;
-- Tag: arrays_arrays_test_select_516
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice;
-- Tag: arrays_arrays_test_select_517
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_518
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_519
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_520
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_521
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_522
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, values ARRAY<FLOAT64>);
INSERT INTO metrics VALUES (1, ARRAY[1.1, 2.2, 3.3, 4.4, 5.5]);
DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_523
SELECT ARRAY_CONCAT(ARRAY[1, 2, 3][1:2], ARRAY[4, 5, 6][2:3]) as concat_slices;
-- Tag: arrays_arrays_test_select_524
SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4, 5, 6, 7][3:6]) as slice_len;
-- Tag: arrays_arrays_test_select_525
SELECT id FROM metrics WHERE ARRAY_LENGTH(values[2:4]) > 0;
-- Tag: arrays_arrays_test_select_526
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6], ARRAY[7, 8]][2:3] as outer_slice;
-- Tag: arrays_arrays_test_select_527
SELECT ARRAY[ARRAY[1, 2, 3, 4, 5], ARRAY[6, 7, 8, 9, 10]][1][2:4] as inner_slice;
-- Tag: arrays_arrays_test_select_528
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice;
-- Tag: arrays_arrays_test_select_529
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_530
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_531
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_532
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_533
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_534
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, values ARRAY<FLOAT64>);
INSERT INTO metrics VALUES (1, ARRAY[1.1, 2.2, 3.3, 4.4, 5.5]);
DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_535
SELECT ARRAY_LENGTH(ARRAY[1, 2, 3, 4, 5, 6, 7][3:6]) as slice_len;
-- Tag: arrays_arrays_test_select_536
SELECT id FROM metrics WHERE ARRAY_LENGTH(values[2:4]) > 0;
-- Tag: arrays_arrays_test_select_537
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6], ARRAY[7, 8]][2:3] as outer_slice;
-- Tag: arrays_arrays_test_select_538
SELECT ARRAY[ARRAY[1, 2, 3, 4, 5], ARRAY[6, 7, 8, 9, 10]][1][2:4] as inner_slice;
-- Tag: arrays_arrays_test_select_539
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice;
-- Tag: arrays_arrays_test_select_540
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_541
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_542
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_543
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_544
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_545
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS metrics;
CREATE TABLE metrics (id INT64, values ARRAY<FLOAT64>);
INSERT INTO metrics VALUES (1, ARRAY[1.1, 2.2, 3.3, 4.4, 5.5]);
DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_546
SELECT id FROM metrics WHERE ARRAY_LENGTH(values[2:4]) > 0;
-- Tag: arrays_arrays_test_select_547
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6], ARRAY[7, 8]][2:3] as outer_slice;
-- Tag: arrays_arrays_test_select_548
SELECT ARRAY[ARRAY[1, 2, 3, 4, 5], ARRAY[6, 7, 8, 9, 10]][1][2:4] as inner_slice;
-- Tag: arrays_arrays_test_select_549
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice;
-- Tag: arrays_arrays_test_select_550
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_551
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_552
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_553
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_554
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_555
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_556
SELECT ARRAY[ARRAY[1, 2], ARRAY[3, 4], ARRAY[5, 6], ARRAY[7, 8]][2:3] as outer_slice;
-- Tag: arrays_arrays_test_select_557
SELECT ARRAY[ARRAY[1, 2, 3, 4, 5], ARRAY[6, 7, 8, 9, 10]][1][2:4] as inner_slice;
-- Tag: arrays_arrays_test_select_558
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice;
-- Tag: arrays_arrays_test_select_559
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_560
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_561
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_562
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_563
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_564
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_565
SELECT ARRAY[ARRAY[1, 2, 3, 4, 5], ARRAY[6, 7, 8, 9, 10]][1][2:4] as inner_slice;
-- Tag: arrays_arrays_test_select_566
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice;
-- Tag: arrays_arrays_test_select_567
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_568
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_569
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_570
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_571
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_572
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_573
SELECT ARRAY[ARRAY[1, 2, 3], ARRAY[4, 5, 6], ARRAY[7, 8, 9]][1:2][1][2:3] as double_slice;
-- Tag: arrays_arrays_test_select_574
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_575
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_576
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_577
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_578
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_579
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_580
SELECT ARRAY[1, 2, 3][1.5:2.5] as bad_slice;
-- Tag: arrays_arrays_test_select_581
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_582
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_583
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_584
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_585
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_586
SELECT ARRAY[1, 2, 3]['a':'b'] as bad_slice;
-- Tag: arrays_arrays_test_select_587
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_588
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_589
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_590
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_591
SELECT 'not_an_array'[1:3] as bad_slice;
-- Tag: arrays_arrays_test_select_592
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_593
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_594
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_595
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_596
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_597
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_598
SELECT ARRAY[1,2,3,4,5,6,7,8,9,10][1:3] as first, ARRAY[1,2,3,4,5,6,7,8,9,10][4:6] as second, ARRAY[1,2,3,4,5,6,7,8,9,10][7:10] as third;
-- Tag: arrays_arrays_test_select_599
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_600
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_601
SELECT ARRAY[10, 20, 30, 40, 50][1+1:3+1] as computed;
-- Tag: arrays_arrays_test_select_602
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

DROP TABLE IF EXISTS bounds;
CREATE TABLE bounds (id INT64, start_idx INT64, end_idx INT64);
INSERT INTO bounds VALUES (1, 2, 4);

-- Tag: arrays_arrays_test_select_603
SELECT ARRAY['a', 'b', 'c', 'd', 'e'][(SELECT start_idx FROM bounds WHERE id = 1):(SELECT end_idx FROM bounds WHERE id = 1)] as dynamic_slice;

-- Tag: arrays_arrays_test_select_604
SELECT ARRAY[ARRAY[ARRAY[ARRAY[ARRAY[1, 2], ARRAY[3, 4]], ARRAY[ARRAY[5, 6], ARRAY[7, 8]]], ARRAY[ARRAY[ARRAY[9, 10], ARRAY[11, 12]], ARRAY[ARRAY[13, 14], ARRAY[15, 16]]]]][1][1][1][1][1] as deep;
-- Tag: arrays_arrays_test_select_605
SELECT ARRAY[10, 20, 30][CAST('2' AS INT64)] as casted;
-- Tag: arrays_arrays_test_select_606
SELECT ARRAY[1, 2, 3][1] as int_elem, ARRAY['a', 'b', 'c'][1] as str_elem, ARRAY[1.1, 2.2, 3.3][1] as float_elem;

-- Tag: arrays_arrays_test_select_607
SELECT ARRAY[ARRAY[ARRAY[ARRAY[ARRAY[1, 2], ARRAY[3, 4]], ARRAY[ARRAY[5, 6], ARRAY[7, 8]]], ARRAY[ARRAY[ARRAY[9, 10], ARRAY[11, 12]], ARRAY[ARRAY[13, 14], ARRAY[15, 16]]]]][1][1][1][1][1] as deep;
-- Tag: arrays_arrays_test_select_608
SELECT ARRAY[10, 20, 30][CAST('2' AS INT64)] as casted;
-- Tag: arrays_arrays_test_select_609
SELECT ARRAY[1, 2, 3][1] as int_elem, ARRAY['a', 'b', 'c'][1] as str_elem, ARRAY[1.1, 2.2, 3.3][1] as float_elem;

-- Tag: arrays_arrays_test_select_610
SELECT ARRAY[10, 20, 30][CAST('2' AS INT64)] as casted;
-- Tag: arrays_arrays_test_select_611
SELECT ARRAY[1, 2, 3][1] as int_elem, ARRAY['a', 'b', 'c'][1] as str_elem, ARRAY[1.1, 2.2, 3.3][1] as float_elem;

-- Tag: arrays_arrays_test_select_612
SELECT ARRAY[1, 2, 3][1] as int_elem, ARRAY['a', 'b', 'c'][1] as str_elem, ARRAY[1.1, 2.2, 3.3][1] as float_elem;
