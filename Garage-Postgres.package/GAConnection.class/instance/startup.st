api
startup

	self connectionArgs isNil ifTrue: [
		self connectionArgs: self class defaultConnectionArgs.
	].
	self connectionArgs clientEncoding ifNotNil: [
		self clientEncoding: self connectionArgs clientEncoding.
	] ifNil: [
		self clientEncoding: #utf8
	].
	self queueEvent: #Startup.
	self saProcessEventsUntil: #(ReadyForQuery ConnectionFailed TerminalError UnsupportedAuthentication).
	^ result
