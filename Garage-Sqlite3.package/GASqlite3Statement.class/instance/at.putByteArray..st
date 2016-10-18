public
at: aColumn putByteArray: anObject
	^ GASqlite3FFI current with: handle at: aColumn putBlob: anObject