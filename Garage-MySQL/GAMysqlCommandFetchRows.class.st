Class {
	#name : #GAMysqlCommandFetchRows,
	#superclass : #GAMysqlCommandBase,
	#instVars : [
		'stmtId',
		'numRows',
		'mapResultsToNativeTypes',
		'resultSetContext'
	],
	#category : 'Garage-MySQL-Protocol'
}

{ #category : #'as yet unclassified' }
GAMysqlCommandFetchRows >> commandArg [
	| |
	ByteArray streamContents: 
		[ :strm | 
		strm
			nextPut: (stmtId digitAt: 1);
			nextPut: (stmtId digitAt: 2);
			nextPut: (stmtId digitAt: 3);
			nextPut: (stmtId digitAt: 4);
			nextPut: (numRows digitAt: 1);
			nextPut: (numRows digitAt: 2);
			nextPut: (numRows digitAt: 3);
			nextPut: (numRows digitAt: 4).
			
		^ strm contents ]
]

{ #category : #'as yet unclassified' }
GAMysqlCommandFetchRows >> commandCode [
	^ ComStmtFetch 
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommandFetchRows >> numRows: count [
	numRows := count
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommandFetchRows >> readEof [
	^ GAMysqlEof from: session read

]

{ #category : #'as yet unclassified' }
GAMysqlCommandFetchRows >> readOneRow: fields [ 
	| parser |
	parser := GAMysqlBinaryRowDataParser new.
	parser driver: driver.
	parser columnDescriptors: fields.
	^ parser read: session read.
]

{ #category : #'as yet unclassified' }
GAMysqlCommandFetchRows >> readResponse [
	| resp |
	resp := self readResult.
	^ resp
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommandFetchRows >> readResult [
	| pkt fieldsEof rows fields rowsEof |
	pkt := driver peekPacket.
	pkt isError ifTrue: [^ GAMysqlError from: session read].
	
	"If not error then zero or more row data packets followed by eof packet"
	fields := resultSetContext fields.
	fieldsEof := resultSetContext fieldsEof.
	fieldsEof hasOpenCursor ifTrue: [	
		rows := self readRowData: fields.
		rowsEof := self readEof. "eof"].
	
	^ resultSetContext
		rows: rows asOrderedCollection;
		rowsEof: rowsEof;
		yourself
		
]

{ #category : #'as yet unclassified' }
GAMysqlCommandFetchRows >> readRowData: fields [ 
	| respRows row |
	respRows := OrderedCollection new.
	[self gotEof] whileFalse: [ 
		"Read each row and save it"
		row := self readOneRow: fields.
		respRows add: row].
		
	^ respRows asArray

]

{ #category : #'as yet unclassified' }
GAMysqlCommandFetchRows >> resultSetContext: partialResultSet [
	resultSetContext := partialResultSet 
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommandFetchRows >> statementId: id [
	stmtId := id
	
]
