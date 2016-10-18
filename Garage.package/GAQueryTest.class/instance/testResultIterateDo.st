as yet unclassified
testResultIterateDo

	| select result rows |

	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	conn execute: 'INSERT INTO student(id) VALUES (2)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 1)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 2)'.
	select:= 'SELECT code, name, observations FROM signature'.

	result := conn execute: select.
	rows := 0.
	result do: [ :row |
		self assert: (row at: 1) equals: 59.
		self assert: (row at: 2) equals: 'TADP'.
		self assert: (row at: 3) equals: 'Tecnicas Av'. 
		rows := rows + 1 ].

	self assert: rows equals: 2.