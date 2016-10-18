as yet unclassified
testPrepareWithWrongArgsFromExistingUninitializedStatement
	| preparedStatement |
	conn supportsPreparedStatements ifFalse: [ ^self skip ].
	conn notBoundArgumentsFail ifFalse: [ self skip ].
	
	preparedStatement := conn createStatement.
	preparedStatement statementString: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', ',(preparedStatement placeholderAt: 1),')'.
	preparedStatement prepare.
	self should: [preparedStatement execute] raise: Error.