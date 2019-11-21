Class {
	#name : #GAMysqlCommandSendLongData,
	#superclass : #GAMysqlCommandBase,
	#instVars : [
		'dataBytes',
		'statementId',
		'paramNum'
	],
	#category : 'Garage-Mysql-Protocol'
}

{ #category : #'as yet unclassified' }
GAMysqlCommandSendLongData >> commandArg [
	ByteArray streamContents: [:strm |
		strm 
			nextPut: (statementId digitAt: 1);
			nextPut: (statementId digitAt: 2);
			nextPut: (statementId digitAt: 3);
			nextPut: (statementId digitAt: 4).
		strm 
			nextPut: (paramNum digitAt: 1);
			nextPut: (paramNum digitAt: 2).
		strm nextPutAll: dataBytes.
		^ strm contents]
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommandSendLongData >> commandCode [
	^ ComStmtSendLongData 
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommandSendLongData >> dataBytes: aByteArray [
	dataBytes := aByteArray 
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommandSendLongData >> paramNum: aNumber [
	paramNum := aNumber
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommandSendLongData >> readResponse [
	"This command does not hae any response from server"
	^ nil
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommandSendLongData >> statementId: anId [
	statementId := anId
	
]
