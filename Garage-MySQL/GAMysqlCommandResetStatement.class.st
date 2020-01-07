Class {
	#name : #GAMysqlCommandResetStatement,
	#superclass : #GAMysqlCommandBase,
	#instVars : [
		'statementId'
	],
	#category : 'Garage-MySQL-Protocol'
}

{ #category : #'as yet unclassified' }
GAMysqlCommandResetStatement >> commandArg [
	ByteArray streamContents: [:strm |
		strm 
		nextPut: (statementId digitAt: 1);
		nextPut: (statementId digitAt: 2);
		nextPut: (statementId digitAt: 3);
		nextPut: (statementId digitAt: 4).
		
		^ strm contents]
]

{ #category : #'as yet unclassified' }
GAMysqlCommandResetStatement >> commandCode [
	^ ComStmtReset 
	

]

{ #category : #'as yet unclassified' }
GAMysqlCommandResetStatement >> readResponse [
	| pkt |

	pkt := super readResponse.
	pkt isOkayOrError 
		ifTrue: [^ pkt] 
		ifFalse: [self error: 'Unrecognized response for command']
		
]

{ #category : #'as yet unclassified' }
GAMysqlCommandResetStatement >> statementId: idValue [ "4 byte integer"
	statementId := idValue
	
	
]
