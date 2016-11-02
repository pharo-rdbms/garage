accessing
close
	| cmd |
	cmd := GAMysqlCommandCloseStatement onSession: connection netSession driver: connection.
	cmd statementId: stmtId.
	^ cmd execute.
	