bindings
at: anInteger bind: anObject
	
	prepared ifFalse: [ self error: 'A statement should be prepared to bind arguments' ].
	arguments add: anObject.