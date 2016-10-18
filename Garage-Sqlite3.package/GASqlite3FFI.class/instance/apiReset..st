private
apiReset: handle
	"int sqlite3_reset(sqlite3_stmt*)"
	
	^ self ffiCall: #(int sqlite3_reset (GASQLite3StatementExternalObject handle))
		module: self library
