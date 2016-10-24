private-states
stCantHappen: event
	"Try to send the terminate packet, then close the socket"

	self isConnected ifTrue: [ self sendTerminate ].
	socket isNil ifFalse: [ self closeSocket ].
	super stCantHappen: event.
