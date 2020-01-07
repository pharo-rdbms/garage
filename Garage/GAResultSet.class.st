"
I am a garage result set representing a result from a database query. I provide a collection-like interface with methods such as #at:, #collect:, #do:, #select.
"
Class {
	#name : #GAResultSet,
	#superclass : #Object,
	#instVars : [
		'implementation'
	],
	#category : #'Garage-Driver'
}

{ #category : #testing }
GAResultSet >> at: anIndex [
	
	"Accesses the nth row of the result set"
	self subclassResponsibility
]

{ #category : #iterating }
GAResultSet >> collect: aBlockClosure [ 
	
	^self subclassResponsibility 
]

{ #category : #iterating }
GAResultSet >> do: aBlockClosure [ 
	
	"A do on the rows of the result set."
	^ self subclassResponsibility 
]

{ #category : #'reflective operations' }
GAResultSet >> doesNotUnderstand: aMessage [
	^(implementation respondsTo: aMessage selector) 
		ifTrue: [ aMessage sendTo: implementation ]
		ifFalse: [ super doesNotUnderstand: aMessage ]
]

{ #category : #iterating }
GAResultSet >> first [
	
	"returns the first row of the result set"
	^ self subclassResponsibility
]

{ #category : #testing }
GAResultSet >> isEmpty [
	
	"Returns if the result set has no rows"
	self subclassResponsibility
]

{ #category : #testing }
GAResultSet >> isResultSet [

	^ true
]

{ #category : #acccessing }
GAResultSet >> on: aResultSet [ 
	implementation := aResultSet
]

{ #category : #streaming }
GAResultSet >> readStream [
	
	"Returns a read stream for the current result set"
	self subclassResponsibility
]

{ #category : #testing }
GAResultSet >> rowAt: anIndex [
	
	"Returns the nth row of the result set. Equivalent to #at:"
	^ self at: anIndex
]

{ #category : #iterating }
GAResultSet >> select: aBlockClosure [ 
	
	"A select on the rows of the result set."
	^ self subclassResponsibility
]
