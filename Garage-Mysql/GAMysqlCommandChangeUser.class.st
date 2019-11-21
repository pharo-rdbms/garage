Class {
	#name : #GAMysqlCommandChangeUser,
	#superclass : #GAMysqlCommandBase,
	#instVars : [
		'user',
		'password',
		'database',
		'charset',
		'scrambleBuff',
		'scrambledPassword'
	],
	#category : 'Garage-Mysql-Protocol'
}

{ #category : #accessing }
GAMysqlCommandChangeUser >> charset: cset [ 
	charset := cset
]

{ #category : #'command configuration' }
GAMysqlCommandChangeUser >> commandArg [
	| buffStream |
	buffStream := WriteStream on: ByteArray new.
	buffStream
		nextPutAll: user asByteArray;
		nextPut: 0.
	GAMysqlPacket new 
		encodeLcs: scrambledPassword asByteArray
		on: buffStream.
	buffStream
		nextPutAll: (database 
				ifNil: [ '' asByteArray ]
				ifNotNil: [ database asByteArray ]);
		nextPut: 0.
	buffStream
		nextPut: (charset digitAt: 1);
		nextPut: (charset digitAt: 2).
	^ buffStream contents
]

{ #category : #'command configuration' }
GAMysqlCommandChangeUser >> commandCode [
	^ ComChangeUser 
]

{ #category : #accessing }
GAMysqlCommandChangeUser >> database: dbName [
	database := dbName
]

{ #category : #accessing }
GAMysqlCommandChangeUser >> password: pwd [
	password := pwd
]

{ #category : #execute }
GAMysqlCommandChangeUser >> readResponse [
	| pkt |

	pkt := super readResponse.
	pkt isOkayOrError 
		ifTrue: [^ pkt].
		
	pkt isEof ifTrue: [
		"Absorb the response"
		session read.
		"For old (short) hash style passwords"
		self send323Scramble.
		pkt := super readResponse.
		pkt isOkayOrError 
			ifTrue: [^ pkt]].
		
	GAMysqlDriverError signal: 'Unrecognized response for command'
	
]

{ #category : #accessing }
GAMysqlCommandChangeUser >> scrambleBuff: seed [
	scrambleBuff := seed
	
]

{ #category : #accessing }
GAMysqlCommandChangeUser >> scrambledPassword: pwd [
	scrambledPassword := pwd
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommandChangeUser >> send323Scramble [
	| scrmblPkt |
	scrmblPkt := GAMysql323Scramble new.
	scrmblPkt password: password; scrambleBuff: scrambleBuff.
	self send: scrmblPkt
	
]

{ #category : #accessing }
GAMysqlCommandChangeUser >> user: userName [
	user := userName
]
