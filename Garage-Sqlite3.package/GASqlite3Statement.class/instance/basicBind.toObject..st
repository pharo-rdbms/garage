as yet unclassified
basicBind: aColumn toObject: anObject

	(anObject isKindOf: ByteString)
		ifTrue: [ ^ self at: aColumn putString: anObject ].
	(anObject isKindOf: Float)
		ifTrue: [ ^ self at: aColumn putFloat: anObject ].
	(anObject isKindOf: ByteArray)
		ifTrue: [ ^ self at: aColumn putByteArray: anObject ].
	(anObject isNil)
		ifTrue: [ ^ self at: aColumn putNil: anObject ].
	(anObject isKindOf: Integer)
		ifTrue: [ ^ self at: aColumn putInteger: anObject ].
	^ self at: aColumn putObject: anObject