sending
writeLimString: aString size: size on: aStream

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
