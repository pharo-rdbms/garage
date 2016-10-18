execute
prepare

	super prepare.
	GASqlite3FFI current prepare: handle on: connection handle with: self statementString.