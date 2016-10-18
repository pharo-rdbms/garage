tests
testPrepareTheCursorTakesOneFetch

	| statement counter resultSet |
	self supportsCursoredFetch ifFalse: [ self skip ].
	conn beginTransaction.
	
	counter := GAFetchCounter new.
	statement := conn createStatement: 'SELECT code, name, observations FROM signature'.
	statement fetchListener: counter.
	statement fetchSize: 20.
	resultSet := statement execute.
	self assert: counter fetches equals: 1 "cursor takes one fetch".