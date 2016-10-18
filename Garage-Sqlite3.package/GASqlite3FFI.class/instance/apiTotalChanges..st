private
apiTotalChanges: handle
	"int sqlite3_total_changes(sqlite3*)"
	
	^ self ffiCall: #(int sqlite3_total_changes (sqlite3 handle))
		module: self library
