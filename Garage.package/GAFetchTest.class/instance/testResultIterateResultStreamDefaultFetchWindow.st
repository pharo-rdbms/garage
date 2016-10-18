as yet unclassified
testResultIterateResultStreamDefaultFetchWindow
	" self debug: #testCursoredResult "
	| select result row rows |
	self supportsCursoredFetch ifFalse: [ self skip. ].

	select:= 'SELECT code, name, observations FROM signature'.

	result := (conn execute: select) readStream.
	rows := 0.
	[ (row := result next) notNil ] whileTrue: [
		rows := rows + 1.
		self assert: (row at: 1) equals: rows.
		self assert: (row at: 2) equals: 'TADP'.
		self assert: (row at: 3) equals: 'Tecnicas Av' ].

	self assert: rows equals: 200.