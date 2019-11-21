Class {
	#name : #GASqlite3ResultSet,
	#superclass : #GAResultSet,
	#instVars : [
		'db',
		'statement',
		'moreRows',
		'columnNames',
		'columnTypes',
		'rows',
		'affectedRows',
		'generatedKey'
	],
	#category : 'Garage-Sqlite3'
}

{ #category : #accessing }
GASqlite3ResultSet >> affectedRows [
	
	^ affectedRows
]

{ #category : #testing }
GASqlite3ResultSet >> at: anIndex [
	
	^ self rowAt: anIndex
]

{ #category : #iterating }
GASqlite3ResultSet >> collect: aBlockClosure [ 
	
	^ self rows collect: aBlockClosure
]

{ #category : #iterating }
GASqlite3ResultSet >> do: aBlockClosure [ 
	
	^ self rows do: aBlockClosure
]

{ #category : #'as yet unclassified' }
GASqlite3ResultSet >> execute: anSQLText with: anObject on: aDb [
	| obj |

	db := aDb.
	obj := anObject isNil ifTrue: [ #() ] ifFalse: [ anObject ].

	(obj isCollection)
		ifTrue: [ self execute: anSQLText withCollection: obj ]
		ifFalse: [
			(anObject respondsTo: #keysAndValuesDo:)
				ifTrue: [ self execute: anSQLText withKeysAndValues: obj ]
				ifFalse: [ GASqlite3Error signal: 'Unable to execute SQL on instance of ', obj class asString ]].

	affectedRows := GASqlite3FFI current changes: db handle.
]

{ #category : #'as yet unclassified' }
GASqlite3ResultSet >> execute: anSQLText withCollection: aCollection [
	| i |

	self prepareStatement: anSQLText.
	i := 1.
	aCollection do: [ :v | i := self execute: statement withIndex: i withValue: v ].
	moreRows := (statement step) = 100. " == SQLITE_ROW "
]

{ #category : #iterating }
GASqlite3ResultSet >> first [
	
	^ self rowAt: 1
]

{ #category : #accessing }
GASqlite3ResultSet >> generatedKey [

	^ generatedKey
]

{ #category : #accessing }
GASqlite3ResultSet >> generatedKey: anInteger [ 
	generatedKey := anInteger
]

{ #category : #accessing }
GASqlite3ResultSet >> indexOfColumnName: aName [

	^ columnNames keyAtValue: aName
]

{ #category : #initialization }
GASqlite3ResultSet >> initialize [
	"Initializes the receiver"
	
	super initialize.
	moreRows := true.
	columnNames := Dictionary new.
	columnTypes := Dictionary new.
]

{ #category : #testing }
GASqlite3ResultSet >> isEmpty [
	
	^ moreRows not and: [ rows isEmptyOrNil ]
]

{ #category : #accessing }
GASqlite3ResultSet >> isResultSet [

	^ columnNames notEmpty "If columns were brought"
]

{ #category : #iterating }
GASqlite3ResultSet >> next [
	| nc rr |

	statement ifNil: [ GASqlite3Misuse signal: 'This result set does not contain a prepared statement.' ].	

	moreRows ifTrue: [	
		nc := statement dataValuesAvailable.
		(nc = 0)
			ifTrue: [ ^ nil ] 
			ifFalse: [ 
				rr := GASqlite3Row new.
				rr resultSet: self.
				0 to: nc - 1 do: [ :c | rr at: c + 1 put: (statement valueOfColumn: c) ].
				"statement clearBindings." "XXX With this, the Glorp result set fails its test..."
				moreRows := (statement step) = 100. " == SQLITE_ROW "
				^ rr ]].
		
	^ nil
]

{ #category : #'as yet unclassified' }
GASqlite3ResultSet >> prepareStatement: anSQLText [

	statement isNil
		ifTrue: [ statement := db prepare: anSQLText ]
		ifFalse: [ statement clearBindings; reset ].

	1 to: statement columnCount do: [ :i |
		columnNames at: i put: (statement nameOfColumn: i -1 ).
		columnTypes at: i put: (statement typeOfColumn: i -1)].
]

{ #category : #streaming }
GASqlite3ResultSet >> readStream [
	
	^ GAResultSetReadStream on: self
]

{ #category : #testing }
GASqlite3ResultSet >> rowAt: anIndex [
	
	^ self rows at: anIndex
]

{ #category : #iterating }
GASqlite3ResultSet >> rows [

	| row |
	"we cache the result"
	rows ifNotNil: [ ^ rows ].
	
	rows := OrderedCollection new.
	[ row := self next. row notNil ] whileTrue: [ rows add: row ].
	^ rows
]

{ #category : #iterating }
GASqlite3ResultSet >> select: aBlockClosure [ 
	
	^ self rows select: aBlockClosure
]

{ #category : #accessing }
GASqlite3ResultSet >> statement: aStatement [

	statement := aStatement
]
