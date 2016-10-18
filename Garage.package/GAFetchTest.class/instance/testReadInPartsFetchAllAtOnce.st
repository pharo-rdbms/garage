tests
testReadInPartsFetchAllAtOnce

	| statement rows counter resultSet |
	
	counter := GAFetchCounter new.
	statement := conn createStatement: 'SELECT code, name, observations FROM signature'.
	statement fetchListener: counter.
	resultSet := statement execute.
	20 timesRepeat: [ rows := resultSet readStream next: 10 ].
	self assert: counter fetches equals: conn numberOfFetchesForSingleExecute.