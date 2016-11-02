reading
validatePacket: pkt
	"Validate a network packet unit. Currently we validate the sequence number."
	"Update sequence if validation passes"
	(self validateSequence: pkt number)
		ifTrue: [self updateSequence]
		ifFalse: [^ self error: 'Packet sequence validation error']
	