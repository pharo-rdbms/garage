as yet unclassified
testGetInsertedKeys
	| result statement generatedKey |
	conn supportsRetrievingGeneratedKeys ifFalse: [ self skip ].
	
	statement := conn createStatement: 'INSERT INTO student(username) VALUES (''guille'')'.

	result := statement execute.
	generatedKey := result generatedKey.
	
	self assert: generatedKey equals: 1.