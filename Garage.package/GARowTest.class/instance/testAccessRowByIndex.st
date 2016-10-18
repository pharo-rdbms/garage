as yet unclassified
testAccessRowByIndex
	" self debug: #testCursoredResult "
	| result catRow |

	conn execute: 'CREATE TABLE CATS (
		name varchar(50),
		owner varchar(50))'.

	conn execute: 'INSERT INTO CATS(name,owner) VALUES(''lutz'',''julien'')'.

	result := conn execute: 'SELECT name AS catname, owner FROM CATS'.
	catRow := result first.

	self assert: (catRow atIndex: 1) equals: 'lutz'.
	self assert: (catRow atIndex: 2) equals: 'julien'.