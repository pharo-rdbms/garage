"
I am the FFI interface to SQLite.
"
Class {
	#name : #GASqlite3FFI,
	#superclass : #Object,
	#classVars : [
		'DataTypeMap',
		'Singleton',
		'TypeMap'
	],
	#pools : [
		'GASQLite3Constants'
	],
	#category : 'Garage-Sqlite3-FFI'
}

{ #category : #factory }
GASqlite3FFI class >> current [
	^ Singleton ifNil: [ Singleton := self basicNew ]
]

{ #category : #'class initialization' }
GASqlite3FFI class >> initialize [

	self initializeTypeMap.
	self initializeDataTypeMap.

]

{ #category : #'class initialization' }
GASqlite3FFI class >> initializeDataTypeMap [

	DataTypeMap := Dictionary newFromPairs: #(
		1			#integerAt: 
		2			#floatAt:
		3			#stringAt:
		4			#byteArrayAt:
		5			#nilAt:
	)
]

{ #category : #'class initialization' }
GASqlite3FFI class >> initializeTypeMap [

	TypeMap := Dictionary newFromPairs: #(
		sqlite3		      GASQLite3DatabaseExternalObject
		sqlite3_stmt			GASQLite3StatementExternalObject
		sqlite_int64			NBInt64
	)
]

{ #category : #factory }
GASqlite3FFI class >> nbBindingOf: aTypeName [
	^ TypeMap at: aTypeName ifAbsent: [ super nbBindingOf: aTypeName ]
]

{ #category : #'class initialization' }
GASqlite3FFI class >> reset [
	Singleton := nil
]

{ #category : #private }
GASqlite3FFI >> apiBindBlob: aStatement atColumn: aColumn with: aByteArray with: anInteger with: aPointer [
	"int sqlite3_bind_blob(sqlite3_stmt*, int, const void *, int, void(*)(void*))"
	
	^ self ffiCall: #(int sqlite3_bind_blob (sqlite3_stmt aStatement, int aColumn, ByteArray aByteArray, int anInteger, int aPointer)) "SQLITE_TRANSIENT"
		module: self library

]

{ #category : #private }
GASqlite3FFI >> apiBindDouble: aStatement atColumn: aColumn with: aFloat [
	"int sqlite3_bind_double(sqlite3_stmt*, int, double)"
	
	^ self ffiCall: #(int sqlite3_bind_double (sqlite3_stmt aStatement, int aColumn, double aFloat))
		module: self library

]

{ #category : #private }
GASqlite3FFI >> apiBindInteger: aStatement atColumn: aColumn with: anInteger [
	"int sqlite3_bind_int64(sqlite3_stmt*, int, sqlite_int64)"
	
	^ self ffiCall: #(int sqlite3_bind_int64 (GASQLite3StatementExternalObject aStatement, int aColumn, FFIInt64 anInteger))
		module: self library

]

{ #category : #private }
GASqlite3FFI >> apiBindNull: aStatement atColumn: aColumn [
	"int sqlite3_bind_null(sqlite3_stmt*, int)"
	
	^ self ffiCall: #(int sqlite3_bind_null (sqlite3_stmt aStatement, int aColumn))
		module: self library

]

{ #category : #private }
GASqlite3FFI >> apiBindParameterCount: aStatement [
	"int sqlite3_bind_parameter_count(sqlite3_stmt*)"
	
	^ self ffiCall: #(int sqlite3_bind_parameter_count (sqlite3_stmt aStatement))
		module: self library

]

{ #category : #private }
GASqlite3FFI >> apiBindParameterIndex: aStatement for: aName [
	"int sqlite3_bind_parameter_index(sqlite3_stmt*, const char* zName)"
	
	^ self ffiCall: #(int sqlite3_bind_parameter_index (sqlite3_stmt aStatement, String aName))
		module: self library

]

{ #category : #private }
GASqlite3FFI >> apiBindString: aStatement atColumn: aColumn with: aString with: anInteger with: anotherInteger [
	"int sqlite3_bind_text(sqlite3_stmt*, int, const char*, int, void(*)(void*))"
	
	^ self ffiCall: #(int sqlite3_bind_text (GASQLite3StatementExternalObject aStatement, int aColumn, String aString, int anInteger, int anotherInteger))
		module: self library

]

{ #category : #private }
GASqlite3FFI >> apiChanges: handle [
	"int sqlite3_changes(sqlite3*)"
	
	^ self ffiCall: #(int sqlite3_changes (GASQLite3DatabaseExternalObject handle))
		module: self library

]

{ #category : #private }
GASqlite3FFI >> apiClearBindings: aStatement [
	"int sqlite3_clear_bindings(sqlite3_stmt*)"
	
	^ self ffiCall: #(int sqlite3_clear_bindings (sqlite3_stmt aStatement))
		module: self library

]

{ #category : #private }
GASqlite3FFI >> apiClose: handle [
	"int sqlite3_close_v2(sqlite3*)"
	
	^ self ffiCall: #(int sqlite3_close_v2 (GASQLite3DatabaseExternalObject handle))
		module: self library

]

{ #category : #private }
GASqlite3FFI >> apiColumnBlob: aStatement atColumn: aColumn [
	"const void *sqlite3_column_blob(sqlite3_stmt*, int)"
	
	^ self ffiCall: #(const void *sqlite3_column_blob (sqlite3_stmt aStatement, int aColumn))
		module: self library

]

{ #category : #private }
GASqlite3FFI >> apiColumnBytes: aStatement atColumn: aColumn [
	"int sqlite3_column_bytes(sqlite3_stmt*, int)"
	
	^ self ffiCall: #(int sqlite3_column_bytes (sqlite3_stmt aStatement, int aColumn))
		module: self library

]

{ #category : #private }
GASqlite3FFI >> apiColumnCount: handle [
	"int sqlite3_column_count(sqlite3_stmt*)"
	
	^ self ffiCall: #(int sqlite3_column_count (GASQLite3StatementExternalObject handle))
		module: self library

]

{ #category : #private }
GASqlite3FFI >> apiColumnDouble: aStatement atColumn: aColumn [
	"double sqlite3_column_double(sqlite3_stmt*, int)"
	
	^ self ffiCall: #(double sqlite3_column_double (sqlite3_stmt aStatement, int aColumn))
		module: self library

]

{ #category : #private }
GASqlite3FFI >> apiColumnInt: aStatement atColumn: aColumn [
	"int sqlite3_column_int(sqlite3_stmt*, int)"
	
	^ self ffiCall: #(int64 sqlite3_column_int64 (GASQLite3StatementExternalObject aStatement, int aColumn))
		module: self library

]

{ #category : #private }
GASqlite3FFI >> apiColumnName: aStatement atColumn: aColumn [
	"const char *sqlite3_column_name(sqlite3_stmt*, int)"
	
	^ self ffiCall: #(String sqlite3_column_name (GASQLite3StatementExternalObject aStatement, int aColumn))
		module: self library

]

{ #category : #private }
GASqlite3FFI >> apiColumnText: aStatement atColumn: aColumn [
	"const unsigned char *sqlite3_column_text(sqlite3_stmt*, int)"
	
	^ self ffiCall: #(String sqlite3_column_text (GASQLite3StatementExternalObject aStatement, int aColumn))
		module: self library

]

{ #category : #private }
GASqlite3FFI >> apiColumnType: aStatement atColumn: aColumn [
	"int sqlite3_column_type(sqlite3_stmt*, int)"
	
	^ self ffiCall: #(int sqlite3_column_type (GASQLite3StatementExternalObject aStatement, int aColumn))
		module: self library

]

{ #category : #private }
GASqlite3FFI >> apiDataCount: handle [
	"int sqlite3_data_count(sqlite3_stmt*)"
	
	^ self ffiCall: #(int sqlite3_data_count (GASQLite3StatementExternalObject handle))
		module: self library

]

{ #category : #private }
GASqlite3FFI >> apiEnableSharedCache: int [
	"int sqlite3_enable_shared_cache(int)"
	
	^ self ffiCall: #(int sqlite3_enable_shared_cache (int))
		module: self library

]

{ #category : #private }
GASqlite3FFI >> apiErrorMessage16: handle [ 
	"const char *sqlite3_errmsg(sqlite3*)"
	
	^ self ffiCall: #(String sqlite3_errmsg16 (sqlite3 handle))
		module: self library	
]

{ #category : #private }
GASqlite3FFI >> apiErrorMessage: handle [ 
	"const char *sqlite3_errmsg(sqlite3*)"
	
	^ self ffiCall: #(String sqlite3_errmsg (sqlite3 handle))
		module: self library	
]

{ #category : #private }
GASqlite3FFI >> apiExec: dbHandle withSQLText: anSQLText with: callback with: callbackData with: errorMessageBuffer [
	"int sqlite3_exec(sqlite3*, const char*, int (*callback), void*, char **)"
	
	^ self ffiCall: #(int sqlite3_exec (GASQLite3DatabaseExternalObject dbHandle, String anSQLText, void *callback, void *callbackData, char **errorMessageBuffer))
		module: self library
]

{ #category : #private }
GASqlite3FFI >> apiFinalize: handle [
	"int sqlite3_finalize(sqlite3_stmt*)"
	
	^ self ffiCall: #(int sqlite3_finalize (sqlite3_stmt handle))
		module: self library

]

{ #category : #private }
GASqlite3FFI >> apiGetAutocommit: handle [
	"int sqlite3_get_autocommit(sqlite3*);"
	
	^ self ffiCall: #(int sqlite3_get_autocommit (GASQLite3DatabaseExternalObject handle))
		module: self library

]

{ #category : #private }
GASqlite3FFI >> apiLastInsertRowId: handle [ 
	"sqlite3_int64 sqlite3_last_insert_rowid(sqlite3*);"
	
	^ self ffiCall: #(int sqlite3_last_insert_rowid (GASQLite3DatabaseExternalObject handle))
		module: self library	
]

{ #category : #private }
GASqlite3FFI >> apiOpen: filename via: handle [
	"int sqlite3_open(const char*, sqlite3**)"
	
	^ self ffiCall: #(int sqlite3_open (String filename, GASQLite3DatabaseExternalObject* handle))
		module: self library

]

{ #category : #private }
GASqlite3FFI >> apiPrepare: dbHandle withSQLText16: anSQLText with: textSize with: sHandle with: tail [
	"int sqlite3_prepare_v2(sqlite3*, const char*, int, sqlite3_stmt**, const char **)"
	
	^ self ffiCall: #(int sqlite3_prepare16_v2 (sqlite3 dbHandle, String anSQLText, int textSize, sqlite3_stmt* sHandle, const char** tail))
		module: self library
	
]

{ #category : #private }
GASqlite3FFI >> apiPrepare: dbHandle withSQLText: anSQLText with: textSize with: sHandle with: tail [
	"int sqlite3_prepare_v2(sqlite3*, const char*, int, sqlite3_stmt**, const char **)"
	
	^ self ffiCall: #(int sqlite3_prepare_v2 (GASQLite3DatabaseExternalObject dbHandle, String anSQLText, int textSize, GASQLite3StatementExternalObject* sHandle, const char** tail))
		module: self library
	
]

{ #category : #private }
GASqlite3FFI >> apiReset: handle [
	"int sqlite3_reset(sqlite3_stmt*)"
	
	^ self ffiCall: #(int sqlite3_reset (GASQLite3StatementExternalObject handle))
		module: self library

]

{ #category : #private }
GASqlite3FFI >> apiStep: handle [
	"int sqlite3_step(sqlite3_stmt*)"
	
	^ self ffiCall: #(int sqlite3_step (GASQLite3StatementExternalObject handle))
		module: self library

]

{ #category : #private }
GASqlite3FFI >> apiThreadsafe [
	"int sqlite3_threadsafe(void)"
	
	^ self ffiCall: #(int sqlite3_threadsafe ())
		module: self library

]

{ #category : #private }
GASqlite3FFI >> apiTotalChanges: handle [
	"int sqlite3_total_changes(sqlite3*)"
	
	^ self ffiCall: #(int sqlite3_total_changes (sqlite3 handle))
		module: self library

]

{ #category : #'public API' }
GASqlite3FFI >> bindParameterCount: aStatementHandle [
	^ self apiBindParameterCount: aStatementHandle
	

]

{ #category : #'public API' }
GASqlite3FFI >> bindParameterIndex: aStatementHandle for: aName [
	^ self apiBindParameterIndex: aStatementHandle for: aName
	

]

{ #category : #'public API' }
GASqlite3FFI >> blobFrom: aStatement at: aColumn [
	| address size |
	
	address := self apiColumnBlob: aStatement atColumn: aColumn.
	size := self apiColumnBytes: aStatement atColumn: aColumn.
	^ (FFIExternalArray fromPointer: address type: Character size: size) address
]

{ #category : #'public API' }
GASqlite3FFI >> changes: aHandle [	
	^ self apiChanges: aHandle
	

]

{ #category : #private }
GASqlite3FFI >> checkForOk: aValue on: aHandle [

	(aValue = OK)
		ifFalse: [ 
			(aValue = BUSY)
				ifTrue: [ self signal: GASqlite3Busy with: aValue on: aHandle ].
			(aValue = LOCKED)
				ifTrue: [ self signal: GASqlite3Locked with: aValue on: aHandle ].
			(aValue = MISUSE)
				ifTrue: [ self signal: GASqlite3Misuse with: aValue on: aHandle ].				
			self signal: GASqlite3Error with: aValue on: aHandle ].	
	^ OK
]

{ #category : #'public API' }
GASqlite3FFI >> clearBindings: sHandle on: dbHandle [	
	^ self checkForOk: (self apiClearBindings: sHandle) on: dbHandle
	

]

{ #category : #'public API' }
GASqlite3FFI >> close: aHandle [	
	^ self checkForOk: (self apiClose: aHandle) on: aHandle
	

]

{ #category : #private }
GASqlite3FFI >> columnCount: aStatementHandle [
	^ self apiColumnCount: aStatementHandle
	

]

{ #category : #'public API' }
GASqlite3FFI >> columnNameFrom: aStatement at: aColumn [
	^ self apiColumnType: aStatement atColumn: aColumn
]

{ #category : #'public API' }
GASqlite3FFI >> columnTypeFrom: aStatement at: aColumn [
	^ self apiColumnType: aStatement atColumn: aColumn
]

{ #category : #'public API' }
GASqlite3FFI >> dataValuesAvailable: aStatementHandle [
	^ self apiDataCount: aStatementHandle
	

]

{ #category : #'public API' }
GASqlite3FFI >> execute: anSQLText on: aDBHandle [
	| null |
	
	null := ExternalAddress null.
	^ self checkForOk: (self apiExec: aDBHandle 
							withSQLText: anSQLText
							with: null
							with: null
							with: null)
		 on: aDBHandle
	

]

{ #category : #'public API' }
GASqlite3FFI >> finalize: aStatementHandle on: aDBHandle [	
	^ self checkForOk: (self apiFinalize: aStatementHandle) on: aDBHandle
	

]

{ #category : #'public API' }
GASqlite3FFI >> floatFrom: aStatement at: aColumn [
	^ self apiColumnDouble: aStatement atColumn: aColumn
]

{ #category : #'public API' }
GASqlite3FFI >> getAutoCommit: aHandle [

	^ self apiGetAutocommit: aHandle
]

{ #category : #'public API' }
GASqlite3FFI >> getAutocommit: aHandle [

	^ self apiGetAutocommit: aHandle
]

{ #category : #'public API' }
GASqlite3FFI >> integerFrom: aStatement at: aColumn [
	^ self apiColumnInt: aStatement atColumn: aColumn
]

{ #category : #'public API' }
GASqlite3FFI >> lastInsertRowId: aHandle [	
	^ self apiLastInsertRowId: aHandle
	

]

{ #category : #accessing }
GASqlite3FFI >> library [
	
	^ 'sqlite3'
]

{ #category : #'public API' }
GASqlite3FFI >> nameFor: aStatement at: aColumn [
	^ self apiColumnName: aStatement atColumn: aColumn
]

{ #category : #'public API' }
GASqlite3FFI >> open: aFilename via: aHandle [	
	^ self checkForOk: (self apiOpen: aFilename via: aHandle) on: aHandle
	

]

{ #category : #'private - conversion' }
GASqlite3FFI >> pharoStringToUTF8: aPharoString [
	"Converts from Pharo Multibyte Characters to SQLite3 UTF-8 storage format"
	
	^ZnUTF8Encoder new encodeString: aPharoString
]

{ #category : #'public API' }
GASqlite3FFI >> prepare: aStatementHandle on: aDBHandle with: anSQLText [

	^ self checkForOk: (self apiPrepare: aDBHandle 
							withSQLText: anSQLText
							with: (anSQLText size)
							with: aStatementHandle
							with: ExternalAddress null)
		 on: aDBHandle
	

]

{ #category : #'public API' }
GASqlite3FFI >> prepare: aStatementHandle on: aDBHandle withUTF16String: aSQLText [

	^ self checkForOk: (self apiPrepare: aDBHandle 
							withSQLText16: aSQLText
							with: (aSQLText size)
							with: aStatementHandle
							with: (NBExternalAddress null))
		 on: aDBHandle
	

]

{ #category : #'public API' }
GASqlite3FFI >> reset: aStatementHandle on: aDBHandle [	
	^ self checkForOk: (self apiReset: aStatementHandle) on: aDBHandle
	

]

{ #category : #private }
GASqlite3FFI >> signal: exceptionClass with: value on: handle [
	exceptionClass new resultCode: value; signal: (self apiErrorMessage: handle)
]

{ #category : #'public API' }
GASqlite3FFI >> step: aStatementHandle [	
	^ self apiStep: aStatementHandle
	

]

{ #category : #'public API' }
GASqlite3FFI >> stringFrom: aStatement at: aColumn [
	^ self apiColumnText: aStatement atColumn: aColumn
]

{ #category : #accessing }
GASqlite3FFI >> threadsafe [
	^ self apiThreadsafe
]

{ #category : #'public API' }
GASqlite3FFI >> totalChanges: aHandle [	
	^ self apiTotalChanges: aHandle
	

]

{ #category : #'public API' }
GASqlite3FFI >> typeFor: aStatement at: aColumn [
	^ DataTypeMap at: (self apiColumnType: aStatement atColumn: aColumn)

]

{ #category : #'public API' }
GASqlite3FFI >> with: aStatement at: aColumn putBlob: aByteArray [
	^ self apiBindBlob: aStatement atColumn: aColumn with: aByteArray with: aByteArray size with: -1 
]

{ #category : #'public API' }
GASqlite3FFI >> with: aStatement at: aColumn putFloat: aFloat [
	^ self apiBindDouble: aStatement atColumn: aColumn with: aFloat
]

{ #category : #'public API' }
GASqlite3FFI >> with: aStatement at: aColumn putInteger: anInteger [
	^ self apiBindInteger: aStatement atColumn: aColumn with: anInteger   
]

{ #category : #'public API' }
GASqlite3FFI >> with: aStatement at: aColumn putString: aString [
	^ self apiBindString: aStatement atColumn: aColumn with: (self pharoStringToUTF8: aString) with: -1 with: -1 
]

{ #category : #'public API' }
GASqlite3FFI >> with: aStatement putNullAt: aColumn [ 
	^ self apiBindNull: aStatement atColumn: aColumn
]
