as yet unclassified
testResultIterateStreamNextN

	| select result rows |

	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	conn execute: 'INSERT INTO student(id) VALUES (2)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 1)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 2)'.
	select:= 'SELECT code, name, observations FROM signature'.

	result := (conn execute: select) readStream.
	rows := result next: 1.
	
	self assert: rows size equals: 1.
	self assert: (rows first at: 1) equals: 59.
	self assert: (rows first at: 2) equals: 'TADP'.
	self assert: (rows first at: 3) equals: 'Tecnicas Av'. 
	
	rows := result next: 1.
	self assert: rows size equals: 1.
	self assert: (rows first at: 1) equals: 59.
	self assert: (rows first at: 2) equals: 'TADP'.
	self assert: (rows first at: 3) equals: 'Tecnicas Av'. 