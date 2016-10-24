query
createStatement: aQuery
	
	| statement pgGoodQuery |
	pgGoodQuery := self pgGoodQuery: aQuery.
	statement := GAPostgresStatement onConnection: self.
	statement statementString: pgGoodQuery.
	^ statement