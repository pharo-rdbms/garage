private
apiFinalize: handle
	"int sqlite3_finalize(sqlite3_stmt*)"
	
	^ self ffiCall: #(int sqlite3_finalize (sqlite3_stmt handle))
		module: self library
