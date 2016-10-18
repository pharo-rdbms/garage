as yet unclassified
testConnectionStringPort

	| driver |
	driver := GAConnectionString fromString: 'someDatabase://Host:1111/database?user=username&password=password'.
	self assert: driver port equals: 1111.