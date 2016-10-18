private
apiDataCount: handle
	"int sqlite3_data_count(sqlite3_stmt*)"
	
	^ self ffiCall: #(int sqlite3_data_count (GASQLite3StatementExternalObject handle))
		module: self library
