Class {
	#name : #GAMysqlRow,
	#superclass : #GARow,
	#instVars : [
		'columnDescriptors',
		'columnValues'
	],
	#category : 'Garage-MySQL-Driver'
}

{ #category : #accessing }
GAMysqlRow >> at: index [
	
	^ self atIndex: index
]

{ #category : #accessing }
GAMysqlRow >> at: index put: aValue [
	
	^ columnValues at: index put: aValue
]

{ #category : #accessing }
GAMysqlRow >> atIndex: indx [
	^ columnValues at: indx ifAbsent: [GAMysqlInvalidRowAccess signal: 'No data at this index']
]

{ #category : #accessing }
GAMysqlRow >> atName: aString [ 
	
	^ columnValues
		at: ((columnDescriptors collect: #name) indexOf: aString asString)
		ifAbsent: [GAMysqlInvalidRowAccess signal: 'No data at name: ', aString asString]
]

{ #category : #initializing }
GAMysqlRow >> columnDescriptors: aCollection [ 
	
	columnDescriptors := aCollection.
	self initializeColumnValues: aCollection size.
]

{ #category : #initializing }
GAMysqlRow >> initializeColumnValues: aCount [
	columnValues := Array new: aCount 
	
]

{ #category : #accessing }
GAMysqlRow >> values [
	
	^ columnValues
]
