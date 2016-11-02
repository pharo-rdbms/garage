writes
storableIntegerValueOfSize: size 
	(paramValue isKindOf: Boolean) ifTrue: [^ paramValue ifTrue: [1] ifFalse: [0]].
	^ paramValue negative 
		ifTrue: [ (1 << (size * 8)) + paramValue ]
		ifFalse: [ paramValue ]