Class {
	#name : #GAMysqlHelper,
	#superclass : #Object,
	#classInstVars : [
		'seedOne',
		'maxValue',
		'seedTwo'
	],
	#category : 'Garage-Mysql-Protocol'
}

{ #category : #'as yet unclassified' }
GAMysqlHelper class >> bytesFromHexString: hexString [
	| strm bytes aByte ii high low hexAlphabet |
	(hexString size \\ 2 = 0) ifFalse: [self error: 'Not proper hex encoding'].
	strm := ReadStream on: hexString.
	
	bytes := ByteArray new: (hexString size // 2).

	hexAlphabet := '0123456789ABCDEF'.
	ii := 1.
	[strm atEnd] whileFalse: [
		high := (hexAlphabet indexOf: (strm next asUppercase)) - 1.
		low := (hexAlphabet indexOf: (strm next asUppercase)) - 1.
		aByte :=   high * 16 + low.
		bytes at: ii put: aByte.
		ii := ii + 1].

	^ bytes
	
]

{ #category : #'as yet unclassified' }
GAMysqlHelper class >> bytesFromSha1Hash: num [ 

	| index bytes |

	index := 0.
	bytes := ByteArray new: (num digitLength max: 20).	"gurantee 20 bytes; required for authentication"
		
	(20 - num digitLength) to: 1 by: -1 do: [ :i | bytes at: (index := index + 1) put: (0 digitAt: 1) ].	"filler 0 from msbyte"
	num digitLength to: 1 by: -1 do: [ :i | bytes at: (index := index + 1) put: (num digitAt: i) ].
	^ bytes
]

{ #category : #'as yet unclassified' }
GAMysqlHelper class >> decodeLcbFrom: byteStream [ 
	"parse length coded binary"
	| first |
	first := byteStream next.
	(first 
		between: 0
		and: 250) ifTrue: [ ^ first ].
	first = 251 ifTrue: [ ^ -1 ].	"column value is NULL; applicable for row data packet only"
	first = 252 ifTrue: [ ^ byteStream next + (byteStream next bitShift: 8) ].	"value of following 2 bytes"
	first = 253 ifTrue: 
		[ ^ byteStream next + (byteStream next bitShift: 8) + (byteStream next bitShift: 16) ].	"value of following 3 bytes"
	first = 254 ifTrue: 
		[ ^ byteStream next + (byteStream next bitShift: 8 * 1) + (byteStream next bitShift: 8 * 2) + (byteStream next bitShift: 8 * 3) + (byteStream next bitShift: 8 * 4) + (byteStream next bitShift: 8 * 5) + (byteStream next bitShift: 8 * 6) + (byteStream next bitShift: 8 * 7) ].	"value of following 8 bytes"
	^ nil
]

{ #category : #'as yet unclassified' }
GAMysqlHelper class >> decodeLcsFrom: aStream [ 
	"parses length coded string"
	| len |
	len := self decodeLcbFrom: aStream.
	len = -1 ifTrue: [^ 'NULL'].
	^ aStream next: len.
	
]

{ #category : #'as yet unclassified' }
GAMysqlHelper class >> encodeLcb: value on: aStream [ 
	value < -1 ifTrue: 
		[ self error: 'Can not encode value' , value asString , ' to length coded binary' ].
	value = -1 ifTrue: 
		[ "represents null column value"
		^ aStream nextPut: 251 ].
	(value 
		between: 0
		and: 250) ifTrue: [ ^ aStream nextPut: (value digitAt: 1) ].
	value <= 65535 ifTrue: 
		[ ^ aStream
			nextPut: 252;
			nextPut: (value digitAt: 1);
			nextPut: (value digitAt: 2) ].
	value <= 16777215 ifTrue: 
		[ ^ aStream
			nextPut: 253;
			nextPut: (value digitAt: 1);
			nextPut: (value digitAt: 2);
			nextPut: (value digitAt: 3)
			yourself].
	^ aStream
		nextPut: 254;
		nextPut: (value digitAt: 1);
		nextPut: (value digitAt: 2);
		nextPut: (value digitAt: 3);
		nextPut: (value digitAt: 4);
		nextPut: (value digitAt: 5);
		nextPut: (value digitAt: 6);
		nextPut: (value digitAt: 7);
		nextPut: (value digitAt: 8);
		yourself
]

{ #category : #'as yet unclassified' }
GAMysqlHelper class >> encodeLcs: bytes on: aStream [
	| len |
	len := bytes size .
	self encodeLcb: len on: aStream .
	aStream nextPutAll: bytes .
	
]

{ #category : #private }
GAMysqlHelper class >> hash: message [
	"Computes a hash form byte strings,
	Returns an array of large positive integers.
	Used in pre-4.1 authentication scheme"
	
"118 {
119   register ulong nr=1345345333L, add=7, nr2=0x12345671L;
120   ulong tmp;
121   const char *password_end= password + password_len;
122   for (; password < password_end; password++)
123   {
124     if (*password == ' ' || *password == '\t')
125       continue;                                 /* skip space in password */
126     tmp= (ulong) (uchar) *password;
127     nr^= (((nr & 63)+add)*tmp)+ (nr << 8);
128     nr2+=(nr2 << 8) ^ nr;
129     add+=tmp;
130   }
131   result[0]=nr & (((ulong) 1L << 31) -1L); /* Don't use sign bit (str2int) */;
132   result[1]=nr2 & (((ulong) 1L << 31) -1L);
133 }"

	| nr add nr2 tmp |

	nr := 1345345333. add := 7. nr2 := 16r12345671.
	message do: [:each |
		((each = Character space) or: [each = Character tab]) ifTrue: [] ifFalse: [
			tmp := each.
			nr := nr bitXor: ((((nr bitAnd: 63) + add) * tmp asInteger) + (nr bitShift: 8)).
			nr2 := nr2 + ((nr2 bitShift: 8) bitXor: nr).
			add := add + tmp asInteger.
		]].
	
	^Array with:(nr bitAnd: ((1 bitShift: 31) - 1)) with: (nr2 bitAnd: ((1 bitShift: 31) - 1))



]

{ #category : #'as yet unclassified' }
GAMysqlHelper class >> hexStringFromBytes: aByteArray [
	^ aByteArray inject: '' into: [:result :each | 
		result, (each printPaddedWith: $0 to: 2 base: 16)].

]

{ #category : #private }
GAMysqlHelper class >> myRandom [
	seedOne := (seedOne * 3 + seedTwo) \\ maxValue.
	seedTwo := (seedOne + seedTwo + 33) \\ maxValue.
	
	^ (seedOne / maxValue) asFloat
	
]

{ #category : #private }
GAMysqlHelper class >> randomInitWith: seedValue1 and: seedValue2 [
	maxValue := 16r3FFFFFFF.
	seedOne := seedValue1 \\ maxValue.
	seedTwo := seedValue2 \\ maxValue.

]

{ #category : #public }
GAMysqlHelper class >> scramble323: message with: password [ 
	"Scamble the bytestring message with password."
	"Return a srambled byte string."
	"Used in pre-4.1 authentication scheme"
	| hashPass hashMessage outMessage extra byteValue rnd msgUsed |
	password isEmptyOrNil ifTrue: [ ^ '' ].

	msgUsed := message first: (self scramble323MessageLimit min: message size).
	hashPass := self hash: password.
	hashMessage := self hash: msgUsed. "323 size limit"
		
	self 
		randomInitWith: ((hashPass first) bitXor: (hashMessage first))
		and: ((hashPass at: 2) bitXor: (hashMessage at: 2)).

	outMessage := ByteArray new: msgUsed size.
	1 to: outMessage size do: [ :indx | 
		rnd := self myRandom.
		byteValue := ((rnd * 31) floor + 64) bitAnd: 255.
		outMessage at: indx 	put: byteValue].

	rnd := self myRandom.
	extra := (rnd * 31) floor bitAnd: 255.
	1 to: outMessage size
		do: 
			[ :indx | 
			byteValue := (outMessage at: indx) asInteger bitXor: extra.
			outMessage at: indx 	put: byteValue ].

	^ outMessage
	
]

{ #category : #'as yet unclassified' }
GAMysqlHelper class >> scramble323MessageLimit [
	^ 8
	
]

{ #category : #'as yet unclassified' }
GAMysqlHelper class >> secureScramble: seed with: password [ 

	| sha1 hashStage1 hashStage2 hash3 reply |

	sha1 := SHA1 new.

	hashStage1 := (sha1 hashMessage: password) asInteger.
	hashStage2 := (sha1 hashMessage: (self bytesFromSha1Hash: hashStage1)) asInteger.

	hash3 := (sha1 hashMessage: seed asByteArray , (self bytesFromSha1Hash: hashStage2)) asInteger.

	reply := self bytesFromSha1Hash: (hashStage1 bitXor: hash3).
	^ reply
]
