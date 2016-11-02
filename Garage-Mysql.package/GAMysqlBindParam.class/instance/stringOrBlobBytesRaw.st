writes
stringOrBlobBytesRaw
	| mappedValue |
	mappedValue := ((paramValue isKindOf: Character) or: [ paramValue isKindOf: Text ]) 
		ifTrue: [ paramValue asString ]
		ifFalse: [ paramValue ].
	^ mappedValue asByteArray