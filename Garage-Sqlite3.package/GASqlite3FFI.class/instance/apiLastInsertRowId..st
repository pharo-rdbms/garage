private
apiLastInsertRowId: handle 
	"sqlite3_int64 sqlite3_last_insert_rowid(sqlite3*);"
	
	^ self ffiCall: #(int sqlite3_last_insert_rowid (GASQLite3DatabaseExternalObject handle))
		module: self library	