as yet unclassified
testResultOfUpdateWhere
	
	| result |
	conn execute: 'CREATE TABLE CATS (
		name varchar(50),
		owner varchar(50))'.

	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''lutz'',''julien'')'.
	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''camila'',''guille'')'.
	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''inuk'',''victor'')'.
	
	result := conn execute: 'UPDATE CATS SET owner = ''guille'' WHERE owner != ''guille'''.

	self assert: result affectedRows = 2.