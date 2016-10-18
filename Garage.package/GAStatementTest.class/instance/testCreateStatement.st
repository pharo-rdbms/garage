as yet unclassified
testCreateStatement

	| statementString statement |
	statementString := 'CREATE TABLE CATS (
	name varchar(50),
	owner varchar(50))'.
	statement := conn createStatement: statementString.
	
	self assert: statement notNil.
	self assert: statement statementString equals: statementString.