private
apiBindDouble: aStatement atColumn: aColumn with: aFloat
	"int sqlite3_bind_double(sqlite3_stmt*, int, double)"
	
	^ self ffiCall: #(int sqlite3_bind_double (sqlite3_stmt aStatement, int aColumn, double aFloat))
		module: self library
