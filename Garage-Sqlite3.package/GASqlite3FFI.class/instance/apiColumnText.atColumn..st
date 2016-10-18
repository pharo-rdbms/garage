private
apiColumnText: aStatement atColumn: aColumn
	"const unsigned char *sqlite3_column_text(sqlite3_stmt*, int)"
	
	^ self ffiCall: #(String sqlite3_column_text (GASQLite3StatementExternalObject aStatement, int aColumn))
		module: self library
