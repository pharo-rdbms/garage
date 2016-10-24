api
functionCall: oid arguments: arguments

	functionCallOid := oid.
	functionCallArgs := arguments.
	self queueEvent: #FunctionCall.
	self saProcessEventsUntil: #(ReadyForQuery ConnectionFailed).
	^ result
