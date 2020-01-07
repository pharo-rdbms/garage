Class {
	#name : #GABackendKeyData,
	#superclass : #GAPacket,
	#instVars : [
		'processId',
		'secretKey'
	],
	#category : 'Garage-Postgres-Protocol'
}

{ #category : #accessing }
GABackendKeyData >> eventName [
	^#BackendKeyData
]

{ #category : #printing }
GABackendKeyData >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: '(';
		nextPutAll: 'processId='; nextPutAll: processId printString;
		nextPutAll: ',secretKey='; nextPutAll: secretKey printString;
		nextPutAll: ')'

]

{ #category : #accessing }
GABackendKeyData >> processId [
	^processId
]

{ #category : #accessing }
GABackendKeyData >> processId: anInteger [
	processId := anInteger
]

{ #category : #receiving }
GABackendKeyData >> receiveFrom: aStream [

	processId := self readInt32From: aStream.
	secretKey := self readInt32From: aStream.

]

{ #category : #accessing }
GABackendKeyData >> secretKey [
	^secretKey
]

{ #category : #accessing }
GABackendKeyData >> secretKey: anInteger [
	secretKey := anInteger
]
