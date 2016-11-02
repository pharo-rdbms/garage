testing
isConnected
	
	^ netSession isNil not and: [netSession connected]