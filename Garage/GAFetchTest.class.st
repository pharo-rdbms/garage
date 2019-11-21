Class {
	#name : #GAFetchTest,
	#superclass : #GADriverTest,
	#category : 'Garage-Tests'
}

{ #category : #running }
GAFetchTest >> setUp [

	super setUp.
	"We create a lot of students"
	conn execute: 'INSERT INTO student(id) VALUES (1)'.
	1 to: 200 do: [ :i | conn execute: 'INSERT INTO signature(code, name, observations, id_student) VALUES (', i asString ,', ''TADP'', ''Tecnicas Av'', 1)'].
]

{ #category : #testing }
GAFetchTest >> supportsCursoredFetch [
	
	^ conn supportsCursoredFetch
]

{ #category : #tests }
GAFetchTest >> testPrepareTheCursorTakesOneFetch [

	| statement counter resultSet |
	self supportsCursoredFetch ifFalse: [ self skip ].
	conn beginTransaction.
	
	counter := GAFetchCounter new.
	statement := conn createStatement: 'SELECT code, name, observations FROM signature'.
	statement fetchListener: counter.
	statement fetchSize: 20.
	resultSet := statement execute.
	self assert: counter fetches equals: 1 "cursor takes one fetch".
]

{ #category : #tests }
GAFetchTest >> testReadAllCursoredAtOnceFetchAllAtOnce [

	| statement rows counter resultSet |
	counter := GAFetchCounter new.
	statement := conn createStatement: 'SELECT code, name, observations FROM signature'.
	statement fetchListener: counter.
	resultSet := statement execute.
	rows := resultSet readStream next: 200.
	self assert: counter fetches equals: conn numberOfFetchesForSingleExecute.
]

{ #category : #tests }
GAFetchTest >> testReadAllFetchInParts [

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
]

{ #category : #tests }
GAFetchTest >> testReadInPartsFetchAllAtOnce [

	| statement rows counter resultSet |
	
	counter := GAFetchCounter new.
	statement := conn createStatement: 'SELECT code, name, observations FROM signature'.
	statement fetchListener: counter.
	resultSet := statement execute.
	20 timesRepeat: [ rows := resultSet readStream next: 10 ].
	self assert: counter fetches equals: conn numberOfFetchesForSingleExecute.
]

{ #category : #tests }
GAFetchTest >> testReadInPartsFetchInBiggerParts [

	| statement rows counter readStream |
	conn supportsCursoredFetch ifFalse: [ self skip ].
	conn beginTransaction.
	
	counter := GAFetchCounter new.
	statement := conn createStatement: 'SELECT code, name, observations FROM signature'.
	statement fetchListener: counter.
	statement fetchSize: 20.
	readStream := statement execute readStream.
	10 timesRepeat: [ rows := readStream next: 21 ].
	self assert: counter fetches equals: 12 "1 create cursor + 10 times * 21 rows + 1 end".
]

{ #category : #tests }
GAFetchTest >> testReadInPartsFetchInParts [

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
]

{ #category : #tests }
GAFetchTest >> testReadInPartsFetchInSmallerParts [

	| statement rows counter readStream |
	conn supportsCursoredFetch ifFalse: [ self skip ].
	conn beginTransaction.
	
	counter := GAFetchCounter new.
	statement := conn createStatement: 'SELECT code, name, observations FROM signature'.
	statement fetchListener: counter.
	statement fetchSize: 20.
	readStream := statement execute readStream.
	25 timesRepeat: [ rows := readStream next: 9 ].
	self assert: counter fetches equals: 12 "1 create cursor + 10 times * 21 rows + 1 end".
]

{ #category : #'as yet unclassified' }
GAFetchTest >> testResultIterateResultStreamBigFetchWindow [
	" self debug: #testCursoredResult "
	| select result statement row rows |
	self supportsCursoredFetch ifFalse: [ self skip. ].
	
	select:= 'SELECT code, name, observations FROM signature'.

	conn beginTransaction.

	[
	statement := conn createStatement: select.
	statement fetchSize: 100.
	result := statement execute readStream.
	rows := 0.
	[ (row := result next) notNil ] whileTrue: [
		rows := rows + 1.
		self assert: (row at: 1) equals: rows.
		self assert: (row at: 2) equals: 'TADP'.
		self assert: (row at: 3) equals: 'Tecnicas Av'. ]
	] ensure: [ conn rollbackTransaction ].

	self assert: rows equals: 200.
]

{ #category : #'as yet unclassified' }
GAFetchTest >> testResultIterateResultStreamDefaultFetchWindow [
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
]

{ #category : #'as yet unclassified' }
GAFetchTest >> testResultIterateResultStreamReallyBigFetchWindow [
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
]

{ #category : #'as yet unclassified' }
GAFetchTest >> testResultIterateesultStreamSmallFetchWindow [
	" self debug: #testCursoredResult "
	| select result statement row rows |
	self supportsCursoredFetch ifFalse: [ self skip. ].

	select:= 'SELECT code, name, observations FROM signature'.

	conn beginTransaction.

	[
	statement := conn createStatement: select.
	statement fetchSize: 10.
	result := statement execute readStream.
	rows := 0.
	[ (row := result next) notNil ] whileTrue: [
		rows := rows + 1.
		self assert: (row at: 1) equals: rows.
		self assert: (row at: 2) equals: 'TADP'.
		self assert: (row at: 3) equals: 'Tecnicas Av'. ]
	] ensure: [ conn rollbackTransaction ].

	self assert: rows equals: 200.
]

{ #category : #tests }
GAFetchTest >> testTryCursoredFetchFailsIfNotSupported [

	| statement |
	self supportsCursoredFetch ifTrue: [ ^self skip ].

	statement := conn createStatement: 'SELECT code, name, observations FROM signature'.
	self should: [statement fetchSize: 20] raise: Error
	
]
