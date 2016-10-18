as yet unclassified
testResultOfInsert
	
	| result |
	conn execute: 'CREATE TABLE CATS (
		name varchar(50),
		owner varchar(50))'.

	result := conn execute: 'INSERT INTO CATS(name,owner) VALUES(''lutz'',''julien'')'.

	self assert: result affectedRows = 1.