as yet unclassified
testConnectionStringWithLongWindowsHost

	| driver |
	driver := GAConnectionString fromString: 'opendbx:///C:\Users\guillermopolito\work\temp\dbxtalk\sodbxtest.db?backend=sqlite3'.
	self assert: driver host equals: ''.
	self assert: driver database equals: 'C:\Users\guillermopolito\work\temp\dbxtalk\sodbxtest.db'.