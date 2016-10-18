setting up
createSetupConnection

	setupConnection := GADriver connectToConnectionString: 
		((GAConnectionString fromString: setupConnectionString) addOptions: options).