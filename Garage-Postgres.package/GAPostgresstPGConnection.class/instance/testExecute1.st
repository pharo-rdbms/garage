tests
testExecute1

	self executeAll: #(
			'select timenow()'
			'select abs(-1)'
		).
