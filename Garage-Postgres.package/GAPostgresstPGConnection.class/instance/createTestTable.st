tests
createTestTable

	self executeAll: #(
			'CREATE TABLE products (
				product_no integer,
				name text,
				price numeric
			)'
		).
