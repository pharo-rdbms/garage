private-states
stStartup: event

	self resetResult.
	socket := self openSocket.
	socket isNil
		ifTrue: [ self generateEvent: #ConnectionFailed to: self ]
		ifFalse: [ self sendStartup ].
