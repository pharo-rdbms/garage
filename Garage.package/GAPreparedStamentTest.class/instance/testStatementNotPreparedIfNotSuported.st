as yet unclassified
testStatementNotPreparedIfNotSuported

	"If we send non-sense, drivers that support prepared statements will fail on preparation and the others will fail on execute as there is no real preparation"
	conn supportsPreparedStatements ifTrue: [ ^ self skip ].
	self should: [conn prepare: 'SELECT 1+1'] raise: Error.