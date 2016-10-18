tests
testInsert
	"self debug: #testInsert"
	| result row |
	
	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 1)'.
	result := conn execute: 'SELECT code, name, observations, id_student FROM signature'.
	row := result first.
	
	self assert: (row at: 1) equals: 59.
	self assert: (row at: 2) equals: 'TADP'.
	self assert: (row at: 3) equals: 'Tecnicas Av'.
	self assert: (row at: 4) equals: 1.