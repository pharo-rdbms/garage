Class {
	#name : #GAPostgresTerminate,
	#superclass : #GAPacket,
	#category : 'Garage-Postgres-Protocol'
}

{ #category : #sending }
GAPostgresTerminate >> writeOn: aStream [

	self writeByte: $X on: aStream.

]
