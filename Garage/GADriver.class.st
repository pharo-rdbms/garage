"
This is the basic interface to instantiate and look for database drivers.

Database drivers subscribe themselves to a global driver manager using this class. Then, they are instantiated through it.

It also describes the minimal interface of all drivers. Its API contains the main methods to execute database queries, prepare statements and manage transactions. Also, to handle the differences between different drivers, this API provides a bunch of supports* methods to check the provided features.
"
Class {
	#name : #GADriver,
	#superclass : #Object,
	#instVars : [
		'connectionString',
		'encoding'
	],
	#classVars : [
		'Drivers'
	],
	#category : #'Garage-Driver'
}

{ #category : #accessing }
GADriver class >> availableDrivers [
	
	^ Drivers availableDrivers
]

{ #category : #'instance-creation' }
GADriver class >> connectToConnectionString: aConnectionString [

	| connection |
	connection := self fromConnectionString: aConnectionString.
	connection connect.
	^ connection
]

{ #category : #drivers }
GADriver class >> driverAt: aDriverId [
	
	^ Drivers driverAt: aDriverId
]

{ #category : #drivers }
GADriver class >> driverId [

	^ self subclassResponsibility
]

{ #category : #drivers }
GADriver class >> driverManager [
	
	^ Drivers
]

{ #category : #'instance-creation' }
GADriver class >> fromConnectionString: string [
	
	| connectionString |
	string isString ifTrue: [connectionString := GAConnectionString fromString: string]
		ifFalse: [ connectionString := string ].
	^ (self driverAt: connectionString driverId) fromConnectionString: connectionString
]

{ #category : #initialize }
GADriver class >> initialize [

	Drivers := GADriverManager new.
]

{ #category : #drivers }
GADriver class >> isAvailable: aKey [
	
	^ Drivers isAvailable: aKey
]

{ #category : #tests }
GADriver class >> newFixture [

	^ self subclassResponsibility
]

{ #category : #tests }
GADriver class >> newFixtureForConnectionString: aConnectionString [

	^ self newFixture
]

{ #category : #drivers }
GADriver class >> subscribeDriver [

	Drivers subscribeDriver: self
]

{ #category : #testing }
GADriver class >> supportsEncoding: anEncoding [
	
	self subclassResponsibility
]

{ #category : #testing }
GADriver >> affectsOnlyChangedRows [

	"Tests if the current database driver will inform the number of effectively affected rows during a INSERT/UPDATE/DELETE query or just all that were selected by the WHERE clause"
	^ false
]

{ #category : #accessing }
GADriver >> backend [
	
	^ self subclassResponsibility
]

{ #category : #transactions }
GADriver >> beginTransaction [

	"Starts a database transaction"
	self subclassResponsibility
]

{ #category : #connection }
GADriver >> close [
	"Closes the current connection"
	self subclassResponsibility
]

{ #category : #schema }
GADriver >> columnsForTable: aTableName [
	self subclassResponsibility 
]

{ #category : #transactions }
GADriver >> commitTransaction [

	"Commits the current database transaction"
	self subclassResponsibility
]

{ #category : #connection }
GADriver >> connect [
	"Opens the connection to the configured database"
	self subclassResponsibility
]

{ #category : #accessing }
GADriver >> connectionString [
	
	^ connectionString
]

{ #category : #accessing }
GADriver >> connectionString: aGAConnectionString [ 

	connectionString := aGAConnectionString
]

{ #category : #transactions }
GADriver >> defaultValueAutoCommit [

	"Retrieves the expected default value of autocommit for the current driver.
	Autocommit should not be used in a general fashion: each database vendor implements it differently."
	self subclassResponsibility
]

{ #category : #accessing }
GADriver >> driverId [

	^ self class driverId
]

{ #category : #encoding }
GADriver >> encoder [
	
	| theEncoding |
	"Returns a Zn encoder corresponding to the configured encoding.
	Default: 'utf8'"
	theEncoding := (self encoding = 'utf8mb4') ifTrue: [ 'utf8' ] ifFalse: [ self encoding ].
	^ ZnCharacterEncoder newForEncoding: theEncoding
]

{ #category : #encoding }
GADriver >> encoding [
	
	"Returns the configured encoding for this driver instance.
	Default: 'utf8'"
	^ encoding ifNil: [ encoding := connectionString optionAt: 'encoding' ifAbsent: 'utf8' ]
]

{ #category : #encoding }
GADriver >> encoding: anEncoding [
	
	"Sets an encoding for the current driver instance.
	Accepted encodings are those supported by ZnCharacterEncoder"
	encoding := anEncoding
]

{ #category : #query }
GADriver >> execute: aQuery [

	"Executes a SQL query against the database in one roundtrip"
	self subclassResponsibility
]

{ #category : #finalization }
GADriver >> finalize [

	"Frees all associated resources of this driver instance"
]

{ #category : #transactions }
GADriver >> hasAutoCommit [

	"Tests if the current database driver has autocommit enabled or not"
	self subclassResponsibility
]

{ #category : #testing }
GADriver >> isConnected [

	"Tests if the connection is alive and connected"
	self subclassResponsibility
]

{ #category : #finalization }
GADriver >> isRegisteredForFinalization [

	"Tests if the current driver instance is registered in the weak registry for finalization or not"
	^ WeakRegistry default includes: self
]

{ #category : #testing }
GADriver >> notBoundArgumentsFail [
	
	"Tests if the current database driver fails if a prepared statement contains arguments that are not bound. Some drivers such as Sqlite3 will default unbound arguments to NULL and not fail."
	^ true
]

{ #category : #accessing }
GADriver >> numberOfFetchesForSingleExecute [
	"Returns the number of roundtrips a database driver does for a single execute command"
	^ 1
]

{ #category : #options }
GADriver >> optionAt: aString [ 
	
	"It allows to access the configuration options of this driver"
	^ self connectionString optionAt: aString
]

{ #category : #statement }
GADriver >> prepare: aSQLString [
	
	"Creates a statement object from a sql query"
	self subclassResponsibility
]

{ #category : #encoding }
GADriver >> queryEncoding [
	^ self encoding
]

{ #category : #finalization }
GADriver >> register [

	"Registers the current driver into the weak registry for automatic memory management"
	WeakRegistry default add: self
]

{ #category : #transactions }
GADriver >> rollbackTransaction [

	"Rollbacks the current database transaction"
	self subclassResponsibility
]

{ #category : #testing }
GADriver >> supportsAutomaticQueryEncoding [
	
	"Tests if the current database driver supports not-encoded strings inside a sql query.
	When true the driver will encode the full request into the configured encoding and the user does not have to manage it.
	When false the driver does not support encoding the query and thus the user has to encode manually arguments if building a query by String concatenation.
	
	Alternatively, use prepared statements when supported to avoid this issue"
	self subclassResponsibility
]

{ #category : #testing }
GADriver >> supportsCursoredFetch [

	"Tests if the current database driver supports cursored fetches. i.e., bringing database rows in batch instead of all in a row."
	^ self subclassResponsibility
]

{ #category : #encoding }
GADriver >> supportsEncoding: anEncoding [
	
	"Returns a boolean that indicates if the current driver supports a particular encoding"
	^ self class supportsEncoding: anEncoding
]

{ #category : #testing }
GADriver >> supportsPreparedStatements [

	"Tests if the current database driver supports prepared statements"
	^ false
]

{ #category : #testing }
GADriver >> supportsRetrievingGeneratedKeys [

	"Tests if the current database driver supports retrieving auto generated keys/ids without an extra query"
	^ false
]

{ #category : #schema }
GADriver >> tables [
	self subclassResponsibility 
]

{ #category : #finalization }
GADriver >> unregister [

	"Unregisters the current driver from the weak registry. Calling this means that finalization will be manual"
	WeakRegistry default remove: self ifAbsent: [  ]
]
