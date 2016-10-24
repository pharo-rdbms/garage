connection
connect

	| response |
	driver := GAConnection new
		connectionArgs: connectionSpec;
		clientEncoding: self encoding asSymbol;
		yourself.
	response := driver startup.
	(response errorResponse isKindOf: GAErrorResponse)
		ifTrue: [ self error: response errorResponse value ].
	self register.