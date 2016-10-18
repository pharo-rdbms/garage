public API
blobFrom: aStatement at: aColumn
	| address size |
	
	address := self apiColumnBlob: aStatement atColumn: aColumn.
	size := self apiColumnBytes: aStatement atColumn: aColumn.
	^ (FFIExternalArray fromPointer: address type: Character size: size) address