private
apiStep: handle
	"int sqlite3_step(sqlite3_stmt*)"
	
	^ self ffiCall: #(int sqlite3_step (GASQLite3StatementExternalObject handle))
		module: self library
