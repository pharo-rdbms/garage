as yet unclassified
testConnectionStringDefaultDatabase

	| driver |
	driver := GAConnectionString fromString: 'someDatabase://Host:1111?user=username&password=password'.
	self assert: driver database equals: ''.