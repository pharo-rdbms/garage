Class {
	#name : #GAReadyForQuery,
	#superclass : #GAPacket,
	#category : 'Garage-Postgres-Protocol'
}

{ #category : #accessing }
GAReadyForQuery >> eventName [
	^#ReadyForQuery
]
