time
dateFrom: aStream "ByteStream"
	"Ref: libmysql.c >> read_binary_date"
	| len year month day |
	
	len := aStream next.
	len = 0 ifTrue: [^ nil].

	year := month := day := 0.

	year := self smallIntFrom: aStream.
	month := self tinyIntFrom: aStream.
	day := self tinyIntFrom: aStream.
	aStream next: (len - 4). "ignore rest of fields even if present"
	^ Date year: year month: month day: day
	