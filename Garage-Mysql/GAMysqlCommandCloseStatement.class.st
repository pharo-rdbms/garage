Class {
	#name : #GAMysqlCommandCloseStatement,
	#superclass : #GAMysqlCommandBase,
	#instVars : [
		'statementId'
	],
	#category : 'Garage-Mysql-Protocol'
}

{ #category : #'as yet unclassified' }
GAMysqlCommandCloseStatement >> commandArg [
	ByteArray streamContents: [:strm |
		strm 
		nextPut: (statementId digitAt: 1);
		nextPut: (statementId digitAt: 2);
		nextPut: (statementId digitAt: 3);
		nextPut: (statementId digitAt: 4).
		
		^ strm contents]
]

{ #category : #'as yet unclassified' }
GAMysqlCommandCloseStatement >> commandCode [
	^ ComStmtClose
	

]

{ #category : #'as yet unclassified' }
GAMysqlCommandCloseStatement >> readResponse [
	^ nil
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommandCloseStatement >> statementId: idValue [ "4 byte integer"
	statementId := idValue
	
	
]
