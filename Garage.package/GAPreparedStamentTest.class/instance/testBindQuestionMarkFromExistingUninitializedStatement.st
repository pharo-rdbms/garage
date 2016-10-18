as yet unclassified
testBindQuestionMarkFromExistingUninitializedStatement
	| result row statement |

	conn supportsPreparedStatements ifFalse: [ ^self skip ].

	statement := conn createStatement.
	statement statementString: 'CREATE TABLE CATS (
		name varchar(50),
		owner varchar(50))'.
	statement execute.

	statement := conn createStatement.
	statement statementString: 'INSERT INTO CATS(name,owner) VALUES(''lutz'',''julien'')'.
	statement execute.
	
	statement := conn createStatement.
	statement statementString: 'SELECT * FROM CATS WHERE name=' , (statement placeholderAt: 1).
	statement prepare.
	statement at: 1 bind: 'lutz'.
	result := statement execute.
	row := result first.
	
	self assert: (row at: 1) equals: 'lutz'.
	self assert: (row at: 2) equals: 'julien'.