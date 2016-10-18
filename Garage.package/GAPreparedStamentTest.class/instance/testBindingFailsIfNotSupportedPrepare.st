as yet unclassified
testBindingFailsIfNotSupportedPrepare

	| statement |
	conn supportsPreparedStatements ifTrue: [ self skip ].
	statement := conn createStatement.
	statement statementString:  'SELECT * FROM CATS WHERE owner = ?'.
	self should: [ statement at: 1 bind: 'guille' ] raise: Error.