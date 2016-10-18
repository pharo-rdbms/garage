as yet unclassified
configureMysql

	self
		configureFixtureWithConnectionString: 'mysql://localhost:3306/sodbxtest?user=sodbxtest&password=sodbxtest'
		andSetupConnectionString: 'mysql://localhost:3306?user=sodbxtest&password=sodbxtest'.