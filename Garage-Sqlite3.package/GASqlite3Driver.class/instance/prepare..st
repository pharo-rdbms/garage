query
prepare: anSQLText 
	| s |
	
	s := self createStatement.
	s statementString: anSQLText.
	s prepare.
	^ s