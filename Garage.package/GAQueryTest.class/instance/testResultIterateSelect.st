as yet unclassified
testResultIterateSelect

	| select result selected |

	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	conn execute: 'INSERT INTO student(id) VALUES (2)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 1)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 2)'.
	select:= 'SELECT code, name, observations, id_student FROM signature'.

	result := conn execute: select.
	selected := result select: [ :row | (row atIndex: 4) = 2].

	self assert: selected size equals: 1.