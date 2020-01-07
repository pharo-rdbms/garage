Class {
	#name : #GAStatementOptions,
	#superclass : #GADriverTest,
	#category : 'Garage-Tests'
}

{ #category : #'as yet unclassified' }
GAStatementOptions >> testGetInsertedKeys [
	| result statement generatedKey |
	conn supportsRetrievingGeneratedKeys ifFalse: [ self skip ].
	
	statement := conn createStatement: 'INSERT INTO student(username) VALUES (''guille'')'.

	result := statement execute.
	generatedKey := result generatedKey.
	
	self assert: generatedKey equals: 1.
]
