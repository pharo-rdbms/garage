tests
testExecuteUsingConnectionDefaults

	useConnectionDefaults := true.
	self executeAll: #(
			'select timenow()'
			'select abs(-1)'
		).
