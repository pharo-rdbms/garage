Class {
	#name : #GADriverManagerTest,
	#superclass : #TestCase,
	#category : 'Garage-Tests'
}

{ #category : #tests }
GADriverManagerTest >> testAccessingAvailableDriversYieldsDriver [

	| manager driver |
	manager := GADriverManager new.
	driver := GAMockDriver new.
	manager subscribeDriver: driver.
	
	self assert: (manager driverAt: driver driverId) equals: driver
]

{ #category : #tests }
GADriverManagerTest >> testAccessingUnavailableDriversRaisesError [
	| manager  |
	manager := GADriverManager new.
	self should: [manager driverAt: 1 ] raise: Error
]

{ #category : #tests }
GADriverManagerTest >> testAvailableDriversDoNotListCollectedDrivers [
	| manager driver |
	manager := GADriverManager new.
	manager subscribeDriver: GAMockDriver new.
	
	driver := nil.
	Smalltalk garbageCollect.
	self assert: manager availableDrivers equals: #()
]

{ #category : #tests }
GADriverManagerTest >> testAvailableDriversListsSubscribedDrivers [
	| manager driver id |
	manager := GADriverManager new.
	driver := GAMockDriver new.
	id := driver driverId.
	manager subscribeDriver: driver.
	
	self assert: manager availableDrivers equals: { id }
]

{ #category : #tests }
GADriverManagerTest >> testDriverManagerIsInitiallyEmpty [
	| manager |
	manager := GADriverManager new.
	self assert: manager availableDrivers equals: #()
]

{ #category : #tests }
GADriverManagerTest >> testSubscribe [

	| manager driver |
	manager := GADriverManager new.
	driver := GAMockDriver new.
	manager subscribeDriver: driver.
	
	self assert: (manager isAvailable: driver driverId)
]

{ #category : #tests }
GADriverManagerTest >> testSubscribeIsWeak [

	| manager driver id |
	manager := GADriverManager new.
	driver := GAMockDriver new.
	id := driver driverId.
	manager subscribeDriver: driver.
	
	driver := nil.
	Smalltalk garbageCollect.
	self assert: (manager isAvailable: id) not
]

{ #category : #tests }
GADriverManagerTest >> testSubscribeTwiceReplaces [

	| manager driver |
	manager := GADriverManager new.
	driver := GAMockDriver new.
	manager subscribeDriver: driver.
	manager subscribeDriver: driver.
	
	self assert: manager availableDrivers equals: { driver driverId }
]
