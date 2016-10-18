as yet unclassified
testResultOfUpdate
	
	| result |
	conn execute: 'CREATE TABLE CATS (
		name varchar(50),
		owner varchar(50))'.

	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''lutz'',''julien'')'.
	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''camila'',''guille'')'.
	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''inuk'',''victor'')'.
	
	result := conn execute: 'UPDATE CATS SET owner=''guille'''.

	"Mysql only affects rows that he has to update"
	conn affectsOnlyChangedRows ifTrue: [ 
		self assert: result affectedRows = 2.
	] ifFalse: [ 
		self assert: result affectedRows = 3.
	]