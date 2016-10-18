tests
testSubscribeTwiceReplaces

	| manager driver |
	manager := GADriverManager new.
	driver := GAMockDriver new.
	manager subscribeDriver: driver.
	manager subscribeDriver: driver.
	
	self assert: manager availableDrivers equals: { driver driverId }