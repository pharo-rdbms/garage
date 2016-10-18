public
putNilAt: aColumn
	^ GASqlite3FFI current with: handle putNullAt: aColumn