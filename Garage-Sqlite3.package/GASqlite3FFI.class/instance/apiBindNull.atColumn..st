private
apiBindNull: aStatement atColumn: aColumn
	"int sqlite3_bind_null(sqlite3_stmt*, int)"
	
	^ self ffiCall: #(int sqlite3_bind_null (sqlite3_stmt aStatement, int aColumn))
		module: self library
