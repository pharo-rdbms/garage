Class {
	#name : #GAMysqlClientAuth,
	#superclass : #GAMysqlPacket,
	#instVars : [
		'user',
		'password',
		'database',
		'scrambleBuff',
		'clientCaps',
		'charset',
		'serverCaps',
		'scrambleBuffMore'
	],
	#category : #'Garage-Mysql-Protocol'
}

{ #category : #'as yet unclassified' }
GAMysqlClientAuth >> charset: csNum [
	charset := csNum
]

{ #category : #'as yet unclassified' }
GAMysqlClientAuth >> database: db [
	database := db
]

{ #category : #'as yet unclassified' }
GAMysqlClientAuth >> initialize [
	clientCaps := CapLongFlag + CapTransactions + CapLongPassword + CapConnectWithDb.
	clientCaps := clientCaps + CapProtocol41 + CapSecureConnection.
]

{ #category : #'as yet unclassified' }
GAMysqlClientAuth >> password: pwd [
	password := pwd.
]

{ #category : #'as yet unclassified' }
GAMysqlClientAuth >> scrambleBuff: buffer [
	scrambleBuff := buffer.
]

{ #category : #'as yet unclassified' }
GAMysqlClientAuth >> scrambleBuffMore: more [
	scrambleBuffMore := more
]

{ #category : #'as yet unclassified' }
GAMysqlClientAuth >> serverCaps: caps [ 
	serverCaps := caps
]

{ #category : #'as yet unclassified' }
GAMysqlClientAuth >> user: userName [
	user := userName
]

{ #category : #'as yet unclassified' }
GAMysqlClientAuth >> write [
	| flags scrmbl buffStream maxNetPacketLength |
	buffStream := WriteStream on: (ByteArray new: 1024).
	flags := serverCaps bitAnd: clientCaps.
	flags := flags bitOr: CapMultiStatements + CapMultiResults.
	buffStream
		nextPut: (flags byteAt: 1);
		nextPut: (flags byteAt: 2);
		nextPut: (flags byteAt: 3);
		nextPut: (flags byteAt: 4).
	maxNetPacketLength := self class maxNetPacketLength.
	buffStream
		nextPut: (maxNetPacketLength byteAt: 1);
		nextPut: (maxNetPacketLength byteAt: 2);
		nextPut: (maxNetPacketLength byteAt: 3);
		nextPut: (maxNetPacketLength byteAt: 4).
	buffStream nextPut: (charset byteAt: 1).
	buffStream nextPutAll: (ByteArray new: 23 withAll: 0).	"filler"
	buffStream nextPutAll: user asByteArray.
	buffStream nextPut: 0.	"null terminated"
	scrmbl := password isEmptyOrNil
		ifTrue: [ '' asByteArray ]
		ifFalse: [ GAMysqlHelper
				secureScramble: scrambleBuff , scrambleBuffMore
				with: password ].
	self encodeLcs: scrmbl on: buffStream.
	(flags bitAnd: CapConnectWithDb) = CapConnectWithDb
		ifTrue: [ database isEmptyOrNil not
				ifTrue: [ buffStream nextPutAll: database asByteArray ].
			buffStream nextPut: 0	"null terminated" ].
	^ buffStream contents
]
