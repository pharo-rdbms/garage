public API
execute: anSQLText on: aDBHandle
	| null |
	
	null := ExternalAddress null.
	^ self checkForOk: (self apiExec: aDBHandle 
							withSQLText: anSQLText
							with: null
							with: null
							with: null)
		 on: aDBHandle
	
