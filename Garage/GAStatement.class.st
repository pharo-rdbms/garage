"
I am a statement object. I can be prepared or directly executed in the database.

If I support being prepared, I also support the configuration of bindings with the #at:bind: method.

Finally, I support the configuration of a #fetchSize: to use batch queries.
"
Class {
	#name : #GAStatement,
	#superclass : #Object,
	#instVars : [
		'connection',
		'statement',
		'arguments',
		'properties',
		'prepared',
		'fetchListener'
	],
	#category : 'Garage-Driver'
}

{ #category : #accessing }
GAStatement class >> onConnection: aPGConnection [ 
	
	^ self new
		connection: aPGConnection;
		yourself
]

{ #category : #bindings }
GAStatement >> at: aColumn bind: anObject [

	"Binds a column at a particular index with an object. Objects are automatically transformed by the driver into the corresponding 	database representation."
	self subclassResponsibility
]

{ #category : #accessing }
GAStatement >> connection: anOpenDBXConnection [ 
	
	connection := anOpenDBXConnection
]

{ #category : #execute }
GAStatement >> execute [

	"It executes the current statement."
	fetchListener ifNotNil: #fetchOccurred.
	^ connection execute: statement.
]

{ #category : #accessing }
GAStatement >> fetchListener: aGAFetchListener [
	
	"Sets a fetch listener to listen when the statement performs a roundtrip to the database."
	fetchListener := aGAFetchListener
]

{ #category : #execute }
GAStatement >> fetchSize: anInteger [ 
	
	"It sets the fetch size or the current statement, for batch retrieving."
	self subclassResponsibility
]

{ #category : #'initialize-release' }
GAStatement >> initialize [

	super initialize.
	arguments := OrderedCollection new.
	prepared := false.
]

{ #category : #bindings }
GAStatement >> placeholderAt: anInteger [ 
	
	"Returns the placeholder that should correspond for a prepared statement at a given index.
	This method is meant to handle compatibility between databases that accept '?' like placeholders and others that accept '$1' like placeholders."
	^ '?'
]

{ #category : #execute }
GAStatement >> prepare [

	"It prepares the current statement if the driver supports prepared statements."
	prepared ifTrue: [ self error: 'This statement is already prepared' ].
	prepared := true.
]

{ #category : #accessing }
GAStatement >> propertyAt: aKey [

	"Obtains the property set at a key"
	^ self propertyAt: aKey ifAbsent: [ self error: 'unexistent key: ', aKey ]
]

{ #category : #accessing }
GAStatement >> propertyAt: aKey ifAbsent: aBlock [

	"Obtains the property set at a key. If absent, aBlock is executed."
	properties ifNil: [ ^ aBlock value ].
	^ properties at: aKey ifAbsent: aBlock
]

{ #category : #accessing }
GAStatement >> propertyAt: aKey put: aValue [

	"Sets the property with the given key with the given value"
	properties ifNil: [ properties := Dictionary new ].
	properties at: aKey put: aValue
]

{ #category : #accessing }
GAStatement >> statementString [
	
	"Gets the SQL query string of the statement"
	^ statement
]

{ #category : #accessing }
GAStatement >> statementString: queryStatement [
	
	"Sets the SQL query string of the statement"
	statement := queryStatement
]
