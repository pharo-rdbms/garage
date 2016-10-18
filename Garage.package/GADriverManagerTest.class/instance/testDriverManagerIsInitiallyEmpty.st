tests
testDriverManagerIsInitiallyEmpty
	| manager |
	manager := GADriverManager new.
	self assert: manager availableDrivers equals: #()