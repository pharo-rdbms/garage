private
apiColumnType: aStatement atColumn: aColumn
	"int sqlite3_column_type(sqlite3_stmt*, int)"
	
	^ self ffiCall: #(int sqlite3_column_type (GASQLite3StatementExternalObject aStatement, int aColumn))
		module: self library
