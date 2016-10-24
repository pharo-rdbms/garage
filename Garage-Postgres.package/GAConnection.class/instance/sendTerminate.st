private-actions
sendTerminate

	self sendPacket: GAPostgresTerminate new on: socket.
