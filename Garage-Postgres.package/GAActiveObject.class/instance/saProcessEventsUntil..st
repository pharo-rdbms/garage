private-sa
saProcessEventsUntil: newStates

	[
		[events size > 0] whileTrue: [
			self processEvent: events removeFirst.
		].
		(newStates includes: state) 
			ifFalse: [self generateEvent: self nextEvent to: self].
		(newStates includes: state) not
	] whileTrue.
