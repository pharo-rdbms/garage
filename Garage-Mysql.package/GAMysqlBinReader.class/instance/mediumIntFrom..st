integer
mediumIntFrom: aStream
	"int24 is sent as 4 bytes int"
	"Ref: libmysql.c >> fetch_result_with_conversion()"
	^ self longIntFrom: aStream
	