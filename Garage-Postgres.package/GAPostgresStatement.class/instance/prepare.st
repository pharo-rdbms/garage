execute
prepare

	| statementId |
	super prepare.
	
	statementId := 'preparedStmt', UUID new asString36.
	connection basicQuery: 'PREPARE ', statementId, ' AS ', self statementString.
	self propertyAt: #statementId put: statementId.
	
	^ self