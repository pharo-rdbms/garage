Class {
	#name : #GAMysqlBindParam,
	#superclass : #Object,
	#instVars : [
		'connection',
		'paramValue',
		'paramType',
		'newParamBound',
		'unsignedFlag',
		'declaredUnsigned',
		'sentAsLongData'
	],
	#category : 'Garage-MySQL-Protocol'
}

{ #category : #'as yet unclassified' }
GAMysqlBindParam class >> listOfSize: count forDescriptors: fields [
	| params |
	params := (1 to: count) collect: [:each |  
			(self new 
				declaredUnsigned: (fields at: each) isUnsigned; 
				yourself)].
	^ params
	
]

{ #category : #'as yet unclassified' }
GAMysqlBindParam class >> withValue: aValue [
	^ self new
		bindValue: aValue;
		yourself
	
]

{ #category : #private }
GAMysqlBindParam >> bigIntRange [
	^ self isDeclaredUnsigned 
		ifTrue: [16r0000000000000000 to: 16rFFFFFFFFFFFFFFFF] 
		ifFalse: [-16r8000000000000000 to: 16r7FFFFFFFFFFFFFFF].

]

{ #category : #accessing }
GAMysqlBindParam >> bindValue: aValue [ 
	| boundType |
	paramValue := aValue.
	(boundType := self detectParamType) ~= paramType 
		ifTrue: [
			paramType := boundType.
			newParamBound := true].
	GAMysqlTypes typeVARSTRING = paramType ifTrue: [ paramValue := connection encoder encodeString: paramValue ].
	unsignedFlag := self detectParamSign.
	
]

{ #category : #accessing }
GAMysqlBindParam >> connection: aConnection [

	connection := aConnection
]

{ #category : #writes }
GAMysqlBindParam >> dateTimeBytes [
	| dt year length micros |
	ByteArray streamContents: [:strm |
		dt := paramValue asDateAndTime.
		length := 0.
		strm nextPut: length. "will re-adjust this as different conditions are found"
				
		year := dt year.
		strm 
			nextPut: (year digitAt: 1); nextPut: (year digitAt: 2); "year"
			nextPut: (dt month digitAt: 1); nextPut: (dt dayOfMonth digitAt: 1).

		strm
			nextPut: (dt hour digitAt: 1); nextPut: (dt minute digitAt: 1); 
			nextPut: (dt second digitAt: 1). 
		
		micros := dt nanoSecond // 1000.
		strm 
			nextPut: (micros digitAt: 1); nextPut: (micros digitAt: 2);
			nextPut: (micros digitAt: 3); nextPut: (micros digitAt: 4).
		
		"Update the length field now."
		length := 11.
		micros = 0 ifTrue: [
			length := 7. "no sub-seconds to send"
			(((dt hour = 0) and: [dt minute = 0]) and: [dt second = 0]) ifTrue: [
				"no hh:mm:ss to send"
				length := 4.				
				((dt year = 0) and: [dt month = 0 and: [dt day = 0]]) ifTrue: [
					"no yy-mm-dd to send"
					length := 0]]].
		
		strm reset; nextPut: length; setToEnd.
		^ strm contents first: (length + 1) "remember to send the length byte itself" ]
	
]

{ #category : #writes }
GAMysqlBindParam >> decimalBytes [
	"For scaled decimal"
	ByteArray streamContents: [:strm |
		strm nextPutAll: (paramValue abs printString allButLast:2) asByteArray.
		^ strm contents]
	
]

{ #category : #accessing }
GAMysqlBindParam >> declaredUnsigned: aBoolean [
	declaredUnsigned := aBoolean
	
]

{ #category : #accessing }
GAMysqlBindParam >> detectParamSign [
	"true is unsigned, false if signed"
	^ (((paramValue isKindOf: Number) or: [paramValue isKindOf: Duration]) and: [paramValue negative]) not
	
]

{ #category : #accessing }
GAMysqlBindParam >> detectParamType [
	"Corresponding database type needs to be inferred from the bound value"
	paramValue ifNil: [ ^ GAMysqlTypes typeNULL ].

	(paramValue isKindOf: Boolean) ifTrue: [ ^ GAMysqlTypes typeTINY ].

	(paramValue isKindOf: Integer) ifTrue: [
		(self tinyIntRange includes: paramValue) ifTrue: [^ GAMysqlTypes typeTINY].
		(self smallIntRange includes: paramValue) ifTrue: [^ GAMysqlTypes typeSHORT].
		(self longIntRange includes: paramValue) ifTrue: [^ GAMysqlTypes typeLONG].
		(self bigIntRange includes: paramValue) ifTrue: [^ GAMysqlTypes typeLONGLONG].
		^ GAMysqlBindError signal: 'Supplied integer does not have a matching database type'].

	(paramValue isKindOf: ScaledDecimal) ifTrue: [ ^ GAMysqlTypes typeDECIMAL ].
	((paramValue isKindOf: Float) or:  [paramValue isKindOf: Fraction]) 
		ifTrue: [	
			(paramValue asFloat at: 2) = 0 
				ifTrue: [^ GAMysqlTypes typeFLOAT]
				ifFalse: [^ GAMysqlTypes typeDOUBLE] ].

	(paramValue isKindOf: Character) ifTrue: [ ^ GAMysqlTypes typeSTRING ].
	((paramValue isKindOf: String) or: [paramValue isKindOf: Text]) 
		ifTrue: [ ^ GAMysqlTypes typeVARSTRING ].

	(paramValue isMemberOf: DateAndTime) ifTrue: [ ^ GAMysqlTypes typeDATETIME ].
	(paramValue isKindOf: TimeStamp) ifTrue: [ ^ GAMysqlTypes typeTIMESTAMP ].
	((paramValue isKindOf: Time) or: [paramValue isKindOf: Duration]) 
		ifTrue: [ ^ GAMysqlTypes typeTIME ].
	(paramValue isKindOf: Date) ifTrue: [ ^ GAMysqlTypes typeDATE ].

	(paramValue isKindOf: ByteArray) ifTrue: [ 
		paramValue size < 16r100 ifTrue: [ ^ GAMysqlTypes typeTINYBLOB ].
		paramValue size < 16r10000 ifTrue: [ ^ GAMysqlTypes typeBLOB ].
		paramValue size < 16r1000000 ifTrue: [ ^ GAMysqlTypes typeMEDIUMBLOB ].
		^ GAMysqlTypes typeLONGBLOB ].
	
	^ GAMysqlBindError signal: 'Unsupported data type for param binding'
	
]

{ #category : #writes }
GAMysqlBindParam >> doubleBytes [ 
	| storable |
	ByteArray streamContents: [:strm |
		storable := paramValue asFloat at: 1.
		strm 
			nextPut: (storable digitAt: 1); nextPut: (storable digitAt: 2);
			nextPut: (storable digitAt: 3); nextPut: (storable digitAt: 4).

		storable := paramValue asFloat at: 2.
		strm 
			nextPut: (storable digitAt: 1); nextPut: (storable digitAt: 2);
			nextPut: (storable digitAt: 3); nextPut: (storable digitAt: 4).
			
		^ strm contents]

]

{ #category : #writes }
GAMysqlBindParam >> floatBytes [ 
	| storable |
	ByteArray streamContents: [:strm |
		storable := paramValue asFloat at: 1. "indexed accedd into a Float"
		strm 
			nextPut: (storable digitAt: 1); nextPut: (storable digitAt: 2);
			nextPut: (storable digitAt: 3); nextPut: (storable digitAt: 4).
		^ strm contents]
	
]

{ #category : #'initialize-release' }
GAMysqlBindParam >> initialize [
	newParamBound := false.
	paramType := GAMysqlTypes typeNULL.
	unsignedFlag := declaredUnsigned := false.
	sentAsLongData := false
	
]

{ #category : #writes }
GAMysqlBindParam >> integerBytes: size [ 
	| storable |
	ByteArray streamContents: [:strm |
		storable := self storableIntegerValueOfSize: size.
		1 to: size do: [:ii | strm nextPut: (storable digitAt: ii)].
		^ strm contents]
	
]

{ #category : #testing }
GAMysqlBindParam >> isDeclaredUnsigned [
	^ declaredUnsigned  
	
]

{ #category : #testing }
GAMysqlBindParam >> isLongData [
	| typeRange |
	"We also send varchar types as long data"
	self paramType = GAMysqlTypes typeVARCHAR ifTrue: [^ true].
	typeRange := (GAMysqlTypes typeTINYBLOB to: GAMysqlTypes typeSTRING).
	^ typeRange includes: self paramType 
	
]

{ #category : #testing }
GAMysqlBindParam >> isNull [
	^ paramType = GAMysqlTypes typeNULL
	
]

{ #category : #testing }
GAMysqlBindParam >> isRebound [
	^ newParamBound 
	
]

{ #category : #testing }
GAMysqlBindParam >> isUnsigned [
	^ unsignedFlag 
	
]

{ #category : #private }
GAMysqlBindParam >> longIntRange [
	^ self isDeclaredUnsigned 
		ifTrue: [16r00000000 to: 16rFFFFFFFF] 
		ifFalse: [-16r80000000 to: 16r7FFFFFFF].

]

{ #category : #accessing }
GAMysqlBindParam >> paramType [
	^ paramType 
	
]

{ #category : #accessing }
GAMysqlBindParam >> resetReboundFlag [
	newParamBound := false
	
]

{ #category : #testing }
GAMysqlBindParam >> sentAsLongData [
	^ sentAsLongData
	
]

{ #category : #accessing }
GAMysqlBindParam >> sentAsLongData: aBoolean [
	sentAsLongData := aBoolean
	
]

{ #category : #private }
GAMysqlBindParam >> smallIntRange [
	^ self isDeclaredUnsigned ifTrue: [16r0000 to: 16rFFFF] ifFalse: [-16r8000 to: 16r7FFF].

]

{ #category : #writes }
GAMysqlBindParam >> storableIntegerValueOfSize: size [ 
	(paramValue isKindOf: Boolean) ifTrue: [^ paramValue ifTrue: [1] ifFalse: [0]].
	^ paramValue negative 
		ifTrue: [ (1 << (size * 8)) + paramValue ]
		ifFalse: [ paramValue ]
]

{ #category : #accessing }
GAMysqlBindParam >> storeBinaryOn: aStream [		
	paramType 
	caseOf: {
		[GAMysqlTypes typeNULL]->[].
		[GAMysqlTypes typeTINY]->[aStream nextPutAll: (self integerBytes: 1)].
		[GAMysqlTypes typeSHORT]->[aStream nextPutAll: (self integerBytes: 2)].
		[GAMysqlTypes typeLONG]->[aStream nextPutAll: (self integerBytes: 4)].		
		[GAMysqlTypes typeLONGLONG]->[aStream nextPutAll: (self integerBytes: 8)].	
		[GAMysqlTypes typeFLOAT]->[aStream nextPutAll: (self floatBytes)].
		[GAMysqlTypes typeDOUBLE]->[aStream nextPutAll: (self doubleBytes)].
		[GAMysqlTypes typeTIME]->[aStream nextPutAll: self timeBytes].
		[GAMysqlTypes typeDATE]->[aStream nextPutAll: self dateTimeBytes].
		[GAMysqlTypes typeTIMESTAMP]->[aStream nextPutAll: self dateTimeBytes].
		[GAMysqlTypes typeDATETIME]->[aStream nextPutAll: self dateTimeBytes].	
		[GAMysqlTypes typeDECIMAL]->[aStream nextPutAll: self decimalBytes]	
	} 
	otherwise: [aStream nextPutAll: self stringOrBlobBytes]
	
]

{ #category : #writes }
GAMysqlBindParam >> stringOrBlobBytes [		
	ByteArray streamContents: [:strm |
		GAMysqlHelper encodeLcs: self stringOrBlobBytesRaw on: strm.
		^ strm contents]
	
]

{ #category : #writes }
GAMysqlBindParam >> stringOrBlobBytesRaw [
	| mappedValue |
	mappedValue := ((paramValue isKindOf: Character) or: [ paramValue isKindOf: Text ]) 
		ifTrue: [ paramValue asString ]
		ifFalse: [ paramValue ].
	^ mappedValue asByteArray
]

{ #category : #writes }
GAMysqlBindParam >> timeBytes [
	| dur days length micros |
	ByteArray streamContents: [:strm |
		dur := paramValue asDuration.
		length := 0.
		strm nextPut: length. "will re-adjust this as different conditions are found"
				
		dur negative ifTrue: [strm nextPut: 1] ifFalse: [strm nextPut: 0].

		days := dur days.
		strm 
			nextPut: (days digitAt: 1); nextPut: (days digitAt: 2);
			nextPut: (days digitAt: 3); nextPut: (days digitAt: 4).
		
		strm 
			nextPut: (dur hours digitAt: 1); nextPut: (dur minutes digitAt: 1); 
			nextPut: (dur seconds asInteger digitAt: 1).
		
		micros := dur nanoSeconds // 1000.
		strm 
			nextPut: (micros digitAt: 1); nextPut: (micros digitAt: 2);
			nextPut: (micros digitAt: 3); nextPut: (micros digitAt: 4).
		
		"Update the length field now."
		length := 11.
		micros = 0 ifTrue: [
			length := 7. "no sub-seconds to send"
			((dur hours = 0) and: [dur minutes = 0 and: [dur seconds = 0]]) ifTrue: [
				"no hh:mm:ss to send"
				length := 4.
				dur days = 0 ifTrue: [length := 0]]].
		 
		length > 0 ifTrue: [length := length + 1 "include sign byte"].
		strm reset; nextPut: length; setToEnd.
		^ strm contents first: (length + 1)] "length byte plus rest"
	
]

{ #category : #private }
GAMysqlBindParam >> tinyIntRange [
	^ self isDeclaredUnsigned ifTrue: [16r00 to: 16rFF] ifFalse: [-16r80 to: 16r7F].

]
