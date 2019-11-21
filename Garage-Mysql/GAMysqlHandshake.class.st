Class {
	#name : #GAMysqlHandshake,
	#superclass : #GAMysqlPacket,
	#instVars : [
		'protocolVer',
		'serverVer',
		'threadId',
		'scrambleBuff',
		'serverCap',
		'serverLang',
		'scrambleBuffMore',
		'serverStatus'
	],
	#category : 'Garage-Mysql-Protocol'
}

{ #category : #'as yet unclassified' }
GAMysqlHandshake >> parse [ 
	protocolVer := inStream next.
	serverVer := (inStream upTo: 0) asString.
	threadId := inStream next + (inStream next bitShift: 8) + 
		(inStream next bitShift: 16) + (inStream next bitShift: 24).
	scrambleBuff := inStream next: 8.
	inStream skip: 1.	"always 0"
	serverCap := inStream next + (inStream next bitShift: 8).
	serverLang := inStream next.
	serverStatus := inStream next + (inStream next bitShift: 8).
	inStream skip: 13.	"filler"
	self supportsProtocol41 ifFalse: [ ^ self ].
	scrambleBuffMore := inStream next: 12.
	inStream skip: 1	"always 0"

]

{ #category : #accessing }
GAMysqlHandshake >> scrambleBuff [
	
	^ scrambleBuff
	
	"self supports41 
		ifTrue: [^ scrambleBuff, scrambleBuffMore]
		ifFalse: [^ scrambleBuff]."
]

{ #category : #'as yet unclassified' }
GAMysqlHandshake >> scrambleBuffMore [
	^scrambleBuffMore 
]

{ #category : #accessing }
GAMysqlHandshake >> serverCaps [
	^ serverCap
]

{ #category : #accessing }
GAMysqlHandshake >> serverLang [
	^ serverLang
]

{ #category : #accessing }
GAMysqlHandshake >> serverStatus [
	^ serverStatus
]

{ #category : #accessing }
GAMysqlHandshake >> serverVer [
	^ serverVer
]

{ #category : #'as yet unclassified' }
GAMysqlHandshake >> supportsProtocol41 [
	^ (serverCap bitAnd: CapProtocol41) = CapProtocol41
]
