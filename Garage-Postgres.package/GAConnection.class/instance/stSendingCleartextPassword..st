private-states
stSendingCleartextPassword: event

	self sendPacket: (GAPasswordPacket password: connectionArgs password) on: socket.
