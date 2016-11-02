as yet unclassified
readResult
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