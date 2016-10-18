as yet unclassified
testConnectionStringHost

	| driver |
	driver := GAConnectionString fromString: 'someDatabase://Host:1111/database?user=username&password=password'.
	self assert: driver host asLowercase equals: 'Host' asLowercase.