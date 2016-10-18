running
performTest

	(fixture driver supportsEncoding: self encoding) ifFalse: [ ^ self skip ].
	^ super performTest.