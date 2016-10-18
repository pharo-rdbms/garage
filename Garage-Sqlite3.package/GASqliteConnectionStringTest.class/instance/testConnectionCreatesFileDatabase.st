tests
testConnectionCreatesFileDatabase

	| connectionString driver dbFile |
	
	dbFile := (FileLocator imageDirectory / 'database.db').
	self deny: dbFile exists.
	
	connectionString := GAConnectionString fromString: 'sqlite3:///', dbFile fullName.
	driver := GASqlite3Driver fromConnectionString: connectionString.
	driver connect.
	
	self assert: dbFile exists.
	driver close.
	dbFile ensureDelete.