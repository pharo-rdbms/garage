as yet unclassified
testConnectionStringDatabase

	| driver |
	driver := GAConnectionString fromString: 'someDatabase://Host:1111/adatabase?user=username&password=password'.
	self assert: driver database equals: 'adatabase'.
	self assert: driver port equals: 1111.