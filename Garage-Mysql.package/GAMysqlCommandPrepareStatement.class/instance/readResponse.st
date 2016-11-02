as yet unclassified
readResponse
	| resp |
	resp := driver peekPacket.
	resp isError ifTrue: [^ GAMysqlError from: session read].
	resp isOkay ifTrue: [^ self readPrepareOkay]
