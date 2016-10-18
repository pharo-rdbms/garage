public API
prepare: aStatementHandle on: aDBHandle with: anSQLText

	^ self checkForOk: (self apiPrepare: aDBHandle 
							withSQLText: anSQLText
							with: (anSQLText size)
							with: aStatementHandle
							with: ExternalAddress null)
		 on: aDBHandle
	
