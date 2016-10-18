private
apiColumnDouble: aStatement atColumn: aColumn
	"double sqlite3_column_double(sqlite3_stmt*, int)"
	
	^ self ffiCall: #(double sqlite3_column_double (sqlite3_stmt aStatement, int aColumn))
		module: self library
