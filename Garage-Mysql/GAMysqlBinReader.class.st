"
I am a reader from the mysql binary protocol. I convert binary data sent by mysql into Pharo objects.
"
Class {
	#name : #GAMysqlBinReader,
	#superclass : #Object,
	#classInstVars : [
		'defaultInstance'
	],
	#category : 'Garage-Mysql-Protocol'
}

{ #category : #'as yet unclassified' }
GAMysqlBinReader class >> default [
	defaultInstance isNil ifTrue: [ defaultInstance := self new ].
	^ defaultInstance
]

{ #category : #integer }
GAMysqlBinReader >> bigIntFrom: aStream [
	^ aStream next + (aStream next << 8) + (aStream next << 16) + (aStream next << 24) + 
		(aStream next << 32) + (aStream next << 40) + (aStream next << 48) + (aStream next << 56)
		
]

{ #category : #time }
GAMysqlBinReader >> dateFrom: aStream [ "ByteStream"
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
	
]

{ #category : #time }
GAMysqlBinReader >> dateTimeFrom: aStream [ "ByteStream"
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
		
]

{ #category : #real }
GAMysqlBinReader >> decimalWithScale: scale from: aStream [
	| valueString |
	valueString := (GAMysqlHelper decodeLcsFrom: aStream) asString, 's', scale asString.
	^ valueString asNumber
	
]

{ #category : #real }
GAMysqlBinReader >> doubleFrom: aStream [
	| num |
	num := Float new: 2.
	num at: 2 put: (self longIntFrom: aStream).
	num at: 1 put: (self longIntFrom: aStream).
	^ num
	

]

{ #category : #real }
GAMysqlBinReader >> floatFrom: aStream [
	^ Float fromIEEE32Bit: (self longIntFrom: aStream)
	
]

{ #category : #integer }
GAMysqlBinReader >> longIntFrom: aStream [
	^ aStream next + (aStream next << 8) + (aStream next << 16) + (aStream next << 24)
	
]

{ #category : #integer }
GAMysqlBinReader >> mediumIntFrom: aStream [
	"int24 is sent as 4 bytes int"
	"Ref: libmysql.c >> fetch_result_with_conversion()"
	^ self longIntFrom: aStream
	
]

{ #category : #integer }
GAMysqlBinReader >> smallIntFrom: aStream [
	^ aStream next + (aStream next << 8) 
		
]

{ #category : #time }
GAMysqlBinReader >> timeFrom: aStream [ 
	"ByteStream"
	"length(1) + sign(1) + days(4) + hh(1) + mm(1) + ss(1) + subSeconds(4)"
	"According to the mySQL docs, it deos not store the fraction part of the seconds."
	| length sign days hh mm ss timeDuration timeOfDay ns |
	length := aStream next.
	length = 0 ifTrue: [ ^ Time midnight ].
	sign := aStream next = 0 
		ifTrue: [ 1 ]
		ifFalse: [ 1 negated ].
	days := self longIntFrom: aStream.
	hh := mm := ss := ns := 0.
	length > 5 ifTrue: 
		[ hh := self tinyIntFrom: aStream.
		mm := self tinyIntFrom: aStream.
		ss := self tinyIntFrom: aStream ].
	length > 8 ifTrue: [ ns := 1000 * (self longIntFrom: aStream) ].
	timeDuration := Duration 
		days: days
		hours: hh
		minutes: mm
		seconds: ss
		nanoSeconds: ns.
	timeOfDay := Time 
		hour: hh
		minute: mm
		second: ss
		nanoSecond: ns.
	sign < 0 ifTrue: [ ^ timeDuration negated ].
	days > 0 
		ifTrue: [ ^ timeDuration ]
		ifFalse: [ ^ timeOfDay ]
]

{ #category : #time }
GAMysqlBinReader >> timeStampFrom: aStream [ "ByteStream"
	| dt |
	dt := self dateTimeFrom: aStream.
	^ dt ifNil: [nil] ifNotNil: [dt asTimeStamp]
	
]

{ #category : #integer }
GAMysqlBinReader >> tinyIntFrom: aStream [
	^ aStream next 
		
]

{ #category : #blob }
GAMysqlBinReader >> varBlobFrom: aStream [
	^ GAMysqlHelper decodeLcsFrom: aStream 
	
	
]

{ #category : #string }
GAMysqlBinReader >> varStringFrom: aStream [
	^ (self varBlobFrom: aStream) asString 
	
	
]

{ #category : #time }
GAMysqlBinReader >> yearFrom: aStream [ "ByteStream"
	^ self smallIntFrom: aStream	
	
]
