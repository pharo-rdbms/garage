as yet unclassified
testConnectionStringDefaultPassword

	| driver |
	driver := GAConnectionString fromString: 'someDatabase://Host:1111'.
	self assert: driver password = ''.