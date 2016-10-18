private
apiEnableSharedCache: int
	"int sqlite3_enable_shared_cache(int)"
	
	^ self ffiCall: #(int sqlite3_enable_shared_cache (int))
		module: self library
