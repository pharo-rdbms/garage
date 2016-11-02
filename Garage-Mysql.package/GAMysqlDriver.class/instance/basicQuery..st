private
basicQuery: queryString
	
	| response qry |
	self assertConnection.		
	qry := GAMysqlCommandQuery onSession: netSession driver: self.
	qry driver: self.
	qry queryString: queryString.
	response := qry execute.
	response isError ifTrue: [ self error: response message ].	
	^ response