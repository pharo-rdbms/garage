tests
testReadAllFetchInParts

	| statement rows counter resultSet |
	self supportsCursoredFetch ifFalse: [ self skip ].
	conn beginTransaction.
	
	counter := GAFetchCounter new.
	statement := conn createStatement: 'SELECT code, name, observations FROM signature'.
	statement fetchListener: counter.
	statement fetchSize: 20.
	resultSet := statement execute.
	rows := resultSet rows.
	self assert: counter fetches equals: 12 "1 execute + 10 times * 20 rows + 1 to know the EOF".