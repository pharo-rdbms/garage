tests
testAccessingAvailableDriversYieldsDriver

	| manager driver |
	manager := GADriverManager new.
	driver := GAMockDriver new.
	manager subscribeDriver: driver.
	
	self assert: (manager driverAt: driver driverId) equals: driver