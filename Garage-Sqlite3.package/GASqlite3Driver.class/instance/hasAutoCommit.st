transactions
hasAutoCommit
	
	^ (GASqlite3FFI current getAutoCommit: self handle) == 1