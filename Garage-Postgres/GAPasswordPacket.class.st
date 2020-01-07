Class {
	#name : #GAPasswordPacket,
	#superclass : #GAPacket,
	#instVars : [
		'password'
	],
	#category : 'Garage-Postgres-Protocol'
}

{ #category : #'instance creation' }
GAPasswordPacket class >> password: aString [

	^self new
		password: aString;
		yourself.

]

{ #category : #accessing }
GAPasswordPacket >> password [
	^password
]

{ #category : #accessing }
GAPasswordPacket >> password: aString [
	password := aString
]

{ #category : #printing }
GAPasswordPacket >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: '(';
		nextPutAll: 'password='; nextPutAll: password printString;
		nextPutAll: ')'
]

{ #category : #sending }
GAPasswordPacket >> writeOn: aStream [

	"Add 5 for the 32bit size header, and add 1 for the '\0' after the string"

	self writeInt32: self password size + 5 on: aStream.
	self writeString: self password on: aStream.

]
