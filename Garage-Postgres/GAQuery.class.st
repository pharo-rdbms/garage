Class {
	#name : #GAQuery,
	#superclass : #GAPacket,
	#instVars : [
		'queryString'
	],
	#category : 'Garage-Postgres-Protocol'
}

{ #category : #'instance creation' }
GAQuery class >> sql: aString [

	^self new
		queryString: aString;
		yourself.

]

{ #category : #accessing }
GAQuery >> eventName [
	^#Query
]

{ #category : #printing }
GAQuery >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: '(';
		nextPutAll: 'queryString='; nextPutAll: queryString printString;
		nextPutAll: ')'
]

{ #category : #accessing }
GAQuery >> queryString [
	^queryString
]

{ #category : #accessing }
GAQuery >> queryString: aString [
	queryString := aString
]

{ #category : #sending }
GAQuery >> writeOn: aStream [

	self writeByte: $Q on: aStream.
	self writeString: self queryString on: aStream.

]
