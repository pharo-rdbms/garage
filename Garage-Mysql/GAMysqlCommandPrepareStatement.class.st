Class {
	#name : #GAMysqlCommandPrepareStatement,
	#superclass : #GAMysqlCommandBase,
	#instVars : [
		'query'
	],
	#category : 'Garage-Mysql-Protocol'
}

{ #category : #'as yet unclassified' }
GAMysqlCommandPrepareStatement >> commandArg [
	^ query 
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommandPrepareStatement >> commandCode [
	^ ComStmtPrepare 
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommandPrepareStatement >> queryString: queryString [ 
	query := queryString
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommandPrepareStatement >> readColumnDescr [
	^ GAMysqlField from: session read.

]

{ #category : #'as yet unclassified' }
GAMysqlCommandPrepareStatement >> readEof [
	^ GAMysqlEof from: session read
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommandPrepareStatement >> readParamDescr [
	^ GAMysqlField from: session read.

]

{ #category : #'as yet unclassified' }
GAMysqlCommandPrepareStatement >> readPrepareOkay [
	| prepOkay params columns paramEof columnEof indx |
	
	prepOkay := GAMysqlPrepareOkay from: session read.
	params := Array new: prepOkay numParams.
	columns := Array new: prepOkay numColumns.
	
	prepOkay numParams > 0 ifTrue: [
		indx := 1.	
		[self gotEof] whileFalse: [
			params at: indx put: self readParamDescr.
			indx := indx + 1 ].
		paramEof := self readEof "eof"].

	prepOkay numColumns > 0 ifTrue: [	
		indx := 1.
		[self gotEof ] whileFalse: [
			columns at: indx put: self readColumnDescr.
			indx := indx + 1 ].
		columnEof := self readEof "eof"].
		
	^ GAMysqlPrepareResponse new
		prepareOkay: prepOkay;
		paramDescriptors: params;
		paramEof: paramEof;
		columnDescriptors: columns;
		columnEof: columnEof;
		yourself
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommandPrepareStatement >> readResponse [
	| resp |
	resp := driver peekPacket.
	resp isError ifTrue: [^ GAMysqlError from: session read].
	resp isOkay ifTrue: [^ self readPrepareOkay]

]
