tests
testEncodeArgumentsInPreparedStatements
	| tmp1 tmp2 tmp3 |
	conn supportsPreparedStatements
		ifFalse: [ ^ self skip ].
	tmp1 := 'áèîÑçö'.
	tmp3 := conn
		prepare: 'INSERT INTO student(id, description) VALUES(1, ?)'.
	tmp3
		at: 1 bind: tmp1;
		execute.
	tmp2 := conn execute: 'SELECT description FROM student WHERE id=1'.
	self assert: (tmp2 first at: 1) equals: tmp1