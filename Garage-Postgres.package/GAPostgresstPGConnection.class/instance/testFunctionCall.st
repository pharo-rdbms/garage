tests
testFunctionCall
	"Test: make several function calls before terminating."

	| conn result arg |
	arg := self asFloat8Arg: 1.0.
	conn := self newConnection.
	conn startup.
	result := conn functionCall: self oidTimenow arguments: OrderedCollection new.
	result := conn functionCall: self oidAbs arguments: (OrderedCollection with: arg).
	result := conn functionCall: self oidSqrt arguments: (OrderedCollection with: arg).
	conn terminate.
	^ result
