as yet unclassified
testResultOfDDL
	
	| result |
	result := conn execute: 'CREATE TABLE CATS (
		name varchar(50),
		owner varchar(50))'.

	self assert: result affectedRows = 0.