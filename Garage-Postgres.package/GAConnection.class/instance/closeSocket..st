private-actions
closeSocket: aSocket

	trace >= 2
		ifTrue: [ self log: 'closeSocket' text: 'hostname: ', connectionArgs hostname, ':', connectionArgs portno printString ].
	trace >= 2
		ifTrue: [ self log: 'closeSocket' text: 'socket: ', aSocket printString ].

	aSocket closeAndDestroy.

	trace >= 2
		ifTrue: [ self log: 'closeSocket' text: 'socket: ', aSocket printString ].
