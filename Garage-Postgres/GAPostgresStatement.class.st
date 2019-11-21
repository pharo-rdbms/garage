Class {
	#name : #GAPostgresStatement,
	#superclass : #GAStatement,
	#instVars : [
		'fetchSize'
	],
	#category : 'Garage-Postgres-Driver'
}

{ #category : #bindings }
GAPostgresStatement >> addBinding: anObject [
	
	arguments add: anObject.
]

{ #category : #bindings }
GAPostgresStatement >> at: anInteger bind: anObject [
	
	prepared ifFalse: [ self error: 'A statement should be prepared to bind arguments' ].
	arguments add: anObject.
]

{ #category : #accessing }
GAPostgresStatement >> connection: aPGConnection [ 

	connection := aPGConnection
]

{ #category : #execute }
GAPostgresStatement >> execute [
	
	^ fetchSize ifNil: [
		fetchListener ifNotNil: #fetchOccurred.
		connection execute: self executionStatement.
	] ifNotNil: [
		^ GAPostgresCursoredResult new
			connection: connection;
			fetchListener: fetchListener;
			fetchSize: fetchSize;
			statement: self;
			declare;
			yourself
	]
]

{ #category : #execute }
GAPostgresStatement >> executionStatement [
	
	| argumentsString |
	prepared ifFalse: [ ^ statement ].
	
	"If not it means by the moment that we are a named prepared statement and we execute that"
	argumentsString := arguments
		ifEmpty: [ '' ]
		ifNotEmpty: [ '(''', (''', ''' join: (arguments collect: #asString)), ''')' ].

	^ 'EXECUTE ', (self propertyAt: #statementId), argumentsString
]

{ #category : #accessing }
GAPostgresStatement >> fetchSize: anInteger [ 
	
	fetchSize := anInteger
]

{ #category : #'initialize-release' }
GAPostgresStatement >> initialize [

	super initialize.
	arguments := OrderedCollection new.
]

{ #category : #accessing }
GAPostgresStatement >> placeholderAt: anInteger [ 
	
	^ '$', anInteger asString
]

{ #category : #execute }
GAPostgresStatement >> prepare [

	| statementId |
	super prepare.
	
	statementId := 'preparedStmt', UUID new asString36.
	connection basicQuery: 'PREPARE ', statementId, ' AS ', self statementString.
	self propertyAt: #statementId put: statementId.
	
	^ self
]

{ #category : #printing }
GAPostgresStatement >> printOn: aStream [
	super printOn: aStream.
	aStream
		<< ' (';
		<< statement;
		<< ')'
]

{ #category : #accessing }
GAPostgresStatement >> statement [

	^ statement
]
