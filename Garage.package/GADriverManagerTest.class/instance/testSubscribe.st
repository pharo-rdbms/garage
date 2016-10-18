tests
testSubscribe

	| manager driver |
	manager := GADriverManager new.
	driver := GAMockDriver new.
	manager subscribeDriver: driver.
	
	self assert: (manager isAvailable: driver driverId)