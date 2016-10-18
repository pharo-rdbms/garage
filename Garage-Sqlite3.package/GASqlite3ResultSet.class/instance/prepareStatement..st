as yet unclassified
prepareStatement: anSQLText

	statement isNil
		ifTrue: [ statement := db prepare: anSQLText ]
		ifFalse: [ statement clearBindings; reset ].

	1 to: statement columnCount do: [ :i |
		columnNames at: i put: (statement nameOfColumn: i -1 ).
		columnTypes at: i put: (statement typeOfColumn: i -1)].