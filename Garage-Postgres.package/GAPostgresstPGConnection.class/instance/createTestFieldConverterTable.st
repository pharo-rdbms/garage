tests
createTestFieldConverterTable

	self executeAll: #(
'CREATE TABLE TestFieldConverterTable (
aBool1 boolean,
aBool2 boolean,
aChar char,
aChar1 char(1),
aChar2 char(2),
anInt2 int2,
anInt4 int4,
anInt8 int8,
aFloat4 float4,
aFloat8 float8,
aNumeric numeric,
aDate date,
aTime time,
aText text
)'
		).
