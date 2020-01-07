Class {
	#name : #GAMysqlError,
	#superclass : #GAMysqlResult,
	#instVars : [
		'fieldCount',
		'errNo',
		'sqlStateMarker',
		'sqlState',
		'message'
	],
	#category : 'Garage-MySQL-Protocol'
}

{ #category : #'as yet unclassified' }
GAMysqlError >> errNo [
	^ errNo 
]

{ #category : #'as yet unclassified' }
GAMysqlError >> isError [
	^ true
]

{ #category : #'as yet unclassified' }
GAMysqlError >> message [
	^ message 
]

{ #category : #'as yet unclassified' }
GAMysqlError >> parse [
	fieldCount := inStream next. "always 0xFF"
	errNo := inStream next + (inStream next bitShift: 8).	
	sqlStateMarker := inStream next asCharacter. "always #"
	sqlState := (inStream next: 5) asString .
	message := inStream upToEnd asString.

]

{ #category : #'as yet unclassified' }
GAMysqlError >> sqlState [
	^ sqlState 
]
