tests
testExecute2

	self executeAll: #(
			'select timenow(); select abs(-1)'
		).
