communication
readResponse
	| resp |

	resp := driver peekPacket.
	resp isError ifTrue: [^ GAMysqlError from: session read].
	resp isOkay ifTrue: [^ GAMysqlOkay from: session read].
	^ resp "Response type unknown at this point"