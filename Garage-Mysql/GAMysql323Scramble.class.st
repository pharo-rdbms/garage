Class {
	#name : #GAMysql323Scramble,
	#superclass : #GAMysqlPacket,
	#instVars : [
		'scrambleBuff',
		'password'
	],
	#category : 'Garage-MySQL-Protocol'
}

{ #category : #'as yet unclassified' }
GAMysql323Scramble >> password: pwd [
	password := pwd
	
]

{ #category : #'as yet unclassified' }
GAMysql323Scramble >> scrambleBuff: scramble [
	scrambleBuff := scramble 
	
]

{ #category : #'as yet unclassified' }
GAMysql323Scramble >> write [
	| scrmbl buffStream |
	buffStream := WriteStream on: (ByteArray new: 256).
	scrmbl := password isEmptyOrNil 
		ifTrue: [ '' asByteArray ]
		ifFalse: 	[ 
			GAMysqlHelper 
				scramble323: scrambleBuff
				with: password ].
	"Server expects just the scramble, null terminated and nothing else"
	buffStream nextPutAll: scrmbl.
	buffStream nextPut: 0.
	^ buffStream contents 
	
]
