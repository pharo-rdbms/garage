Class {
	#name : #GAErrorResponse,
	#superclass : #GAAbstractStringResponse,
	#category : 'Garage-Postgres-Protocol'
}

{ #category : #accessing }
GAErrorResponse >> eventName [
	^#ErrorResponse
]
