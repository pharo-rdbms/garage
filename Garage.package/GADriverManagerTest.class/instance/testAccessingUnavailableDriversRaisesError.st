tests
testAccessingUnavailableDriversRaisesError
	| manager  |
	manager := GADriverManager new.
	self should: [manager driverAt: 1 ] raise: Error