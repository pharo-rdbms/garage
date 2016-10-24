private-states
stQuerying: event
	self resetResult.
	self sendPacket: (GAQuery sql: sql) on: socket.
