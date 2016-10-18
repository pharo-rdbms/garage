private
apiBindInteger: aStatement atColumn: aColumn with: anInteger
	"int sqlite3_bind_int64(sqlite3_stmt*, int, sqlite_int64)"
	
	^ self ffiCall: #(int sqlite3_bind_int64 (GASQLite3StatementExternalObject aStatement, int aColumn, FFIInt64 anInteger))
		module: self library
