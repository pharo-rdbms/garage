initialization
buildDefaultFieldConverters
	"The type oid's can be found using:
		SELECT oid,typname from pg_type
	Also, see the source code file:
		.../src/include/catalog/pg_type.h
	"
	| converters |
	converters := IdentityDictionary new.
	#(
		(booleanConverter (16 "boolean"))
		(booleanArrayConverter (1000 "boolean[]"))
		(characterConverter (18 "char" 1002 "_char" 1042 "bpchar")) "fix the array converter!"
		(integerConveter (20 "int8" 21 "int2" 23 "int4"))
		(integerArrayConveter (1005 "_int2[]" 1007 "_int4[]" 1016 "_int8[]"))
		(stringArrayConveter (1009)) "doesn't handle nulls"
		(floatConverter (700 "float4" 701 "float8" 1021 "_float4" 1022 "_float8")) "fix the array converter"
		(numericConverter (1700 "numeric")) "fix it, it returns a float now"
		(dateConverter (1082 "date" 1182 "_date")) "fix the array converter"
		(timeConverter (1083 "time" 1183 "_time")) "fix the array converter"
		(timestampConverter (1114 "timestamp" 1115 "_timestamp")) "fix the array converter"
		(timeWithTimezoneConverter (1266 "timetz" 1270 "_timetz")) "probably omits the timezone. fix the array converter"
		(timestampWithTimezoneConverter (1184 "timestamptz " 1185 "_timestamptz")) "fix the array converter"
		(jsonConverter (114 114))
	) do: [ :each |
		each second do: [ :typeOid |
			converters at: typeOid put: (self perform: each first) ] ].
	^ converters
