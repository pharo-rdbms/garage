tests
testSpecialCharactersWithoutQueryEncoding
	| tmp1 tmp2 |
	conn supportsAutomaticQueryEncoding
		ifFalse: [ ^ self skip ].
	tmp1 := 'áèîÑçö'.
	conn
		execute: 'INSERT INTO student(id, description) VALUES(1, ''' , tmp1 , ''')'.
	tmp2 := conn execute: 'SELECT description FROM student WHERE id=1'.
	self assert: (tmp2 first at: 1) equals: tmp1