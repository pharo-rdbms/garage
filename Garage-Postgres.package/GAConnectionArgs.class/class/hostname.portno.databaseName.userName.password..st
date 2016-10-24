instance creation
hostname: host portno: port databaseName: database userName: user password: pwd
	^(self new)
		hostname: host;
		portno: port;
		databaseName: database;
		userName: user;
		password: pwd;
		yourself