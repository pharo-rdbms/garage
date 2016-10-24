tests
testResultSet1

	| conn result |

	self dropTestTable.
	self createTestTable.

	conn := self newConnection.
	conn startup.
	result := conn execute: 'insert into products values(77,''abcde'',123.456)'.
	result := conn execute: 'select * from products'.
	conn terminate.

	self assert: result rows size = 1.
