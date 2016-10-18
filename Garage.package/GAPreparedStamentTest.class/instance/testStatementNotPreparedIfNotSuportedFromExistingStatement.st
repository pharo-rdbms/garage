as yet unclassified
testStatementNotPreparedIfNotSuportedFromExistingStatement

	"If we send non-sense, drivers that support prepared statements will fail on preparation and the others will fail on execute as there is no real preparation"
	| preparedStatement |
	conn supportsPreparedStatements ifTrue: [ ^ self skip ].
	preparedStatement := conn createStatement: 'SELECT 1+1'.
	self should: [ preparedStatement prepare ] raise: Error.