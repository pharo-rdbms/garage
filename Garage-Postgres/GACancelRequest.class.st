Class {
	#name : #GACancelRequest,
	#superclass : #GAPacket,
	#instVars : [
		'processId',
		'secretKey'
	],
	#category : 'Garage-Postgres-Protocol'
}

{ #category : #'instance creation' }
GACancelRequest class >> processId: pid secretKey: secretKey [

	^self new
		processId: pid;
		secretKey: secretKey;
		yourself.

]

{ #category : #accessing }
GACancelRequest >> eventName [
	^#CancelRequest
]

{ #category : #accessing }
GACancelRequest >> processId [
	^processId
]

{ #category : #accessing }
GACancelRequest >> processId: anInteger [
	processId := anInteger
]

{ #category : #accessing }
GACancelRequest >> secretKey [
	^secretKey
]

{ #category : #accessing }
GACancelRequest >> secretKey: anInteger [
	secretKey := anInteger
]

{ #category : #sending }
GACancelRequest >> writeOn: aStream [
	"Write a cancel request on the stream."

	"80877102 - The cancel request code.
	The value is chosen to contain 1234 in the most significant 16 bits,
	and 5678 in the least 16 significant bits. (To avoid confusion,
	this code must not be the same as any protocol version number.)
	"

	self writeInt32: 16 on: aStream.
	self writeInt32: 80877102 on: aStream. "major=1234, minor=5678"
	self writeInt32: self processId on: aStream.
	self writeInt32: self secretKey on: aStream.

]
