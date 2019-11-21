Class {
	#name : #GAMysqlStatement,
	#superclass : #GAStatement,
	#instVars : [
		'stmtId',
		'params',
		'rsContext',
		'cursoredFetch',
		'fetchSize'
	],
	#category : 'Garage-Mysql-Driver'
}

{ #category : #'as yet unclassified' }
GAMysqlStatement >> at: anInteger bind: aValue [
	
	prepared ifFalse: [ self error: 'this statement is not prepared' ].
	params at: anInteger put: (GAMysqlBindParam new connection: connection; bindValue: aValue)
]

{ #category : #accessing }
GAMysqlStatement >> close [
	| cmd |
	cmd := GAMysqlCommandCloseStatement onSession: connection netSession driver: connection.
	cmd statementId: stmtId.
	^ cmd execute.
	
]

{ #category : #accessing }
GAMysqlStatement >> cursoredFetch [
	^ cursoredFetch
]

{ #category : #accessing }
GAMysqlStatement >> cursoredFetch: aBoolean [ 
	cursoredFetch := aBoolean
]

{ #category : #'as yet unclassified' }
GAMysqlStatement >> execute [
	| cmd resp |
	
	cursoredFetch ifTrue: [ self prepare ].
	
	prepared ifFalse: [ 
		fetchListener ifNotNil: #fetchOccurred.
		^ connection basicQuery: statement ].
	
	resp := self resetStmt.
	resp isError ifTrue: [ ^ resp ].
	self sendLongData.
	cmd := GAMysqlCommandExecute onSession: connection netSession driver: connection.
	cmd driver: connection.
	cmd
		fetchListener: fetchListener;
		cursoredFetch: cursoredFetch;
		statementId: stmtId;
		params: params values asArray.
	resp := cmd execute.
	resp isError ifTrue: [ self error: resp message ].
	
	
	rsContext := resp isResultSet 
		ifTrue: [ 
			resp statement: self.
			resp fetchListener: fetchListener.
			resp ]
		ifFalse: [ nil ].
	^ resp
]

{ #category : #accessing }
GAMysqlStatement >> fetchListener: aGAFetchListener [

	fetchListener := aGAFetchListener
]

{ #category : #accessing }
GAMysqlStatement >> fetchRows: num [
	| cmd |
	cmd := GAMysqlCommandFetchRows onSession: connection netSession driver: connection.
	cmd driver: connection.
	cmd
		fetchListener: fetchListener;
		resultSetContext: rsContext;
		statementId: stmtId;
		numRows: num.		
	^ cmd execute
	 
]

{ #category : #accessing }
GAMysqlStatement >> fetchSize [
	
	^ fetchSize
]

{ #category : #cursor }
GAMysqlStatement >> fetchSize: anInteger [ 
	
	self cursoredFetch: true.
	fetchSize := anInteger
]

{ #category : #'as yet unclassified' }
GAMysqlStatement >> initialize [
	super initialize.
	params := Dictionary new.
	cursoredFetch := false.
]

{ #category : #accessing }
GAMysqlStatement >> params: bindParams [
	params := bindParams
	
]

{ #category : #accessing }
GAMysqlStatement >> prepare [

	| response |
	super prepare.
	response := connection basicPrepare: statement.
	response isError ifTrue: [ self error: response message ].

	self stmtId: response prepareOkay stmtHandlerId.
	^ self
]

{ #category : #accessing }
GAMysqlStatement >> resetStmt [
	| cmd |
	cmd := GAMysqlCommandResetStatement onSession: connection netSession driver: connection.
	cmd statementId: stmtId.
	^ cmd execute.
	
]

{ #category : #'as yet unclassified' }
GAMysqlStatement >> sendLongData [

	params keysAndValuesDo: [ :indx :aParam |
		aParam isLongData ifTrue: [
			self sendLongParam: aParam withNum: indx - 1. "first param index is 0"
			aParam sentAsLongData: true "mark that it has been sent as long data"]]
	
]

{ #category : #private }
GAMysqlStatement >> sendLongParam: aParam withNum: paramNum [
	| cmd dataStream dataPart |
	
	dataStream := ReadStream on: aParam stringOrBlobBytesRaw.
	[
		dataPart := dataStream next: 1048576. "1 MB; default"
		cmd := GAMysqlCommandSendLongData onSession: connection netSession driver: connection.
		cmd 
			paramNum: paramNum;
			statementId: stmtId; 
			dataBytes: dataPart.
		cmd execute] doWhileFalse: [dataStream atEnd]
	
]

{ #category : #accessing }
GAMysqlStatement >> stmtId: anId [
	stmtId := anId
	
]
