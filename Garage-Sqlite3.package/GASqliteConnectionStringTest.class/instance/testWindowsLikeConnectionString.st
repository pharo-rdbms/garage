tests
testWindowsLikeConnectionString

	| connectionString driver |
	connectionString := GAConnectionString new
		platform: Win32Platform new;
		initializeFromString: 'sqlite3:///C:\Users\guillermopolito\work\temp\dbxtalk\sodbxtest.db';
		yourself.
	driver := GASqlite3Driver fromConnectionString: connectionString.
	
	self assert: driver database equals: 'C:\Users\guillermopolito\work\temp\dbxtalk\sodbxtest.db'