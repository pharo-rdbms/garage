instance-creation
fromConnectionString: aConnectionString

	^ self new
		connectionString: aConnectionString;
		database: (aConnectionString host = 'memory' ifTrue: [ ':memory:' ] ifFalse: [ (aConnectionString databasePath) urlDecoded ]);
		yourself