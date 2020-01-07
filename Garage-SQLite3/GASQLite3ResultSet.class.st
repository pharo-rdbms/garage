Class {
	#name : #GASQLite3ResultSet,
	#superclass : #GAResultSet,
	#instVars : [
		'rows'
	],
	#category : #'Garage-SQLite3-Driver'
}

{ #category : #'instance creation' }
GASQLite3ResultSet class >> on: aSQLite3Cursor [
	^self new on: aSQLite3Cursor 
]

{ #category : #testing }
GASQLite3ResultSet >> at: anIndex [
	
	"Accesses the nth row of the result set"
	self rows at: anIndex
]

{ #category : #iterating }
GASQLite3ResultSet >> collect: aBlockClosure [ 
	
	^self rows collect: aBlockClosure 
]

{ #category : #iterating }
GASQLite3ResultSet >> do: aBlockClosure [ 
	
	"A do on the rows of the result set."
	^ self rows do: aBlockClosure 
]

{ #category : #iterating }
GASQLite3ResultSet >> first [
	
	"returns the first row of the result set"
	^ self rows first
]

{ #category : #testing }
GASQLite3ResultSet >> isEmpty [
	
	"Returns if the result set has no rows"
	^self rows isEmpty
]

{ #category : #acccessing }
GASQLite3ResultSet >> on: anImplementation [
	super on: anImplementation.
	anImplementation rowClass: GARow
]

{ #category : #streaming }
GASQLite3ResultSet >> readStream [
	
	^ GAResultSetReadStream on: self
]

{ #category : #acccessing }
GASQLite3ResultSet >> rows [ 
	^rows ifNil: [ rows := implementation rows ]
]

{ #category : #iterating }
GASQLite3ResultSet >> select: aBlockClosure [ 
	
	"A select on the rows of the result set."
	^ self rows select: aBlockClosure
]
