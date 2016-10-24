private-actions
sendCancel

	| cancelRequestSocket |

	trace >= 2
		ifTrue: [ self log: 'sendCancel' text: 'processId=', processId printString ].

	cancelRequestSocket := self openSocket.
	self sendPacket: (GACancelRequest processId: processId secretKey: secretKey) on: cancelRequestSocket.
	self closeSocket: cancelRequestSocket.
