Class {
	#name : #GAMysqlCommandExecute,
	#superclass : #GAMysqlCommandBase,
	#instVars : [
		'stmtId',
		'params',
		'cursoredFetch'
	],
	#category : 'Garage-MySQL-Protocol'
}

{ #category : #'as yet unclassified' }
GAMysqlCommandExecute >> commandArg [
	| paramType nonLongs |
	ByteArray streamContents: 
		[ :strm | 
		strm
			nextPut: (stmtId digitAt: 1);
			nextPut: (stmtId digitAt: 2);
			nextPut: (stmtId digitAt: 3);
			nextPut: (stmtId digitAt: 4).
		cursoredFetch 
			ifTrue: [ strm nextPut: 1	"flags => READ_CURSOR" ]
			ifFalse: [ strm nextPut: 0	"flags => NO_CURSOR" ].
		strm
			nextPut: 1;
			nextPut: 0;
			nextPut: 0;
			nextPut: 0.	"iterationCount"
		strm nextPutAll: self nullBitMap.
		self hasNewParamBound 
			ifTrue: 
				[ strm nextPut: 1.	"new params bound <- true"
				params do: 
					[ :each | 
					paramType := each paramType.
					strm
						nextPut: (paramType digitAt: 1);
						nextPut: (paramType digitAt: 2) ] ]
			ifFalse: [ strm nextPut: 0 ].	"new params bound <- false"
		nonLongs := params 
			ifNil: [ Array new ]
			ifNotNil: [ params reject: [ :each | each isLongData ] ].
		nonLongs do: [ :each | each storeBinaryOn: strm ].
		^ strm contents ]
]

{ #category : #'as yet unclassified' }
GAMysqlCommandExecute >> commandCode [
	^ ComStmtExecute 
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommandExecute >> cursoredFetch: aBoolean [ 
	cursoredFetch := aBoolean
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommandExecute >> execute [
	| resp |
	"Remember to send long data for the longdata params before calling here"
	resp := super execute.
	self resetNewParamBound.
	^ resp
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommandExecute >> hasNewParamBound [
	^ params anySatisfy: [:each | each isRebound]
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommandExecute >> initialize [
	super initialize.
	cursoredFetch := false.
]

{ #category : #'as yet unclassified' }
GAMysqlCommandExecute >> nullBitMap [
	| nullBitMap mapByte byteIndex bitMask |
	nullBitMap := ByteArray new: (params size + 7) // 8.
	params doWithIndex: [:each :paramIndex |
		each isNull ifTrue: [
			byteIndex := (paramIndex + 7) // 8.
			bitMask := 1 bitShift: (paramIndex + 7) \\ 8.
			mapByte := nullBitMap at: byteIndex.
			mapByte := mapByte bitOr: bitMask.
			nullBitMap at: byteIndex put: mapByte.
		]
	].

	^ nullBitMap 
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommandExecute >> params: inParams [
	params := inParams.
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommandExecute >> readEof [
	^ GAMysqlEof from: session read

]

{ #category : #'as yet unclassified' }
GAMysqlCommandExecute >> readFields [
	| respFields field |
	respFields := OrderedCollection new.
	
	[self gotEof] whileFalse:[ 
		"Read each field and save it"
		field := self readOneField.
		respFields add: field ].
		
	^ respFields asArray
			
]

{ #category : #'as yet unclassified' }
GAMysqlCommandExecute >> readOneField [
	^ GAMysqlField from: session read.

]

{ #category : #'as yet unclassified' }
GAMysqlCommandExecute >> readOneRow: fields [ 
	| parser |
	parser := GAMysqlBinaryRowDataParser new.
	parser driver: driver.
	parser columnDescriptors: fields.
	^ parser read: session read.
]

{ #category : #'as yet unclassified' }
GAMysqlCommandExecute >> readResponse [
	| resp |
	resp := self readResult.
	"We do not need to look for multi-result responses in statement execute; so the following
	line of code is commented out. Check COM_QUERY response handling for multi-result"
	"resp hasMoreResults ifTrue: [resp next: self readResponse]."
	^ resp
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommandExecute >> readResult [
	| resultSetHdr pkt fieldsEof rows fields rowsEof |
	pkt := super readResponse.
	pkt isOkayOrError ifTrue: [^ pkt].
	
	resultSetHdr := GAMysqlResultSetHeader from: session read.
	fields := self readFields.
	fieldsEof := self readEof.	"eof"

	fieldsEof hasOpenCursor ifFalse: [	
		rows := self readRowData: fields.
		rowsEof := self readEof. "eof"].
	
	^ GAMysqlResultSet new
		header: resultSetHdr;
		fields: fields;
		fieldsEof: fieldsEof;
		rows: rows;
		rowsEof: rowsEof;
		yourself
]

{ #category : #'as yet unclassified' }
GAMysqlCommandExecute >> readRowData: fields [ 
	| respRows row |
	respRows := OrderedCollection new.
	[self gotEof] whileFalse: [ 
		"Read each row and save it"
		row := self readOneRow: fields.
		respRows add: row].
		
	^ respRows asArray

]

{ #category : #'as yet unclassified' }
GAMysqlCommandExecute >> resetNewParamBound [
	params do: [:each | each resetReboundFlag]
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommandExecute >> statementId: id [
	stmtId := id
	
]
