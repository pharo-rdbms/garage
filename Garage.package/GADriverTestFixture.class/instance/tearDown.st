setting up
tearDown

	options := nil.
	[connection ifNotNil: [ 
		connection close.
		connection := nil. ].]
		ensure: [
		[self dropDatabase.]
			ensure: [
			setupConnection ifNotNil: [
			setupConnection close.
			setupConnection := nil ]]]