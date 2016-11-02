as yet unclassified
execute
	| cmd resp |
	
	cursoredFetch ifTrue: [ self prepare ].
	
	prepared ifFalse: [ 
		fetchListener ifNotNilDo: #fetchOccurred.
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