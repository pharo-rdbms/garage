accessing
fetchRows: num
	| cmd |
	cmd := GAMysqlCommandFetchRows onSession: connection netSession driver: connection.
	cmd driver: connection.
	cmd
		fetchListener: fetchListener;
		resultSetContext: rsContext;
		statementId: stmtId;
		numRows: num.		
	^ cmd execute
	 