connection
connect
	
	((GASqlite3FFI current open: database via: handle) = 0) 
		ifTrue: [ 
			isOpen := true.
			self register.
			^ self ]
		ifFalse: [
			| err |
			err := GASqlite3FFI current apiErrorMessage: handle.
			GASqlite3FFI current apiClose: handle.
			GASqlite3Error signal: err ]