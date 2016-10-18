as yet unclassified
testConnectionStringUser

	| driver |
	driver := GAConnectionString fromString: 'someDatabase://Host:1111?user=username&password=password'.
	self assert: driver user equals: 'username'.