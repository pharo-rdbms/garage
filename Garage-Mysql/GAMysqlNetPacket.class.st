Class {
	#name : #GAMysqlNetPacket,
	#superclass : #Object,
	#instVars : [
		'length',
		'number',
		'data'
	],
	#classVars : [
		'MaxPacketLength'
	],
	#category : 'Garage-Mysql-Protocol'
}

{ #category : #'as yet unclassified' }
GAMysqlNetPacket class >> initialize [
	"self initialize"
	MaxPacketLength := 16rFFFFFF.

]

{ #category : #'as yet unclassified' }
GAMysqlNetPacket class >> maxLength [
	^ MaxPacketLength
]

{ #category : #accessing }
GAMysqlNetPacket >> data [
	^ data
]

{ #category : #accessing }
GAMysqlNetPacket >> data: buffer [ "should be ByteArray"
	data := buffer
]

{ #category : #testing }
GAMysqlNetPacket >> isOfMaxLength [
	^ length = MaxPacketLength
]

{ #category : #accessing }
GAMysqlNetPacket >> length [
	^ length 
]

{ #category : #accessing }
GAMysqlNetPacket >> length: size [
	length := size
]

{ #category : #accessing }
GAMysqlNetPacket >> maxLength [
	^ MaxPacketLength
]

{ #category : #accessing }
GAMysqlNetPacket >> number [
	^ number
]

{ #category : #accessing }
GAMysqlNetPacket >> number: num [
	number := num
]

{ #category : #reading }
GAMysqlNetPacket >> readFrom: aStream [
	length := aStream next + (aStream next << 8) + (aStream next << 16).
	number := aStream next.
	data := aStream next: length.
]

{ #category : #writing }
GAMysqlNetPacket >> writeTo: aStream [
	length = data size ifFalse: [self error: 'Mismatch between packet length and data size'].

	aStream 
		nextPut: (length digitAt: 1);
		nextPut: (length digitAt: 2);
		nextPut: (length digitAt: 3).
		
	aStream nextPut: (number digitAt: 1)	.
	
	(aStream respondsTo: #nextPutAllFlush:)  "socket streams respond to this"
		ifTrue: [aStream nextPutAllFlush: data] "this one avoids some data copy"
		ifFalse: [aStream nextPutAll: data; flush]
]
