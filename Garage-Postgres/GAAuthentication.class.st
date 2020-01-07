Class {
	#name : #GAAuthentication,
	#superclass : #GAPacket,
	#instVars : [
		'type',
		'salt'
	],
	#category : 'Garage-Postgres-Protocol'
}

{ #category : #accessing }
GAAuthentication >> eventName [

	type > 6 ifTrue: [self error: 'Unknown authentication type'].

	^#(
		AuthenticationOk
		AuthenticationKerberosV4
		AuthenticationKerberosV5
		AuthenticationCleartextPassword
		AuthenticationCryptPassword
		AuthenticationMD5Password
		AuthenticationSCMCredential
	) at: (type + 1)

]

{ #category : #printing }
GAAuthentication >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: '(';
		nextPutAll: 'type='; nextPutAll: type printString;
		nextPutAll: ',salt='; nextPutAll: salt printString;
		nextPutAll: ')'

]

{ #category : #receiving }
GAAuthentication >> receiveFrom: connection [

	type := self readInt32From: connection.

	"AuthenticationCryptPassword"
	type == 4 ifTrue: [ salt := self readByteN: 2 from: connection ].

	"AuthenticationMD5Password"
	type == 5 ifTrue: [ salt := self readByteN: 4 from: connection ].

	"
	For documentation purposes here are the other authentication methods.
	There is no other packet data to read in these cases.

	type == 1 AuthenticationKerberosV4
	type == 2 AuthenticationKerberosV5
	type == 3 AuthenticationCleartextPassword
	type == 6 AuthenticationSCMCredential
	"

]

{ #category : #accessing }
GAAuthentication >> salt [
	^salt
]

{ #category : #accessing }
GAAuthentication >> salt: anInteger [
	salt := anInteger
]

{ #category : #accessing }
GAAuthentication >> type [
	^type
]

{ #category : #accessing }
GAAuthentication >> type: anInteger [
	type := anInteger
]
