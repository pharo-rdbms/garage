tests
testEncoder

	self assert: conn encoder equals: (ZnCharacterEncoder newForEncoding: self encoding)