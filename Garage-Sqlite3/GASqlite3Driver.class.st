Class {
	#name : #GASqlite3Driver,
	#superclass : #GADriver,
	#instVars : [
		'connection'
	],
	#category : #'Garage-Sqlite3-Driver'
}

{ #category : #drivers }
GASqlite3Driver class >> driverId [

	^ 'sqlite3'
]

{ #category : #'instance-creation' }
GASqlite3Driver class >> fromConnectionString: aConnectionString [

	^ self new
		connectionString: aConnectionString;
		connection: (SQLite3Connection on:(aConnectionString host = 'memory' ifTrue: [ ':memory:' ] ifFalse: [ (aConnectionString databasePath) urlDecoded ]));
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

	^ connection basicExecute: anSQLText
]

{ #category : #transactions }
GASqlite3Driver >> beginTransaction [

	^ connection beginTransaction
]

{ #category : #connection }
GASqlite3Driver >> close [

	^connection close
]

{ #category : #schema }
GASqlite3Driver >> columnsForTable: aTableName [
	^connection columnNamesFor: aTableName
]

{ #category : #transactions }
GASqlite3Driver >> commitTransaction [

	^ connection commitTransaction
]

{ #category : #connection }
GASqlite3Driver >> connect [
	
	^connection open
]

{ #category : #accessing }
GASqlite3Driver >> connection: aSQLite3Connection [
	
	connection := aSQLite3Connection
]

{ #category : #accessing }
GASqlite3Driver >> database [

	^connection filename
]

{ #category : #transactions }
GASqlite3Driver >> defaultValueAutoCommit [
	
	^ true
]

{ #category : #query }
GASqlite3Driver >> execute: aQuery [

	^ connection execute: aQuery
]

{ #category : #query }
GASqlite3Driver >> execute: aQuery with: anArray [

	^ connection execute: aQuery with: anArray
]

{ #category : #finalization }
GASqlite3Driver >> finalize [

	connection isOpen ifTrue: [connection close].
]

{ #category : #transactions }
GASqlite3Driver >> hasAutoCommit [
	
	^ connection getAutoCommit
]

{ #category : #testing }
GASqlite3Driver >> isConnected [

	^ connection isNotNil and: [ connection isOpen ]
]

{ #category : #testing }
GASqlite3Driver >> isMemory [
	
	^ self connection filename = ':memory:'
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
GASqlite3Driver >> prepare: aString [ 
	
	^connection prepare: aString
]

{ #category : #transactions }
GASqlite3Driver >> rollbackTransaction [

	^ connection rollbackTransaction
]

{ #category : #testing }
GASqlite3Driver >> supportsAutomaticQueryEncoding [
	
	^ false
]

{ #category : #testing }
GASqlite3Driver >> supportsCursoredFetch [
	
	^ true
]

{ #category : #testing }
GASqlite3Driver >> supportsPreparedStatements [

	^ true
]

{ #category : #testing }
GASqlite3Driver >> supportsRetrievingGeneratedKeys [

	^ true
]

{ #category : #schema }
GASqlite3Driver >> tables [
	^connection tableNames
]
