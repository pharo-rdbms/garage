tests
testReadAllCursoredAtOnceFetchAllAtOnce

	| statement rows counter resultSet |
	counter := GAFetchCounter new.
	statement := conn createStatement: 'SELECT code, name, observations FROM signature'.
	statement fetchListener: counter.
	resultSet := statement execute.
	rows := resultSet readStream next: 200.
	self assert: counter fetches equals: conn numberOfFetchesForSingleExecute.