"
I represent an SQLite non-ok condition.
"
Class {
	#name : #GASqlite3Error,
	#superclass : #Error,
	#instVars : [
		'resultCode'
	],
	#category : 'Garage-Sqlite3-Errors'
}

{ #category : #accessing }
GASqlite3Error >> resultCode [
	^ resultCode
]

{ #category : #accessing }
GASqlite3Error >> resultCode: anObject [
	resultCode := anObject
]
