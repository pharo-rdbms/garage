as yet unclassified
testPrepareWithWrongArgsFromExistingStatement
	| preparedStatement |
	conn supportsPreparedStatements ifFalse: [ ^self skip ].
	conn notBoundArgumentsFail ifFalse: [ self skip ].
	
	preparedStatement := conn createStatement: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', ?)'.
	preparedStatement prepare.
	self should: [preparedStatement execute] raise: Error.