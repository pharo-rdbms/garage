public API
reset: aStatementHandle on: aDBHandle	
	^ self checkForOk: (self apiReset: aStatementHandle) on: aDBHandle
	
