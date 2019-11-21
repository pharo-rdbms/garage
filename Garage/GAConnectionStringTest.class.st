Class {
	#name : #GAConnectionStringTest,
	#superclass : #TestCase,
	#instVars : [
		'conn'
	],
	#category : 'Garage-Tests'
}

{ #category : #'as yet unclassified' }
GAConnectionStringTest >> testConnectionPortInSimpleConnectionString [

	| driver |
	driver := GAConnectionString fromString: 'someDatabase://Host:1111'.
	self assert: driver port equals: 1111.
]

{ #category : #'as yet unclassified' }
GAConnectionStringTest >> testConnectionStringDatabase [

	| driver |
	driver := GAConnectionString fromString: 'someDatabase://Host:1111/adatabase?user=username&password=password'.
	self assert: driver database equals: 'adatabase'.
	self assert: driver port equals: 1111.
]

{ #category : #'as yet unclassified' }
GAConnectionStringTest >> testConnectionStringDefaultDatabase [

	| driver |
	driver := GAConnectionString fromString: 'someDatabase://Host:1111?user=username&password=password'.
	self assert: driver database equals: ''.
]

{ #category : #'as yet unclassified' }
GAConnectionStringTest >> testConnectionStringDefaultPassword [

	| driver |
	driver := GAConnectionString fromString: 'someDatabase://Host:1111'.
	self assert: driver password = ''.
]

{ #category : #'as yet unclassified' }
GAConnectionStringTest >> testConnectionStringDefaultUser [

	| driver |
	driver := GAConnectionString fromString: 'someDatabase://Host:1111?password=password'.
	self assert: driver user = ''.
]

{ #category : #'as yet unclassified' }
GAConnectionStringTest >> testConnectionStringHost [

	| driver |
	driver := GAConnectionString fromString: 'someDatabase://Host:1111/database?user=username&password=password'.
	self assert: driver host asLowercase equals: 'Host' asLowercase.
]

{ #category : #'as yet unclassified' }
GAConnectionStringTest >> testConnectionStringPassword [

	| driver |
	driver := GAConnectionString fromString: 'someDatabase://Host:1111?password=pa55w0rd'.
	self assert: driver password equals: 'pa55w0rd'.
]

{ #category : #'as yet unclassified' }
GAConnectionStringTest >> testConnectionStringPort [

	| driver |
	driver := GAConnectionString fromString: 'someDatabase://Host:1111/database?user=username&password=password'.
	self assert: driver port equals: 1111.
]

{ #category : #'as yet unclassified' }
GAConnectionStringTest >> testConnectionStringUser [

	| driver |
	driver := GAConnectionString fromString: 'someDatabase://Host:1111?user=username&password=password'.
	self assert: driver user equals: 'username'.
]

{ #category : #'as yet unclassified' }
GAConnectionStringTest >> testConnectionStringWithInvertedSlashHost [

	| driver |
	driver := GAConnectionString fromString: 'someDatabase:///c:\somepath'.
	self assert: driver host equals: ''.
	self assert: driver database equals: 'c:\somepath'.
]

{ #category : #'as yet unclassified' }
GAConnectionStringTest >> testConnectionStringWithLongHost [

	| driver |
	driver := GAConnectionString fromString: 'opendbx:///Users/guillermopolito/work/temp/dbxtalk/sodbxtest.db?backend=sqlite3'.
	self assert: driver host equals: ''.
	self assert: driver database equals: 'Users/guillermopolito/work/temp/dbxtalk/sodbxtest.db'.
]

{ #category : #'as yet unclassified' }
GAConnectionStringTest >> testConnectionStringWithLongWindowsHost [

	| driver |
	driver := GAConnectionString fromString: 'opendbx:///C:\Users\guillermopolito\work\temp\dbxtalk\sodbxtest.db?backend=sqlite3'.
	self assert: driver host equals: ''.
	self assert: driver database equals: 'C:\Users\guillermopolito\work\temp\dbxtalk\sodbxtest.db'.
]
