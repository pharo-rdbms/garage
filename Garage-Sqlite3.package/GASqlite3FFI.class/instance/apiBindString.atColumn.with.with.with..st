private
apiBindString: aStatement atColumn: aColumn with: aString with: anInteger with: anotherInteger
	"int sqlite3_bind_text(sqlite3_stmt*, int, const char*, int, void(*)(void*))"
	
	^ self ffiCall: #(int sqlite3_bind_text (GASQLite3StatementExternalObject aStatement, int aColumn, String aString, int anInteger, int anotherInteger))
		module: self library
