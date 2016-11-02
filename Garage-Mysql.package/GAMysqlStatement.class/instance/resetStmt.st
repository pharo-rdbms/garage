accessing
resetStmt
	| cmd |
	cmd := GAMysqlCommandResetStatement onSession: connection netSession driver: connection.
	cmd statementId: stmtId.
	^ cmd execute.
	