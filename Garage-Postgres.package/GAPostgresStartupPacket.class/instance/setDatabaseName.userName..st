private-initialize
setDatabaseName: database userName: user

	^self
		version: (2 bitShift: 16); "major=2 minor=0"
		databaseName: database;
		userName: user;
		yourself