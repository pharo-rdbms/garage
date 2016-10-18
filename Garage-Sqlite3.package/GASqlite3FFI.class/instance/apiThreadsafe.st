private
apiThreadsafe
	"int sqlite3_threadsafe(void)"
	
	^ self ffiCall: #(int sqlite3_threadsafe ())
		module: self library
