tests
testSubscribeIsWeak

	| manager driver id |
	manager := GADriverManager new.
	driver := GAMockDriver new.
	id := driver driverId.
	manager subscribeDriver: driver.
	
	driver := nil.
	Smalltalk garbageCollect.
	self assert: (manager isAvailable: id) not