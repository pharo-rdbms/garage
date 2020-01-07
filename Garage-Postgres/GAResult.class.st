Class {
	#name : #GAResult,
	#superclass : #Object,
	#instVars : [
		'connection',
		'resultSets',
		'errorResponse',
		'functionResult'
	],
	#category : 'Garage-Postgres-Driver'
}

{ #category : #'instance creation' }
GAResult class >> new [
	^ self error: 'should not use'

]

{ #category : #'instance creation' }
GAResult class >> on: aConnection [

	^ self basicNew initialize
		connection: aConnection;
		yourself.

]

{ #category : #'accessing-convenience' }
GAResult >> addResultSet [

	resultSets add: (GAPostgresResultSet on: self).

]

{ #category : #accessing }
GAResult >> affectedRows [
	
	^ self resultSets first completedResponse value substrings last asInteger ifNil: [ 0 ]
]

{ #category : #accessing }
GAResult >> at: anIndex [
	
	^ self resultSets first at: anIndex
]

{ #category : #enumerating }
GAResult >> collect: aBlock [
	
	^ self resultSets first collect: aBlock
]

{ #category : #'accessing-convenience' }
GAResult >> completedResponse [

	^ self lastResultSet completedResponse
]

{ #category : #'accessing-convenience' }
GAResult >> completedResponse: value [

	self lastResultSet completedResponse: value
]

{ #category : #accessing }
GAResult >> connection [
	^ connection
]

{ #category : #accessing }
GAResult >> connection: value [
	connection := value
]

{ #category : #'accessing-convenience' }
GAResult >> dataRows [

	^ self lastResultSet ifNotNil: [ :rs |
		rs dataRows ]
]

{ #category : #printing }
GAResult >> displayResultOn: aStream [

	errorResponse ifNotNil: [
		aStream nextPutAll: errorResponse value.
		aStream cr].

	resultSets do: [:each | each displayResultSetOn: aStream].

]

{ #category : #enumerating }
GAResult >> do: aBlock [
	
	^ self resultSets first do: aBlock
]

{ #category : #'reflective operations' }
GAResult >> doesNotUnderstand: aMessage [
	^ aMessage sendTo: self resultSets first
]

{ #category : #accessing }
GAResult >> errorResponse [
	^ errorResponse
]

{ #category : #accessing }
GAResult >> errorResponse: value [
	errorResponse := value
]

{ #category : #accessing }
GAResult >> first [
	
	^ self at: 1
]

{ #category : #accessing }
GAResult >> functionResult [
	^ functionResult
]

{ #category : #accessing }
GAResult >> functionResult: value [
	functionResult := value
]

{ #category : #initialization }
GAResult >> initialize [

	resultSets := OrderedCollection new.

]

{ #category : #testing }
GAResult >> isEmpty [
	
	^ self resultSets first isEmpty
]

{ #category : #testing }
GAResult >> isError [
	^ self errorResponse isNotNil
]

{ #category : #testing }
GAResult >> isResultSet [
	
	^ resultSets first rows notEmpty
]

{ #category : #'accessing-convenience' }
GAResult >> lastResultSet [

	^resultSets
		ifEmpty: [ nil ]
		ifNotEmpty: [ resultSets last ]
]

{ #category : #accessing }
GAResult >> nextRow [

	self rows ifEmpty:[ ^ nil ].
	^ self rows removeFirst
]

{ #category : #printing }
GAResult >> printOn: aStream [
	super printOn: aStream.
	aStream << ' ('.
	self resultSets do: [ :item | item printOn: aStream ] separatedBy: [ aStream << ', ' ].
	aStream << ')'
]

{ #category : #streaming }
GAResult >> readStream [
	
	^ self resultSets first readStream
]

{ #category : #initialization }
GAResult >> reset [
	"Clear the previous results in preparation to hold new query results."

	"There's an opportunity to tweak the code here for performance.
	If the result sets are cleared each time, then there's a lot of
	re-allocation. But, if the old results are just cleared, an earlier
	large result set may cause a large collection to remain in memory.
	Maybe it's just better to let GC handle it.
	"

	self errorResponse: nil.
	self functionResult: nil.
	resultSets := OrderedCollection new.

]

{ #category : #accessing }
GAResult >> resultSets [
	^ resultSets
]

{ #category : #accessing }
GAResult >> resultSets: value [
	resultSets := value
]

{ #category : #'accessing-convenience' }
GAResult >> rowDescription [

	^ self lastResultSet rowDescription
]

{ #category : #'accessing-convenience' }
GAResult >> rowDescription: aRowDescription [

	| rs |

	rs := self lastResultSet.
	rs rowDescription: aRowDescription.
	rs result: self.
	aRowDescription resultSet: rs.

]

{ #category : #'accessing-convenience' }
GAResult >> rows [

	^ self lastResultSet rows
]

{ #category : #'accessing-convenience' }
GAResult >> rows: value [

	self lastResultSet rows: value
]

{ #category : #enumerating }
GAResult >> select: aBlock [
	
	^ self resultSets first select: aBlock
]
