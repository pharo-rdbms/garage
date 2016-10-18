private
apiColumnBytes: aStatement atColumn: aColumn
	"int sqlite3_column_bytes(sqlite3_stmt*, int)"
	
	^ self ffiCall: #(int sqlite3_column_bytes (sqlite3_stmt aStatement, int aColumn))
		module: self library
