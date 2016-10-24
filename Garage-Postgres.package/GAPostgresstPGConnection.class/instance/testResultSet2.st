tests
testResultSet2

	| conn result rs1 rs2 |

	self dropTestTable.
	self createTestTable.

	conn := self newConnection.
	conn startup.
	result := conn execute: 'insert into products values(49,''abcde'',123.456)'.
	result := conn execute: 'insert into products values(50,''abcde'',123.456)'.
	result := conn execute: 'insert into products values(51,''abcde'',123.456)'.
	result := conn execute: 'insert into products values(52,''abcde'',123.456)'.
	result := conn execute: 'select * from products; select * from products where product_no > 50'.
	conn terminate.

	rs1 := result resultSets at: 1.
	self assert: rs1 rows size = 4.

	rs2 := result resultSets at: 2.
	self assert: rs2 rows size = 2.
