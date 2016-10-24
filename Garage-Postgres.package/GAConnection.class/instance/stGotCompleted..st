private-states
stGotCompleted: event

	result completedResponse: event.

	"This causes an extra result set to be added.
	But a result set has to be available at this point,
	given the current state machine.
	"
	result addResultSet.
