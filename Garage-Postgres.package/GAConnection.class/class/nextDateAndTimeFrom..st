private
nextDateAndTimeFrom: string
	"Accepted format: 'YYYY-MM-DD HH:MM:SS[.ss...s][(+|-)HH]' fractional seconds and timezone are optional"
	"#( '1967-08-07 18:50:12+02' '1967-08-07 18:50:12' '1967-08-07 18:50:12.12+02' 
		'1967-08-07 18:50:12.123+02' '1967-08-07 18:50:12.123456' ) 
		collect: [ :each | self nextDateAndTimeFrom: each ] "
	
	| stream parser parseInteger direction fractionalSeconds offset |
	stream := ReadStream on: string.
	parser := NumberParser on: stream.
	parseInteger := [ :from :to | 
		stream setFrom: from to: to. 
		parser nextUnsignedIntegerBase: 10 ].
	fractionalSeconds := 0.
	offset := DateAndTime localOffset.
	string size > 19 
		ifTrue: [ | offsetStart |
			(string at: 20) = $.
				ifTrue: [
					offsetStart := 21.
					[ offsetStart <= string size and: [ (string at: offsetStart) isDigit ] ]
						whileTrue: [ offsetStart := offsetStart + 1 ].
					offsetStart > 21 ifTrue: [ fractionalSeconds := parseInteger value: 21 value: offsetStart - 1 ] ]
				ifFalse: [ 
					offsetStart := 20 ].
			offsetStart <= string size
				ifTrue: [	
					direction := (string at: offsetStart) = $- ifTrue: [ -1 ] ifFalse: [ 1 ].
					offset := Duration hours: (parseInteger value: offsetStart + 1 value: string size) * direction ] ].
	^ DateAndTime
		year: (parseInteger value: 1 value: 4)
		month: (parseInteger value: 6 value: 7)
		day: (parseInteger value: 9 value: 10)
		hour: (parseInteger value: 12 value: 13)
		minute: (parseInteger value: 15 value: 16)
		second: (parseInteger value: 18 value: 19)
		nanoSecond: fractionalSeconds * (10 raisedToInteger: (9 - fractionalSeconds numberOfDigits))
		offset: offset