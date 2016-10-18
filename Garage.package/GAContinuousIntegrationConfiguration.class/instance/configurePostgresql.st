as yet unclassified
configurePostgresql

	self
		configureFixtureWithConnectionString: 'postgresV2://localhost:5432/sodbxtest?user=sodbxtest&password=sodbxtest'
		andSetupConnectionString: 'postgresV2://localhost:5432/postgres?user=postgres&password=postgres'.