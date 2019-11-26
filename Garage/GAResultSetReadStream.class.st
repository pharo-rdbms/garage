"
I provide a stream-like  API to access a result set. I ask the result set for its rows in a lazy way. If no more rows are available, the #next method will return nil and the #next: method will return just an array with the available rows.
"
Class {
	#name : #GAResultSetReadStream,
	#superclass : #Object,
	#instVars : [
		'implementation',
		'position'
	],
	#category : #'Garage-Driver'
}

{ #category : #'instance creation' }
GAResultSetReadStream class >> on: aResultSet [

	^ self new 
		on: aResultSet;
		yourself
]

{ #category : #accessing }
GAResultSetReadStream >> currentRow [
	
	"Gets the current row of the stream"
	^ [ implementation rows at: position ] on: SubscriptOutOfBounds do: [ nil ]
]

{ #category : #'reflective operations' }
GAResultSetReadStream >> doesNotUnderstand: aMessage [
	^(implementation respondsTo: aMessage selector) 
		ifTrue: [ aMessage sendTo: implementation ]
		ifFalse: [ super doesNotUnderstand: aMessage ]
]

{ #category : #'initialization-release' }
GAResultSetReadStream >> initialize [
	
	super initialize.
	position := 0.
]

{ #category : #accessing }
GAResultSetReadStream >> next [
	
	"Advances the stream and retrieves the row at the current position. If no more rows are available, it returns nil."
	position := position + 1.
	^ self currentRow.
]

{ #category : #iterating }
GAResultSetReadStream >> next: anInteger [
	"Advances the stream and tries to retrieve the following N rows of the result set. If not enough rows are available, the retrieved array will contain only the available elements."

	^ Array
		streamContents: [ :str | 
			anInteger
				timesRepeat: [ self next ifNotNil: [ :next | str nextPut: next ] ] ]
]

{ #category : #'initialization-release' }
GAResultSetReadStream >> on: aResultSet [ 

	implementation := aResultSet
]
