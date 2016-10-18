as yet unclassified
testConnectionPortInSimpleConnectionString

	| driver |
	driver := GAConnectionString fromString: 'someDatabase://Host:1111'.
	self assert: driver port equals: 1111.