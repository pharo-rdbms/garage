private
apiClose: handle
	"int sqlite3_close_v2(sqlite3*)"
	
	^ self ffiCall: #(int sqlite3_close_v2 (GASQLite3DatabaseExternalObject handle))
		module: self library
