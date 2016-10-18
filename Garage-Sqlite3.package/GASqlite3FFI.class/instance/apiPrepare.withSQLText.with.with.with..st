private
apiPrepare: dbHandle withSQLText: anSQLText with: textSize with: sHandle with: tail
	"int sqlite3_prepare_v2(sqlite3*, const char*, int, sqlite3_stmt**, const char **)"
	
	^ self ffiCall: #(int sqlite3_prepare_v2 (GASQLite3DatabaseExternalObject dbHandle, String anSQLText, int textSize, GASQLite3StatementExternalObject* sHandle, const char** tail))
		module: self library
	