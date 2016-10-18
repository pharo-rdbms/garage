public
stringAt: aColumn	 
	^ connection encoder decodeBytes: (GASqlite3FFI current stringFrom: handle at: aColumn) asByteArray