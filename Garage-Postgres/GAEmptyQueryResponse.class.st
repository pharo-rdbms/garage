Class {
	#name : #GAEmptyQueryResponse,
	#superclass : #GAAbstractStringResponse,
	#category : 'Garage-Postgres-Protocol'
}

{ #category : #accessing }
GAEmptyQueryResponse >> eventName [
	^#EmptyQueryResponse
]
