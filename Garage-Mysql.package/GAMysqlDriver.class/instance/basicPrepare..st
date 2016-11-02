statements
basicPrepare: aQuery

	| prepStmt prepResp |
	self assertConnection.		
	prepStmt := GAMysqlCommandPrepareStatement onSession: netSession driver: self.
	prepStmt queryString: aQuery.
	prepResp := prepStmt execute. "error or prepare reponse"
	^ prepResp