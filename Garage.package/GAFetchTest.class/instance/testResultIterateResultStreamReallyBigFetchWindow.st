as yet unclassified
testResultIterateResultStreamReallyBigFetchWindow
	" self debug: #testCursoredResult "
	| select result statement row rows |
	self supportsCursoredFetch ifFalse: [ self skip. ].

	select:= 'SELECT code, name, observations FROM signature'.

	conn beginTransaction.

	[
	statement := conn createStatement: select.
	statement fetchSize: 1000.
	result := statement execute readStream.
	rows := 0.
	[ (row := result next) notNil ] whileTrue: [
		rows := rows + 1.
		self assert: (row at: 1) equals: rows.
		self assert: (row at: 2) equals: 'TADP'.
		self assert: (row at: 3) equals: 'Tecnicas Av'. ]
	] ensure: [ conn rollbackTransaction ].

	self assert: rows equals: 200.