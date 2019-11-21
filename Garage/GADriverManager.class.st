"
I am a simple driver manager that handle the subscriptions of database drivers. You can also ask a driver manager which are the installed drivers and get a driver by id.

Drivers are handled in a weak way: unloading a driver will eventually garbage collect the driver and the manager will be cleaned up.
"
Class {
	#name : #GADriverManager,
	#superclass : #Object,
	#instVars : [
		'drivers'
	],
	#category : 'Garage-Driver'
}

{ #category : #accessing }
GADriverManager >> availableDrivers [
	
	"Returns the available database drivers"
	self cleanUp.
	^ drivers keys
]

{ #category : #cleanup }
GADriverManager >> cleanUp [

	| toClean |
	"Private. Cleans up the current manager. If drivers were unloaded they will be removed from the manager on garbage collection."
	Smalltalk garbageCollect.
	toClean := drivers keys select: [ :key | (drivers at: key) isNil ].
	toClean do: [:key | drivers removeKey: key ]
]

{ #category : #drivers }
GADriverManager >> driverAt: aDriverId [
	
	"Returns the available driver with the id given as argument. If no driver is available with such id, an exception is risen."
	^ drivers at: aDriverId ifAbsent: [ self error: ('No driver configured with id {1}' format: { aDriverId }) ]
]

{ #category : #initialization }
GADriverManager >> initialize [

	super initialize.
	drivers := WeakValueDictionary new.
]

{ #category : #testing }
GADriverManager >> isAvailable: aDriverId [
	
	"Tests if a driver is available with the id given as argument."
	self cleanUp.
	^ drivers includesKey: aDriverId asLowercase asSymbol
]

{ #category : #drivers }
GADriverManager >> removeDriver: aDriver [

	drivers removeKey: aDriver driverId asLowercase asSymbol
]

{ #category : #drivers }
GADriverManager >> removeDriverById: aDriverId [

	drivers removeKey: aDriverId asLowercase asSymbol
]

{ #category : #drivers }
GADriverManager >> subscribeDriver: aDriver [

	"Subscribes weakly the driver given as argument in the current manager"
	drivers at: aDriver driverId asLowercase asSymbol put: aDriver
]
