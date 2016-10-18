tests
testUnixLikeConnectionString

	| connectionString driver |
	connectionString := GAConnectionString new
		platform: UnixPlatform new;
		initializeFromString: 'sqlite3:///Users/guillermopolito/work/temp/dbxtalk/sodbxtest.db';
		yourself.
	driver := GASqlite3Driver fromConnectionString: connectionString.
	
	self assert: driver database equals: '/Users/guillermopolito/work/temp/dbxtalk/sodbxtest.db'