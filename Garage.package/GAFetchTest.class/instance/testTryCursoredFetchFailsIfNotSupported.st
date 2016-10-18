tests
testTryCursoredFetchFailsIfNotSupported

	| statement |
	self supportsCursoredFetch ifTrue: [ ^self skip ].

	statement := conn createStatement: 'SELECT code, name, observations FROM signature'.
	self should: [statement fetchSize: 20] raise: Error
	