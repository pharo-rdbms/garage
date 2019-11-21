Class {
	#name : #GASqlite3Driver,
	#superclass : #GADriver,
	#instVars : [
		'database',
		'handle',
		'isOpen'
	],
	#category : 'Garage-Sqlite3'
}

{ #category : #drivers }
GASqlite3Driver class >> driverId [

	^ 'sqlite3'
]

{ #category : #'instance-creation' }
GASqlite3Driver class >> fromConnectionString: aConnectionString [

	^ self new
		connectionString: aConnectionString;
		database: (aConnectionString host = 'memory' ifTrue: [ ':memory:' ] ifFalse: [ (aConnectionString databasePath) urlDecoded ]);
		yourself
]

{ #category : #initialize }
GASqlite3Driver class >> initialize [

	self subscribeDriver
]

{ #category : #tests }
GASqlite3Driver class >> newFixture [
	
	^ GADriverSQLiteTestFixture new
]

{ #category : #encoding }
GASqlite3Driver class >> supportsEncoding: anEncoding [
	
	^ (ZnCharacterEncoder newForEncoding: anEncoding) = ZnUTF8Encoder new
]

{ #category : #accessing }
GASqlite3Driver >> backend [
	
	^ 'sqlite3'
]

{ #category : #public }
GASqlite3Driver >> basicExecute: anSQLText [

	^ GASqlite3FFI current execute: anSQLText on: handle
]

{ #category : #transactions }
GASqlite3Driver >> beginTransaction [

	^ self basicExecute: 'begin'
]

{ #category : #connection }
GASqlite3Driver >> close [

	handle isNil ifFalse: [ GASqlite3FFI current close: handle ].
	self unregister.
	handle := nil.
	isOpen := false
]

{ #category : #transactions }
GASqlite3Driver >> commitTransaction [

	^ self basicExecute: 'commit'
]

{ #category : #connection }
GASqlite3Driver >> connect [
	
	((GASqlite3FFI current open: database via: handle) = 0) 
		ifTrue: [ 
			isOpen := true.
			self register.
			^ self ]
		ifFalse: [
			| err |
			err := GASqlite3FFI current apiErrorMessage: handle.
			GASqlite3FFI current apiClose: handle.
			GASqlite3Error signal: err ]
]

{ #category : #query }
GASqlite3Driver >> createStatement [

	^ GASqlite3Statement new connection: self; yourself
]

{ #category : #query }
GASqlite3Driver >> createStatement: aString [ 
	
	^ self createStatement
		statementString: aString;
		yourself
]

{ #category : #accessing }
GASqlite3Driver >> database [

	^ database
]

{ #category : #accessing }
GASqlite3Driver >> database: aDatabase [
	
	database := aDatabase
]

{ #category : #transactions }
GASqlite3Driver >> defaultValueAutoCommit [
	
	^ true
]

{ #category : #query }
GASqlite3Driver >> execute: aQuery [

	^ self execute: aQuery with: #()
]

{ #category : #query }
GASqlite3Driver >> execute: aQuery with: anObject [

	^ GASqlite3ResultSet new execute: aQuery with: anObject on: self
]

{ #category : #finalization }
GASqlite3Driver >> finalize [

	self isConnected ifTrue: [ self close ].
]

{ #category : #accessing }
GASqlite3Driver >> handle [

	^ handle
]

{ #category : #transactions }
GASqlite3Driver >> hasAutoCommit [
	
	^ (GASqlite3FFI current getAutoCommit: self handle) == 1
]

{ #category : #'initialize-release' }
GASqlite3Driver >> initialize [
	super initialize.

	handle := GASQLite3DatabaseExternalObject new.
	isOpen := false.
]

{ #category : #testing }
GASqlite3Driver >> isConnected [

	^ handle isNotNil and: [ isOpen ]
]

{ #category : #testing }
GASqlite3Driver >> isMemory [
	
	^ self database = ':memory:'
]

{ #category : #'test-support' }
GASqlite3Driver >> newFixture [

	^ GADriverSQLiteTestFixture new
]

{ #category : #testing }
GASqlite3Driver >> notBoundArgumentsFail [
	
	^ false
]

{ #category : #query }
GASqlite3Driver >> prepare: anSQLText [ 
	| s |
	
	s := self createStatement.
	s statementString: anSQLText.
	s prepare.
	^ s
]

{ #category : #transactions }
GASqlite3Driver >> rollbackTransaction [

	^ self basicExecute: 'rollback'
]

{ #category : #testing }
GASqlite3Driver >> supportsAutomaticQueryEncoding [
	
	^ false
]

{ #category : #testing }
GASqlite3Driver >> supportsCursoredFetch [
	
	^ false
]

{ #category : #testing }
GASqlite3Driver >> supportsPreparedStatements [

	^ true
]

{ #category : #testing }
GASqlite3Driver >> supportsRetrievingGeneratedKeys [

	^ true
]
