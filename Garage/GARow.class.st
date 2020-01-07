"
I am a copy of class SQLite3Row. This comment is copied from there, and might not be entirely accurate

I represent a row of results returned by the database.

"
Class {
	#name : #GARow,
	#superclass : #Object,
	#instVars : [
		'values',
		'columnNames'
	],
	#category : #'Garage-Driver'
}

{ #category : #converting }
GARow >> asArray [
	^ self values asArray
]

{ #category : #converting }
GARow >> asCombinedDictionary [
	^self asDictionary addAll: ((self values collectWithIndex:[:v :i | i -> v]) asDictionary); yourself 
]

{ #category : #converting }
GARow >> asDictionary [
	^ Dictionary newFromKeys: self columnNames andValues: self data
]

{ #category : #accessing }
GARow >> at: aKey [ 
	^ self at: aKey ifAbsent: [  ]
]

{ #category : #accessing }
GARow >> at: aKey ifAbsent: aBlock [
	^ aKey isInteger 
		ifTrue: [ self values at: aKey ifAbsent: aBlock ] 
		ifFalse: [ self values at:(self columnNames indexOf: aKey) ifAbsent: aBlock ]
]

{ #category : #accessing }
GARow >> at: aKey put: anObject [
	^ aKey isInteger 
		ifTrue: [self values at: aKey put: anObject]
		ifFalse: [ self atName: aKey put: anObject ]
]

{ #category : #accessing }
GARow >> atIndex: anIndex [
	^ values at: anIndex ifAbsent: [  ]
]

{ #category : #accessing }
GARow >> atIndex: anIndex put: anObject [
	^ self values at: anIndex put: anObject
]

{ #category : #accessing }
GARow >> atName: aKey [ 
	^ self values at: (self columnNames indexOf: aKey) ifAbsent: [ ]
]

{ #category : #accessing }
GARow >> atName: aKey put: anObject [
	| idx |
	^ (idx := self columnNames indexOf: aKey) isZero 
		ifTrue: [ 
			columnNames := self columnNames copyWith: aKey.
			values := self values copyWith: anObject ]
		ifFalse: [ values at: idx put: anObject ]
]

{ #category : #accessing }
GARow >> columnNames [
	^ columnNames ifNil: [ #() ]
]

{ #category : #accessing }
GARow >> columnNames: anArray [
 
	columnNames := anArray.
	values := Array new: anArray size
]

{ #category : #accessing }
GARow >> data [
	"compatibility"
	 ^self asCombinedDictionary
]

{ #category : #accessing }
GARow >> dataCount [
	^ self columnNames size
]

{ #category : #'reflective operations' }
GARow >> doesNotUnderstand: aMessage [

	^ self at: aMessage selector asString 
			ifAbsent: [ 
				"20160514: This bit, for Glorp integration, feels a bit iffy."
				self at: aMessage selector asString asUppercase 
					ifAbsent: [ super doesNotUnderstand: aMessage ]]
]

{ #category : #accessing }
GARow >> first [
	^ self values ifEmpty: [] ifNotEmpty: [:v | v first ]

]

{ #category : #accessing }
GARow >> last [
	^ self values ifEmpty: [ nil ] ifNotEmpty: [:v | v last ]

]

{ #category : #accessing }
GARow >> size [
	^ self columnNames size
]

{ #category : #accessing }
GARow >> values [
	 ^values ifNil: [ #() ]
]
