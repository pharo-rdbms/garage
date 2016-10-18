public API
finalize: aStatementHandle on: aDBHandle	
	^ self checkForOk: (self apiFinalize: aStatementHandle) on: aDBHandle
	
