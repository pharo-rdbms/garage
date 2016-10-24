private-sa
generateEvent: event to: receiver

	^self == receiver
		ifTrue: [self processEvent: event]
		ifFalse: [receiver queueEvent: event].
