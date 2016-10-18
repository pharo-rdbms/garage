accessing
currentRow
	
	"Gets the current row of the stream"
	self flag: #possibleBug.
	^ [ resultSet rowAt: position ] on: SubscriptOutOfBounds do: [ nil ]