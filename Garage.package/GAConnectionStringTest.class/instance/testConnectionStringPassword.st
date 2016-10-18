as yet unclassified
testConnectionStringPassword

	| driver |
	driver := GAConnectionString fromString: 'someDatabase://Host:1111?password=pa55w0rd'.
	self assert: driver password equals: 'pa55w0rd'.