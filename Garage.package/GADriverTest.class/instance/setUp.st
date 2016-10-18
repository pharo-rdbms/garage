running
setUp

	super setUp.
	fixture := Fixture ifNil: [ self createFixture ].
	fixture setUp.
	conn := fixture connection.