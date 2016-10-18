private
apiPrepare: dbHandle withSQLText16: anSQLText with: textSize with: sHandle with: tail
	"int sqlite3_prepare_v2(sqlite3*, const char*, int, sqlite3_stmt**, const char **)"
	
	^ self ffiCall: #(int sqlite3_prepare16_v2 (sqlite3 dbHandle, String anSQLText, int textSize, sqlite3_stmt* sHandle, const char** tail))
		module: self library
	