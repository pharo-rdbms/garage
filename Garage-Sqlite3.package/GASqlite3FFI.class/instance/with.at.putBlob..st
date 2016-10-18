public API
with: aStatement at: aColumn putBlob: aByteArray
	^ self apiBindBlob: aStatement atColumn: aColumn with: aByteArray with: aByteArray size with: -1 