Class {
	#name : #GASqlite3Driver,
	#superclass : #GADriver,
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
		on: (SQLite3Connection on:(aConnectionString host = 'memory' 
			ifTrue: [ ':memory:' ] 
			ifFalse: [ (aConnectionString databasePath) urlDecoded ]));
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

	^ implementation basicExecute: anSQLText
]

{ #category : #transactions }
GASqlite3Driver >> beginTransaction [

	^ implementation beginTransaction
]

{ #category : #connection }
GASqlite3Driver >> close [

	^implementation close
]

{ #category : #schema }
GASqlite3Driver >> columnsForTable: aTableName [
	^implementation columnNamesFor: aTableName
]

{ #category : #transactions }
GASqlite3Driver >> commitTransaction [

	^ implementation commitTransaction
]

{ #category : #connection }
GASqlite3Driver >> connect [
	
	^implementation open
]

{ #category : #accessing }
GASqlite3Driver >> database [

	^implementation filename
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
GASqlite3Driver >> execute: aQuery with: anArray [

	^ GASqlite3ResultSet on:(implementation execute: aQuery with: anArray)
]

{ #category : #finalization }
GASqlite3Driver >> finalize [

	implementation isOpen ifTrue: [implementation close].
]

{ #category : #transactions }
GASqlite3Driver >> hasAutoCommit [
	
	^ implementation getAutoCommit
]

{ #category : #testing }
GASqlite3Driver >> isConnected [

	^ implementation isNotNil and: [ implementation isOpen ]
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
	
	^implementation prepare: aString
]

{ #category : #transactions }
GASqlite3Driver >> rollbackTransaction [

	^ implementation rollbackTransaction
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
	^implementation tableNames
]
