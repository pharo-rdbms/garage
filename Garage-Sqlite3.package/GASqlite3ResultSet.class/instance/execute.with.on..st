as yet unclassified
execute: anSQLText with: anObject on: aDb
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