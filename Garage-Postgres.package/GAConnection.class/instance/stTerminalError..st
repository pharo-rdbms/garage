private-states
stTerminalError: event

	result errorResponse: event.
	self closeSocket: socket.
	socket := nil.
