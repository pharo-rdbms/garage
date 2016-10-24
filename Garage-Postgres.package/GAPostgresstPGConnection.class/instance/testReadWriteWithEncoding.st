as yet unclassified
testReadWriteWithEncoding

	| conn1 result1 |
	self dropTestTable.
	self createTestTable.

	conn1 := self newConnection.
	conn1 connectionArgs clientEncoding: #utf8.
	conn1 startup.

	result1 := conn1 execute: 'INSERT INTO products VALUES (1, ''öäüßøæ¢'');'.
	result1 := conn1 execute: 'select * from products'.

	conn1 terminate.

	self assert: result1 rows size = 1.
	self assert: result1 rows first data second = 'öäüßøæ¢'.
