private
apiExec: dbHandle withSQLText: anSQLText with: callback with: callbackData with: errorMessageBuffer
	"int sqlite3_exec(sqlite3*, const char*, int (*callback), void*, char **)"
	
	^ self ffiCall: #(int sqlite3_exec (GASQLite3DatabaseExternalObject dbHandle, String anSQLText, void *callback, void *callbackData, char **errorMessageBuffer))
		module: self library