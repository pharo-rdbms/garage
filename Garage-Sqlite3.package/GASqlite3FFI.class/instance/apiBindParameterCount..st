private
apiBindParameterCount: aStatement
	"int sqlite3_bind_parameter_count(sqlite3_stmt*)"
	
	^ self ffiCall: #(int sqlite3_bind_parameter_count (sqlite3_stmt aStatement))
		module: self library
