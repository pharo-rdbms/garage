"
I am a fixture setting up and tearing down the database and tables needed for running tests.

Each of my concrete subclasses implement the particular details of a database vendor. That is, for each driver flavor, one of me should be available.

For insight into my usage, look at the setup and teardown methods in DBXDriverTest
"
Class {
	#name : #GADriverTestFixture,
	#superclass : #Object,
	#instVars : [
		'setupConnection',
		'connection',
		'connectionString',
		'setupConnectionString',
		'options'
	],
	#category : 'Garage-Tests'
}

{ #category : #'as yet unclassified' }
GADriverTestFixture class >> setupConnectionString: setupConnectionString connectionString: connectionString [

	| theConnectionString |
	theConnectionString := GAConnectionString fromString: setupConnectionString.
	^ ((GADriver driverAt: theConnectionString driverId)
			newFixtureForConnectionString: theConnectionString)
			setupConnectionString: setupConnectionString;
			connectionString: connectionString;
			yourself
]

{ #category : #accessing }
GADriverTestFixture >> connection [
	
	^ connection ifNil:[ connection := self newConnection ]
]

{ #category : #accessing }
GADriverTestFixture >> connectionString [

	^ connectionString
]

{ #category : #accessing }
GADriverTestFixture >> connectionString: aConnectionString [

	connectionString := aConnectionString
]

{ #category : #'setting up' }
GADriverTestFixture >> createDatabase [

	self subclassResponsibility
]

{ #category : #'setting up' }
GADriverTestFixture >> createSetupConnection [

	setupConnection := GADriver connectToConnectionString: 
		((GAConnectionString fromString: setupConnectionString) addOptions: options).
]

{ #category : #'setting up' }
GADriverTestFixture >> createTables [

	self subclassResponsibility
]

{ #category : #accessing }
GADriverTestFixture >> driver [
	
	^ GADriver driverAt: (GAConnectionString fromString: setupConnectionString) driverId
]

{ #category : #'setting up' }
GADriverTestFixture >> dropDatabase [

	self subclassResponsibility
]

{ #category : #'setting up' }
GADriverTestFixture >> dropTables [

	self subclassResponsibility
]

{ #category : #'setting up' }
GADriverTestFixture >> newConnection [

	^ GADriver connectToConnectionString: 
		((GAConnectionString fromString: connectionString) addOptions: options).
]

{ #category : #'setting up' }
GADriverTestFixture >> setUp [

	"We create the connection that will create the database. The other one will be created lazily"
	self setUp: Dictionary new
]

{ #category : #'setting up' }
GADriverTestFixture >> setUp: someOptions [

	"We create the connection that will create the database. The other one will be created lazily"
	options := someOptions.
	connection := setupConnection := nil.
	self createSetupConnection.
	self dropDatabase.
	self createDatabase.
	self createTables.
]

{ #category : #accessing }
GADriverTestFixture >> setupConnectionString: aConnectionString [

	setupConnectionString := aConnectionString
]

{ #category : #'setting up' }
GADriverTestFixture >> tearDown [

	options := nil.
	[connection ifNotNil: [ 
		connection close.
		connection := nil. ].]
		ensure: [
		[self dropDatabase.]
			ensure: [
			setupConnection ifNotNil: [
			setupConnection close.
			setupConnection := nil ]]]
]
