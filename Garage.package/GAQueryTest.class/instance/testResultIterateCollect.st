as yet unclassified
testResultIterateCollect

	| select result collected |

	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	conn execute: 'INSERT INTO student(id) VALUES (2)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 1)'.
	conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (59, ''TADP'', ''Tecnicas Av'', 2)'.
	select:= 'SELECT code, name, observations, id_student FROM signature'.

	result := conn execute: select.
	collected := result collect: [ :row | row atIndex: 4].

	self assert: collected asArray equals: #(1 2).