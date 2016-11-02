statements
createStatement: aSqlStatement
	
	^ self createStatement
		statementString: aSqlStatement;
		yourself