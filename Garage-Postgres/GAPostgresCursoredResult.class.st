Class {
	#name : #GAPostgresCursoredResult,
	#superclass : #Object,
	#instVars : [
		'connection',
		'fetchSize',
		'statement',
		'rows',
		'finished',
		'name',
		'fetchListener'
	],
	#category : 'Garage-Postgres-Driver'
}

{ #category : #accessing }
GAPostgresCursoredResult >> allRows [

	self fetchAllRows.
	^ rows
]

{ #category : #iterating }
GAPostgresCursoredResult >> at: anIndex [
	
	"Ok we should optimize it later"
	self fetchWhile: [ rows size < anIndex ].
	^ rows at: anIndex
]

{ #category : #'cursor management' }
GAPostgresCursoredResult >> close [

	connection executeAndCheckResult: 'CLOSE ', name
]

{ #category : #iterating }
GAPostgresCursoredResult >> collect: aBlockClosure [ 
	
	"Ok we should optimize it later"
	^ self allRows collect: aBlockClosure
]

{ #category : #accessing }
GAPostgresCursoredResult >> connection [
	^ connection
]

{ #category : #accessing }
GAPostgresCursoredResult >> connection: anObject [
	connection := anObject
]

{ #category : #'cursor management' }
GAPostgresCursoredResult >> declare [

	connection execute: 'DECLARE ', name, ' CURSOR FOR ', statement executionStatement.
	fetchListener ifNotNil: #fetchOccurred.
]

{ #category : #iterating }
GAPostgresCursoredResult >> do: aBlockClosure [ 
	
	"Ok we should optimize it later"
	^ self allRows do: aBlockClosure
]

{ #category : #cursor }
GAPostgresCursoredResult >> fetchAllRows [

	[ self hasMoreRowsInServer ] whileTrue: [ self fetchMoreRows ]
]

{ #category : #accessing }
GAPostgresCursoredResult >> fetchListener: aFetchListener [

	fetchListener := aFetchListener
]

{ #category : #cursor }
GAPostgresCursoredResult >> fetchMoreRows [
	
	| result obtained |
	result := connection execute: 'FETCH FORWARD ', fetchSize asString, ' FROM ', name.
	obtained := result resultSets first rows.
	rows addAll: obtained.
	fetchListener ifNotNil: #fetchOccurred.
	finished := obtained isEmpty or: [ obtained size < fetchSize ].
]

{ #category : #cursor }
GAPostgresCursoredResult >> fetchRows [
	
	| result obtained |

	result := connection execute: 'FETCH FORWARD ', fetchSize asString, ' FROM ', name.
	obtained := result resultSets first rows.
	rows addAll: obtained.
	finished := obtained isEmpty or: [ obtained size < fetchSize ].
]

{ #category : #accessing }
GAPostgresCursoredResult >> fetchSize [
	^ fetchSize
]

{ #category : #accessing }
GAPostgresCursoredResult >> fetchSize: anObject [
	fetchSize := anObject
]

{ #category : #cursor }
GAPostgresCursoredResult >> fetchWhile: aBlock [

	[ self hasMoreRowsInServer and: aBlock ] whileTrue: [ self fetchMoreRows ]
]

{ #category : #iterating }
GAPostgresCursoredResult >> first [
	
	^ self at: 1
]

{ #category : #testing }
GAPostgresCursoredResult >> hasMoreRowsInServer [
	
	^ finished not
]

{ #category : #'initialize - release' }
GAPostgresCursoredResult >> initialize [

	super initialize.
	name := 'cursorpgv2', UUID new asString36.
	rows := OrderedCollection new.
	finished := false.
	
]

{ #category : #testing }
GAPostgresCursoredResult >> isEmpty [
	
	^ rows isEmptyOrNil
		and: [ self hasMoreRowsInServer not ]
]

{ #category : #'as yet unclassified' }
GAPostgresCursoredResult >> nextRow [
	
	self halt.
	(rows isEmpty and: [ finished not ])
		ifTrue: [ self fetchRows ].

	^ rows isEmpty
		ifTrue: [ nil ]
		ifFalse: [ rows removeFirst ]
]

{ #category : #iterating }
GAPostgresCursoredResult >> readStream [

	^ GAResultSetReadStream on: self
]

{ #category : #iterating }
GAPostgresCursoredResult >> rowAt: anIndex [
	
	^ self at: anIndex
]

{ #category : #iterating }
GAPostgresCursoredResult >> rows [

	^ self allRows
]

{ #category : #iterating }
GAPostgresCursoredResult >> select: aBlockClosure [ 
	
	"Ok we should optimize it later"
	^ self allRows select: aBlockClosure
]

{ #category : #accessing }
GAPostgresCursoredResult >> statement [
	^ statement
]

{ #category : #accessing }
GAPostgresCursoredResult >> statement: anObject [
	statement := anObject
]
