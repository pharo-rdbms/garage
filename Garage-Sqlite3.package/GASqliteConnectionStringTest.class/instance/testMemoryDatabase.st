tests
testMemoryDatabase

	| driver |
	driver := GASqlite3Driver fromConnectionString: (GAConnectionString fromString: 'sqlite3://memory').
	self assert: driver database equals: ':memory:'.
	
	self deny: 'memory' asFileReference exists.
	self deny: ':memory:' asFileReference exists.