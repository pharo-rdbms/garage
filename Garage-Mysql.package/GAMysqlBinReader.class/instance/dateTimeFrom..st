time
dateTimeFrom: aStream "ByteStream"
	"Ref: libmysql.c >> read_binary_datetime"
	"length(1) + year(2) + month(1) + day(1) + hh(1) + mm(1) + ss(1) + micoSeconds(4)"
	
	| length year month day hh mm ss ns |
	length := aStream next.
	length = 0 ifTrue: [^ nil].
	
	year := self smallIntFrom: aStream.
	month := self tinyIntFrom: aStream..
	day := self tinyIntFrom: aStream..
	
	hh := mm:= ss := ns := 0.
	length > 4 ifTrue: [
		hh := self tinyIntFrom: aStream..
		mm := self tinyIntFrom: aStream.
		ss := self tinyIntFrom: aStream.].	
	length > 7 ifTrue: [ns := (self longIntFrom: aStream) * 1000].

	^ DateAndTime 
		year: year month: month day: day 
		hour: hh minute: mm second: ss 
		nanoSecond: ns offset: 0 hours
		