Class {
	#name : #GAConnectionArgs,
	#superclass : #Object,
	#instVars : [
		'hostname',
		'portno',
		'databaseName',
		'userName',
		'password',
		'extraArgs',
		'debugTty',
		'clientEncoding'
	],
	#category : 'Garage-Postgres-Protocol'
}

{ #category : #'instance creation' }
GAConnectionArgs class >> hostname: host portno: port databaseName: database userName: user password: pwd [
	^(self new)
		hostname: host;
		portno: port;
		databaseName: database;
		userName: user;
		password: pwd;
		yourself
]

{ #category : #'instance creation' }
GAConnectionArgs class >> hostname: host portno: port databaseName: database userName: user password: pwd extraArgs: extra debugTty: debug [
	^(self new)
		hostname: host;
		portno: port;
		databaseName: database;
		userName: user;
		password: pwd;
		extraArgs: extra;
		debugTty: debug;
		yourself
]

{ #category : #'as yet unclassified' }
GAConnectionArgs >> clientEncoding [
	^ clientEncoding
]

{ #category : #'as yet unclassified' }
GAConnectionArgs >> clientEncoding: aSymbol [
	clientEncoding := aSymbol
]

{ #category : #accessing }
GAConnectionArgs >> databaseName [
	^databaseName
]

{ #category : #accessing }
GAConnectionArgs >> databaseName: anObject [
	databaseName := anObject
]

{ #category : #accessing }
GAConnectionArgs >> debugTty [
	^debugTty
]

{ #category : #accessing }
GAConnectionArgs >> debugTty: anObject [
	debugTty := anObject
]

{ #category : #accessing }
GAConnectionArgs >> extraArgs [
	^extraArgs
]

{ #category : #accessing }
GAConnectionArgs >> extraArgs: anObject [
	extraArgs := anObject
]

{ #category : #accessing }
GAConnectionArgs >> hostname [
	^hostname
]

{ #category : #accessing }
GAConnectionArgs >> hostname: anObject [
	hostname := anObject
]

{ #category : #accessing }
GAConnectionArgs >> password [
	^password
]

{ #category : #accessing }
GAConnectionArgs >> password: anObject [
	password := anObject
]

{ #category : #accessing }
GAConnectionArgs >> portno [
	^portno
]

{ #category : #accessing }
GAConnectionArgs >> portno: anObject [
	portno := anObject
]

{ #category : #'private-initialize' }
GAConnectionArgs >> setHostname: host portno: port databaseName: database userName: user password: pwd extraArgs: extra debugTty: debug [

	hostname := host.
	portno := port.
	databaseName := database.
	userName := user.
	password := pwd.
	extraArgs := extra.
	debugTty := debug.
	^self
]

{ #category : #accessing }
GAConnectionArgs >> userName [
	^userName
]

{ #category : #accessing }
GAConnectionArgs >> userName: anObject [
	userName := anObject
]
