as yet unclassified
testConnectionStringWithInvertedSlashHost

	| driver |
	driver := GAConnectionString fromString: 'someDatabase:///c:\somepath'.
	self assert: driver host equals: ''.
	self assert: driver database equals: 'c:\somepath'.