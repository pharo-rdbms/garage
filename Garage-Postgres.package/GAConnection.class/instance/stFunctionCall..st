private-states
stFunctionCall: event

	self resetResult.
	self sendPacket: (GAFunctionCall oid: functionCallOid arguments: functionCallArgs) on: socket.
