initialization
buildDefaultConnectionArgs

	^ GAConnectionArgs
		hostname: 'localhost'
		portno: 5432
		databaseName: 'postgres'
		userName: 'postgres'
		password: 'postgres'
