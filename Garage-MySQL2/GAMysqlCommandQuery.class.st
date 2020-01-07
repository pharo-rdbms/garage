Class {
	#name : #GAMysqlCommandQuery,
	#superclass : #GAMysqlCommandBase,
	#instVars : [
		'query'
	],
	#category : 'Garage-MySQL-Protocol'
}

{ #category : #'as yet unclassified' }
GAMysqlCommandQuery >> commandArg [
	^ query 
]

{ #category : #'as yet unclassified' }
GAMysqlCommandQuery >> commandCode [
	^ ComQuery 
]

{ #category : #'as yet unclassified' }
GAMysqlCommandQuery >> queryString: queryString [ 
	query := queryString
]

{ #category : #'as yet unclassified' }
GAMysqlCommandQuery >> readEof [
	^ GAMysqlEof from: session read

]

{ #category : #'as yet unclassified' }
GAMysqlCommandQuery >> readFields [
	| respFields field |
	respFields := OrderedCollection new.
	
	[self gotEof] whileFalse:[ 
		"Read each field and save it"
		field := self readOneField.
		respFields add: field ].
		
	^ respFields asArray
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommandQuery >> readOneField [
	^ GAMysqlField from: session read
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommandQuery >> readOneRow: fields [
	| parser |
	parser := GAMysqlTextRowDataParser new.
	parser driver: driver.
	parser columnDescriptors: fields.
	^ parser read: session read.
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommandQuery >> readResponse [
	| resp |
	resp := self readResult.
	resp hasMoreResults ifTrue: [resp nextResult: self readResponse].
	^ resp
]

{ #category : #'as yet unclassified' }
GAMysqlCommandQuery >> readResult [
	| fields fieldsEof rows rowsEof resultSetHdr pkt |
	pkt := super readResponse.
	pkt isOkayOrError 
		ifTrue: [ ^ pkt ]
		ifFalse: [ resultSetHdr := self readRsHeader ].
	fields := self readFields.
	fieldsEof := self readEof.
	rows := self readRowData: fields.
	rowsEof := self readEof.
	^ GAMysqlResultSet new
		header: resultSetHdr;
		fields: fields;
		fieldsEof: fieldsEof;
		rows: rows;
		rowsEof: rowsEof;
		yourself
]

{ #category : #'as yet unclassified' }
GAMysqlCommandQuery >> readRowData: fields [ 
	| respRows row |
	respRows := OrderedCollection new.
	[self gotEof] whileFalse: [ 
		"Read each field and save it"
		row := self readOneRow: fields.
		respRows add: row].
		
	^ respRows asArray
	
]

{ #category : #'as yet unclassified' }
GAMysqlCommandQuery >> readRsHeader [
	^ GAMysqlResultSetHeader from: session read
	
]
