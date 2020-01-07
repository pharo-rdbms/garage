Class {
	#name : #GAAbstractStringResponse,
	#superclass : #GAPacket,
	#instVars : [
		'value'
	],
	#category : 'Garage-Postgres-Protocol'
}

{ #category : #printing }
GAAbstractStringResponse >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: '(';
		nextPutAll: 'value='; nextPutAll: value printString;
		nextPutAll: ')'

]

{ #category : #receiving }
GAAbstractStringResponse >> receiveFrom: aStream [

	value := self readStringFrom: aStream.

]

{ #category : #accessing }
GAAbstractStringResponse >> value [
	^value
]
