Class {
	#name : #GAConnectionTest,
	#superclass : #GADriverTest,
	#category : 'Garage-Tests'
}

{ #category : #'as yet unclassified' }
GAConnectionTest >> testConnectionStringDriver [

	| driver |
	"Test that we can create a driver from a connection string such as
		opendbx:///Users/guillermopolito/work/temp/garage/memory?backend=sqlite3
	or
		 mysql:/localhost:3306/sodbxtest?user=sodbxtest&password=sodbxtest
	"
	driver := GADriver fromConnectionString: fixture connectionString.

	self assert: driver driverId asLowercase equals: fixture connectionString asZnUrl scheme asLowercase.
]

{ #category : #'as yet unclassified' }
GAConnectionTest >> testConnectionsAreFinalizedOnCollection [

	| newConnection |
	newConnection := fixture newConnection.
	newConnection finalize.
	self deny: newConnection isConnected.
]

{ #category : #'as yet unclassified' }
GAConnectionTest >> testConnectionsAreRegisteredForFinalization [

	| newConnection |
	newConnection := fixture newConnection.
	self assert: newConnection isRegisteredForFinalization.
	newConnection close.
]

{ #category : #'as yet unclassified' }
GAConnectionTest >> testDefaultEncoding [

	self assert: conn encoder equals: ZnUTF8Encoder new.
]

{ #category : #'as yet unclassified' }
GAConnectionTest >> testGetConnectionFromConnectionStringDoesNotOpenConnection [

	| connection |
	connection := GADriver fromConnectionString: fixture connectionString.
	self deny: connection isConnected.
]

{ #category : #'as yet unclassified' }
GAConnectionTest >> testIsConnected [

	| newConnection |
	[newConnection := fixture newConnection.
	self assert: newConnection isConnected.]
	ensure: [ newConnection close ]
]

{ #category : #'as yet unclassified' }
GAConnectionTest >> testNotConnected [

	| newConnection |
	newConnection := fixture newConnection.
	newConnection close.
	self deny: newConnection isConnected
]
