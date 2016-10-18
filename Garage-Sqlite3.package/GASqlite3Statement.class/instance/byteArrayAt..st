public
byteArrayAt: aColumn
	^ GASqlite3FFI current blobFrom: handle at: aColumn