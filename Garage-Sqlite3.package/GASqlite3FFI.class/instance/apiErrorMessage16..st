private
apiErrorMessage16: handle 
	"const char *sqlite3_errmsg(sqlite3*)"
	
	^ self ffiCall: #(String sqlite3_errmsg16 (sqlite3 handle))
		module: self library	