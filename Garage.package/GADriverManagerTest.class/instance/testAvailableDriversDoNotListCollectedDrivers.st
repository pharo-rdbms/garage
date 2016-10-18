tests
testAvailableDriversDoNotListCollectedDrivers
	| manager driver |
	manager := GADriverManager new.
	manager subscribeDriver: GAMockDriver new.
	
	driver := nil.
	Smalltalk garbageCollect.
	self assert: manager availableDrivers equals: #()