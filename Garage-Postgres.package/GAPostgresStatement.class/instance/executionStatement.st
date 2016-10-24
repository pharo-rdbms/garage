execute
executionStatement
	
	| argumentsString |
	prepared ifFalse: [ ^ statement ].
	
	"If not it means by the moment that we are a named prepared statement and we execute that"
	argumentsString := arguments
		ifEmpty: [ '' ]
		ifNotEmpty: [ '(''', (''', ''' join: (arguments collect: #asString)), ''')' ].

	^ 'EXECUTE ', (self propertyAt: #statementId), argumentsString