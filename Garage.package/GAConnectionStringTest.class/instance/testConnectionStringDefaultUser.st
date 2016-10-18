as yet unclassified
testConnectionStringDefaultUser

	| driver |
	driver := GAConnectionString fromString: 'someDatabase://Host:1111?password=password'.
	self assert: driver user = ''.