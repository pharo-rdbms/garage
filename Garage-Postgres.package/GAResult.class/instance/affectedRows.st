accessing
affectedRows
	
	^ self resultSets first completedResponse value substrings last asInteger ifNil: [ 0 ]