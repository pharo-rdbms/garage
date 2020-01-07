Class {
	#name : #GACopyInResponse,
	#superclass : #GAPacket,
	#category : 'Garage-Postgres-Protocol'
}

{ #category : #accessing }
GACopyInResponse >> eventName [
	^#CopyInResponse
]
