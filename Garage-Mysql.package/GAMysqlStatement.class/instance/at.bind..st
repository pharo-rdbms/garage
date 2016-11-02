as yet unclassified
at: anInteger bind: aValue
	
	prepared ifFalse: [ self error: 'this statement is not prepared' ].
	params at: anInteger put: (GAMysqlBindParam new connection: connection; bindValue: aValue)