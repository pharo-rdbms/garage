private
apiBindParameterIndex: aStatement for: aName
	"int sqlite3_bind_parameter_index(sqlite3_stmt*, const char* zName)"
	
	^ self ffiCall: #(int sqlite3_bind_parameter_index (sqlite3_stmt aStatement, String aName))
		module: self library
