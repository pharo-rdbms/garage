as yet unclassified
setupConnectionString: setupConnectionString connectionString: connectionString

	| theConnectionString |
	theConnectionString := GAConnectionString fromString: setupConnectionString.
	^ ((GADriver driverAt: theConnectionString driverId)
			newFixtureForConnectionString: theConnectionString)
			setupConnectionString: setupConnectionString;
			connectionString: connectionString;
			yourself