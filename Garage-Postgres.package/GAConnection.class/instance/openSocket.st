private-actions
openSocket
	| newSocket |
	trace >= 2 
		ifTrue: 
			[self log: 'openSocket'
				text: 'hostname: ' , connectionArgs hostname , ':' 
						, connectionArgs portno printString].
	Socket initializeNetwork.
	newSocket := Socket newTCP.
	newSocket 
		connectTo: (NetNameResolver addressForName: connectionArgs hostname
				timeout: 15)
		port: connectionArgs portno.
	newSocket waitForConnectionFor: Socket standardTimeout ifTimedOut: [newSocket := nil].
	trace >= 2 
		ifTrue: [self log: 'openSocket' text: 'socket: ' , newSocket printString].
	^newSocket