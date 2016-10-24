instance creation
hostname: host portno: port databaseName: database userName: user password: pwd extraArgs: extra debugTty: debug
	^(self new)
		hostname: host;
		portno: port;
		databaseName: database;
		userName: user;
		password: pwd;
		extraArgs: extra;
		debugTty: debug;
		yourself