Class {
	#name : #GAMysqlCommand,
	#superclass : #GAMysqlPacket,
	#instVars : [
		'command',
		'arg'
	],
	#category : 'Garage-Mysql-Protocol'
}

{ #category : #'as yet unclassified' }
GAMysqlCommand >> command: cmd arg: text [
	command := cmd.
	arg := text.
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommand >> write [
	| buffStream |
	buffStream := WriteStream on: ByteArray new.
	buffStream nextPut: command.
	arg isEmptyOrNil ifFalse: [ buffStream nextPutAll: arg asByteArray ].
	^ buffStream contents
]
