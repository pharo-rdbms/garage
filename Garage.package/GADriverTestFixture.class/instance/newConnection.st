setting up
newConnection

	^ GADriver connectToConnectionString: 
		((GAConnectionString fromString: connectionString) addOptions: options).