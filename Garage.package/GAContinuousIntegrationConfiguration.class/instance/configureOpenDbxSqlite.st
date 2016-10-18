as yet unclassified
configureOpenDbxSqlite

	self
		configureFixtureWithConnectionString: 'opendbx://memory?backend=sqlite3'
		andSetupConnectionString: 'opendbx://memory?backend=sqlite3'.