Class {
	#name : #GAColumnDescription,
	#superclass : #GAPacket,
	#instVars : [
		'fieldName',
		'typeOid',
		'typeSize',
		'typeModifier'
	],
	#category : 'Garage-Postgres-Protocol'
}

{ #category : #printing }
GAColumnDescription >> displayOn: aStream [

	aStream nextPutAll: fieldName.

]

{ #category : #accessing }
GAColumnDescription >> eventName [
	^#ColumnDescription
]

{ #category : #accessing }
GAColumnDescription >> fieldName [
	^ fieldName
]

{ #category : #printing }
GAColumnDescription >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: '(';
		nextPutAll: 'fieldName='; nextPutAll: fieldName printString;
		nextPutAll: ',typeOid='; nextPutAll: typeOid printString;
		nextPutAll: ',typeSize='; nextPutAll: typeSize printString;
		nextPutAll: ',typeModifier='; nextPutAll: typeModifier printString;
		nextPutAll: ')'

]

{ #category : #receiving }
GAColumnDescription >> receiveFrom: connection [

	fieldName := self readStringFrom: connection.
	typeOid := self readInt32From: connection.
	typeSize := self readInt16From: connection.
	typeModifier := self readInt32From: connection.

]

{ #category : #accessing }
GAColumnDescription >> typeModifier [
	^ typeModifier
]

{ #category : #accessing }
GAColumnDescription >> typeOid [
	^ typeOid
]

{ #category : #accessing }
GAColumnDescription >> typeSize [
	^ typeSize
]
