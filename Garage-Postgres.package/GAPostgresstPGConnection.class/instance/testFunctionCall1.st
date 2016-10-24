tests
testFunctionCall1

	| result |
	result := self functionCall: self oidTimenow arguments: OrderedCollection new.
	self assert: result functionResult notNil.
