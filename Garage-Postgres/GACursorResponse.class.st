Class {
	#name : #GACursorResponse,
	#superclass : #GAAbstractStringResponse,
	#category : 'Garage-Postgres-Protocol'
}

{ #category : #accessing }
GACursorResponse >> eventName [
	^#CursorResponse
]
