Class {
	#name : #GAPacket,
	#superclass : #Object,
	#classVars : [
		'PacketClasses'
	],
	#category : 'Garage-Postgres-Protocol'
}

{ #category : #'initialize-release' }
GAPacket class >> initialize [
	"GAPacket initialize"

	PacketClasses := IdentityDictionary new
		at: $K put: GABackendKeyData;
		at: $R put: GAAuthentication;
		at: $C put: GACompletedResponse;
		at: $G put: GACopyInResponse;
		at: $H put: GACopyOutResponse;
		at: $P put: GACursorResponse;
		at: $I put: GAEmptyQueryResponse;
		at: $E put: GAErrorResponse;
		at: $V put: GAFunctionResultResponse;
		at: $N put: GANoticeResponse;
		at: $A put: GANotificationResponse;
		at: $Z put: GAReadyForQuery;
		at: $T put: GAPostgresRowDescription;
		at: $D put: GAAsciiRow;
		at: $B put: GABinaryRow;
		yourself
]

{ #category : #factory }
GAPacket class >> newPacket: typeCode [
	| packetClass |

	packetClass := PacketClasses at: typeCode ifAbsent: [nil].
	^packetClass isNil
		ifTrue: [nil]
		ifFalse: [packetClass new]
]

{ #category : #accessing }
GAPacket >> eventName [
	^self subclassResponsibility
]

{ #category : #printing }
GAPacket >> printOn: aStream [

	aStream nextPutAll: self class name.

]

{ #category : #receiving }
GAPacket >> readBitmap: nbits from: connection [

	| nbytes bitmap |

	nbytes := (nbits + 7) // 8.
	bitmap := ByteArray new: nbytes.
	1 to: nbytes do: [:i |
		bitmap at: i put: connection next codePoint.
	].
	^bitmap

]

{ #category : #receiving }
GAPacket >> readByteN: n from: connection [

	| bytes |

	bytes := ByteArray new: n.
	1 to: n do: [:i | bytes byteAt: i put: connection next codePoint].
	^bytes
]

{ #category : #receiving }
GAPacket >> readFieldFrom: connection [

	| n tmp |

	n := (self readInt32From: connection) - 4.
	tmp := WriteStream on: String new.
	1 to: n do: [:i |
		tmp nextPut: connection next.
	].
	^tmp contents

]

{ #category : #receiving }
GAPacket >> readInt16From: connection [

	| value |

	value := connection next codePoint.
	value := (value bitShift: 8) bitOr: connection next codePoint.
	^value

]

{ #category : #receiving }
GAPacket >> readInt32From: connection [

	| value |

	value := connection next codePoint.
	value := (value bitShift: 8) bitOr: connection next codePoint.
	value := (value bitShift: 8) bitOr: connection next codePoint.
	value := (value bitShift: 8) bitOr: connection next codePoint.
	^value

]

{ #category : #receiving }
GAPacket >> readStringFrom: connection [

	| tmp ch |
	tmp := WriteStream on: String new.
	[ (ch := connection next) codePoint ~= 0 ] whileTrue: [
		tmp nextPut: ch.
	].
	^tmp contents


]

{ #category : #receiving }
GAPacket >> receiveFrom: connection [

	"Read nothing, by default"

]

{ #category : #sending }
GAPacket >> writeByte: aCharacter on: aStream [

	aStream
		nextPut: aCharacter;
		yourself.


]

{ #category : #sending }
GAPacket >> writeInt16: anInteger on: aStream [

	aStream
		nextPut: (Character value: ((anInteger bitShift: -1*8) bitAnd: 16rFF));
		nextPut: (Character value: ((anInteger bitShift: 0*8) bitAnd: 16rFF));
		yourself.

]

{ #category : #sending }
GAPacket >> writeInt32: anInteger on: aStream [

	aStream
		nextPut: (Character value: ((anInteger bitShift: -3*8) bitAnd: 16rFF));
		nextPut: (Character value: ((anInteger bitShift: -2*8) bitAnd: 16rFF));
		nextPut: (Character value: ((anInteger bitShift: -1*8) bitAnd: 16rFF));
		nextPut: (Character value: ((anInteger bitShift: 0*8) bitAnd: 16rFF));
		yourself.

]

{ #category : #sending }
GAPacket >> writeLimString: aString size: size on: aStream [

	aString isNil ifTrue: [
		size timesRepeat: [ aStream nextPut: (Character value: 0) ].
		^aStream.
	].

	aString size < size
		ifTrue: [
			aStream nextPutAll: aString.
			(size - aString size max: 0) timesRepeat: [ aStream nextPut: (Character value: 0) ].
		]
		ifFalse: [
			aStream nextPutAll: (aString copyFrom: 1 to: size).
		].

	^aStream.

]

{ #category : #sending }
GAPacket >> writeOn: aStream [

	self subclassResponsiblity

]

{ #category : #sending }
GAPacket >> writeString: aString on: aStream [

	aStream
		nextPutAll: aString;
		nextPut: (Character value: 0);
		yourself.


]
