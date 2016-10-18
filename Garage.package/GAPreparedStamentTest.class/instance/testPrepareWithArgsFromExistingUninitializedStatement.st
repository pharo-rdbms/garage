as yet unclassified
testPrepareWithArgsFromExistingUninitializedStatement
	| result row preparedStatement |
	conn supportsPreparedStatements ifFalse: [ ^self skip ].
	
	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	preparedStatement := conn prepare: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', ?)'.
	preparedStatement at: 1 bind: 1.
	preparedStatement execute.
	
	preparedStatement := conn createStatement.
	preparedStatement statementString: 'SELECT code, name, observations, id_student FROM signature WHERE id_student = ',(preparedStatement placeholderAt: 1).
	preparedStatement prepare.
	preparedStatement at: 1 bind: 1.
	result := preparedStatement execute.
	row := result first.
	
	self assert: (row at: 1) equals: 59.
	self assert: (row at: 2) equals: 'TADP'.
	self assert: (row at: 3) equals: 'Tecnicas Av'.
	self assert: (row at: 4) equals: 1.