accessing
prepare

	| response |
	super prepare.
	response := connection basicPrepare: statement.
	response isError ifTrue: [ self error: response message ].

	self stmtId: response prepareOkay stmtHandlerId.
	^ self