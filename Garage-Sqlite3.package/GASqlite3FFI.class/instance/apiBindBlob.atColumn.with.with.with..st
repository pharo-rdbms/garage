private
apiBindBlob: aStatement atColumn: aColumn with: aByteArray with: anInteger with: aPointer
	"int sqlite3_bind_blob(sqlite3_stmt*, int, const void *, int, void(*)(void*))"
	
	^ self ffiCall: #(int sqlite3_bind_blob (sqlite3_stmt aStatement, int aColumn, ByteArray aByteArray, int anInteger, int aPointer)) "SQLITE_TRANSIENT"
		module: self library
