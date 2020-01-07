Class {
	#name : #GAPostgresStartupPacket,
	#superclass : #GAPacket,
	#instVars : [
		'version',
		'databaseName',
		'userName',
		'extraArgs',
		'debugTty'
	],
	#category : 'Garage-Postgres-Protocol'
}

{ #category : #'instance creation' }
GAPostgresStartupPacket class >> databaseName: database userName: user [

	^self new
		setDatabaseName: database userName: user;
		yourself
]

{ #category : #accessing }
GAPostgresStartupPacket >> byteCount [
	^296

]

{ #category : #accessing }
GAPostgresStartupPacket >> databaseName [
	^databaseName

]

{ #category : #accessing }
GAPostgresStartupPacket >> databaseName: aString [
	databaseName := aString

]

{ #category : #accessing }
GAPostgresStartupPacket >> debugTty [
	^debugTty
]

{ #category : #accessing }
GAPostgresStartupPacket >> debugTty: aString [
	debugTty := aString
]

{ #category : #accessing }
GAPostgresStartupPacket >> extraArgs [
	^extraArgs
]

{ #category : #accessing }
GAPostgresStartupPacket >> extraArgs: aString [
	extraArgs := aString
]

{ #category : #printing }
GAPostgresStartupPacket >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: '(';
		nextPutAll: 'databaseName='; nextPutAll: databaseName printString;
		nextPutAll: ',userName='; nextPutAll: userName printString;
		nextPutAll: ',extraArgs='; nextPutAll: extraArgs printString;
		nextPutAll: ',debugTty='; nextPutAll: debugTty printString;
		nextPutAll: ',version='; nextPutAll: version printString;
		nextPutAll: ')'

]

{ #category : #'private-initialize' }
GAPostgresStartupPacket >> setDatabaseName: database userName: user [

	^self
		version: (2 bitShift: 16); "major=2 minor=0"
		databaseName: database;
		userName: user;
		yourself
]

{ #category : #accessing }
GAPostgresStartupPacket >> userName [
	^userName
]

{ #category : #accessing }
GAPostgresStartupPacket >> userName: aString [
	userName := aString
]

{ #category : #accessing }
GAPostgresStartupPacket >> version [
	^version

]

{ #category : #accessing }
GAPostgresStartupPacket >> version: anInteger [
	version := anInteger

]

{ #category : #sending }
GAPostgresStartupPacket >> writeOn: aStream [

	self writeInt32: self byteCount on: aStream.
	self writeInt32: self version on: aStream.
	self writeLimString: self databaseName size: 64 on: aStream.
	self writeLimString: self userName size: 32 on: aStream.
	self writeLimString: self extraArgs size: 64 on: aStream.
	self writeLimString: nil size: 64 on: aStream. "unused"
	self writeLimString: self debugTty size: 64 on: aStream.

]
