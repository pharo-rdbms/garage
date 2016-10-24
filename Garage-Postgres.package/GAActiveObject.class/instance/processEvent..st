private-sa
processEvent: event

	| nextState eventName eventNameString traceText |

	eventName := event isSymbol ifTrue: [event] ifFalse: [event eventName].
	nextState := (self stateTransitionTable at: state)
		at: eventName
		ifAbsent: [ #CantHappen ].

	trace >= 8 ifTrue: [
		eventNameString := event isSymbol ifTrue: [event asString] ifFalse: [event eventName].
		traceText := nextState = #EventIgnored
			ifTrue: [ state asString, ' IGNORE ', eventNameString ]
			ifFalse: [ state asString, '-->', nextState asString, ' on ', eventNameString ].
		self log: 'processEvent' text: traceText.
	].

	nextState = #EventIgnored
		ifFalse: [
			state := nextState.
			self perform: ('st', state asString, ':') asSymbol with: event.
		].
