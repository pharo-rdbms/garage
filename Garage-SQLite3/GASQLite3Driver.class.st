Class {
	#name : #GASQLite3Driver,
	#superclass : #GADriver,
	#category : #'Garage-SQLite3-Driver'
}

{ #category : #drivers }
GASQLite3Driver class >> driverId [

	^ 'sqlite3'
]

{ #category : #'instance-creation' }
GASQLite3Driver class >> fromConnectionString: aConnectionString [

	^ self new
		connectionString: aConnectionString;
		on: (SQLite3Connection on:(aConnectionString host = 'memory' 
			ifTrue: [ ':memory:' ] 
			ifFalse: [ (aConnectionString databasePath) urlDecoded ]));
		yourself
]

{ #category : #initialize }
GASQLite3Driver class >> initialize [

	self subscribeDriver
]

{ #category : #tests }
GASQLite3Driver class >> newFixture [
	
	^ GADriverSQLiteTestFixture new
]

{ #category : #encoding }
GASQLite3Driver class >> supportsEncoding: anEncoding [
	
	^ (ZnCharacterEncoder newForEncoding: anEncoding) = ZnUTF8Encoder new
]

{ #category : #accessing }
GASQLite3Driver >> backend [
	
	^ 'sqlite3'
]

{ #category : #public }
GASQLite3Driver >> basicExecute: anSQLText [

	^ implementation basicExecute: anSQLText
]

{ #category : #transactions }
GASQLite3Driver >> beginTransaction [

	^ implementation beginTransaction
]

{ #category : #connection }
GASQLite3Driver >> close [

	^implementation close
]

{ #category : #schema }
GASQLite3Driver >> columnsForTable: aTableName [
	^implementation columnNamesFor: aTableName
]

{ #category : #transactions }
GASQLite3Driver >> commitTransaction [

	^ implementation commitTransaction
]

{ #category : #connection }
GASQLite3Driver >> connect [
	
	^implementation open
]

{ #category : #accessing }
GASQLite3Driver >> database [

	^implementation filename
]

{ #category : #transactions }
GASQLite3Driver >> defaultValueAutoCommit [
	
	^ true
]

{ #category : #query }
GASQLite3Driver >> execute: aQuery [

	^ self execute: aQuery with: #()
]

{ #category : #query }
GASQLite3Driver >> execute: aQuery with: anArray [

	^ GASqlite3ResultSet on:(implementation execute: aQuery with: anArray)
]

{ #category : #finalization }
GASQLite3Driver >> finalize [

	implementation isOpen ifTrue: [implementation close].
]

{ #category : #transactions }
GASQLite3Driver >> hasAutoCommit [
	
	^ implementation getAutoCommit
]

{ #category : #testing }
GASQLite3Driver >> isConnected [

	^ implementation isNotNil and: [ implementation isOpen ]
]

{ #category : #testing }
GASQLite3Driver >> isMemory [
	
	^ self connection filename = ':memory:'
]

{ #category : #'test-support' }
GASQLite3Driver >> newFixture [

	^ GADriverSQLiteTestFixture new
]

{ #category : #testing }
GASQLite3Driver >> notBoundArgumentsFail [
	
	^ false
]

{ #category : #query }
GASQLite3Driver >> prepare: aString [ 
	
	^implementation prepare: aString
]

{ #category : #transactions }
GASQLite3Driver >> rollbackTransaction [

	^ implementation rollbackTransaction
]

{ #category : #testing }
GASQLite3Driver >> supportsAutomaticQueryEncoding [
	
	^ false
]

{ #category : #testing }
GASQLite3Driver >> supportsCursoredFetch [
	
	^ true
]

{ #category : #testing }
GASQLite3Driver >> supportsPreparedStatements [

	^ true
]

{ #category : #testing }
GASQLite3Driver >> supportsRetrievingGeneratedKeys [

	^ true
]

{ #category : #schema }
GASQLite3Driver >> tables [
	^implementation tableNames
]
