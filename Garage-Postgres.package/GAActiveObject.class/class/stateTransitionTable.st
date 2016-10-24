stt
stateTransitionTable

	stateTransitionTable == nil ifTrue: [stateTransitionTable := self buildStateTransitionTable].
	^ stateTransitionTable
