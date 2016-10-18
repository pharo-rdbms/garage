as yet unclassified
testAccessUnamedFunctionsByName
	" self debug: #testCursoredResult "
	| result  |

	conn execute: 'CREATE TABLE CATS (
		name varchar(50),
		owner varchar(50))'.

	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''lutz'',''julien'')'.

	result := conn execute: 'SELECT COUNT(*) AS count FROM CATS'.

	self assert: (result first atName: 'count') equals: 1.