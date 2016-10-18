as yet unclassified
testCreateStatementWithoutStatementString

	| statementString statement |
	statementString := 'CREATE TABLE CATS (
	name varchar(50),
	owner varchar(50))'.
	statement := conn createStatement.
	statement statementString: statementString.	

	self assert: statement notNil.
	self assert: statement statementString equals: statementString.