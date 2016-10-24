private-initialize
setHostname: host portno: port databaseName: database userName: user password: pwd extraArgs: extra debugTty: debug

	hostname := host.
	portno := port.
	databaseName := database.
	userName := user.
	password := pwd.
	extraArgs := extra.
	debugTty := debug.
	^self