Class {
	#name : #GACopyOutResponse,
	#superclass : #GAPacket,
	#category : 'Garage-Postgres-Protocol'
}

{ #category : #accessing }
GACopyOutResponse >> eventName [
	^#CopyOutResponse
]
