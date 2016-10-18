as yet unclassified
testPrepareWithWrongArgs
	| preparedStatement |
	conn supportsPreparedStatements ifFalse: [ ^self skip ].
	conn notBoundArgumentsFail ifFalse: [ self skip ].
	
	preparedStatement := conn prepare: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', ?)'.
	self should: [preparedStatement execute] raise: Error.