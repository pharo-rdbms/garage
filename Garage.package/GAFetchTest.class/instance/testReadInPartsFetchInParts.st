tests
testReadInPartsFetchInParts

	| statement rows counter readStream |
	self supportsCursoredFetch ifFalse: [ self skip ].
	conn beginTransaction.
	
	counter := GAFetchCounter new.
	statement := conn createStatement: 'SELECT code, name, observations FROM signature'.
	statement fetchListener: counter.
	statement fetchSize: 20.
	readStream := statement execute readStream.
	10 timesRepeat: [ rows := readStream next: 20 ].
	self assert: counter fetches equals: 11 "1 create cursor + 10 times * 20 rows".