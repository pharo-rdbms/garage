instance-creation
connectToConnectionString: aConnectionString

	| connection |
	connection := self fromConnectionString: aConnectionString.
	connection connect.
	^ connection