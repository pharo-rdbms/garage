private-sa
stCantHappen: event
	"Handle a defective state machine."

	self error: self class name, ' has a defective state machine'.
