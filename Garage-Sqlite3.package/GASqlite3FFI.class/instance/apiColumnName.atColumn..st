private
apiColumnName: aStatement atColumn: aColumn
	"const char *sqlite3_column_name(sqlite3_stmt*, int)"
	
	^ self ffiCall: #(String sqlite3_column_name (GASQLite3StatementExternalObject aStatement, int aColumn))
		module: self library
