as yet unclassified
testStatementDoesNotAcceptBindings

	| statementString statement |
	statementString := 'CREATE TABLE CATS (
	name varchar(50),
	owner varchar(50))'.
	statement := conn createStatement: statementString.
	
	self should: [ statement at: 1 bind: 'unbinded' ] raise: Error.