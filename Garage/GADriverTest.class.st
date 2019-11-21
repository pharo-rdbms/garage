Class {
	#name : #GADriverTest,
	#superclass : #TestCase,
	#instVars : [
		'conn',
		'fixture'
	],
	#classVars : [
		'Fixture'
	],
	#category : 'Garage-Tests'
}

{ #category : #'as yet unclassified' }
GADriverTest class >> fixture: aFixture [

	Fixture := aFixture
]

{ #category : #configuration }
GADriverTest >> createFixture [

	"You should implement this method as a user of garage to make the tests run on your database.
	This method should return an instance of GADriverTestFixture with two connection strings:
	 - setupConnectionString is the connection string used to create the initial database (if needed)
	 - connection string is the connection string used to manipulate the created database.
	
	Examples can be found in class GAContinuousIntegrationConfiguration"
	
	self shouldBeImplemented
	
	"^ GADriverTestFixture 
		setupConnectionString: SetupConnectionString
		connectionString: ConnectionString"
]

{ #category : #running }
GADriverTest >> setUp [

	super setUp.
	fixture := Fixture ifNil: [ self createFixture ].
	fixture setUp.
	conn := fixture connection.
]

{ #category : #running }
GADriverTest >> tearDown [

	fixture tearDown.
	super tearDown.
]
