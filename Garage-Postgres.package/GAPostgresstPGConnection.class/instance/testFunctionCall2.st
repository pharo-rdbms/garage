tests
testFunctionCall2

	| arg result |
	arg := self asFloat8Arg: -1.0.
	result :=  self functionCall: self oidAbs arguments: (OrderedCollection with: arg).
	self assert: result functionResult notNil.
	self assert: (self floatFromByteArray: result functionResult result) = 1.0.
