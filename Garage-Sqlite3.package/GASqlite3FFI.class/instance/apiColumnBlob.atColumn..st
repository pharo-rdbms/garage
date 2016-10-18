private
apiColumnBlob: aStatement atColumn: aColumn
	"const void *sqlite3_column_blob(sqlite3_stmt*, int)"
	
	^ self ffiCall: #(const void *sqlite3_column_blob (sqlite3_stmt aStatement, int aColumn))
		module: self library
