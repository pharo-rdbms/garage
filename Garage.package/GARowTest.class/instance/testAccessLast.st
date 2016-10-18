as yet unclassified
testAccessLast
	" self debug: #testCursoredResult "
	| result  |

	conn execute: 'CREATE TABLE CATS (
		name varchar(50),
		owner varchar(50))'.

	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''lutz'',''julien'')'.

	result := conn execute: 'SELECT * FROM CATS'.

	self assert: result first last equals: 'julien'.