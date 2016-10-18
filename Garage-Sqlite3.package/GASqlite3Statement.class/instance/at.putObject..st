public
at: aColumn putObject: anObject
	^ GASqlite3FFI current with: handle at: aColumn putBlob: (FLSerializer serializeToByteArray: anObject)