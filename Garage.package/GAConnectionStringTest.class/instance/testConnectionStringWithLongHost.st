as yet unclassified
testConnectionStringWithLongHost

	| driver |
	driver := GAConnectionString fromString: 'opendbx:///Users/guillermopolito/work/temp/dbxtalk/sodbxtest.db?backend=sqlite3'.
	self assert: driver host equals: ''.
	self assert: driver database equals: 'Users/guillermopolito/work/temp/dbxtalk/sodbxtest.db'.