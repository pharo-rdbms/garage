connection
close

	handle isNil ifFalse: [ GASqlite3FFI current close: handle ].
	self unregister.
	handle := nil.
	isOpen := false