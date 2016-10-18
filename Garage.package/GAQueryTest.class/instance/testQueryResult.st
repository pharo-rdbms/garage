as yet unclassified
testQueryResult
	| select result |

	select:= 'SELECT * FROM signature'.
	result := conn execute: select.
	
	self assert: result isEmpty.