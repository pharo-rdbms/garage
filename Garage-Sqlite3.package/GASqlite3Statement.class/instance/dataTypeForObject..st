public
dataTypeForObject: anObject

	anObject ifNil: [ ^#at:putNil: ].

	(anObject isKindOf: Integer)
		ifTrue: [ ^#at:putInteger: ].
		
	(anObject isKindOf: Float)
		ifTrue: [ ^#at:putFloat: ].
		
	(anObject isKindOf: String)
		ifTrue: [ ^#at:putString: ].
		
	(anObject isKindOf: ByteArray)
		ifTrue: [ ^#at:putByteArray: ].
		
	^ #at:putObject: 