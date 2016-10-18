private
apiColumnCount: handle
	"int sqlite3_column_count(sqlite3_stmt*)"
	
	^ self ffiCall: #(int sqlite3_column_count (GASQLite3StatementExternalObject handle))
		module: self library
