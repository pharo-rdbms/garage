Class {
	#name : #GAMysqlEof,
	#superclass : #GAMysqlPacket,
	#instVars : [
		'fieldCount',
		'warningCount',
		'serverStatus'
	],
	#category : 'Garage-MySQL-Protocol'
}

{ #category : #'as yet unclassified' }
GAMysqlEof >> hasLastRowSent [
	^ (serverStatus bitAnd: GAMysqlServerStatusConstants statusLastRowSent) ~= 0
	
]

{ #category : #'as yet unclassified' }
GAMysqlEof >> hasMoreResults [
	^ (serverStatus bitAnd: GAMysqlServerStatusConstants moreResultsExist) ~= 0
	
]

{ #category : #'as yet unclassified' }
GAMysqlEof >> hasOpenCursor [
	^ (serverStatus bitAnd: GAMysqlServerStatusConstants statusCursorExists) ~= 0
	
]

{ #category : #'as yet unclassified' }
GAMysqlEof >> isEof [
	^ true
]

{ #category : #'as yet unclassified' }
GAMysqlEof >> parse [
	fieldCount := inStream next.
	warningCount := inStream next + (inStream next bitShift: 8).
	serverStatus := inStream next + (inStream next bitShift: 8).

]

{ #category : #'as yet unclassified' }
GAMysqlEof >> serverStatus [
	^ serverStatus 
]

{ #category : #'as yet unclassified' }
GAMysqlEof >> warningCount [
	^ warningCount 
]
