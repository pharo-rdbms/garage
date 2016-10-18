public API
prepare: aStatementHandle on: aDBHandle withUTF16String: aSQLText

	^ self checkForOk: (self apiPrepare: aDBHandle 
							withSQLText16: aSQLText
							with: (aSQLText size)
							with: aStatementHandle
							with: (NBExternalAddress null))
		 on: aDBHandle
	
