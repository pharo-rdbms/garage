private-actions
sendStartup

	self sendPacket: (GAPostgresStartupPacket databaseName: connectionArgs databaseName userName: connectionArgs userName) on: socket.
