as yet unclassified
testStatementNotPreparedIfNotSuportedFromExistingUninitializedStatement

	"If we send non-sense, drivers that support prepared statements will fail on preparation and the others will fail on execute as there is no real preparation"
	| statement |
	conn supportsPreparedStatements ifTrue: [ ^ self skip ].
	statement := conn createStatement.
	statement statementString: 'SELECT 1+1'.
	self should: [ conn prepare ] raise: Error.