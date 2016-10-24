private-actions
sendPacket: aPacket on: aSocket

	| s |
	s := WriteStream on: String new.
	aPacket writeOn: s.

	trace >= 5
		ifTrue: [
			self log: 'sendPacket' text: aPacket printString.
			trace >= 10 ifTrue: [self log: 'sendPacket' text: s contents printString].
		].

	aSocket sendData: s contents.
