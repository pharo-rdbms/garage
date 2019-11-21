"
I am a garage row representing a row from a database query. I provide an array like interface with methods such as #at:, #first, #last
"
Class {
	#name : #GARow,
	#superclass : #Object,
	#category : 'Garage-Driver'
}

{ #category : #converting }
GARow >> asArray [

	^ self values asArray
]

{ #category : #accessing }
GARow >> at: anIndex [

	^ self values at: anIndex
]

{ #category : #accessing }
GARow >> first [

	^ self values first
]

{ #category : #accessing }
GARow >> last [

	^ self values last
]

{ #category : #accessing }
GARow >> size [

	^ self values size
]

{ #category : #accessing }
GARow >> values [

	self subclassResponsibility
]
