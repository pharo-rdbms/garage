tests
testAvailableDriversListsSubscribedDrivers
	| manager driver id |
	manager := GADriverManager new.
	driver := GAMockDriver new.
	id := driver driverId.
	manager subscribeDriver: driver.
	
	self assert: manager availableDrivers equals: { id }