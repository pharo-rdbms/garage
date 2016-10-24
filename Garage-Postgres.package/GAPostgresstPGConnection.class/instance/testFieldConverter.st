tests
testFieldConverter
	"Test: two different connections can have a different field converter for a given typeOid.

	This capability would be useful when using one image to connect to two different databases,
	where the same (custom) typeOid is defined differently in each database.
	"

	| conn1 result1 conn2 result2 newConverter |

	self dropTestTable.
	self createTestTable.

	conn1 := self newConnection.
	conn2 := self newConnection.
	conn1 startup.
	conn2 startup.

	result1 := conn1 execute: 'INSERT INTO products VALUES (1);'.
	result1 := conn1 execute: 'select * from products'.

	newConverter := [:value | value].
	conn2 fieldConverterAt: 20 put: newConverter.
	conn2 fieldConverterAt: 21 put: newConverter.
	conn2 fieldConverterAt: 23 put: newConverter.
	result2 := conn2 execute: 'select * from products'.

	conn1 terminate.
	conn2 terminate.

	self assert: result1 rows size = 1.
	self assert: result1 rows first data first = 1.

	self assert: result2 rows size = 1.
	self assert: result2 rows first data first = '1'.
