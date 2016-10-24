finalization
finalize

	self isConnected ifTrue: [ self close ].
	driver := nil