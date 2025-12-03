-- Functions - SQL:2023
-- Description: SQL functions: string, numeric, date, conditional
--
-- PostgreSQL: Full support
-- BigQuery: Full support
-- SQL Standard: SQL:2023

-- Tag: functions_functions_test_select_001
SELECT 42;
-- Tag: functions_functions_test_select_002
SELECT 3.14159;
-- Tag: functions_functions_test_select_003
SELECT 'hello world';
-- Tag: functions_functions_test_select_004
SELECT TRUE;
-- Tag: functions_functions_test_select_005
SELECT FALSE;
-- Tag: functions_functions_test_select_006
SELECT NULL;
-- Tag: functions_functions_test_select_007
SELECT 10 + 5;
-- Tag: functions_functions_test_select_008
SELECT 20 - 7;
-- Tag: functions_functions_test_select_009
SELECT 6 * 7;
-- Tag: functions_functions_test_select_010
SELECT 100 / 4;
-- Tag: functions_functions_test_select_011
SELECT 17 % 5;
-- Tag: functions_functions_test_select_012
SELECT (10 + 5) * 2 - 3;
-- Tag: functions_functions_test_select_013
SELECT 3.5 + 2.5;
-- Tag: functions_functions_test_select_014
SELECT PI();
-- Tag: functions_functions_test_select_015
SELECT RANDOM();
-- Tag: functions_functions_test_select_016
SELECT CURRENT_DATE;
-- Tag: functions_functions_test_select_017
SELECT CURRENT_TIMESTAMP;
-- Tag: functions_functions_test_select_018
SELECT ABS(-42);
-- Tag: functions_functions_test_select_019
SELECT UPPER('hello');
-- Tag: functions_functions_test_select_020
SELECT LOWER('WORLD');
-- Tag: functions_functions_test_select_021
SELECT CONCAT('Hello', ' ', 'World');
-- Tag: functions_functions_test_select_022
SELECT 42, 'hello', TRUE;
-- Tag: functions_functions_test_select_023
SELECT 1 + 1, 2 * 3, 10 / 2;
-- Tag: functions_functions_test_select_024
SELECT PI(), RANDOM(), 'test', 123;
-- Tag: functions_functions_test_select_025
SELECT 42 AS answer;
-- Tag: functions_functions_test_select_026
SELECT 1 + 1 AS two, 2 * 3 AS six, PI() AS pi_value;
-- Tag: functions_functions_test_select_027
SELECT CASE WHEN TRUE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_028
SELECT CASE WHEN FALSE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_029
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_030
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_031
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_032
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_033
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_034
SELECT -42;
-- Tag: functions_functions_test_select_035
SELECT '';
-- Tag: functions_functions_test_select_036
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_037
SELECT 0;
-- Tag: functions_functions_test_select_038
SELECT 10 / 0;
-- Tag: functions_functions_test_select_039
SELECT 5 = 5;
-- Tag: functions_functions_test_select_040
SELECT 5 != 3;
-- Tag: functions_functions_test_select_041
SELECT 10 > 5;
-- Tag: functions_functions_test_select_042
SELECT 3 < 7;
-- Tag: functions_functions_test_select_043
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_044
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_045
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_046
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_047
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_048
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_049
SELECT SIN(PI());
-- Tag: functions_functions_test_select_050
SELECT COS(0);
-- Tag: functions_functions_test_select_051
SELECT SQRT(16);
-- Tag: functions_functions_test_select_052
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_001
SELECT;
-- Tag: functions_functions_test_select_053
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_054
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_055
SELECT 3.14159;
-- Tag: functions_functions_test_select_056
SELECT 'hello world';
-- Tag: functions_functions_test_select_057
SELECT TRUE;
-- Tag: functions_functions_test_select_058
SELECT FALSE;
-- Tag: functions_functions_test_select_059
SELECT NULL;
-- Tag: functions_functions_test_select_060
SELECT 10 + 5;
-- Tag: functions_functions_test_select_061
SELECT 20 - 7;
-- Tag: functions_functions_test_select_062
SELECT 6 * 7;
-- Tag: functions_functions_test_select_063
SELECT 100 / 4;
-- Tag: functions_functions_test_select_064
SELECT 17 % 5;
-- Tag: functions_functions_test_select_065
SELECT (10 + 5) * 2 - 3;
-- Tag: functions_functions_test_select_066
SELECT 3.5 + 2.5;
-- Tag: functions_functions_test_select_067
SELECT PI();
-- Tag: functions_functions_test_select_068
SELECT RANDOM();
-- Tag: functions_functions_test_select_069
SELECT CURRENT_DATE;
-- Tag: functions_functions_test_select_070
SELECT CURRENT_TIMESTAMP;
-- Tag: functions_functions_test_select_071
SELECT ABS(-42);
-- Tag: functions_functions_test_select_072
SELECT UPPER('hello');
-- Tag: functions_functions_test_select_073
SELECT LOWER('WORLD');
-- Tag: functions_functions_test_select_074
SELECT CONCAT('Hello', ' ', 'World');
-- Tag: functions_functions_test_select_075
SELECT 42, 'hello', TRUE;
-- Tag: functions_functions_test_select_076
SELECT 1 + 1, 2 * 3, 10 / 2;
-- Tag: functions_functions_test_select_077
SELECT PI(), RANDOM(), 'test', 123;
-- Tag: functions_functions_test_select_078
SELECT 42 AS answer;
-- Tag: functions_functions_test_select_079
SELECT 1 + 1 AS two, 2 * 3 AS six, PI() AS pi_value;
-- Tag: functions_functions_test_select_080
SELECT CASE WHEN TRUE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_081
SELECT CASE WHEN FALSE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_082
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_083
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_084
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_085
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_086
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_087
SELECT -42;
-- Tag: functions_functions_test_select_088
SELECT '';
-- Tag: functions_functions_test_select_089
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_090
SELECT 0;
-- Tag: functions_functions_test_select_091
SELECT 10 / 0;
-- Tag: functions_functions_test_select_092
SELECT 5 = 5;
-- Tag: functions_functions_test_select_093
SELECT 5 != 3;
-- Tag: functions_functions_test_select_094
SELECT 10 > 5;
-- Tag: functions_functions_test_select_095
SELECT 3 < 7;
-- Tag: functions_functions_test_select_096
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_097
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_098
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_099
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_100
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_101
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_102
SELECT SIN(PI());
-- Tag: functions_functions_test_select_103
SELECT COS(0);
-- Tag: functions_functions_test_select_104
SELECT SQRT(16);
-- Tag: functions_functions_test_select_105
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_002
SELECT;
-- Tag: functions_functions_test_select_106
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_107
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_108
SELECT 'hello world';
-- Tag: functions_functions_test_select_109
SELECT TRUE;
-- Tag: functions_functions_test_select_110
SELECT FALSE;
-- Tag: functions_functions_test_select_111
SELECT NULL;
-- Tag: functions_functions_test_select_112
SELECT 10 + 5;
-- Tag: functions_functions_test_select_113
SELECT 20 - 7;
-- Tag: functions_functions_test_select_114
SELECT 6 * 7;
-- Tag: functions_functions_test_select_115
SELECT 100 / 4;
-- Tag: functions_functions_test_select_116
SELECT 17 % 5;
-- Tag: functions_functions_test_select_117
SELECT (10 + 5) * 2 - 3;
-- Tag: functions_functions_test_select_118
SELECT 3.5 + 2.5;
-- Tag: functions_functions_test_select_119
SELECT PI();
-- Tag: functions_functions_test_select_120
SELECT RANDOM();
-- Tag: functions_functions_test_select_121
SELECT CURRENT_DATE;
-- Tag: functions_functions_test_select_122
SELECT CURRENT_TIMESTAMP;
-- Tag: functions_functions_test_select_123
SELECT ABS(-42);
-- Tag: functions_functions_test_select_124
SELECT UPPER('hello');
-- Tag: functions_functions_test_select_125
SELECT LOWER('WORLD');
-- Tag: functions_functions_test_select_126
SELECT CONCAT('Hello', ' ', 'World');
-- Tag: functions_functions_test_select_127
SELECT 42, 'hello', TRUE;
-- Tag: functions_functions_test_select_128
SELECT 1 + 1, 2 * 3, 10 / 2;
-- Tag: functions_functions_test_select_129
SELECT PI(), RANDOM(), 'test', 123;
-- Tag: functions_functions_test_select_130
SELECT 42 AS answer;
-- Tag: functions_functions_test_select_131
SELECT 1 + 1 AS two, 2 * 3 AS six, PI() AS pi_value;
-- Tag: functions_functions_test_select_132
SELECT CASE WHEN TRUE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_133
SELECT CASE WHEN FALSE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_134
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_135
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_136
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_137
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_138
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_139
SELECT -42;
-- Tag: functions_functions_test_select_140
SELECT '';
-- Tag: functions_functions_test_select_141
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_142
SELECT 0;
-- Tag: functions_functions_test_select_143
SELECT 10 / 0;
-- Tag: functions_functions_test_select_144
SELECT 5 = 5;
-- Tag: functions_functions_test_select_145
SELECT 5 != 3;
-- Tag: functions_functions_test_select_146
SELECT 10 > 5;
-- Tag: functions_functions_test_select_147
SELECT 3 < 7;
-- Tag: functions_functions_test_select_148
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_149
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_150
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_151
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_152
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_153
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_154
SELECT SIN(PI());
-- Tag: functions_functions_test_select_155
SELECT COS(0);
-- Tag: functions_functions_test_select_156
SELECT SQRT(16);
-- Tag: functions_functions_test_select_157
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_003
SELECT;
-- Tag: functions_functions_test_select_158
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_159
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_160
SELECT TRUE;
-- Tag: functions_functions_test_select_161
SELECT FALSE;
-- Tag: functions_functions_test_select_162
SELECT NULL;
-- Tag: functions_functions_test_select_163
SELECT 10 + 5;
-- Tag: functions_functions_test_select_164
SELECT 20 - 7;
-- Tag: functions_functions_test_select_165
SELECT 6 * 7;
-- Tag: functions_functions_test_select_166
SELECT 100 / 4;
-- Tag: functions_functions_test_select_167
SELECT 17 % 5;
-- Tag: functions_functions_test_select_168
SELECT (10 + 5) * 2 - 3;
-- Tag: functions_functions_test_select_169
SELECT 3.5 + 2.5;
-- Tag: functions_functions_test_select_170
SELECT PI();
-- Tag: functions_functions_test_select_171
SELECT RANDOM();
-- Tag: functions_functions_test_select_172
SELECT CURRENT_DATE;
-- Tag: functions_functions_test_select_173
SELECT CURRENT_TIMESTAMP;
-- Tag: functions_functions_test_select_174
SELECT ABS(-42);
-- Tag: functions_functions_test_select_175
SELECT UPPER('hello');
-- Tag: functions_functions_test_select_176
SELECT LOWER('WORLD');
-- Tag: functions_functions_test_select_177
SELECT CONCAT('Hello', ' ', 'World');
-- Tag: functions_functions_test_select_178
SELECT 42, 'hello', TRUE;
-- Tag: functions_functions_test_select_179
SELECT 1 + 1, 2 * 3, 10 / 2;
-- Tag: functions_functions_test_select_180
SELECT PI(), RANDOM(), 'test', 123;
-- Tag: functions_functions_test_select_181
SELECT 42 AS answer;
-- Tag: functions_functions_test_select_182
SELECT 1 + 1 AS two, 2 * 3 AS six, PI() AS pi_value;
-- Tag: functions_functions_test_select_183
SELECT CASE WHEN TRUE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_184
SELECT CASE WHEN FALSE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_185
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_186
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_187
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_188
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_189
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_190
SELECT -42;
-- Tag: functions_functions_test_select_191
SELECT '';
-- Tag: functions_functions_test_select_192
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_193
SELECT 0;
-- Tag: functions_functions_test_select_194
SELECT 10 / 0;
-- Tag: functions_functions_test_select_195
SELECT 5 = 5;
-- Tag: functions_functions_test_select_196
SELECT 5 != 3;
-- Tag: functions_functions_test_select_197
SELECT 10 > 5;
-- Tag: functions_functions_test_select_198
SELECT 3 < 7;
-- Tag: functions_functions_test_select_199
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_200
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_201
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_202
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_203
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_204
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_205
SELECT SIN(PI());
-- Tag: functions_functions_test_select_206
SELECT COS(0);
-- Tag: functions_functions_test_select_207
SELECT SQRT(16);
-- Tag: functions_functions_test_select_208
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_004
SELECT;
-- Tag: functions_functions_test_select_209
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_210
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_211
SELECT FALSE;
-- Tag: functions_functions_test_select_212
SELECT NULL;
-- Tag: functions_functions_test_select_213
SELECT 10 + 5;
-- Tag: functions_functions_test_select_214
SELECT 20 - 7;
-- Tag: functions_functions_test_select_215
SELECT 6 * 7;
-- Tag: functions_functions_test_select_216
SELECT 100 / 4;
-- Tag: functions_functions_test_select_217
SELECT 17 % 5;
-- Tag: functions_functions_test_select_218
SELECT (10 + 5) * 2 - 3;
-- Tag: functions_functions_test_select_219
SELECT 3.5 + 2.5;
-- Tag: functions_functions_test_select_220
SELECT PI();
-- Tag: functions_functions_test_select_221
SELECT RANDOM();
-- Tag: functions_functions_test_select_222
SELECT CURRENT_DATE;
-- Tag: functions_functions_test_select_223
SELECT CURRENT_TIMESTAMP;
-- Tag: functions_functions_test_select_224
SELECT ABS(-42);
-- Tag: functions_functions_test_select_225
SELECT UPPER('hello');
-- Tag: functions_functions_test_select_226
SELECT LOWER('WORLD');
-- Tag: functions_functions_test_select_227
SELECT CONCAT('Hello', ' ', 'World');
-- Tag: functions_functions_test_select_228
SELECT 42, 'hello', TRUE;
-- Tag: functions_functions_test_select_229
SELECT 1 + 1, 2 * 3, 10 / 2;
-- Tag: functions_functions_test_select_230
SELECT PI(), RANDOM(), 'test', 123;
-- Tag: functions_functions_test_select_231
SELECT 42 AS answer;
-- Tag: functions_functions_test_select_232
SELECT 1 + 1 AS two, 2 * 3 AS six, PI() AS pi_value;
-- Tag: functions_functions_test_select_233
SELECT CASE WHEN TRUE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_234
SELECT CASE WHEN FALSE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_235
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_236
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_237
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_238
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_239
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_240
SELECT -42;
-- Tag: functions_functions_test_select_241
SELECT '';
-- Tag: functions_functions_test_select_242
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_243
SELECT 0;
-- Tag: functions_functions_test_select_244
SELECT 10 / 0;
-- Tag: functions_functions_test_select_245
SELECT 5 = 5;
-- Tag: functions_functions_test_select_246
SELECT 5 != 3;
-- Tag: functions_functions_test_select_247
SELECT 10 > 5;
-- Tag: functions_functions_test_select_248
SELECT 3 < 7;
-- Tag: functions_functions_test_select_249
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_250
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_251
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_252
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_253
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_254
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_255
SELECT SIN(PI());
-- Tag: functions_functions_test_select_256
SELECT COS(0);
-- Tag: functions_functions_test_select_257
SELECT SQRT(16);
-- Tag: functions_functions_test_select_258
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_005
SELECT;
-- Tag: functions_functions_test_select_259
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_260
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_261
SELECT NULL;
-- Tag: functions_functions_test_select_262
SELECT 10 + 5;
-- Tag: functions_functions_test_select_263
SELECT 20 - 7;
-- Tag: functions_functions_test_select_264
SELECT 6 * 7;
-- Tag: functions_functions_test_select_265
SELECT 100 / 4;
-- Tag: functions_functions_test_select_266
SELECT 17 % 5;
-- Tag: functions_functions_test_select_267
SELECT (10 + 5) * 2 - 3;
-- Tag: functions_functions_test_select_268
SELECT 3.5 + 2.5;
-- Tag: functions_functions_test_select_269
SELECT PI();
-- Tag: functions_functions_test_select_270
SELECT RANDOM();
-- Tag: functions_functions_test_select_271
SELECT CURRENT_DATE;
-- Tag: functions_functions_test_select_272
SELECT CURRENT_TIMESTAMP;
-- Tag: functions_functions_test_select_273
SELECT ABS(-42);
-- Tag: functions_functions_test_select_274
SELECT UPPER('hello');
-- Tag: functions_functions_test_select_275
SELECT LOWER('WORLD');
-- Tag: functions_functions_test_select_276
SELECT CONCAT('Hello', ' ', 'World');
-- Tag: functions_functions_test_select_277
SELECT 42, 'hello', TRUE;
-- Tag: functions_functions_test_select_278
SELECT 1 + 1, 2 * 3, 10 / 2;
-- Tag: functions_functions_test_select_279
SELECT PI(), RANDOM(), 'test', 123;
-- Tag: functions_functions_test_select_280
SELECT 42 AS answer;
-- Tag: functions_functions_test_select_281
SELECT 1 + 1 AS two, 2 * 3 AS six, PI() AS pi_value;
-- Tag: functions_functions_test_select_282
SELECT CASE WHEN TRUE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_283
SELECT CASE WHEN FALSE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_284
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_285
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_286
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_287
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_288
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_289
SELECT -42;
-- Tag: functions_functions_test_select_290
SELECT '';
-- Tag: functions_functions_test_select_291
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_292
SELECT 0;
-- Tag: functions_functions_test_select_293
SELECT 10 / 0;
-- Tag: functions_functions_test_select_294
SELECT 5 = 5;
-- Tag: functions_functions_test_select_295
SELECT 5 != 3;
-- Tag: functions_functions_test_select_296
SELECT 10 > 5;
-- Tag: functions_functions_test_select_297
SELECT 3 < 7;
-- Tag: functions_functions_test_select_298
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_299
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_300
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_301
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_302
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_303
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_304
SELECT SIN(PI());
-- Tag: functions_functions_test_select_305
SELECT COS(0);
-- Tag: functions_functions_test_select_306
SELECT SQRT(16);
-- Tag: functions_functions_test_select_307
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_006
SELECT;
-- Tag: functions_functions_test_select_308
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_309
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_310
SELECT 10 + 5;
-- Tag: functions_functions_test_select_311
SELECT 20 - 7;
-- Tag: functions_functions_test_select_312
SELECT 6 * 7;
-- Tag: functions_functions_test_select_313
SELECT 100 / 4;
-- Tag: functions_functions_test_select_314
SELECT 17 % 5;
-- Tag: functions_functions_test_select_315
SELECT (10 + 5) * 2 - 3;
-- Tag: functions_functions_test_select_316
SELECT 3.5 + 2.5;
-- Tag: functions_functions_test_select_317
SELECT PI();
-- Tag: functions_functions_test_select_318
SELECT RANDOM();
-- Tag: functions_functions_test_select_319
SELECT CURRENT_DATE;
-- Tag: functions_functions_test_select_320
SELECT CURRENT_TIMESTAMP;
-- Tag: functions_functions_test_select_321
SELECT ABS(-42);
-- Tag: functions_functions_test_select_322
SELECT UPPER('hello');
-- Tag: functions_functions_test_select_323
SELECT LOWER('WORLD');
-- Tag: functions_functions_test_select_324
SELECT CONCAT('Hello', ' ', 'World');
-- Tag: functions_functions_test_select_325
SELECT 42, 'hello', TRUE;
-- Tag: functions_functions_test_select_326
SELECT 1 + 1, 2 * 3, 10 / 2;
-- Tag: functions_functions_test_select_327
SELECT PI(), RANDOM(), 'test', 123;
-- Tag: functions_functions_test_select_328
SELECT 42 AS answer;
-- Tag: functions_functions_test_select_329
SELECT 1 + 1 AS two, 2 * 3 AS six, PI() AS pi_value;
-- Tag: functions_functions_test_select_330
SELECT CASE WHEN TRUE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_331
SELECT CASE WHEN FALSE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_332
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_333
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_334
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_335
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_336
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_337
SELECT -42;
-- Tag: functions_functions_test_select_338
SELECT '';
-- Tag: functions_functions_test_select_339
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_340
SELECT 0;
-- Tag: functions_functions_test_select_341
SELECT 10 / 0;
-- Tag: functions_functions_test_select_342
SELECT 5 = 5;
-- Tag: functions_functions_test_select_343
SELECT 5 != 3;
-- Tag: functions_functions_test_select_344
SELECT 10 > 5;
-- Tag: functions_functions_test_select_345
SELECT 3 < 7;
-- Tag: functions_functions_test_select_346
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_347
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_348
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_349
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_350
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_351
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_352
SELECT SIN(PI());
-- Tag: functions_functions_test_select_353
SELECT COS(0);
-- Tag: functions_functions_test_select_354
SELECT SQRT(16);
-- Tag: functions_functions_test_select_355
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_007
SELECT;
-- Tag: functions_functions_test_select_356
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_357
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_358
SELECT 20 - 7;
-- Tag: functions_functions_test_select_359
SELECT 6 * 7;
-- Tag: functions_functions_test_select_360
SELECT 100 / 4;
-- Tag: functions_functions_test_select_361
SELECT 17 % 5;
-- Tag: functions_functions_test_select_362
SELECT (10 + 5) * 2 - 3;
-- Tag: functions_functions_test_select_363
SELECT 3.5 + 2.5;
-- Tag: functions_functions_test_select_364
SELECT PI();
-- Tag: functions_functions_test_select_365
SELECT RANDOM();
-- Tag: functions_functions_test_select_366
SELECT CURRENT_DATE;
-- Tag: functions_functions_test_select_367
SELECT CURRENT_TIMESTAMP;
-- Tag: functions_functions_test_select_368
SELECT ABS(-42);
-- Tag: functions_functions_test_select_369
SELECT UPPER('hello');
-- Tag: functions_functions_test_select_370
SELECT LOWER('WORLD');
-- Tag: functions_functions_test_select_371
SELECT CONCAT('Hello', ' ', 'World');
-- Tag: functions_functions_test_select_372
SELECT 42, 'hello', TRUE;
-- Tag: functions_functions_test_select_373
SELECT 1 + 1, 2 * 3, 10 / 2;
-- Tag: functions_functions_test_select_374
SELECT PI(), RANDOM(), 'test', 123;
-- Tag: functions_functions_test_select_375
SELECT 42 AS answer;
-- Tag: functions_functions_test_select_376
SELECT 1 + 1 AS two, 2 * 3 AS six, PI() AS pi_value;
-- Tag: functions_functions_test_select_377
SELECT CASE WHEN TRUE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_378
SELECT CASE WHEN FALSE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_379
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_380
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_381
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_382
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_383
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_384
SELECT -42;
-- Tag: functions_functions_test_select_385
SELECT '';
-- Tag: functions_functions_test_select_386
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_387
SELECT 0;
-- Tag: functions_functions_test_select_388
SELECT 10 / 0;
-- Tag: functions_functions_test_select_389
SELECT 5 = 5;
-- Tag: functions_functions_test_select_390
SELECT 5 != 3;
-- Tag: functions_functions_test_select_391
SELECT 10 > 5;
-- Tag: functions_functions_test_select_392
SELECT 3 < 7;
-- Tag: functions_functions_test_select_393
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_394
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_395
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_396
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_397
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_398
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_399
SELECT SIN(PI());
-- Tag: functions_functions_test_select_400
SELECT COS(0);
-- Tag: functions_functions_test_select_401
SELECT SQRT(16);
-- Tag: functions_functions_test_select_402
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_008
SELECT;
-- Tag: functions_functions_test_select_403
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_404
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_405
SELECT 6 * 7;
-- Tag: functions_functions_test_select_406
SELECT 100 / 4;
-- Tag: functions_functions_test_select_407
SELECT 17 % 5;
-- Tag: functions_functions_test_select_408
SELECT (10 + 5) * 2 - 3;
-- Tag: functions_functions_test_select_409
SELECT 3.5 + 2.5;
-- Tag: functions_functions_test_select_410
SELECT PI();
-- Tag: functions_functions_test_select_411
SELECT RANDOM();
-- Tag: functions_functions_test_select_412
SELECT CURRENT_DATE;
-- Tag: functions_functions_test_select_413
SELECT CURRENT_TIMESTAMP;
-- Tag: functions_functions_test_select_414
SELECT ABS(-42);
-- Tag: functions_functions_test_select_415
SELECT UPPER('hello');
-- Tag: functions_functions_test_select_416
SELECT LOWER('WORLD');
-- Tag: functions_functions_test_select_417
SELECT CONCAT('Hello', ' ', 'World');
-- Tag: functions_functions_test_select_418
SELECT 42, 'hello', TRUE;
-- Tag: functions_functions_test_select_419
SELECT 1 + 1, 2 * 3, 10 / 2;
-- Tag: functions_functions_test_select_420
SELECT PI(), RANDOM(), 'test', 123;
-- Tag: functions_functions_test_select_421
SELECT 42 AS answer;
-- Tag: functions_functions_test_select_422
SELECT 1 + 1 AS two, 2 * 3 AS six, PI() AS pi_value;
-- Tag: functions_functions_test_select_423
SELECT CASE WHEN TRUE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_424
SELECT CASE WHEN FALSE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_425
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_426
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_427
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_428
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_429
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_430
SELECT -42;
-- Tag: functions_functions_test_select_431
SELECT '';
-- Tag: functions_functions_test_select_432
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_433
SELECT 0;
-- Tag: functions_functions_test_select_434
SELECT 10 / 0;
-- Tag: functions_functions_test_select_435
SELECT 5 = 5;
-- Tag: functions_functions_test_select_436
SELECT 5 != 3;
-- Tag: functions_functions_test_select_437
SELECT 10 > 5;
-- Tag: functions_functions_test_select_438
SELECT 3 < 7;
-- Tag: functions_functions_test_select_439
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_440
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_441
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_442
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_443
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_444
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_445
SELECT SIN(PI());
-- Tag: functions_functions_test_select_446
SELECT COS(0);
-- Tag: functions_functions_test_select_447
SELECT SQRT(16);
-- Tag: functions_functions_test_select_448
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_009
SELECT;
-- Tag: functions_functions_test_select_449
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_450
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_451
SELECT 100 / 4;
-- Tag: functions_functions_test_select_452
SELECT 17 % 5;
-- Tag: functions_functions_test_select_453
SELECT (10 + 5) * 2 - 3;
-- Tag: functions_functions_test_select_454
SELECT 3.5 + 2.5;
-- Tag: functions_functions_test_select_455
SELECT PI();
-- Tag: functions_functions_test_select_456
SELECT RANDOM();
-- Tag: functions_functions_test_select_457
SELECT CURRENT_DATE;
-- Tag: functions_functions_test_select_458
SELECT CURRENT_TIMESTAMP;
-- Tag: functions_functions_test_select_459
SELECT ABS(-42);
-- Tag: functions_functions_test_select_460
SELECT UPPER('hello');
-- Tag: functions_functions_test_select_461
SELECT LOWER('WORLD');
-- Tag: functions_functions_test_select_462
SELECT CONCAT('Hello', ' ', 'World');
-- Tag: functions_functions_test_select_463
SELECT 42, 'hello', TRUE;
-- Tag: functions_functions_test_select_464
SELECT 1 + 1, 2 * 3, 10 / 2;
-- Tag: functions_functions_test_select_465
SELECT PI(), RANDOM(), 'test', 123;
-- Tag: functions_functions_test_select_466
SELECT 42 AS answer;
-- Tag: functions_functions_test_select_467
SELECT 1 + 1 AS two, 2 * 3 AS six, PI() AS pi_value;
-- Tag: functions_functions_test_select_468
SELECT CASE WHEN TRUE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_469
SELECT CASE WHEN FALSE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_470
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_471
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_472
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_473
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_474
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_475
SELECT -42;
-- Tag: functions_functions_test_select_476
SELECT '';
-- Tag: functions_functions_test_select_477
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_478
SELECT 0;
-- Tag: functions_functions_test_select_479
SELECT 10 / 0;
-- Tag: functions_functions_test_select_480
SELECT 5 = 5;
-- Tag: functions_functions_test_select_481
SELECT 5 != 3;
-- Tag: functions_functions_test_select_482
SELECT 10 > 5;
-- Tag: functions_functions_test_select_483
SELECT 3 < 7;
-- Tag: functions_functions_test_select_484
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_485
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_486
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_487
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_488
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_489
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_490
SELECT SIN(PI());
-- Tag: functions_functions_test_select_491
SELECT COS(0);
-- Tag: functions_functions_test_select_492
SELECT SQRT(16);
-- Tag: functions_functions_test_select_493
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_010
SELECT;
-- Tag: functions_functions_test_select_494
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_495
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_496
SELECT 17 % 5;
-- Tag: functions_functions_test_select_497
SELECT (10 + 5) * 2 - 3;
-- Tag: functions_functions_test_select_498
SELECT 3.5 + 2.5;
-- Tag: functions_functions_test_select_499
SELECT PI();
-- Tag: functions_functions_test_select_500
SELECT RANDOM();
-- Tag: functions_functions_test_select_501
SELECT CURRENT_DATE;
-- Tag: functions_functions_test_select_502
SELECT CURRENT_TIMESTAMP;
-- Tag: functions_functions_test_select_503
SELECT ABS(-42);
-- Tag: functions_functions_test_select_504
SELECT UPPER('hello');
-- Tag: functions_functions_test_select_505
SELECT LOWER('WORLD');
-- Tag: functions_functions_test_select_506
SELECT CONCAT('Hello', ' ', 'World');
-- Tag: functions_functions_test_select_507
SELECT 42, 'hello', TRUE;
-- Tag: functions_functions_test_select_508
SELECT 1 + 1, 2 * 3, 10 / 2;
-- Tag: functions_functions_test_select_509
SELECT PI(), RANDOM(), 'test', 123;
-- Tag: functions_functions_test_select_510
SELECT 42 AS answer;
-- Tag: functions_functions_test_select_511
SELECT 1 + 1 AS two, 2 * 3 AS six, PI() AS pi_value;
-- Tag: functions_functions_test_select_512
SELECT CASE WHEN TRUE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_513
SELECT CASE WHEN FALSE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_514
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_515
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_516
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_517
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_518
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_519
SELECT -42;
-- Tag: functions_functions_test_select_520
SELECT '';
-- Tag: functions_functions_test_select_521
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_522
SELECT 0;
-- Tag: functions_functions_test_select_523
SELECT 10 / 0;
-- Tag: functions_functions_test_select_524
SELECT 5 = 5;
-- Tag: functions_functions_test_select_525
SELECT 5 != 3;
-- Tag: functions_functions_test_select_526
SELECT 10 > 5;
-- Tag: functions_functions_test_select_527
SELECT 3 < 7;
-- Tag: functions_functions_test_select_528
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_529
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_530
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_531
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_532
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_533
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_534
SELECT SIN(PI());
-- Tag: functions_functions_test_select_535
SELECT COS(0);
-- Tag: functions_functions_test_select_536
SELECT SQRT(16);
-- Tag: functions_functions_test_select_537
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_011
SELECT;
-- Tag: functions_functions_test_select_538
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_539
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_540
SELECT (10 + 5) * 2 - 3;
-- Tag: functions_functions_test_select_541
SELECT 3.5 + 2.5;
-- Tag: functions_functions_test_select_542
SELECT PI();
-- Tag: functions_functions_test_select_543
SELECT RANDOM();
-- Tag: functions_functions_test_select_544
SELECT CURRENT_DATE;
-- Tag: functions_functions_test_select_545
SELECT CURRENT_TIMESTAMP;
-- Tag: functions_functions_test_select_546
SELECT ABS(-42);
-- Tag: functions_functions_test_select_547
SELECT UPPER('hello');
-- Tag: functions_functions_test_select_548
SELECT LOWER('WORLD');
-- Tag: functions_functions_test_select_549
SELECT CONCAT('Hello', ' ', 'World');
-- Tag: functions_functions_test_select_550
SELECT 42, 'hello', TRUE;
-- Tag: functions_functions_test_select_551
SELECT 1 + 1, 2 * 3, 10 / 2;
-- Tag: functions_functions_test_select_552
SELECT PI(), RANDOM(), 'test', 123;
-- Tag: functions_functions_test_select_553
SELECT 42 AS answer;
-- Tag: functions_functions_test_select_554
SELECT 1 + 1 AS two, 2 * 3 AS six, PI() AS pi_value;
-- Tag: functions_functions_test_select_555
SELECT CASE WHEN TRUE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_556
SELECT CASE WHEN FALSE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_557
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_558
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_559
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_560
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_561
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_562
SELECT -42;
-- Tag: functions_functions_test_select_563
SELECT '';
-- Tag: functions_functions_test_select_564
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_565
SELECT 0;
-- Tag: functions_functions_test_select_566
SELECT 10 / 0;
-- Tag: functions_functions_test_select_567
SELECT 5 = 5;
-- Tag: functions_functions_test_select_568
SELECT 5 != 3;
-- Tag: functions_functions_test_select_569
SELECT 10 > 5;
-- Tag: functions_functions_test_select_570
SELECT 3 < 7;
-- Tag: functions_functions_test_select_571
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_572
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_573
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_574
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_575
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_576
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_577
SELECT SIN(PI());
-- Tag: functions_functions_test_select_578
SELECT COS(0);
-- Tag: functions_functions_test_select_579
SELECT SQRT(16);
-- Tag: functions_functions_test_select_580
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_012
SELECT;
-- Tag: functions_functions_test_select_581
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_582
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_583
SELECT 3.5 + 2.5;
-- Tag: functions_functions_test_select_584
SELECT PI();
-- Tag: functions_functions_test_select_585
SELECT RANDOM();
-- Tag: functions_functions_test_select_586
SELECT CURRENT_DATE;
-- Tag: functions_functions_test_select_587
SELECT CURRENT_TIMESTAMP;
-- Tag: functions_functions_test_select_588
SELECT ABS(-42);
-- Tag: functions_functions_test_select_589
SELECT UPPER('hello');
-- Tag: functions_functions_test_select_590
SELECT LOWER('WORLD');
-- Tag: functions_functions_test_select_591
SELECT CONCAT('Hello', ' ', 'World');
-- Tag: functions_functions_test_select_592
SELECT 42, 'hello', TRUE;
-- Tag: functions_functions_test_select_593
SELECT 1 + 1, 2 * 3, 10 / 2;
-- Tag: functions_functions_test_select_594
SELECT PI(), RANDOM(), 'test', 123;
-- Tag: functions_functions_test_select_595
SELECT 42 AS answer;
-- Tag: functions_functions_test_select_596
SELECT 1 + 1 AS two, 2 * 3 AS six, PI() AS pi_value;
-- Tag: functions_functions_test_select_597
SELECT CASE WHEN TRUE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_598
SELECT CASE WHEN FALSE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_599
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_600
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_601
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_602
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_603
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_604
SELECT -42;
-- Tag: functions_functions_test_select_605
SELECT '';
-- Tag: functions_functions_test_select_606
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_607
SELECT 0;
-- Tag: functions_functions_test_select_608
SELECT 10 / 0;
-- Tag: functions_functions_test_select_609
SELECT 5 = 5;
-- Tag: functions_functions_test_select_610
SELECT 5 != 3;
-- Tag: functions_functions_test_select_611
SELECT 10 > 5;
-- Tag: functions_functions_test_select_612
SELECT 3 < 7;
-- Tag: functions_functions_test_select_613
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_614
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_615
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_616
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_617
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_618
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_619
SELECT SIN(PI());
-- Tag: functions_functions_test_select_620
SELECT COS(0);
-- Tag: functions_functions_test_select_621
SELECT SQRT(16);
-- Tag: functions_functions_test_select_622
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_013
SELECT;
-- Tag: functions_functions_test_select_623
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_624
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_625
SELECT PI();
-- Tag: functions_functions_test_select_626
SELECT RANDOM();
-- Tag: functions_functions_test_select_627
SELECT CURRENT_DATE;
-- Tag: functions_functions_test_select_628
SELECT CURRENT_TIMESTAMP;
-- Tag: functions_functions_test_select_629
SELECT ABS(-42);
-- Tag: functions_functions_test_select_630
SELECT UPPER('hello');
-- Tag: functions_functions_test_select_631
SELECT LOWER('WORLD');
-- Tag: functions_functions_test_select_632
SELECT CONCAT('Hello', ' ', 'World');
-- Tag: functions_functions_test_select_633
SELECT 42, 'hello', TRUE;
-- Tag: functions_functions_test_select_634
SELECT 1 + 1, 2 * 3, 10 / 2;
-- Tag: functions_functions_test_select_635
SELECT PI(), RANDOM(), 'test', 123;
-- Tag: functions_functions_test_select_636
SELECT 42 AS answer;
-- Tag: functions_functions_test_select_637
SELECT 1 + 1 AS two, 2 * 3 AS six, PI() AS pi_value;
-- Tag: functions_functions_test_select_638
SELECT CASE WHEN TRUE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_639
SELECT CASE WHEN FALSE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_640
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_641
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_642
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_643
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_644
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_645
SELECT -42;
-- Tag: functions_functions_test_select_646
SELECT '';
-- Tag: functions_functions_test_select_647
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_648
SELECT 0;
-- Tag: functions_functions_test_select_649
SELECT 10 / 0;
-- Tag: functions_functions_test_select_650
SELECT 5 = 5;
-- Tag: functions_functions_test_select_651
SELECT 5 != 3;
-- Tag: functions_functions_test_select_652
SELECT 10 > 5;
-- Tag: functions_functions_test_select_653
SELECT 3 < 7;
-- Tag: functions_functions_test_select_654
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_655
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_656
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_657
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_658
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_659
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_660
SELECT SIN(PI());
-- Tag: functions_functions_test_select_661
SELECT COS(0);
-- Tag: functions_functions_test_select_662
SELECT SQRT(16);
-- Tag: functions_functions_test_select_663
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_014
SELECT;
-- Tag: functions_functions_test_select_664
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_665
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_666
SELECT RANDOM();
-- Tag: functions_functions_test_select_667
SELECT CURRENT_DATE;
-- Tag: functions_functions_test_select_668
SELECT CURRENT_TIMESTAMP;
-- Tag: functions_functions_test_select_669
SELECT ABS(-42);
-- Tag: functions_functions_test_select_670
SELECT UPPER('hello');
-- Tag: functions_functions_test_select_671
SELECT LOWER('WORLD');
-- Tag: functions_functions_test_select_672
SELECT CONCAT('Hello', ' ', 'World');
-- Tag: functions_functions_test_select_673
SELECT 42, 'hello', TRUE;
-- Tag: functions_functions_test_select_674
SELECT 1 + 1, 2 * 3, 10 / 2;
-- Tag: functions_functions_test_select_675
SELECT PI(), RANDOM(), 'test', 123;
-- Tag: functions_functions_test_select_676
SELECT 42 AS answer;
-- Tag: functions_functions_test_select_677
SELECT 1 + 1 AS two, 2 * 3 AS six, PI() AS pi_value;
-- Tag: functions_functions_test_select_678
SELECT CASE WHEN TRUE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_679
SELECT CASE WHEN FALSE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_680
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_681
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_682
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_683
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_684
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_685
SELECT -42;
-- Tag: functions_functions_test_select_686
SELECT '';
-- Tag: functions_functions_test_select_687
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_688
SELECT 0;
-- Tag: functions_functions_test_select_689
SELECT 10 / 0;
-- Tag: functions_functions_test_select_690
SELECT 5 = 5;
-- Tag: functions_functions_test_select_691
SELECT 5 != 3;
-- Tag: functions_functions_test_select_692
SELECT 10 > 5;
-- Tag: functions_functions_test_select_693
SELECT 3 < 7;
-- Tag: functions_functions_test_select_694
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_695
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_696
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_697
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_698
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_699
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_700
SELECT SIN(PI());
-- Tag: functions_functions_test_select_701
SELECT COS(0);
-- Tag: functions_functions_test_select_702
SELECT SQRT(16);
-- Tag: functions_functions_test_select_703
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_015
SELECT;
-- Tag: functions_functions_test_select_704
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_705
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_706
SELECT CURRENT_DATE;
-- Tag: functions_functions_test_select_707
SELECT CURRENT_TIMESTAMP;
-- Tag: functions_functions_test_select_708
SELECT ABS(-42);
-- Tag: functions_functions_test_select_709
SELECT UPPER('hello');
-- Tag: functions_functions_test_select_710
SELECT LOWER('WORLD');
-- Tag: functions_functions_test_select_711
SELECT CONCAT('Hello', ' ', 'World');
-- Tag: functions_functions_test_select_712
SELECT 42, 'hello', TRUE;
-- Tag: functions_functions_test_select_713
SELECT 1 + 1, 2 * 3, 10 / 2;
-- Tag: functions_functions_test_select_714
SELECT PI(), RANDOM(), 'test', 123;
-- Tag: functions_functions_test_select_715
SELECT 42 AS answer;
-- Tag: functions_functions_test_select_716
SELECT 1 + 1 AS two, 2 * 3 AS six, PI() AS pi_value;
-- Tag: functions_functions_test_select_717
SELECT CASE WHEN TRUE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_718
SELECT CASE WHEN FALSE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_719
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_720
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_721
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_722
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_723
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_724
SELECT -42;
-- Tag: functions_functions_test_select_725
SELECT '';
-- Tag: functions_functions_test_select_726
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_727
SELECT 0;
-- Tag: functions_functions_test_select_728
SELECT 10 / 0;
-- Tag: functions_functions_test_select_729
SELECT 5 = 5;
-- Tag: functions_functions_test_select_730
SELECT 5 != 3;
-- Tag: functions_functions_test_select_731
SELECT 10 > 5;
-- Tag: functions_functions_test_select_732
SELECT 3 < 7;
-- Tag: functions_functions_test_select_733
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_734
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_735
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_736
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_737
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_738
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_739
SELECT SIN(PI());
-- Tag: functions_functions_test_select_740
SELECT COS(0);
-- Tag: functions_functions_test_select_741
SELECT SQRT(16);
-- Tag: functions_functions_test_select_742
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_016
SELECT;
-- Tag: functions_functions_test_select_743
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_744
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_745
SELECT CURRENT_TIMESTAMP;
-- Tag: functions_functions_test_select_746
SELECT ABS(-42);
-- Tag: functions_functions_test_select_747
SELECT UPPER('hello');
-- Tag: functions_functions_test_select_748
SELECT LOWER('WORLD');
-- Tag: functions_functions_test_select_749
SELECT CONCAT('Hello', ' ', 'World');
-- Tag: functions_functions_test_select_750
SELECT 42, 'hello', TRUE;
-- Tag: functions_functions_test_select_751
SELECT 1 + 1, 2 * 3, 10 / 2;
-- Tag: functions_functions_test_select_752
SELECT PI(), RANDOM(), 'test', 123;
-- Tag: functions_functions_test_select_753
SELECT 42 AS answer;
-- Tag: functions_functions_test_select_754
SELECT 1 + 1 AS two, 2 * 3 AS six, PI() AS pi_value;
-- Tag: functions_functions_test_select_755
SELECT CASE WHEN TRUE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_756
SELECT CASE WHEN FALSE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_757
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_758
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_759
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_760
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_761
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_762
SELECT -42;
-- Tag: functions_functions_test_select_763
SELECT '';
-- Tag: functions_functions_test_select_764
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_765
SELECT 0;
-- Tag: functions_functions_test_select_766
SELECT 10 / 0;
-- Tag: functions_functions_test_select_767
SELECT 5 = 5;
-- Tag: functions_functions_test_select_768
SELECT 5 != 3;
-- Tag: functions_functions_test_select_769
SELECT 10 > 5;
-- Tag: functions_functions_test_select_770
SELECT 3 < 7;
-- Tag: functions_functions_test_select_771
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_772
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_773
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_774
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_775
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_776
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_777
SELECT SIN(PI());
-- Tag: functions_functions_test_select_778
SELECT COS(0);
-- Tag: functions_functions_test_select_779
SELECT SQRT(16);
-- Tag: functions_functions_test_select_780
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_017
SELECT;
-- Tag: functions_functions_test_select_781
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_782
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_783
SELECT ABS(-42);
-- Tag: functions_functions_test_select_784
SELECT UPPER('hello');
-- Tag: functions_functions_test_select_785
SELECT LOWER('WORLD');
-- Tag: functions_functions_test_select_786
SELECT CONCAT('Hello', ' ', 'World');
-- Tag: functions_functions_test_select_787
SELECT 42, 'hello', TRUE;
-- Tag: functions_functions_test_select_788
SELECT 1 + 1, 2 * 3, 10 / 2;
-- Tag: functions_functions_test_select_789
SELECT PI(), RANDOM(), 'test', 123;
-- Tag: functions_functions_test_select_790
SELECT 42 AS answer;
-- Tag: functions_functions_test_select_791
SELECT 1 + 1 AS two, 2 * 3 AS six, PI() AS pi_value;
-- Tag: functions_functions_test_select_792
SELECT CASE WHEN TRUE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_793
SELECT CASE WHEN FALSE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_794
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_795
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_796
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_797
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_798
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_799
SELECT -42;
-- Tag: functions_functions_test_select_800
SELECT '';
-- Tag: functions_functions_test_select_801
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_802
SELECT 0;
-- Tag: functions_functions_test_select_803
SELECT 10 / 0;
-- Tag: functions_functions_test_select_804
SELECT 5 = 5;
-- Tag: functions_functions_test_select_805
SELECT 5 != 3;
-- Tag: functions_functions_test_select_806
SELECT 10 > 5;
-- Tag: functions_functions_test_select_807
SELECT 3 < 7;
-- Tag: functions_functions_test_select_808
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_809
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_810
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_811
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_812
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_813
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_814
SELECT SIN(PI());
-- Tag: functions_functions_test_select_815
SELECT COS(0);
-- Tag: functions_functions_test_select_816
SELECT SQRT(16);
-- Tag: functions_functions_test_select_817
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_018
SELECT;
-- Tag: functions_functions_test_select_818
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_819
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_820
SELECT UPPER('hello');
-- Tag: functions_functions_test_select_821
SELECT LOWER('WORLD');
-- Tag: functions_functions_test_select_822
SELECT CONCAT('Hello', ' ', 'World');
-- Tag: functions_functions_test_select_823
SELECT 42, 'hello', TRUE;
-- Tag: functions_functions_test_select_824
SELECT 1 + 1, 2 * 3, 10 / 2;
-- Tag: functions_functions_test_select_825
SELECT PI(), RANDOM(), 'test', 123;
-- Tag: functions_functions_test_select_826
SELECT 42 AS answer;
-- Tag: functions_functions_test_select_827
SELECT 1 + 1 AS two, 2 * 3 AS six, PI() AS pi_value;
-- Tag: functions_functions_test_select_828
SELECT CASE WHEN TRUE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_829
SELECT CASE WHEN FALSE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_830
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_831
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_832
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_833
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_834
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_835
SELECT -42;
-- Tag: functions_functions_test_select_836
SELECT '';
-- Tag: functions_functions_test_select_837
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_838
SELECT 0;
-- Tag: functions_functions_test_select_839
SELECT 10 / 0;
-- Tag: functions_functions_test_select_840
SELECT 5 = 5;
-- Tag: functions_functions_test_select_841
SELECT 5 != 3;
-- Tag: functions_functions_test_select_842
SELECT 10 > 5;
-- Tag: functions_functions_test_select_843
SELECT 3 < 7;
-- Tag: functions_functions_test_select_844
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_845
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_846
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_847
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_848
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_849
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_850
SELECT SIN(PI());
-- Tag: functions_functions_test_select_851
SELECT COS(0);
-- Tag: functions_functions_test_select_852
SELECT SQRT(16);
-- Tag: functions_functions_test_select_853
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_019
SELECT;
-- Tag: functions_functions_test_select_854
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_855
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_856
SELECT LOWER('WORLD');
-- Tag: functions_functions_test_select_857
SELECT CONCAT('Hello', ' ', 'World');
-- Tag: functions_functions_test_select_858
SELECT 42, 'hello', TRUE;
-- Tag: functions_functions_test_select_859
SELECT 1 + 1, 2 * 3, 10 / 2;
-- Tag: functions_functions_test_select_860
SELECT PI(), RANDOM(), 'test', 123;
-- Tag: functions_functions_test_select_861
SELECT 42 AS answer;
-- Tag: functions_functions_test_select_862
SELECT 1 + 1 AS two, 2 * 3 AS six, PI() AS pi_value;
-- Tag: functions_functions_test_select_863
SELECT CASE WHEN TRUE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_864
SELECT CASE WHEN FALSE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_865
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_866
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_867
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_868
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_869
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_870
SELECT -42;
-- Tag: functions_functions_test_select_871
SELECT '';
-- Tag: functions_functions_test_select_872
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_873
SELECT 0;
-- Tag: functions_functions_test_select_874
SELECT 10 / 0;
-- Tag: functions_functions_test_select_875
SELECT 5 = 5;
-- Tag: functions_functions_test_select_876
SELECT 5 != 3;
-- Tag: functions_functions_test_select_877
SELECT 10 > 5;
-- Tag: functions_functions_test_select_878
SELECT 3 < 7;
-- Tag: functions_functions_test_select_879
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_880
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_881
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_882
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_883
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_884
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_885
SELECT SIN(PI());
-- Tag: functions_functions_test_select_886
SELECT COS(0);
-- Tag: functions_functions_test_select_887
SELECT SQRT(16);
-- Tag: functions_functions_test_select_888
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_020
SELECT;
-- Tag: functions_functions_test_select_889
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_890
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_891
SELECT CONCAT('Hello', ' ', 'World');
-- Tag: functions_functions_test_select_892
SELECT 42, 'hello', TRUE;
-- Tag: functions_functions_test_select_893
SELECT 1 + 1, 2 * 3, 10 / 2;
-- Tag: functions_functions_test_select_894
SELECT PI(), RANDOM(), 'test', 123;
-- Tag: functions_functions_test_select_895
SELECT 42 AS answer;
-- Tag: functions_functions_test_select_896
SELECT 1 + 1 AS two, 2 * 3 AS six, PI() AS pi_value;
-- Tag: functions_functions_test_select_897
SELECT CASE WHEN TRUE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_898
SELECT CASE WHEN FALSE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_899
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_900
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_901
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_902
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_903
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_904
SELECT -42;
-- Tag: functions_functions_test_select_905
SELECT '';
-- Tag: functions_functions_test_select_906
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_907
SELECT 0;
-- Tag: functions_functions_test_select_908
SELECT 10 / 0;
-- Tag: functions_functions_test_select_909
SELECT 5 = 5;
-- Tag: functions_functions_test_select_910
SELECT 5 != 3;
-- Tag: functions_functions_test_select_911
SELECT 10 > 5;
-- Tag: functions_functions_test_select_912
SELECT 3 < 7;
-- Tag: functions_functions_test_select_913
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_914
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_915
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_916
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_917
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_918
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_919
SELECT SIN(PI());
-- Tag: functions_functions_test_select_920
SELECT COS(0);
-- Tag: functions_functions_test_select_921
SELECT SQRT(16);
-- Tag: functions_functions_test_select_922
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_021
SELECT;
-- Tag: functions_functions_test_select_923
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_924
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_925
SELECT 42, 'hello', TRUE;
-- Tag: functions_functions_test_select_926
SELECT 1 + 1, 2 * 3, 10 / 2;
-- Tag: functions_functions_test_select_927
SELECT PI(), RANDOM(), 'test', 123;
-- Tag: functions_functions_test_select_928
SELECT 42 AS answer;
-- Tag: functions_functions_test_select_929
SELECT 1 + 1 AS two, 2 * 3 AS six, PI() AS pi_value;
-- Tag: functions_functions_test_select_930
SELECT CASE WHEN TRUE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_931
SELECT CASE WHEN FALSE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_932
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_933
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_934
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_935
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_936
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_937
SELECT -42;
-- Tag: functions_functions_test_select_938
SELECT '';
-- Tag: functions_functions_test_select_939
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_940
SELECT 0;
-- Tag: functions_functions_test_select_941
SELECT 10 / 0;
-- Tag: functions_functions_test_select_942
SELECT 5 = 5;
-- Tag: functions_functions_test_select_943
SELECT 5 != 3;
-- Tag: functions_functions_test_select_944
SELECT 10 > 5;
-- Tag: functions_functions_test_select_945
SELECT 3 < 7;
-- Tag: functions_functions_test_select_946
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_947
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_948
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_949
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_950
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_951
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_952
SELECT SIN(PI());
-- Tag: functions_functions_test_select_953
SELECT COS(0);
-- Tag: functions_functions_test_select_954
SELECT SQRT(16);
-- Tag: functions_functions_test_select_955
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_022
SELECT;
-- Tag: functions_functions_test_select_956
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_957
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_958
SELECT 1 + 1, 2 * 3, 10 / 2;
-- Tag: functions_functions_test_select_959
SELECT PI(), RANDOM(), 'test', 123;
-- Tag: functions_functions_test_select_960
SELECT 42 AS answer;
-- Tag: functions_functions_test_select_961
SELECT 1 + 1 AS two, 2 * 3 AS six, PI() AS pi_value;
-- Tag: functions_functions_test_select_962
SELECT CASE WHEN TRUE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_963
SELECT CASE WHEN FALSE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_964
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_965
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_966
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_967
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_968
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_969
SELECT -42;
-- Tag: functions_functions_test_select_970
SELECT '';
-- Tag: functions_functions_test_select_971
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_972
SELECT 0;
-- Tag: functions_functions_test_select_973
SELECT 10 / 0;
-- Tag: functions_functions_test_select_974
SELECT 5 = 5;
-- Tag: functions_functions_test_select_975
SELECT 5 != 3;
-- Tag: functions_functions_test_select_976
SELECT 10 > 5;
-- Tag: functions_functions_test_select_977
SELECT 3 < 7;
-- Tag: functions_functions_test_select_978
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_979
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_980
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_981
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_982
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_983
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_984
SELECT SIN(PI());
-- Tag: functions_functions_test_select_985
SELECT COS(0);
-- Tag: functions_functions_test_select_986
SELECT SQRT(16);
-- Tag: functions_functions_test_select_987
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_023
SELECT;
-- Tag: functions_functions_test_select_988
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_989
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_990
SELECT PI(), RANDOM(), 'test', 123;
-- Tag: functions_functions_test_select_991
SELECT 42 AS answer;
-- Tag: functions_functions_test_select_992
SELECT 1 + 1 AS two, 2 * 3 AS six, PI() AS pi_value;
-- Tag: functions_functions_test_select_993
SELECT CASE WHEN TRUE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_994
SELECT CASE WHEN FALSE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_995
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_996
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_997
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_998
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_999
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_1000
SELECT -42;
-- Tag: functions_functions_test_select_1001
SELECT '';
-- Tag: functions_functions_test_select_1002
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_1003
SELECT 0;
-- Tag: functions_functions_test_select_1004
SELECT 10 / 0;
-- Tag: functions_functions_test_select_1005
SELECT 5 = 5;
-- Tag: functions_functions_test_select_1006
SELECT 5 != 3;
-- Tag: functions_functions_test_select_1007
SELECT 10 > 5;
-- Tag: functions_functions_test_select_1008
SELECT 3 < 7;
-- Tag: functions_functions_test_select_1009
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_1010
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_1011
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_1012
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_1013
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_1014
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_1015
SELECT SIN(PI());
-- Tag: functions_functions_test_select_1016
SELECT COS(0);
-- Tag: functions_functions_test_select_1017
SELECT SQRT(16);
-- Tag: functions_functions_test_select_1018
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_024
SELECT;
-- Tag: functions_functions_test_select_1019
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_1020
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_1021
SELECT 42 AS answer;
-- Tag: functions_functions_test_select_1022
SELECT 1 + 1 AS two, 2 * 3 AS six, PI() AS pi_value;
-- Tag: functions_functions_test_select_1023
SELECT CASE WHEN TRUE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_1024
SELECT CASE WHEN FALSE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_1025
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_1026
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_1027
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_1028
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_1029
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_1030
SELECT -42;
-- Tag: functions_functions_test_select_1031
SELECT '';
-- Tag: functions_functions_test_select_1032
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_1033
SELECT 0;
-- Tag: functions_functions_test_select_1034
SELECT 10 / 0;
-- Tag: functions_functions_test_select_1035
SELECT 5 = 5;
-- Tag: functions_functions_test_select_1036
SELECT 5 != 3;
-- Tag: functions_functions_test_select_1037
SELECT 10 > 5;
-- Tag: functions_functions_test_select_1038
SELECT 3 < 7;
-- Tag: functions_functions_test_select_1039
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_1040
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_1041
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_1042
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_1043
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_1044
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_1045
SELECT SIN(PI());
-- Tag: functions_functions_test_select_1046
SELECT COS(0);
-- Tag: functions_functions_test_select_1047
SELECT SQRT(16);
-- Tag: functions_functions_test_select_1048
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_025
SELECT;
-- Tag: functions_functions_test_select_1049
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_1050
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_1051
SELECT 1 + 1 AS two, 2 * 3 AS six, PI() AS pi_value;
-- Tag: functions_functions_test_select_1052
SELECT CASE WHEN TRUE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_1053
SELECT CASE WHEN FALSE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_1054
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_1055
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_1056
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_1057
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_1058
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_1059
SELECT -42;
-- Tag: functions_functions_test_select_1060
SELECT '';
-- Tag: functions_functions_test_select_1061
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_1062
SELECT 0;
-- Tag: functions_functions_test_select_1063
SELECT 10 / 0;
-- Tag: functions_functions_test_select_1064
SELECT 5 = 5;
-- Tag: functions_functions_test_select_1065
SELECT 5 != 3;
-- Tag: functions_functions_test_select_1066
SELECT 10 > 5;
-- Tag: functions_functions_test_select_1067
SELECT 3 < 7;
-- Tag: functions_functions_test_select_1068
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_1069
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_1070
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_1071
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_1072
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_1073
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_1074
SELECT SIN(PI());
-- Tag: functions_functions_test_select_1075
SELECT COS(0);
-- Tag: functions_functions_test_select_1076
SELECT SQRT(16);
-- Tag: functions_functions_test_select_1077
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_026
SELECT;
-- Tag: functions_functions_test_select_1078
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_1079
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_1080
SELECT CASE WHEN TRUE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_1081
SELECT CASE WHEN FALSE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_1082
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_1083
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_1084
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_1085
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_1086
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_1087
SELECT -42;
-- Tag: functions_functions_test_select_1088
SELECT '';
-- Tag: functions_functions_test_select_1089
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_1090
SELECT 0;
-- Tag: functions_functions_test_select_1091
SELECT 10 / 0;
-- Tag: functions_functions_test_select_1092
SELECT 5 = 5;
-- Tag: functions_functions_test_select_1093
SELECT 5 != 3;
-- Tag: functions_functions_test_select_1094
SELECT 10 > 5;
-- Tag: functions_functions_test_select_1095
SELECT 3 < 7;
-- Tag: functions_functions_test_select_1096
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_1097
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_1098
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_1099
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_1100
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_1101
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_1102
SELECT SIN(PI());
-- Tag: functions_functions_test_select_1103
SELECT COS(0);
-- Tag: functions_functions_test_select_1104
SELECT SQRT(16);
-- Tag: functions_functions_test_select_1105
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_027
SELECT;
-- Tag: functions_functions_test_select_1106
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_1107
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_1108
SELECT CASE WHEN FALSE THEN 'yes' ELSE 'no' END;
-- Tag: functions_functions_test_select_1109
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_1110
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_1111
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_1112
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_1113
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_1114
SELECT -42;
-- Tag: functions_functions_test_select_1115
SELECT '';
-- Tag: functions_functions_test_select_1116
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_1117
SELECT 0;
-- Tag: functions_functions_test_select_1118
SELECT 10 / 0;
-- Tag: functions_functions_test_select_1119
SELECT 5 = 5;
-- Tag: functions_functions_test_select_1120
SELECT 5 != 3;
-- Tag: functions_functions_test_select_1121
SELECT 10 > 5;
-- Tag: functions_functions_test_select_1122
SELECT 3 < 7;
-- Tag: functions_functions_test_select_1123
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_1124
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_1125
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_1126
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_1127
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_1128
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_1129
SELECT SIN(PI());
-- Tag: functions_functions_test_select_1130
SELECT COS(0);
-- Tag: functions_functions_test_select_1131
SELECT SQRT(16);
-- Tag: functions_functions_test_select_1132
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_028
SELECT;
-- Tag: functions_functions_test_select_1133
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_1134
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_1135
SELECT CASE WHEN 1 + 1 = 2 THEN 'correct' ELSE 'wrong' END;
-- Tag: functions_functions_test_select_1136
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_1137
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_1138
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_1139
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_1140
SELECT -42;
-- Tag: functions_functions_test_select_1141
SELECT '';
-- Tag: functions_functions_test_select_1142
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_1143
SELECT 0;
-- Tag: functions_functions_test_select_1144
SELECT 10 / 0;
-- Tag: functions_functions_test_select_1145
SELECT 5 = 5;
-- Tag: functions_functions_test_select_1146
SELECT 5 != 3;
-- Tag: functions_functions_test_select_1147
SELECT 10 > 5;
-- Tag: functions_functions_test_select_1148
SELECT 3 < 7;
-- Tag: functions_functions_test_select_1149
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_1150
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_1151
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_1152
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_1153
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_1154
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_1155
SELECT SIN(PI());
-- Tag: functions_functions_test_select_1156
SELECT COS(0);
-- Tag: functions_functions_test_select_1157
SELECT SQRT(16);
-- Tag: functions_functions_test_select_1158
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_029
SELECT;
-- Tag: functions_functions_test_select_1159
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_1160
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_1161
SELECT COALESCE(NULL, 'default');
-- Tag: functions_functions_test_select_1162
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_1163
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_1164
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_1165
SELECT -42;
-- Tag: functions_functions_test_select_1166
SELECT '';
-- Tag: functions_functions_test_select_1167
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_1168
SELECT 0;
-- Tag: functions_functions_test_select_1169
SELECT 10 / 0;
-- Tag: functions_functions_test_select_1170
SELECT 5 = 5;
-- Tag: functions_functions_test_select_1171
SELECT 5 != 3;
-- Tag: functions_functions_test_select_1172
SELECT 10 > 5;
-- Tag: functions_functions_test_select_1173
SELECT 3 < 7;
-- Tag: functions_functions_test_select_1174
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_1175
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_1176
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_1177
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_1178
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_1179
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_1180
SELECT SIN(PI());
-- Tag: functions_functions_test_select_1181
SELECT COS(0);
-- Tag: functions_functions_test_select_1182
SELECT SQRT(16);
-- Tag: functions_functions_test_select_1183
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_030
SELECT;
-- Tag: functions_functions_test_select_1184
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_1185
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_1186
SELECT COALESCE('value', 'default');
-- Tag: functions_functions_test_select_1187
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_1188
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_1189
SELECT -42;
-- Tag: functions_functions_test_select_1190
SELECT '';
-- Tag: functions_functions_test_select_1191
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_1192
SELECT 0;
-- Tag: functions_functions_test_select_1193
SELECT 10 / 0;
-- Tag: functions_functions_test_select_1194
SELECT 5 = 5;
-- Tag: functions_functions_test_select_1195
SELECT 5 != 3;
-- Tag: functions_functions_test_select_1196
SELECT 10 > 5;
-- Tag: functions_functions_test_select_1197
SELECT 3 < 7;
-- Tag: functions_functions_test_select_1198
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_1199
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_1200
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_1201
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_1202
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_1203
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_1204
SELECT SIN(PI());
-- Tag: functions_functions_test_select_1205
SELECT COS(0);
-- Tag: functions_functions_test_select_1206
SELECT SQRT(16);
-- Tag: functions_functions_test_select_1207
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_031
SELECT;
-- Tag: functions_functions_test_select_1208
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_1209
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_1210
SELECT IFNULL(NULL, 42);
-- Tag: functions_functions_test_select_1211
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_1212
SELECT -42;
-- Tag: functions_functions_test_select_1213
SELECT '';
-- Tag: functions_functions_test_select_1214
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_1215
SELECT 0;
-- Tag: functions_functions_test_select_1216
SELECT 10 / 0;
-- Tag: functions_functions_test_select_1217
SELECT 5 = 5;
-- Tag: functions_functions_test_select_1218
SELECT 5 != 3;
-- Tag: functions_functions_test_select_1219
SELECT 10 > 5;
-- Tag: functions_functions_test_select_1220
SELECT 3 < 7;
-- Tag: functions_functions_test_select_1221
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_1222
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_1223
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_1224
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_1225
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_1226
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_1227
SELECT SIN(PI());
-- Tag: functions_functions_test_select_1228
SELECT COS(0);
-- Tag: functions_functions_test_select_1229
SELECT SQRT(16);
-- Tag: functions_functions_test_select_1230
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_032
SELECT;
-- Tag: functions_functions_test_select_1231
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_1232
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_1233
SELECT 9223372036854775807;
-- Tag: functions_functions_test_select_1234
SELECT -42;
-- Tag: functions_functions_test_select_1235
SELECT '';
-- Tag: functions_functions_test_select_1236
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_1237
SELECT 0;
-- Tag: functions_functions_test_select_1238
SELECT 10 / 0;
-- Tag: functions_functions_test_select_1239
SELECT 5 = 5;
-- Tag: functions_functions_test_select_1240
SELECT 5 != 3;
-- Tag: functions_functions_test_select_1241
SELECT 10 > 5;
-- Tag: functions_functions_test_select_1242
SELECT 3 < 7;
-- Tag: functions_functions_test_select_1243
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_1244
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_1245
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_1246
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_1247
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_1248
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_1249
SELECT SIN(PI());
-- Tag: functions_functions_test_select_1250
SELECT COS(0);
-- Tag: functions_functions_test_select_1251
SELECT SQRT(16);
-- Tag: functions_functions_test_select_1252
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_033
SELECT;
-- Tag: functions_functions_test_select_1253
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_1254
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_1255
SELECT -42;
-- Tag: functions_functions_test_select_1256
SELECT '';
-- Tag: functions_functions_test_select_1257
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_1258
SELECT 0;
-- Tag: functions_functions_test_select_1259
SELECT 10 / 0;
-- Tag: functions_functions_test_select_1260
SELECT 5 = 5;
-- Tag: functions_functions_test_select_1261
SELECT 5 != 3;
-- Tag: functions_functions_test_select_1262
SELECT 10 > 5;
-- Tag: functions_functions_test_select_1263
SELECT 3 < 7;
-- Tag: functions_functions_test_select_1264
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_1265
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_1266
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_1267
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_1268
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_1269
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_1270
SELECT SIN(PI());
-- Tag: functions_functions_test_select_1271
SELECT COS(0);
-- Tag: functions_functions_test_select_1272
SELECT SQRT(16);
-- Tag: functions_functions_test_select_1273
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_034
SELECT;
-- Tag: functions_functions_test_select_1274
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_1275
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_1276
SELECT '';
-- Tag: functions_functions_test_select_1277
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_1278
SELECT 0;
-- Tag: functions_functions_test_select_1279
SELECT 10 / 0;
-- Tag: functions_functions_test_select_1280
SELECT 5 = 5;
-- Tag: functions_functions_test_select_1281
SELECT 5 != 3;
-- Tag: functions_functions_test_select_1282
SELECT 10 > 5;
-- Tag: functions_functions_test_select_1283
SELECT 3 < 7;
-- Tag: functions_functions_test_select_1284
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_1285
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_1286
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_1287
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_1288
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_1289
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_1290
SELECT SIN(PI());
-- Tag: functions_functions_test_select_1291
SELECT COS(0);
-- Tag: functions_functions_test_select_1292
SELECT SQRT(16);
-- Tag: functions_functions_test_select_1293
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_035
SELECT;
-- Tag: functions_functions_test_select_1294
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_1295
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_1296
SELECT 'It''s a test';
-- Tag: functions_functions_test_select_1297
SELECT 0;
-- Tag: functions_functions_test_select_1298
SELECT 10 / 0;
-- Tag: functions_functions_test_select_1299
SELECT 5 = 5;
-- Tag: functions_functions_test_select_1300
SELECT 5 != 3;
-- Tag: functions_functions_test_select_1301
SELECT 10 > 5;
-- Tag: functions_functions_test_select_1302
SELECT 3 < 7;
-- Tag: functions_functions_test_select_1303
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_1304
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_1305
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_1306
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_1307
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_1308
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_1309
SELECT SIN(PI());
-- Tag: functions_functions_test_select_1310
SELECT COS(0);
-- Tag: functions_functions_test_select_1311
SELECT SQRT(16);
-- Tag: functions_functions_test_select_1312
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_036
SELECT;
-- Tag: functions_functions_test_select_1313
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_1314
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_1315
SELECT 0;
-- Tag: functions_functions_test_select_1316
SELECT 10 / 0;
-- Tag: functions_functions_test_select_1317
SELECT 5 = 5;
-- Tag: functions_functions_test_select_1318
SELECT 5 != 3;
-- Tag: functions_functions_test_select_1319
SELECT 10 > 5;
-- Tag: functions_functions_test_select_1320
SELECT 3 < 7;
-- Tag: functions_functions_test_select_1321
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_1322
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_1323
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_1324
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_1325
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_1326
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_1327
SELECT SIN(PI());
-- Tag: functions_functions_test_select_1328
SELECT COS(0);
-- Tag: functions_functions_test_select_1329
SELECT SQRT(16);
-- Tag: functions_functions_test_select_1330
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_037
SELECT;
-- Tag: functions_functions_test_select_1331
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_1332
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_1333
SELECT 10 / 0;
-- Tag: functions_functions_test_select_1334
SELECT 5 = 5;
-- Tag: functions_functions_test_select_1335
SELECT 5 != 3;
-- Tag: functions_functions_test_select_1336
SELECT 10 > 5;
-- Tag: functions_functions_test_select_1337
SELECT 3 < 7;
-- Tag: functions_functions_test_select_1338
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_1339
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_1340
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_1341
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_1342
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_1343
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_1344
SELECT SIN(PI());
-- Tag: functions_functions_test_select_1345
SELECT COS(0);
-- Tag: functions_functions_test_select_1346
SELECT SQRT(16);
-- Tag: functions_functions_test_select_1347
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_038
SELECT;
-- Tag: functions_functions_test_select_1348
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_1349
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_1350
SELECT 5 = 5;
-- Tag: functions_functions_test_select_1351
SELECT 5 != 3;
-- Tag: functions_functions_test_select_1352
SELECT 10 > 5;
-- Tag: functions_functions_test_select_1353
SELECT 3 < 7;
-- Tag: functions_functions_test_select_1354
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_1355
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_1356
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_1357
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_1358
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_1359
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_1360
SELECT SIN(PI());
-- Tag: functions_functions_test_select_1361
SELECT COS(0);
-- Tag: functions_functions_test_select_1362
SELECT SQRT(16);
-- Tag: functions_functions_test_select_1363
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_039
SELECT;
-- Tag: functions_functions_test_select_1364
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_1365
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_1366
SELECT 5 != 3;
-- Tag: functions_functions_test_select_1367
SELECT 10 > 5;
-- Tag: functions_functions_test_select_1368
SELECT 3 < 7;
-- Tag: functions_functions_test_select_1369
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_1370
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_1371
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_1372
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_1373
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_1374
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_1375
SELECT SIN(PI());
-- Tag: functions_functions_test_select_1376
SELECT COS(0);
-- Tag: functions_functions_test_select_1377
SELECT SQRT(16);
-- Tag: functions_functions_test_select_1378
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_040
SELECT;
-- Tag: functions_functions_test_select_1379
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_1380
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_1381
SELECT 10 > 5;
-- Tag: functions_functions_test_select_1382
SELECT 3 < 7;
-- Tag: functions_functions_test_select_1383
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_1384
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_1385
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_1386
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_1387
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_1388
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_1389
SELECT SIN(PI());
-- Tag: functions_functions_test_select_1390
SELECT COS(0);
-- Tag: functions_functions_test_select_1391
SELECT SQRT(16);
-- Tag: functions_functions_test_select_1392
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_041
SELECT;
-- Tag: functions_functions_test_select_1393
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_1394
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_1395
SELECT 3 < 7;
-- Tag: functions_functions_test_select_1396
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_1397
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_1398
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_1399
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_1400
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_1401
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_1402
SELECT SIN(PI());
-- Tag: functions_functions_test_select_1403
SELECT COS(0);
-- Tag: functions_functions_test_select_1404
SELECT SQRT(16);
-- Tag: functions_functions_test_select_1405
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_042
SELECT;
-- Tag: functions_functions_test_select_1406
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_1407
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_1408
SELECT TRUE AND TRUE;
-- Tag: functions_functions_test_select_1409
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_1410
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_1411
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_1412
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_1413
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_1414
SELECT SIN(PI());
-- Tag: functions_functions_test_select_1415
SELECT COS(0);
-- Tag: functions_functions_test_select_1416
SELECT SQRT(16);
-- Tag: functions_functions_test_select_1417
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_043
SELECT;
-- Tag: functions_functions_test_select_1418
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_1419
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_1420
SELECT TRUE OR FALSE;
-- Tag: functions_functions_test_select_1421
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_1422
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_1423
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_1424
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_1425
SELECT SIN(PI());
-- Tag: functions_functions_test_select_1426
SELECT COS(0);
-- Tag: functions_functions_test_select_1427
SELECT SQRT(16);
-- Tag: functions_functions_test_select_1428
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_044
SELECT;
-- Tag: functions_functions_test_select_1429
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_1430
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_1431
SELECT NOT FALSE;
-- Tag: functions_functions_test_select_1432
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_1433
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_1434
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_1435
SELECT SIN(PI());
-- Tag: functions_functions_test_select_1436
SELECT COS(0);
-- Tag: functions_functions_test_select_1437
SELECT SQRT(16);
-- Tag: functions_functions_test_select_1438
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_045
SELECT;
-- Tag: functions_functions_test_select_1439
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_1440
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_1441
SELECT UPPER(LOWER('TEST'));
-- Tag: functions_functions_test_select_1442
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_1443
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_1444
SELECT SIN(PI());
-- Tag: functions_functions_test_select_1445
SELECT COS(0);
-- Tag: functions_functions_test_select_1446
SELECT SQRT(16);
-- Tag: functions_functions_test_select_1447
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_046
SELECT;
-- Tag: functions_functions_test_select_1448
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_1449
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_1450
SELECT ((10 + 5) * 2) / 3;
-- Tag: functions_functions_test_select_1451
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_1452
SELECT SIN(PI());
-- Tag: functions_functions_test_select_1453
SELECT COS(0);
-- Tag: functions_functions_test_select_1454
SELECT SQRT(16);
-- Tag: functions_functions_test_select_1455
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_047
SELECT;
-- Tag: functions_functions_test_select_1456
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_1457
SELECT 'text' > 123;

-- Tag: functions_functions_test_select_1458
SELECT CASE WHEN 1 + 1 = 2 THEN UPPER('correct') ELSE LOWER('WRONG') END;
-- Tag: functions_functions_test_select_1459
SELECT SIN(PI());
-- Tag: functions_functions_test_select_1460
SELECT COS(0);
-- Tag: functions_functions_test_select_1461
SELECT SQRT(16);
-- Tag: functions_functions_test_select_1462
SELECT POWER(2, 10);
-- Tag: functions_functions_test_select_048
SELECT;
-- Tag: functions_functions_test_select_1463
SELECT UNDEFINED_FUNC();
-- Tag: functions_functions_test_select_1464
SELECT 'text' > 123;
