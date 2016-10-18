private
apiOpen: filename via: handle
	"int sqlite3_open(const char*, sqlite3**)"
	
	^ self ffiCall: #(int sqlite3_open (String filename, GASQLite3DatabaseExternalObject* handle))
		module: self library
