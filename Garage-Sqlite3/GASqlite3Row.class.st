Class {
	#name : #GASqlite3Row,
	#superclass : #GARow,
	#instVars : [
		'data',
		'resultSet'
	],
	#category : 'Garage-Sqlite3'
}

{ #category : #accessing }
GASqlite3Row >> at: aKey [ 
	^ self at: aKey ifAbsent: [  ]
]

{ #category : #accessing }
GASqlite3Row >> at: aKey ifAbsent: aBlock [
	^ data at: aKey ifAbsent: aBlock
]

{ #category : #accessing }
GASqlite3Row >> at: aKey put: anObject [
	data at: aKey put: anObject
]

{ #category : #'as yet unclassified' }
GASqlite3Row >> atIndex: anInteger [ 
	
	^ self at: anInteger
]

{ #category : #'as yet unclassified' }
GASqlite3Row >> atName: aKey [ 
	^ self at: (resultSet indexOfColumnName: aKey) ifAbsent: [  ]
]

{ #category : #'reflective operations' }
GASqlite3Row >> doesNotUnderstand: aMessage [

	^self 
		at: aMessage selector asString 
		ifAbsent: [ super doesNotUnderstand: aMessage ]
]

{ #category : #initialization }
GASqlite3Row >> initialize [
	"Initializes the receiver"
	
	super initialize.
	data := Dictionary new
]

{ #category : #'as yet unclassified' }
GASqlite3Row >> resultSet: aResultSet [

	resultSet := aResultSet
]

{ #category : #'as yet unclassified' }
GASqlite3Row >> values [

	^ data keys sorted collect: [ :k | self at: k ]
]
