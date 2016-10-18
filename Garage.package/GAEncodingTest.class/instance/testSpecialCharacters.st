tests
testSpecialCharacters
	| tmp1 tmp2 |
	conn supportsAutomaticQueryEncoding
		ifTrue: [ ^ self skip ].
	tmp1 := 'áèîÑçö'.
	conn
		execute:
			'INSERT INTO student(id, description) VALUES(1, '''
				, (conn encoder encodeString: tmp1) asString , ''')'.
	tmp2 := conn execute: 'SELECT description FROM student WHERE id=1'.
	self assert: (tmp2 first at: 1) equals: tmp1