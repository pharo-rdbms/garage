private
apiChanges: handle
	"int sqlite3_changes(sqlite3*)"
	
	^ self ffiCall: #(int sqlite3_changes (GASQLite3DatabaseExternalObject handle))
		module: self library
