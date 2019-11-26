Class {
	#name : #GASqlite3ResultSet,
	#superclass : #GAResultSet,
	#instVars : [
		'rows'
	],
	#category : #'Garage-Sqlite3-Driver'
}

{ #category : #'instance creation' }
GASqlite3ResultSet class >> on: aSQLite3Cursor [
	^self new on: aSQLite3Cursor 
]

{ #category : #testing }
GASqlite3ResultSet >> at: anIndex [
	
	"Accesses the nth row of the result set"
	self rows at: anIndex
]

{ #category : #iterating }
GASqlite3ResultSet >> collect: aBlockClosure [ 
	
	^self rows collect: aBlockClosure 
]

{ #category : #iterating }
GASqlite3ResultSet >> do: aBlockClosure [ 
	
	"A do on the rows of the result set."
	^ self rows do: aBlockClosure 
]

{ #category : #'as yet unclassified' }
GASqlite3ResultSet >> first [
	
	"returns the first row of the result set"
	^ self rows first
]

{ #category : #testing }
GASqlite3ResultSet >> isEmpty [
	
	"Returns if the result set has no rows"
	^self rows isEmpty
]

{ #category : #acccessing }
GASqlite3ResultSet >> on: anImplementation [
	super on: anImplementation.
	anImplementation rowClass: GARow
]

{ #category : #streaming }
GASqlite3ResultSet >> readStream [
	
	^ GAResultSetReadStream on: self
]

{ #category : #acccessing }
GASqlite3ResultSet >> rows [ 
	^rows ifNil: [ rows := implementation rows ]
]

{ #category : #iterating }
GASqlite3ResultSet >> select: aBlockClosure [ 
	
	"A select on the rows of the result set."
	^ self rows select: aBlockClosure
]
