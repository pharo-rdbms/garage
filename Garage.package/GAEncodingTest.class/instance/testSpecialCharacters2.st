tests
testSpecialCharacters2
	| tmp1 tmp2 |
	conn supportsAutomaticQueryEncoding
		ifTrue: [ ^ self skip ].
	tmp1 := 'î℉ yõù g𐌹ѷЄ ΣϘГくטƏ UTF-8, it stores it'.
	conn
		execute:
			'INSERT INTO student(id, description) VALUES(1, '''
				, (conn encoder encodeString: tmp1) asString , ''')'.
	tmp2 := conn execute: 'SELECT description FROM student WHERE id=1'.
	self assert: (tmp2 first at: 1) equals: tmp1