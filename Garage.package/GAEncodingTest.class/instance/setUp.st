running
setUp

	"super setUp."	
	fixture := Fixture ifNil: [ self createFixture ].
	
	(fixture driver supportsEncoding: self encoding) ifFalse: [ ^ self skip ].
	
	fixture setUp: {'encoding' -> self encoding} asDictionary.
	conn := fixture connection.