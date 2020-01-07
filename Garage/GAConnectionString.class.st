"
I am a database connection string for url-like connections. For example:

mysql://localhost:5432/sodbxtest?&user=sodbxtest&password=sodbxtest

More generally, a connection string is written as:

driver://host:port/database?key=value&key2=value2

Internally, I use ZnUrl to parse and access the data inside a connection string.
"
Class {
	#name : #GAConnectionString,
	#superclass : #Object,
	#instVars : [
		'connectionString',
		'options',
		'platform'
	],
	#category : 'Garage-Driver'
}

{ #category : #'instance creation' }
GAConnectionString class >> fromString: aString [ 
	
	^ self new
		initializeFromString: aString;
		yourself
]

{ #category : #private }
GAConnectionString >> addOptions: aDictionaryOfOptions [

	self options addAll: aDictionaryOfOptions
]

{ #category : #accessing }
GAConnectionString >> database [
	
	^ connectionString pathPrintString allButFirst urlDecoded
]

{ #category : #accessing }
GAConnectionString >> databasePath [
	
	"If it is windows, we remove the extra / at the beginning"
	^ (self platform isWindows
		ifTrue: [ connectionString pathPrintString allButFirst ]
		ifFalse: [ connectionString pathPrintString ]) urlDecoded
]

{ #category : #accessing }
GAConnectionString >> driverId [
	
	^ connectionString scheme
]

{ #category : #accessing }
GAConnectionString >> host [
	
	^ connectionString host ifNil: ''
]

{ #category : #'initialize - release' }
GAConnectionString >> initializeFromString: aString [ 
	
	connectionString := aString asUrl
]

{ #category : #accessing }
GAConnectionString >> optionAt: aString [ 
	
	^ self options at: aString ifAbsent: ''
]

{ #category : #accessing }
GAConnectionString >> optionAt: aString ifAbsent: aBlockClosure [ 
	
	^ self options at: aString ifAbsent: aBlockClosure
]

{ #category : #private }
GAConnectionString >> options [
	^ options
		ifNil: [ options := connectionString query
				ifNil: [ Dictionary new ]
				ifNotNil: #asDictionary ]
]

{ #category : #accessing }
GAConnectionString >> password [
	
	^ self optionAt: 'password'
]

{ #category : #accessing }
GAConnectionString >> platform [
	"Getting the set platform.
	Change it for testing.
	If not set it will use the default platform available in the system."
	
	^ platform ifNil: [ OSPlatform current ]
]

{ #category : #accessing }
GAConnectionString >> platform: aPlatform [
	"Setting the platform.
	Mainly for testing.
	If not set it will use the default platform available in the system."
	
	platform := aPlatform
]

{ #category : #accessing }
GAConnectionString >> port [
	
	^ connectionString port
]

{ #category : #accessing }
GAConnectionString >> user [
	
	^ self optionAt: 'user'
]
