Class {
	#name : #GASqliteConnectionStringTest,
	#superclass : #TestCase,
	#category : 'Garage-SQLite3-Tests'
}

{ #category : #tests }
GASqliteConnectionStringTest >> testConnectionCreatesFileDatabase [

	| connectionString driver dbFile |
	
	dbFile := (FileLocator imageDirectory / 'database.db').
	self deny: dbFile exists.
	
	connectionString := GAConnectionString fromString: 'sqlite3:///', dbFile fullName.
	driver := GASQLite3Driver fromConnectionString: connectionString.
	driver connect.
	
	self assert: dbFile exists.
	driver close.
	dbFile ensureDelete.
]

{ #category : #tests }
GASqliteConnectionStringTest >> testMemoryDatabase [

	| driver |
	driver := GASQLite3Driver fromConnectionString: (GAConnectionString fromString: 'sqlite3://memory').
	self assert: driver database equals: ':memory:'.
	
	self deny: 'memory' asFileReference exists.
	self deny: ':memory:' asFileReference exists.
]

{ #category : #tests }
GASqliteConnectionStringTest >> testUnixLikeConnectionString [

	| connectionString driver |
	connectionString := GAConnectionString new
		platform: UnixPlatform new;
		initializeFromString: 'sqlite3:///Users/guillermopolito/work/temp/dbxtalk/sodbxtest.db';
		yourself.
	driver := GASQLite3Driver fromConnectionString: connectionString.
	
	self assert: driver database equals: '/Users/guillermopolito/work/temp/dbxtalk/sodbxtest.db'
]

{ #category : #tests }
GASqliteConnectionStringTest >> testWindowsLikeConnectionString [

	| connectionString driver |
	connectionString := GAConnectionString new
		platform: Win32Platform new;
		initializeFromString: 'sqlite3:///C:\Users\guillermopolito\work\temp\dbxtalk\sodbxtest.db';
		yourself.
	driver := GASQLite3Driver fromConnectionString: connectionString.
	
	self assert: driver database equals: 'C:\Users\guillermopolito\work\temp\dbxtalk\sodbxtest.db'
]
