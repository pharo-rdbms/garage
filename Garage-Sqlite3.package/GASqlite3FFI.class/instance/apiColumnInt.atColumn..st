private
apiColumnInt: aStatement atColumn: aColumn
	"int sqlite3_column_int(sqlite3_stmt*, int)"
	
	^ self ffiCall: #(int64 sqlite3_column_int64 (GASQLite3StatementExternalObject aStatement, int aColumn))
		module: self library
