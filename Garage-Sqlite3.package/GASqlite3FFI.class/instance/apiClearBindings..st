private
apiClearBindings: aStatement
	"int sqlite3_clear_bindings(sqlite3_stmt*)"
	
	^ self ffiCall: #(int sqlite3_clear_bindings (sqlite3_stmt aStatement))
		module: self library
