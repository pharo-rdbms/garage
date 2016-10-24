accessing-convenience
lastResultSet

	^resultSets
		ifEmpty: [ nil ]
		ifNotEmpty: [ resultSets last ]