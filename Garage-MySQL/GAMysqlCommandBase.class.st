"
I am a basic mysql protocol command.
"
Class {
	#name : #GAMysqlCommandBase,
	#superclass : #Object,
	#instVars : [
		'session',
		'fetchListener',
		'driver'
	],
	#classVars : [
		'ComChangeUser',
		'ComCreateDb',
		'ComDebug',
		'ComDropDb',
		'ComFieldList',
		'ComInitDb',
		'ComPing',
		'ComQuery',
		'ComQuit',
		'ComSetOption',
		'ComSleep',
		'ComStat',
		'ComStmtClose',
		'ComStmtExecute',
		'ComStmtFetch',
		'ComStmtPrepare',
		'ComStmtReset',
		'ComStmtSendLongData'
	],
	#category : 'Garage-MySQL-Protocol'
}

{ #category : #'as yet unclassified' }
GAMysqlCommandBase class >> initialize [
	"self initialize"
	
	ComSleep := 16r00.
	ComQuit := 16r01.
	ComInitDb := 16r02.
	ComQuery := 16r03.
	ComFieldList := 16r04.
	ComStat := 16r09.
	ComDebug := 16r0D.
	ComPing := 16r0E.
	ComChangeUser := 16r11.
	ComStmtPrepare := 16r16.
	ComStmtExecute := 16r17.
	ComStmtSendLongData := 16r18.
	ComStmtClose := 16r19.
	ComStmtReset := 16r1A.
	ComSetOption := 16r1B.
	ComStmtFetch := 16r1C.
]

{ #category : #'as yet unclassified' }
GAMysqlCommandBase class >> onSession: ioSession driver: aDriver [
	^ self new
		session: ioSession;
		driver: aDriver;
		yourself
]

{ #category : #'command configuration' }
GAMysqlCommandBase >> commandArg [
	self subclassResponsibility 
]

{ #category : #'command configuration' }
GAMysqlCommandBase >> commandCode [
	self subclassResponsibility 
]

{ #category : #accessing }
GAMysqlCommandBase >> driver: aMysqlDriver [ 
	driver := aMysqlDriver
]

{ #category : #execute }
GAMysqlCommandBase >> execute [
	| resp cmd |
	session resetSequence.
	cmd := self prepare.
	self send: cmd.
	resp := self readResponse.
	fetchListener ifNotNil: #fetchOccurred.
	^ resp
]

{ #category : #accessing }
GAMysqlCommandBase >> fetchListener: aFetchListener [

	fetchListener := aFetchListener
]

{ #category : #communication }
GAMysqlCommandBase >> gotEof [
	^ driver peekPacket isEof 

]

{ #category : #execute }
GAMysqlCommandBase >> prepare [
	| cmd |
	cmd := GAMysqlCommand new.
	cmd command: self commandCode arg: self commandArg.
	^ cmd
]

{ #category : #communication }
GAMysqlCommandBase >> readResponse [
	| resp |

	resp := driver peekPacket.
	resp isError ifTrue: [^ GAMysqlError from: session read].
	resp isOkay ifTrue: [^ GAMysqlOkay from: session read].
	^ resp "Response type unknown at this point"
]

{ #category : #communication }
GAMysqlCommandBase >> send: cmd [

	session write: cmd write.
]

{ #category : #accessing }
GAMysqlCommandBase >> session: ioSession [
	session := ioSession
]
