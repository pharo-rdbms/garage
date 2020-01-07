Class {
	#name : #GAPostgresResultSet,
	#superclass : #GAResultSet,
	#instVars : [
		'result',
		'completedResponse',
		'rowDescription',
		'rows'
	],
	#category : 'Garage-Postgres-Driver'
}

{ #category : #'instance creation' }
GAPostgresResultSet class >> new [
	self error: 'should not use'
]

{ #category : #'instance creation' }
GAPostgresResultSet class >> on: aResult [

	^ self basicNew initialize
		result: aResult;
		yourself.

]

{ #category : #accessing }
GAPostgresResultSet >> at: anIndex [
	
	^ rows at: anIndex
]

{ #category : #iterating }
GAPostgresResultSet >> collect: aBlock [
	
	^ rows collect: aBlock
]

{ #category : #accessing }
GAPostgresResultSet >> completedResponse [
	"Answer the value of completedResponse"

	^ completedResponse
]

{ #category : #accessing }
GAPostgresResultSet >> completedResponse: anObject [
	"Set the value of completedResponse"

	completedResponse := anObject
]

{ #category : #accessing }
GAPostgresResultSet >> dataRows [

	^rows collect: [ :e | e dataRow ]
]

{ #category : #printing }
GAPostgresResultSet >> displayResultSetOn: aStream [

	completedResponse ifNotNil: [
		completedResponse displayOn: aStream.
		aStream cr.
	].
	rowDescription ifNotNil: [
		self displayRowDescriptionOn: aStream.
		aStream cr; nextPutAll: '----------'; cr.
		self displayRowsOn: aStream.
		aStream nextPut: $(.
		rows size printOn: aStream.
		aStream nextPutAll: ' row'.
		rows size > 1 ifTrue: [aStream nextPut: $s].
		aStream nextPut: $); cr; cr.
	].

]

{ #category : #printing }
GAPostgresResultSet >> displayRowDescriptionOn: aStream [

	rowDescription displayOn: aStream.

]

{ #category : #printing }
GAPostgresResultSet >> displayRowsOn: aStream [

	rows do: [:each | each displayOn: aStream. aStream cr.].

]

{ #category : #iterating }
GAPostgresResultSet >> do: aBlock [
	
	^ rows do: aBlock
]

{ #category : #'reflective operations' }
GAPostgresResultSet >> doesNotUnderstand: aMessage [
	^ aMessage sendTo: self rows
]

{ #category : #accessing }
GAPostgresResultSet >> first [
	
	^ rows first
]

{ #category : #initialization }
GAPostgresResultSet >> initialize [

	rows := OrderedCollection new.
]

{ #category : #testing }
GAPostgresResultSet >> isEmpty [
	
	^ rows isEmpty
]

{ #category : #printing }
GAPostgresResultSet >> printOn: aStream [
	super printOn: aStream.
	aStream
		<< '(';
		cr.
	self displayResultSetOn: aStream.
	aStream << ')'
]

{ #category : #streaming }
GAPostgresResultSet >> readStream [
	
	^ GAResultSetReadStream on: self
]

{ #category : #accessing }
GAPostgresResultSet >> result [
	"Answer the value of result"

	^ result
]

{ #category : #accessing }
GAPostgresResultSet >> result: anObject [
	"Set the value of result"

	result := anObject
]

{ #category : #testing }
GAPostgresResultSet >> rowAt: anIndex [
	
	^ self at: anIndex
]

{ #category : #accessing }
GAPostgresResultSet >> rowDescription [
	"Answer the value of rowDescription"

	^ rowDescription
]

{ #category : #accessing }
GAPostgresResultSet >> rowDescription: anObject [
	"Set the value of rowDescription"

	rowDescription := anObject
]

{ #category : #accessing }
GAPostgresResultSet >> rows [
	"Answer the value of rows"

	^ rows
]

{ #category : #accessing }
GAPostgresResultSet >> rows: anObject [
	"Set the value of rows"

	rows := anObject
]

{ #category : #iterating }
GAPostgresResultSet >> select: aBlock [
	
	^ rows select: aBlock
]

{ #category : #accessing }
GAPostgresResultSet >> valueAt: fieldName [

	| i |
	i := rowDescription columnDescriptions findFirst: [:each | each fieldName = fieldName].
	i = 0 ifTrue: [^ nil].
	rows == nil ifTrue: [^ nil].
	^ (rows at: 1) rawData at: i
]
