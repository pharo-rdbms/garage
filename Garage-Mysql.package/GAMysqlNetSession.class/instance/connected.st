testing
connected
	^ theStream ifNil: [false] ifNotNil: [theStream isConnected] 