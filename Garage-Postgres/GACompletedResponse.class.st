Class {
	#name : #GACompletedResponse,
	#superclass : #GAAbstractStringResponse,
	#category : 'Garage-Postgres-Protocol'
}

{ #category : #printing }
GACompletedResponse >> displayOn: aStream [

	aStream nextPutAll: value.

]

{ #category : #accessing }
GACompletedResponse >> eventName [
	^#CompletedResponse
]
