private
apiGetAutocommit: handle
	"int sqlite3_get_autocommit(sqlite3*);"
	
	^ self ffiCall: #(int sqlite3_get_autocommit (GASQLite3DatabaseExternalObject handle))
		module: self library
