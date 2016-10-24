private-states
stTerminated: event

	self sendTerminate.
	self closeSocket: socket.
	socket := nil.
