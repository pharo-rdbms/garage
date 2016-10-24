tests
createTestCopyInOutTable

	self executeAll: #(
			'CREATE TABLE TestCopyInOutTable (
				id integer,
				name text
			)'
		).
