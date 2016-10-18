as yet unclassified
testExecuteStatement

	| statement result |
	conn execute: 'CREATE TABLE CATS (
	name varchar(50),
	owner varchar(50))'.

	conn execute: 'INSERT INTO CATS(name, owner) VALUES(''lutz'', ''julien'')'.
	statement := conn createStatement: 'SELECT * FROM CATS'.
	result := statement execute.

	self assert: (result first at: 1) equals: 'lutz'.
	self assert: (result first at: 2) equals: 'julien'.