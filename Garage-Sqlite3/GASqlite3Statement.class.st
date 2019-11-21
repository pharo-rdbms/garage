"
I represent an SQLite prepared statement.
"
Class {
	#name : #GASqlite3Statement,
	#superclass : #GAStatement,
	#instVars : [
		'handle'
	],
	#category : 'Garage-Sqlite3'
}

{ #category : #'instance finalization' }
GASqlite3Statement class >> finalizeResourceData: aHandle [
	NBSQLite3FFI current apiFinalize: aHandle.
]

{ #category : #'as yet unclassified' }
GASqlite3Statement >> at: aColumn bind: anObject [

	| result |
	result := self basicBind: aColumn toObject: anObject.
	GASqlite3FFI current checkForOk: result on: connection handle.
]

{ #category : #public }
GASqlite3Statement >> at: aColumn putByteArray: anObject [
	^ GASqlite3FFI current with: handle at: aColumn putBlob: anObject
]

{ #category : #public }
GASqlite3Statement >> at: aColumn putFloat: aFloat [
	^ GASqlite3FFI current with: handle at: aColumn putFloat: aFloat
]

{ #category : #public }
GASqlite3Statement >> at: aColumn putInteger: anInteger [
	^ GASqlite3FFI current with: handle at: aColumn putInteger: anInteger
]

{ #category : #public }
GASqlite3Statement >> at: aColumn putNil: anObject [
	"Goofy interface note - anObject is ignored here. When used by NBSQLite3Connection, anObject will always be nil."
	^ GASqlite3FFI current with: handle putNullAt: aColumn
]

{ #category : #public }
GASqlite3Statement >> at: aColumn putObject: anObject [
	^ GASqlite3FFI current with: handle at: aColumn putBlob: (FLSerializer serializeToByteArray: anObject)
]

{ #category : #public }
GASqlite3Statement >> at: aColumn putString: aString [
	^ GASqlite3FFI current with: handle at: aColumn putString: aString
]

{ #category : #'as yet unclassified' }
GASqlite3Statement >> basicBind: aColumn toObject: anObject [

	(anObject isKindOf: ByteString)
		ifTrue: [ ^ self at: aColumn putString: anObject ].
	(anObject isKindOf: Float)
		ifTrue: [ ^ self at: aColumn putFloat: anObject ].
	(anObject isKindOf: ByteArray)
		ifTrue: [ ^ self at: aColumn putByteArray: anObject ].
	(anObject isNil)
		ifTrue: [ ^ self at: aColumn putNil: anObject ].
	(anObject isKindOf: Integer)
		ifTrue: [ ^ self at: aColumn putInteger: anObject ].
	^ self at: aColumn putObject: anObject
]

{ #category : #public }
GASqlite3Statement >> basicExecute: aBlock [
	| ret |
	
	ret := self step. 
	(ret = 101) " == SQLITE_DONE, meaning step should not be sent again."
		ifTrue: [ aBlock value: self ]
		ifFalse: [
			[ ret = 100 ] whileTrue: [ " == SQLITE_ROW, meaning another row is available."
				aBlock value: self.
				ret := self step ]]
]

{ #category : #public }
GASqlite3Statement >> bindParameterCount [
	^ GASqlite3FFI current bindParameterCount: handle
]

{ #category : #public }
GASqlite3Statement >> bindParameterIndex: aName [
	^ GASqlite3FFI current bindParameterIndex: handle for: aName
]

{ #category : #public }
GASqlite3Statement >> byteArrayAt: aColumn [
	^ GASqlite3FFI current blobFrom: handle at: aColumn
]

{ #category : #public }
GASqlite3Statement >> clearBindings [
	connection clearBindings: self
]

{ #category : #accessing }
GASqlite3Statement >> columnCount [

	^ GASqlite3FFI current columnCount: handle
]

{ #category : #private }
GASqlite3Statement >> connection: anObject [
	connection := anObject
]

{ #category : #public }
GASqlite3Statement >> dataTypeForObject: anObject [

	anObject ifNil: [ ^#at:putNil: ].

	(anObject isKindOf: Integer)
		ifTrue: [ ^#at:putInteger: ].
		
	(anObject isKindOf: Float)
		ifTrue: [ ^#at:putFloat: ].
		
	(anObject isKindOf: String)
		ifTrue: [ ^#at:putString: ].
		
	(anObject isKindOf: ByteArray)
		ifTrue: [ ^#at:putByteArray: ].
		
	^ #at:putObject: 
]

{ #category : #public }
GASqlite3Statement >> dataValuesAvailable [
	^ GASqlite3FFI current dataValuesAvailable: handle
]

{ #category : #execute }
GASqlite3Statement >> execute [
	
	prepared ifFalse: [ self prepare ].
	
	self reset.
	self basicExecute: [ :theStatement | | generatedKey |
		generatedKey := GASqlite3FFI current lastInsertRowId: connection handle.
		fetchListener ifNotNil: #fetchOccurred.
		^ GASqlite3ResultSet new
			statement: theStatement;
			generatedKey: generatedKey;
			yourself.
		 ]
]

{ #category : #'as yet unclassified' }
GASqlite3Statement >> fetchSize: anInteger [ 
	
	"We do not care, it is sqlite"
	self error: 'This driver does not support cursored fetches'
]

{ #category : #public }
GASqlite3Statement >> finalize [ 

	connection finalize: self.
	handle := nil	
]

{ #category : #public }
GASqlite3Statement >> floatAt: aColumn [
	^ GASqlite3FFI current floatFrom: handle at: aColumn
]

{ #category : #private }
GASqlite3Statement >> handle [
	^ handle
]

{ #category : #'initialize-release' }
GASqlite3Statement >> initialize [

	super initialize.
	handle := GASQLite3StatementExternalObject new.
]

{ #category : #public }
GASqlite3Statement >> integerAt: aColumn [
	^ GASqlite3FFI current integerFrom: handle at: aColumn
]

{ #category : #public }
GASqlite3Statement >> nameOfColumn: aColumn [
	^ GASqlite3FFI current nameFor: handle at: aColumn
]

{ #category : #public }
GASqlite3Statement >> nilAt: aColumn [
	^ nil
]

{ #category : #public }
GASqlite3Statement >> objectAt: aColumn [
	^ FLMaterializer materializeFromByteArray: (GASqlite3FFI current blobFrom: handle at: aColumn)
]

{ #category : #execute }
GASqlite3Statement >> prepare [

	super prepare.
	GASqlite3FFI current prepare: handle on: connection handle with: self statementString.
]

{ #category : #public }
GASqlite3Statement >> putNilAt: aColumn [
	^ GASqlite3FFI current with: handle putNullAt: aColumn
]

{ #category : #public }
GASqlite3Statement >> reset [

	GASqlite3FFI current reset: handle on: connection handle
]

{ #category : #public }
GASqlite3Statement >> step [

	| result |
	result := GASqlite3FFI current step: handle.
	(#[101 100] includes: result) not
		ifTrue: [ GASqlite3FFI current signal: GASqlite3Error with: result on: connection handle].
	^ result
]

{ #category : #public }
GASqlite3Statement >> stringAt: aColumn [	 
	^ connection encoder decodeBytes: (GASqlite3FFI current stringFrom: handle at: aColumn) asByteArray
]

{ #category : #public }
GASqlite3Statement >> typeOfColumn: aColumn [
	^ GASqlite3FFI current typeFor: handle at: aColumn
]

{ #category : #public }
GASqlite3Statement >> valueOfColumn: aColumn [
	^ self perform: (self typeOfColumn: aColumn) with: aColumn

]
