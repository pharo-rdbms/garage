private-actions
receivePacket

	| typeCode packet |

	typeCode := self next.
	trace >= 5
		ifTrue: [ self log: 'packet typeCode=' text: typeCode printString ].

	packet := GAPacket newPacket: typeCode.

	packet == nil
		ifTrue: [packet := #UnknownPacket]
		ifFalse: [packet receiveFrom: self ].

	trace >= 5
		ifTrue: [ self log: 'receivePacket' text: packet printString ].

	^ packet
