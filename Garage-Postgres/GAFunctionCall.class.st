Class {
	#name : #GAFunctionCall,
	#superclass : #GAPacket,
	#instVars : [
		'oid',
		'arguments'
	],
	#category : 'Garage-Postgres-Protocol'
}

{ #category : #'instance creation' }
GAFunctionCall class >> oid: anInteger arguments: aCollection [
	"Return a new instance of the receiver.

	'anInteger' specifies the object ID of the function to call. The object ID is a site specific PostgreSQL value.
	'aCollection' contains the arguments of the function call. It should contain String values, which may have non-printable characters (i.e. values 0..255).
	"

	^ self new setOid: anInteger arguments: aCollection

]

{ #category : #accessing }
GAFunctionCall >> arguments [
	^arguments
]

{ #category : #accessing }
GAFunctionCall >> arguments: value [
	arguments := value
]

{ #category : #accessing }
GAFunctionCall >> oid [
	^oid
]

{ #category : #accessing }
GAFunctionCall >> oid: value [
	oid := value
]

{ #category : #printing }
GAFunctionCall >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: '(';
		nextPutAll: 'oid='; nextPutAll: oid printString;
		nextPutAll: ',arguments='; nextPutAll: arguments printString;
		nextPutAll: ')'
]

{ #category : #'private-initialize' }
GAFunctionCall >> setOid: anInteger arguments: anArray [

	oid := anInteger.
	arguments := anArray
]

{ #category : #printing }
GAFunctionCall >> writeOn: aStream [

	self writeByte: $F on: aStream.
	self writeString: '' on: aStream.
	self writeInt32: self oid on: aStream.
	self writeInt32: self arguments size on: aStream.
	self arguments do: [:arg |
		self writeInt32: arg size on: aStream.
		arg do: [:b | self writeByte: (Character value: b) on: aStream].
	]
]
