as yet unclassified
prepare: sqlString named: aName

	trace >= 2 ifTrue: [self log: 'execute' text: sqlString].

	self isConnected ifFalse: [ self error: 'Connection not valid' ].

	sql := 'PREPARE ', aName ,' AS ', sqlString convertToWithConverter: receivingTextConverter. "sqlStringConverter value: sqlString."
	self queueEvent: #Query.
	self saProcessEventsUntil: #(ReadyForQuery ConnectionFailed).

	"There's an extra result set, so nuke it here."
	result resultSets size > 0
		ifTrue: [ result resultSets removeLast ].

	^ result
