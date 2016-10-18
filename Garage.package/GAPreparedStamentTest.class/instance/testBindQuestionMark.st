as yet unclassified
testBindQuestionMark
	| result row statement |

	conn supportsPreparedStatements ifFalse: [ ^self skip ].

	conn execute: 'CREATE TABLE CATS (
		name varchar(50),
		owner varchar(50))'.

	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''lutz'',''julien'')'.
	
	statement := conn prepare: 'SELECT * FROM CATS WHERE name=?'.
	statement at: 1 bind: 'lutz'.
	result := statement execute.
	row := result first.
	
	self assert: (row at: 1) equals: 'lutz'.
	self assert: (row at: 2) equals: 'julien'.